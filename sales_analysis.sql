CREATE DATABASE SalesDB;
USE SalesDB;

CREATE TABLE sales (
    order_id VARCHAR(20),
    order_date DATE,
    city VARCHAR(50),
    category VARCHAR(50),
    sales FLOAT,
    profit FLOAT
);
SELECT * FROM sales;

SET SQL_SAFE_UPDATES = 0;
-- Step 1: Standardize text data
UPDATE sales
SET city = UPPER(TRIM(city)),
    category = UPPER(TRIM(category));
    
-- KPI: Total Sales and Total Profit

SELECT 
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM sales;

-- Category-wise Sales Analysis

SELECT category,
    SUM(sales) AS total_sales
FROM sales
GROUP BY category
ORDER BY total_sales DESC;

-- City-wise Sales Analysis

SELECT city,
    SUM(sales) AS total_sales
FROM sales
GROUP BY city
ORDER BY total_sales DESC;

-- Daily Sales Trend

SELECT 
    order_date,
    SUM(sales) AS daily_sales
FROM sales
GROUP BY order_date
ORDER BY order_date;

-- Monthly Sales Analysis

SELECT 
    DATE_FORMAT(order_date, '%b') AS month,
    SUM(sales) AS total_sales
FROM sales
GROUP BY DATE_FORMAT(order_date, '%b'), MONTH(order_date)
ORDER BY MONTH(order_date);

-- Profit Margin Analysis by Category

ALTER TABLE sales ADD profit_margin FLOAT;

UPDATE sales
SET profit_margin = profit / sales;

SELECT 
    category,
    ROUND(AVG(profit / sales), 2) AS avg_profit_margin
FROM sales
GROUP BY category
ORDER BY avg_profit_margin DESC;
