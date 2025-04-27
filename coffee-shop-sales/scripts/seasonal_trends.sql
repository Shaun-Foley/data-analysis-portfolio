-- Are there specific days or periods with unusually high/low sales 
-- (e.g., weekends vs. weekdays)?

USE coffee_shop;

-- Daily sales weekend vs weekday

WITH DailySales AS (
    SELECT 
        DATE(t.`transaction_datetime`) AS sale_date,
        DAYNAME(t.`transaction_datetime`) AS day_of_week,
        SUM(t.`transaction_qty`) AS total_quantity,
        SUM(t.`transaction_qty` * p.`unit_price`) AS total_revenue
    FROM `transactions` AS t
    JOIN `products` AS p ON t.product_id = p.product_id
    GROUP BY DATE(t.`transaction_datetime`), DAYNAME(t.`transaction_datetime`)
),
SalesWithStats AS (
    SELECT 
        sale_date,
        day_of_week,
        CASE 
            WHEN day_of_week IN ('Saturday', 'Sunday') THEN 'Weekend'
            ELSE 'Weekday'
        END AS day_type,
        total_quantity,
        total_revenue,
        AVG(total_revenue) OVER () AS avg_daily_revenue,
        (total_revenue - AVG(total_revenue) OVER ()) / AVG(total_revenue) OVER () * 100 AS revenue_pct_diff,
        AVG(total_quantity) OVER () AS avg_daily_quantity,
        (total_quantity - AVG(total_quantity) OVER ()) / AVG(total_quantity) OVER () * 100 AS quantity_pct_diff
    FROM DailySales
)
SELECT 
    sale_date,
    day_of_week,
    day_type,
    total_quantity,
    total_revenue,
    ROUND(revenue_pct_diff, 2) AS revenue_pct_diff_from_avg,
    ROUND(quantity_pct_diff, 2) AS quantity_pct_diff_from_avg,
    CASE 
        WHEN revenue_pct_diff > 20 THEN 'Unusually High'
        WHEN revenue_pct_diff < -20 THEN 'Unusually Low'
        ELSE 'Typical'
    END AS revenue_status,
    CASE 
        WHEN quantity_pct_diff > 20 THEN 'Unusually High'
        WHEN quantity_pct_diff < -20 THEN 'Unusually Low'
        ELSE 'Typical'
    END AS quantity_status
FROM SalesWithStats
ORDER BY sale_date;