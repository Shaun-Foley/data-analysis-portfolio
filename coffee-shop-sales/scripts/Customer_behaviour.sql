-- What is the average transaction value, 
-- and how does it vary by product type or time of day?  

USE coffee_shop;

-- Average Transaction Value (ATV)
-- Average revenue per transaction

WITH TransactionRevenue AS (
	SELECT
		t.`transaction_id`,
        SUM(t.`transaction_qty` * p.`unit_price`) AS transaction_value
	FROM `transactions` AS t
    JOIN `products` AS p ON t.product_id = p.product_id
    GROUP BY t.`transaction_id`
)
SELECT
	ROUND(AVG(transaction_value), 2) AS avg_transaction_value
FROM TransactionRevenue;

-- Average Transaction Value by Product Category
WITH TransactionRevenue AS (
	SELECT
		t.`transaction_id`,
        pc.`product_category`,
        SUM(t.`transaction_qty` * p.`unit_price`) AS transaction_value
	FROM `transactions` AS t
    JOIN `products` AS p ON t.product_id = p.product_id
    JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
    GROUP BY t.`transaction_id`, pc.`product_category`
),
CategoryTransactions AS (
	SELECT
		product_category,
        COUNT(DISTINCT transaction_id) AS transaction_count,
        SUM(transaction_value) AS total_revenue
	FROM TransactionRevenue
    GROUP BY product_category
)
SELECT
	product_category,
    transaction_count,
    ROUND(total_revenue / transaction_count, 2) AS avg_transaction_value
FROM CategoryTransactions
ORDER BY avg_transaction_value DESC;
