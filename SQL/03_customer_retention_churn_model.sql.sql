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