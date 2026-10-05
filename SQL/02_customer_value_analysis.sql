
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