/* 2. Top Products Identification
Objective: Determine which products are the best and worst performers within the dataset timeframe.
Tasks:
    Rank products based on total sales revenue.
    Analyze sales quantity and revenue to identify high-demand products.
    Examine the impact of product classifications on sales performance.
*/

-- Rank products based on total sales revenue. (Top 10 Products)
SELECT 
    p.product_name,
    SUM(s.quantity * p.price * (1 - s.discount)) AS total_sales
FROM sales_fact s
INNER JOIN products_dim p
    ON s.product_id = p.product_id
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Rank products based on total sales revenue. (Bottom 10 Products)
SELECT 
    p.product_name,
    SUM(s.quantity * p.price * (1 - s.discount)) AS total_sales,
    ROW_NUMBER() OVER (ORDER BY SUM(s.quantity * p.price * (1 - s.discount)) DESC) AS sales_rank
FROM sales_fact s
INNER JOIN products_dim p
    ON s.product_id = p.product_id
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 100;

--Analyze sales quantity and revenue to identify high-demand products.
SELECT 
    p.product_name,
    SUM(s.quantity) AS sales_quantity,
    SUM(s.quantity * p.price * (1 - s.discount)) AS total_sales,
    ROW_NUMBER() OVER (ORDER BY SUM(s.quantity * p.price * (1 - s.discount)) DESC) AS sales_rank
FROM sales_fact s
INNER JOIN products_dim p
    ON s.product_id = p.product_id
GROUP BY product_name
ORDER BY sales_quantity DESC
LIMIT 10;

