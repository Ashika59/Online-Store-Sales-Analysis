-- 1. Total Sales Revenue
SELECT SUM(amount) AS total_revenue
FROM orders;

-- 2. Top Customers by Spend
SELECT c.customer_name, SUM(o.amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 3;

-- 3. Monthly Sales Trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(amount) AS monthly_sales
FROM orders
GROUP BY month
ORDER BY month;

-- 4. Revenue by Region
SELECT c.region, SUM(o.amount) AS region_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region
ORDER BY region_revenue DESC;

-- 5. Average Order Value (AOV)
SELECT AVG(amount) AS avg_order_value
FROM orders;

-- 6. Number of Repeat Customers
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1;

-- 7. Highest Single Day Revenue
SELECT order_date, SUM(amount) AS daily_revenue
FROM orders
GROUP BY order_date
ORDER BY daily_revenue DESC
LIMIT 1;

-- 8. Rank Customers by Spend in Each Region (Window Function)
SELECT 
    c.region,
    c.customer_name,
    SUM(o.amount) AS total_spent,
    RANK() OVER (PARTITION BY c.region ORDER BY SUM(o.amount) DESC) AS rank_in_region
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region, c.customer_name;
