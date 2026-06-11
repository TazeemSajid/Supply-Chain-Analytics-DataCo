-- 1. Rank Products by Sales within each Category
SELECT 
    category_name,
    product_name,
    total_sales,
    total_profit,
    RANK() OVER (
        PARTITION BY category_name 
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM (
    SELECT 
        p.category_name,
        p.product_name,
        ROUND(CAST(SUM(f.sales) AS NUMERIC), 2)             AS total_sales,
        ROUND(CAST(SUM(f.benefit_per_order) AS NUMERIC), 2) AS total_profit
    FROM fact_orders f
    JOIN dim_products p ON f.product_card_id = p.product_card_id
    GROUP BY p.category_name, p.product_name
) ranked
ORDER BY category_name, sales_rank
LIMIT 20;

-- 2. Running Total Sales by Month
SELECT 
    order_year,
    order_month_name,
    total_sales,
    ROUND(CAST(SUM(total_sales) OVER (
        PARTITION BY order_year 
        ORDER BY order_month
    ) AS NUMERIC), 2) AS running_total_sales
FROM (
    SELECT 
        order_year,
        order_month,
        order_month_name,
        ROUND(CAST(SUM(sales) AS NUMERIC), 2) AS total_sales
    FROM fact_orders
    GROUP BY order_year, order_month, order_month_name
) monthly
ORDER BY order_year, order_month;

-- 3. Rank Regions by Delay using DENSE_RANK
SELECT 
    order_region,
    avg_delay,
    total_orders,
    late_orders,
    DENSE_RANK() OVER (ORDER BY avg_delay DESC) AS delay_rank
FROM (
    SELECT 
        order_region,
        ROUND(CAST(AVG(delivery_delay_days) AS NUMERIC), 2) AS avg_delay,
        COUNT(*)        AS total_orders,
        SUM(delay_flag) AS late_orders
    FROM fact_orders
    GROUP BY order_region
) regional
ORDER BY delay_rank;

-- 4. Top 3 Products per Department by Profit
SELECT * FROM (
    SELECT 
        p.department_name,
        p.product_name,
        ROUND(CAST(SUM(f.benefit_per_order) AS NUMERIC), 2) AS total_profit,
        ROUND(CAST(SUM(f.sales) AS NUMERIC), 2)             AS total_sales,
        RANK() OVER (
            PARTITION BY p.department_name 
            ORDER BY SUM(f.benefit_per_order) DESC
        ) AS profit_rank
    FROM fact_orders f
    JOIN dim_products p ON f.product_card_id = p.product_card_id
    GROUP BY p.department_name, p.product_name
) ranked
WHERE profit_rank <= 3
ORDER BY department_name, profit_rank;

-- 5. Customer Segment Performance with CTE
WITH segment_stats AS (
    SELECT 
        c.customer_segment,
        COUNT(DISTINCT f.order_id)                           AS total_orders,
        ROUND(CAST(SUM(f.sales) AS NUMERIC), 2)             AS total_sales,
        ROUND(CAST(SUM(f.benefit_per_order) AS NUMERIC), 2) AS total_profit,
        ROUND(CAST(AVG(f.delivery_delay_days) AS NUMERIC), 2) AS avg_delay
    FROM fact_orders f
    JOIN dim_customers c ON f.order_customer_id = c.customer_id
    GROUP BY c.customer_segment
),
overall AS (
    SELECT SUM(total_sales) AS grand_total_sales FROM segment_stats
)
SELECT 
    s.customer_segment,
    s.total_orders,
    s.total_sales,
    s.total_profit,
    s.avg_delay,
    ROUND(CAST(s.total_sales * 100.0 / o.grand_total_sales AS NUMERIC), 2) AS sales_contribution_pct
FROM segment_stats s, overall o
ORDER BY s.total_profit DESC;

-- 6. Shipping Mode Efficiency using CASE
SELECT 
    shipping_mode,
    COUNT(*)        AS total_orders,
    SUM(delay_flag) AS late_orders,
    ROUND(CAST(AVG(delivery_delay_days) AS NUMERIC), 2) AS avg_delay,
    CASE 
        WHEN AVG(delivery_delay_days) <= 0   THEN '🟢 Excellent'
        WHEN AVG(delivery_delay_days) <= 0.5 THEN '🟡 Good'
        WHEN AVG(delivery_delay_days) <= 1.0 THEN '🟠 Average'
        ELSE                                      '🔴 Poor'
    END AS performance_rating
FROM fact_orders
GROUP BY shipping_mode
ORDER BY avg_delay;