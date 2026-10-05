/*
===========================================================
CUSTOMER RETENTION & VALUE ANALYTICS
Financial Services Customer Analytics Project

Author: Daniel Henshaw Japhet

Tools:
- SQL Server
- SQL
- CTEs
- Window Functions
- Conditional Aggregation

Business Objectives:
1. Analyse customer transaction behaviour
2. Measure customer value
3. Identify inactive customers
4. Analyse churn risk
5. Identify high-value customers at risk
===========================================================
*/


/*
===========================================================
SECTION 1: DATA VALIDATION
===========================================================
*/

-- Total customers and unique customers

SELECT
    COUNT(*) AS total_customer_records,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM [Portfolio].[dbo].[customers]


-- Transaction population
SELECT
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT customer_id) AS customers_with_transactions
FROM [Portfolio].[dbo].[bank_transactions_relational_250k]


-- Transaction date range
SELECT
    MIN(transaction_date) AS earliest_transaction,
    MAX(transaction_date) AS latest_transaction
FROM [Portfolio].[dbo].[bank_transactions_relational_250k]



/*
===========================================================
SECTION 2: CUSTOMER VALUE ANALYSIS
===========================================================
*/

WITH customer_value AS
(
    SELECT
        c.customer_id,
        c.age,
        c.occupation,
        c.home_region,
        c.customer_segment,
        COUNT(t.transaction_id) AS transaction_count,
        ROUND(SUM(t.amount_gbp), 2) AS total_spending,
        ROUND(AVG(t.amount_gbp), 2) AS average_transaction
    FROM [Portfolio].[dbo].[customers] c
    LEFT JOIN [Portfolio].[dbo].[bank_transactions_relational_250k] t
        ON c.customer_id = t.customer_id
    GROUP BY
        c.customer_id, c.age, c.occupation, c.home_region, c.customer_segment
)

SELECT
    *,
    DENSE_RANK() OVER
    (
        ORDER BY total_spending DESC
    ) AS customer_value_rank,
    CASE
        WHEN total_spending >= 90000 THEN 'VIP'
        WHEN total_spending >= 50000 THEN 'High Value'
        ELSE 'Standard'
    END AS customer_value_category
FROM customer_value
ORDER BY total_spending DESC



/*
===========================================================
SECTION 3: CUSTOMER RETENTION & CHURN MODEL
===========================================================
*/

WITH customer_activity AS
(
    SELECT
        c.customer_id,
        c.age,
        c.occupation,
        c.home_region,
        c.customer_segment,
        COUNT(t.transaction_id) AS transaction_count,
        ROUND(SUM(t.amount_gbp), 2) AS total_spending,
        ROUND(AVG(t.amount_gbp), 2) AS average_transaction,
        MAX(t.transaction_date) AS last_transaction
    FROM [Portfolio].[dbo].[customers] c
    LEFT JOIN [Portfolio].[dbo].[bank_transactions_relational_250k] t
        ON c.customer_id = t.customer_id
    GROUP BY c.customer_id, c.age, c.occupation, c.home_region, c.customer_segment
),

customer_inactivity AS
(
    SELECT
        *,
        DATEDIFF(
            DAY,
            last_transaction,
            GETDATE()
        ) AS days_inactive
    FROM customer_activity
)

SELECT
    *,
    CASE
        WHEN days_inactive IS NULL THEN 'Never Activated'
        WHEN days_inactive >= 100 THEN 'Churn Risk'
        WHEN days_inactive >= 50 THEN 'Need Attention'
        ELSE 'Active'
    END AS risk_status
FROM customer_inactivity
ORDER BY days_inactive DESC



/*
===========================================================
SECTION 4: HIGH-VALUE CUSTOMERS AT RISK
===========================================================
*/

WITH customer_activity AS
(
    SELECT
        c.customer_id,
        c.age,
        c.occupation,
        c.home_region,
        c.customer_segment,
        COUNT(t.transaction_id) AS transaction_count,
        ROUND(SUM(t.amount_gbp), 2) AS total_spending,
        ROUND(AVG(t.amount_gbp), 2) AS average_transaction,
        MAX(t.transaction_date) AS last_transaction
    FROM [Portfolio].[dbo].[customers] c
    LEFT JOIN [Portfolio].[dbo].[bank_transactions_relational_250k] t
        ON c.customer_id = t.customer_id
    GROUP BY c.customer_id, c.age, c.occupation, c.home_region, c.customer_segment
),

customer_risk AS
(
    SELECT
        *,
        DATEDIFF(
            DAY,
            last_transaction,
            GETDATE()
        ) AS days_inactive
    FROM customer_activity
)

SELECT
    customer_id,
    age,
    occupation,
    home_region,
    customer_segment,
    transaction_count,
    total_spending,
    average_transaction,
    last_transaction,
    days_inactive,
    CASE
        WHEN total_spending >= 90000 THEN 'VIP'
        WHEN total_spending >= 50000 THEN 'High Value'
        ELSE 'Standard'
    END AS value_category
FROM customer_risk
WHERE days_inactive >= 100
AND total_spending >= 50000
ORDER BY total_spending DESC