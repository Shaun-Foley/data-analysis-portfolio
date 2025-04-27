-- Which product categories (e.g., coffee, pastries) 
-- contribute most to revenue, and are there underperforming items?  

USE coffee_shop;

-- High-performing product categories
SELECT 
    pc.`product_category`,
    ( (SUM(t.`transaction_qty` * p.`unit_price`) 
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
GROUP BY pc.`product_category`

;

-- Underperforming product categories
SELECT 
    pc.`product_category`,
    SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
GROUP BY pc.`product_category`

; 

-- Top product categories for total revenue
SELECT 
    pc.`product_category`,
	SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue,
    total_revenue / SUM(t.`transaction_qty` * p.`unit_price`) AS revenue_share
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
GROUP BY pc.`product_category`
ORDER BY total_revenue DESC
;


