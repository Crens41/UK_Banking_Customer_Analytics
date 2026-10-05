
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