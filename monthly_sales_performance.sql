-- Total Monthly Sales
SELECT 
    EXTRACT(MONTH FROM sales_fact.sales_date) as month,
    SUM(sales_fact.quantity * products_dim.price * (1 - sales_fact.discount)) AS total_sales
FROM sales_fact
INNER JOIN products_dim
    ON sales_fact.product_id = products_dim.product_id
GROUP BY month
ORDER BY MONTH;

-- Sample Calculation of the total sales per transaction
SELECT
    sales_fact.sales_id,
    sales_fact.quantity,
    sales_fact.discount,
    products_dim.price,
    (sales_fact.quantity * products_dim.price * (1 - sales_fact.discount)) AS total_sales
FROM sales_fact
INNER JOIN products_dim
    ON sales_fact.product_id = products_dim.product_id
LIMIT 100;

--Compare sales performance across different product categories each month.
-- Sales Performance for the month of January
SELECT 
    products_dim.product_name,
    SUM(sales_fact.quantity * products_dim.price * (1 - sales_fact.discount)) AS total_sales
FROM sales_fact
INNER JOIN products_dim
    ON sales_fact.product_id = products_dim.product_id
WHERE EXTRACT(MONTH FROM sales_fact.sales_date) = 1
GROUP BY products_dim.product_name
ORDER BY total_sales DESC;

-- Sales Performance for the month of February
SELECT 
    products_dim.product_name,
    SUM(sales_fact.quantity * products_dim.price * (1 - sales_fact.discount)) AS total_sales
FROM sales_fact
INNER JOIN products_dim
    ON sales_fact.product_id = products_dim.product_id
WHERE EXTRACT(MONTH FROM sales_fact.sales_date) = 2
GROUP BY products_dim.product_name
ORDER BY total_sales DESC;

-- Sales Performance for the month of March
SELECT 
    products_dim.product_name,
    SUM(sales_fact.quantity * products_dim.price * (1 - sales_fact.discount)) AS total_sales
FROM sales_fact
INNER JOIN products_dim
    ON sales_fact.product_id = products_dim.product_id
WHERE EXTRACT(MONTH FROM sales_fact.sales_date) = 3
GROUP BY products_dim.product_name
ORDER BY total_sales DESC;

-- Sales Performance for the month of April
SELECT 
    products_dim.product_name,
    SUM(sales_fact.quantity * products_dim.price * (1 - sales_fact.discount)) AS total_sales
FROM sales_fact
INNER JOIN products_dim
    ON sales_fact.product_id = products_dim.product_id
WHERE EXTRACT(MONTH FROM sales_fact.sales_date) = 4
GROUP BY products_dim.product_name
ORDER BY total_sales DESC;

-- Sales Performance for the month of May
SELECT 
    products_dim.product_name,
    SUM(sales_fact.quantity * products_dim.price * (1 - sales_fact.discount)) AS total_sales
FROM sales_fact
INNER JOIN products_dim
    ON sales_fact.product_id = products_dim.product_id
WHERE EXTRACT(MONTH FROM sales_fact.sales_date) = 5
GROUP BY products_dim.product_name
ORDER BY total_sales DESC;

-- Sales Performance for Null sales_date
SELECT
    products_dim.product_name,
    SUM(sales_fact.quantity * products_dim.price * (1 - sales_fact.discount)) AS total_sales
FROM sales_fact
INNER JOIN products_dim
    ON sales_fact.product_id = products_dim.product_id
WHERE sales_fact.sales_date IS NULL
GROUP BY products_dim.product_name
ORDER BY total_sales DESC;


-- Monthly sales using Window Function
WITH monthly_sales AS (
    SELECT 
        p.product_name,
        EXTRACT(MONTH FROM s.sales_date) AS sales_month,
        SUM(s.quantity * p.price * (1 - s.discount)) AS total_sales
    FROM sales_fact s
    INNER JOIN products_dim p
        ON s.product_id = p.product_id
    GROUP BY p.product_name, sales_month
)
SELECT 
    product_name,
    sales_month,
    total_sales
FROM (
    SELECT 
        ms.*,
        ROW_NUMBER() OVER (PARTITION BY sales_month ORDER BY total_sales DESC) AS rank
    FROM monthly_sales ms
) ranked
WHERE rank <= 5   -- change 3 to how many "top products" you want
ORDER BY sales_month, rank;

-- Monthly sales using Window Function
WITH monthly_sales AS (
    SELECT 
        p.product_name,
        EXTRACT(MONTH FROM s.sales_date) AS sales_month,
        SUM(s.quantity * p.price * (1 - s.discount)) AS total_sales
    FROM sales_fact s
    INNER JOIN products_dim p
        ON s.product_id = p.product_id
    GROUP BY p.product_name, sales_month
)
SELECT 
    product_name,
    sales_month,
    total_sales,
    rank
FROM (
    SELECT 
        ms.*,
        ROW_NUMBER() OVER (PARTITION BY sales_month ORDER BY total_sales DESC) AS rank
    FROM monthly_sales ms
) ranked
WHERE rank <= 5   -- change 3 to how many "top products" you want
ORDER BY sales_month, rank;





