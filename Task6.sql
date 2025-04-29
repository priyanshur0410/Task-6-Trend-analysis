CREATE DATABASE revenue_analysis;
USE revenue_analysis;
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    product_id INT
);

INSERT INTO orders (order_id, order_date, amount, product_id) VALUES
(1, '2023-01-05', 100.00, 101),
(1, '2023-01-05', 50.00,  102),  -- एक ही ऑर्डर (1) में दो प्रोडक्ट
(2, '2023-01-15', 75.00,  103),
(3, '2023-02-10', 200.00, 104),
(3, '2023-02-10', 150.00, 105),  -- ऑर्डर 3 में तीन प्रोडक्ट
(3, '2023-02-10', 50.00,  106),
(4, '2023-03-20', 300.00, 107),
(5, '2024-01-05', 250.00, 108),
(5, '2024-01-05', 100.00, 109),   -- 2024 का डेटा
(6, '2024-02-15', 80.00,  110);


-- मंथली रेवेन्यू और ऑर्डर वॉल्यूम
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) AS monthly_revenue,
    COUNT(DISTINCT order_id) AS order_volume
FROM orders
GROUP BY year, month
ORDER BY year, month;

SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) AS monthly_revenue
FROM orders
GROUP BY year, month
ORDER BY monthly_revenue DESC
LIMIT 3;

SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount) / COUNT(DISTINCT order_id) AS avg_order_value
FROM orders
GROUP BY year, month;

SELECT 
    product_id,
    SUM(amount) AS total_sales,
    COUNT(*) AS items_sold
FROM orders
GROUP BY product_id
ORDER BY total_sales DESC;

WITH monthly_sales AS (
    SELECT 
        EXTRACT(YEAR FROM order_date) AS year,
        EXTRACT(MONTH FROM order_date) AS month,
        SUM(amount) AS revenue
    FROM orders
    GROUP BY year, month
)
SELECT 
    year,
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY year, month) AS prev_month_revenue,
    ROUND((revenue - LAG(revenue) OVER (ORDER BY year, month)) / LAG(revenue) OVER (ORDER BY year, month) * 100, 2) AS growth_percent
FROM monthly_sales;

SELECT 
    order_date,
    SUM(amount) AS daily_sales
FROM orders
GROUP BY order_date
ORDER BY order_date;

