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
