-- What are the top-selling products by revenue and quantity
-- How do sales vary by day of the week or hour of the day?  

USE coffee_shop;

-- Total Revenue for the three stores
SELECT 
	SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id;

-- Total revenue for each store
SELECT 
	s.`store_name`,
	SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
JOIN `stores` AS s ON t.store_id = s.store_id
GROUP BY s.`store_name`;

-- Top products by revenue 
SELECT 
	p.`product_name`,
	SUM(`transaction_qty` * `unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
GROUP BY p.`product_name`
ORDER BY total_revenue DESC
;

-- Top products by total sold
SELECT 
	p.`product_name`,
	SUM(t.`transaction_qty`) AS total_sold
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
GROUP BY p.`product_name`
ORDER BY total_sold DESC
;

-- -- Top products by total sold with product category
SELECT 
	p.`product_name`,
    pc.`product_category`,
	SUM(t.`transaction_qty`) AS total_sold
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
GROUP BY p.`product_name`, pc.`product_category`
ORDER BY total_sold DESC
;

-- Top product categories for total sold
SELECT 
    pc.`product_category`,
	SUM(t.`transaction_qty`) AS total_sold
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
GROUP BY pc.`product_category`
ORDER BY total_sold DESC
;

-- Top product categories for total revenue
SELECT 
    pc.`product_category`,
	SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
GROUP BY pc.`product_category`
ORDER BY total_revenue DESC
;

-- -- Top products by total sold with product category with total revenue
SELECT 
	p.`product_name`,
    pc.`product_category`,
	SUM(t.`transaction_qty`) AS total_sold,
    SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
GROUP BY p.`product_name`, pc.`product_category`
ORDER BY total_sold DESC
;

-- Coffee performance for total sold and total revenue
SELECT 
	p.`product_name`,
    pc.`product_category`,
	SUM(t.`transaction_qty`) AS total_sold,
    SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
WHERE pc.`product_category` = 'Coffee'
GROUP BY p.`product_name`, pc.`product_category`
ORDER BY total_sold DESC
;

-- Tea performance for total sold and total revenue
SELECT 
	p.`product_name`,
    pc.`product_category`,
	SUM(t.`transaction_qty`) AS total_sold,
    SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
WHERE pc.`product_category` = 'Tea'
GROUP BY p.`product_name`, pc.`product_category`
ORDER BY total_sold DESC
;

-- Bakery performance for total sold and total revenue
SELECT 
	p.`product_name`,
    pc.`product_category`,
	SUM(t.`transaction_qty`) AS total_sold,
    SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
WHERE pc.`product_category` = 'Bakery'
GROUP BY p.`product_name`, pc.`product_category`
ORDER BY total_sold DESC
;

-- Sales variation by day of the week
SELECT 
	DAYNAME(t.`transaction_datetime`) AS day_of_week,
	SUM(t.`transaction_qty`) AS total_sold,
    SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
GROUP BY DAYNAME(t.`transaction_datetime`), DAYOFWEEK(t.`transaction_datetime`)
ORDER BY DAYOFWEEK(t.`transaction_datetime`)
;

-- Sales variation by hour of the day for peak hours
SELECT 
	HOUR(t.`transaction_datetime`) AS hour_of_day,
	SUM(t.`transaction_qty`) AS total_sold,
    SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
GROUP BY HOUR(t.`transaction_datetime`)
ORDER BY hour_of_day
;
-- -- Sales variation by hour of the day for peak hours -> added AM / PM to hour of day
SELECT 
	DATE_FORMAT(t.`transaction_datetime`, '%h %p') AS hour_of_day,
	SUM(t.`transaction_qty`) AS total_sold,
    SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
GROUP BY HOUR(t.`transaction_datetime`), hour_of_day
ORDER BY HOUR(t.`transaction_datetime`)
;

-- Days of the week with hour of the day
SELECT 
    DAYNAME(t.`transaction_datetime`) AS day_of_week,
    DATE_FORMAT(t.`transaction_datetime`, '%h %p') AS hour_of_day,
    SUM(t.`transaction_qty`) AS total_sold,
    SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
GROUP BY DAYNAME(t.`transaction_datetime`), HOUR(t.`transaction_datetime`), DAYOFWEEK(t.`transaction_datetime`), DATE_FORMAT(t.`transaction_datetime`, '%h %p')
ORDER BY DAYOFWEEK(t.`transaction_datetime`), HOUR(t.`transaction_datetime`)
;

-- days of the week / hour of the day - ordered by total_sold
SELECT 
    DAYNAME(t.`transaction_datetime`) AS day_of_week,
    DATE_FORMAT(t.`transaction_datetime`, '%h %p') AS hour_of_day,
    SUM(t.`transaction_qty`) AS total_sold,
    SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
FROM `transactions` AS t
JOIN `products` AS p ON t.product_id = p.product_id
GROUP BY DAYNAME(t.`transaction_datetime`), HOUR(t.`transaction_datetime`), DAYOFWEEK(t.`transaction_datetime`), DATE_FORMAT(t.`transaction_datetime`, '%h %p')
ORDER BY total_sold DESC
;

-- Top products by hour of the day
SELECT *
FROM (
    SELECT 
		HOUR(t.`transaction_datetime`) AS hour_of_day,
		p.`product_name`,
		SUM(t.`transaction_qty`) AS total_sold,
		SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue,
		RANK() OVER(PARTITION BY HOUR(t.`transaction_datetime`) 
			ORDER BY SUM(t.`transaction_qty` * p.`unit_price`) DESC) AS revenue_rank
	FROM `transactions` AS t
	JOIN `products` AS p ON t.product_id = p.product_id
	GROUP BY HOUR(t.`transaction_datetime`), p.`product_name`
) AS RankedProducts
WHERE revenue_rank <= 3
ORDER BY hour_of_day, revenue_rank
;