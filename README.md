# Online-Store-Sales-Analysis
SQL mini project analysing online store sales to identify top customers, monthly revenue trends, and regional insights.

**Purposes of the Project**
The main goal of this project is to gain understanding from sales data, exploring the various factors that influence sales across different branches.

# Analysis List:

**Online Store Sales Analysis – Business Questions
Customer Insights**

1.Who are the top 3 customers by total spend?

2.How many repeat customers does the store have?

3.What is the average spend per customer?

4.Which customers placed the most number of orders?

**Sales Performance**

1.What is the total revenue generated?

2.What is the average order value (AOV)?

3.How does sales trend month over month?

4.On which date did the store make the highest single-day revenue?

**Regional Insights**

1.Which region generates the highest revenue?

2.What percentage of total revenue comes from each region?

3.Do customers from certain regions place larger orders on average?

**Advanced Analysis (Optional for Extra Value)**

1.Use a window function to rank customers by spend within each region.

2.Calculate the revenue growth rate month-over-month.

3.Identify the top-selling quarter (Q1, Q2, etc.).

4.Find the customer lifetime value (CLV) = total spend per customer.


# SQL Code
## 01_create_tables.sql ##

-- Create Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    region VARCHAR(20)
);

-- Insert sample data into Customers
INSERT INTO customers (customer_id, customer_name, region) VALUES
(1, 'Alice', 'North'),
(2, 'Bob', 'South'),
(3, 'Charlie', 'East'),
(4, 'David', 'West'),
(5, 'Eva', 'North');

-- Create Orders Table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert sample data into Orders
INSERT INTO orders (order_id, customer_id, order_date, amount) VALUES
(101, 1, '2023-01-05', 250.00),
(102, 2, '2023-01-07', 300.00),
(103, 1, '2023-02-10', 450.00),
(104, 3, '2023-02-15', 150.00),
(105, 4, '2023-03-01', 700.00),
(106, 5, '2023-03-05', 200.00),
(107, 2, '2023-03-08', 500.00);

**02_queries.sql**

-- **1. Total Sales Revenue**
SELECT SUM(amount) AS total_revenue
FROM orders;

-- **2. Top Customers by Spend**
SELECT c.customer_name, SUM(o.amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 3;

-- **3. Monthly Sales Trend**
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(amount) AS monthly_sales
FROM orders
GROUP BY month
ORDER BY month;

-- **4. Revenue by Region**
SELECT c.region, SUM(o.amount) AS region_revenue
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region
ORDER BY region_revenue DESC;

-- **5. Average Order Value (AOV)**
SELECT AVG(amount) AS avg_order_value
FROM orders;

-- **6. Number of Repeat Customers**
SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1;

-- **7. Highest Single Day Revenue**
SELECT order_date, SUM(amount) AS daily_revenue
FROM orders
GROUP BY order_date
ORDER BY daily_revenue DESC
LIMIT 1;

-- **8. Rank Customers by Spend in Each Region (Window Function)**
SELECT 
    c.region,
    c.customer_name,
    SUM(o.amount) AS total_spent,
    RANK() OVER (PARTITION BY c.region ORDER BY SUM(o.amount) DESC) AS rank_in_region
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region, c.customer_name;


