-- View  dataset
SELECT * 
FROM ecommerce_dataset;

-- Create a staging table 
CREATE TABLE ecommerce_dataset_staging
LIKE ecommerce_dataset;

-- Copy
INSERT ecommerce_dataset_staging
SELECT * 
FROM ecommerce_dataset;

SELECT * 
FROM ecommerce_dataset_staging;

-- ===========================================
-- Data preprocessing
-- ===========================================

-- Change signup_date
ALTER TABLE ecommerce_dataset_staging
ADD COLUMN signup_date_dt DATE,
ADD COLUMN order_date_dt DATE,
ADD COLUMN review_date_dt DATE;

UPDATE ecommerce_dataset_staging
SET signup_date_dt = CAST(signup_date AS DATE),
    order_date_dt  = CAST(order_date AS DATE),
    review_date_dt = CAST(review_date AS DATE);
    
DESCRIBE ecommerce_dataset_staging;

-- ===========================================
-- Basic Descriptive Insights
-- ===========================================

DESCRIBE ecommerce_dataset_staging;

-- Count total customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM ecommerce_dataset_staging;

-- Count total orders
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM ecommerce_dataset_staging;

-- Revenue by multiplying quantity * unit_price
SELECT SUM(quantity * unit_price) AS total_revenue
FROM ecommerce_dataset_staging;

-- ===========================================
-- Customer Demographics
-- ===========================================

-- Customers by gender
SELECT gender, COUNT(*) AS total_customers
FROM ecommerce_dataset_staging
GROUP BY gender;

-- Customers by age group
SELECT age_group, COUNT(*) AS total_customers
FROM ecommerce_dataset_staging
GROUP BY age_group;

-- ===========================================
-- Order Status & Payments
-- ===========================================

-- Orders by status
SELECT order_status, COUNT(*) AS total_orders
FROM ecommerce_dataset_staging
GROUP BY order_status;

-- Payment method usage
SELECT payment_method, COUNT(*) AS count_method
FROM ecommerce_dataset_staging
GROUP BY payment_method;

-- ===========================================
-- Product Performance
-- ===========================================

-- Best-selling products by quantity
SELECT product_name, SUM(quantity) AS total_sold
FROM ecommerce_dataset_staging
GROUP BY product_name
ORDER BY total_sold DESC;

-- Highest revenue products
SELECT product_name, SUM(quantity * unit_price) AS revenue
FROM ecommerce_dataset_staging
GROUP BY product_name
ORDER BY revenue DESC;

-- ===========================================
-- Customer Reviews
-- ===========================================

-- Average rating by product
SELECT product_name, AVG(rating) AS avg_rating
FROM ecommerce_dataset_staging
GROUP BY product_name
ORDER BY avg_rating DESC;

-- Rating distribution
SELECT rating, COUNT(*) AS total_reviews
FROM ecommerce_dataset_staging
GROUP BY rating
ORDER BY rating DESC;

-- ===========================================
-- Orders in a specific year
-- ===========================================

-- Orders placed in 2024
SELECT *
FROM ecommerce_dataset_staging
WHERE YEAR(order_date_dt) = 2024;