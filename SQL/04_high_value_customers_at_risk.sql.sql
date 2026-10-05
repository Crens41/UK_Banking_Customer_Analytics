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