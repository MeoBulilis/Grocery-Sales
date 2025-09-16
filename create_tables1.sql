-- 1. categories
CREATE TABLE categories_dim (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(45)
);

-- 2. countries
CREATE TABLE countries_dim (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(45),
    country_code VARCHAR(2)
);

-- 3. cities
CREATE TABLE cities_dim (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(45),
    zipcode DECIMAL(5,0),
    country_id INT,
    FOREIGN KEY (country_id) REFERENCES countries_dim(country_id)
);

-- 4. customers
CREATE TABLE customers_dim (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(45),
    middle_initial VARCHAR(1),
    last_name VARCHAR(45),
    city_id INT,
    address VARCHAR(90),
    FOREIGN KEY (city_id) REFERENCES cities_dim(city_id)
);

-- 5. employees
CREATE TABLE employees_dim (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    middle_initial VARCHAR(1),
    last_name VARCHAR(45) NOT NULL,
    birth_date DATE,
    gender VARCHAR(10),
    city_id INT,
    hire_date DATE,
    FOREIGN KEY (city_id) REFERENCES cities_dim(city_id)
);

-- 6. products
CREATE TABLE products_dim (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(45) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category_id INT,
    class VARCHAR(15),
    modify_date DATE,
    resistant VARCHAR(15),
    is_allergic VARCHAR(5),
    vitality_days DECIMAL(3,0),
    FOREIGN KEY (category_id) REFERENCES categories_dim(category_id)
);

-- 7. sales
CREATE TABLE sales_fact (
    sales_id INT PRIMARY KEY,
    sales_person_id INT,
    customer_id INT,
    product_id INT,
    quantity INT,
    discount DECIMAL(10,2),
    total_price DECIMAL(10,2),
    sales_date timestamp,
    transaction_number VARCHAR(25) UNIQUE,
    FOREIGN KEY (sales_person_id) REFERENCES employees_dim(employee_id),
    FOREIGN KEY (customer_id) REFERENCES customers_dim(customer_id),
    FOREIGN KEY (product_id) REFERENCES products_dim(product_id)
);


-- Copying the csv files to the respective tables
COPY categories_dim
FROM 'C:\CSV files\categories.csv'
DELIMITER ',' CSV HEADER;

COPY cities_dim
FROM 'C:\CSV files\cities.csv'
DELIMITER ',' CSV HEADER;

COPY countries_dim
FROM 'C:\CSV files\countries.csv'
DELIMITER ',' CSV HEADER;

COPY customers_dim
FROM 'C:\CSV files\customers.csv'
DELIMITER ',' CSV HEADER;

COPY employees_dim
FROM 'C:\CSV files\employees.csv'
DELIMITER ',' CSV HEADER;

COPY products_dim
FROM 'C:\CSV files\products.csv'
DELIMITER ',' CSV HEADER;

COPY sales_fact
FROM 'C:\CSV files\sales.csv'
DELIMITER ',' CSV HEADER;

SELECT *
FROM customers_dim

ALTER TABLE customers_dim
ALTER COLUMN middle_initial TYPE VARCHAR(4);

ALTER TABLE products_dim
ALTER COLUMN is_allergic TYPE VARCHAR(7)

SELECT * FROM categories_dim LIMIT 5;
SELECT * FROM cities_dim LIMIT 5;
SELECT * FROM countries_dim LIMIT 5;
SELECT * FROM customers_dim LIMIT 5;
SELECT * FROM employees_dim LIMIT 5;
SELECT * FROM products_dim LIMIT 5;
SELECT * FROM sales_fact LIMIT 5;


