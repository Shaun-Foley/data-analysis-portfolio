-- Which product categories (e.g., coffee, pastries) 
-- contribute most to revenue, and are there underperforming items?

USE coffee_shop;

-- Best contributing products
WITH CategoryRevenue AS (
	SELECT
		pc. `product_category`,
        SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
	FROM `transactions` AS t
    JOIN `products` AS p ON t.product_id = p.product_id
    JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
    GROUP BY pc.`product_category`
),
TotalRevenue AS (
	SELECT SUM(total_revenue) AS overall_revenue
    FROM CategoryRevenue
)
SELECT
	cr.`product_category`,
    cr.total_revenue,
    (cr.total_revenue / tr.overall_revenue)*100 AS revenue_share
FROM CategoryRevenue AS CR
CROSS JOIN TotalRevenue AS tr
ORDER BY cr.total_revenue DESC
;


-- Underperforming products
WITH ProductSales AS (
	SELECT
		p.`product_name`,
        pc.`product_category`,
        SUM(t.`transaction_qty`) AS total_sales,
        SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
    FROM `transactions` AS t
    JOIN `products` AS p ON t.product_id = p.product_id
    JOIN `product_category` AS pc ON p.product_category_id = pc.product_category_id
    GROUP BY p.`product_name`, pc.`product_category`
),
Totals AS (
	SELECT
		SUM(total_sales) AS overall_sales,
        SUM(total_revenue) AS overall_revenue
	FROM ProductSales
),
RankedProducts AS (
	SELECT
		ps.product_name,
        ps.product_category,
        ps.total_sales,
        ps.total_revenue,
        RANK() OVER (ORDER BY ps.total_revenue ASC) AS revenue_rank,
        RANK() OVER (ORDER BY ps.total_sales ASC) AS sales_rank,
        ROUND((ps.total_sales / Totals.overall_sales) * 100, 2) AS sales_share_percentage,
        ROUND((ps.total_revenue / Totals.overall_revenue) * 100, 2) AS revenue_share_percentage
    FROM ProductSales ps
    CROSS JOIN Totals
)		
SELECT
	product_name,
    product_category,
    total_sales,
    total_revenue,
    revenue_rank,
    sales_rank,
    sales_share_percentage,
    revenue_share_percentage
FROM RankedProducts
WHERE revenue_rank <= 5 OR sales_rank <= 5
ORDER BY revenue_rank, sales_rank;