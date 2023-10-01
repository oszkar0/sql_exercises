/*
1. Table customers:
	customer_id (Primary Key): Unique identifier for each customer.
	first_name: First name of the customer.
	last_name: Last name of the customer.
	email: Email address of the customer.
	phone: Phone number of the customer.

2. Table products:
	product_id (Primary Key): Unique identifier for each product.
	product_name: Name of the product.
	category: Category to which the product belongs (e.g., Electronics, Clothing).
	price: Price of the product.

3. Table orders:
	order_id (Primary Key): Unique identifier for each order.
	customer_id (Foreign Key): References the customer_id in the customers table, linking each order to a customer.
	order_date: Date when the order was placed.

4. Table order_details:
	order_detail_id (Primary Key): Unique identifier for each order detail.
	order_id (Foreign Key): References the order_id in the orders table, linking each detail to an order.
	product_id (Foreign Key): References the product_id in the products table, specifying the product in the order detail.
	quantity: Quantity of the product in the order detail.
    
Tasks:

1. Select all products in the "Electronics" category with a price greater than 500.
2. Count how many orders each customer has placed.
3. Calculate the total order value (sum of product prices multiplied by their quantity) for each order.
4. Find the top three customers who spent the most money on purchases.
5. Calculate the average price of products in the "Clothing" category.
6. Find the dates on which orders were placed.
7. Identify products that have not been ordered yet.
8. Select all customers who placed at least one order in the year 2023.
9. Find the product that has been ordered the most.
10. Calculate the total quantity of products in each category.
*/

DROP SCHEMA IF EXISTS clients_orders;
CREATE SCHEMA clients_orders;
USE clients_orders;

-- Create the customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
);

-- Insert data into the customers table
INSERT INTO customers (customer_id, first_name, last_name, email, phone)
VALUES
    (1, 'John', 'Smith', 'john@example.com', '555-123-4567'),
    (2, 'Jane', 'Doe', 'jane@example.com', '555-987-6543'),
    (3, 'Mike', 'Johnson', 'mike@example.com', '555-555-5555'),
    (4, 'Sarah', 'Brown', 'sarah@example.com', '555-111-2222');

-- Create the products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Insert data into the products table
INSERT INTO products (product_id, product_name, category, price)
VALUES
    (101, 'Laptop', 'Electronics', 800.00),
    (102, 'Smartphone', 'Electronics', 600.00),
    (103, 'T-shirt', 'Clothing', 20.00),
    (104, 'Jeans', 'Clothing', 50.00),
    (105, 'Headphones', 'Electronics', 100.00),
    (106, 'Keyboard', 'Electronics', 1100.00);

-- Create the orders table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert data into the orders table
INSERT INTO orders (order_id, customer_id, order_date)
VALUES
    (501, 1, '2023-01-15'),
    (502, 2, '2023-02-20'),
    (503, 1, '2023-03-25'),
    (504, 3, '2023-04-10');

-- Create the order_details table
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert data into the order_details table
INSERT INTO order_details (order_detail_id, order_id, product_id, quantity)
VALUES
    (1, 501, 101, 2),
    (2, 501, 103, 3),
    (3, 502, 102, 1),
    (4, 503, 105, 2),
    (5, 504, 104, 4);
    
-- 1. Select all products in the "Electronics" category with a price greater than 500.

SELECT p.product_id, p.product_name, p.price
FROM products p
WHERE p.category = 'Electronics' AND price > 500.0;

-- 2. Count how many orders each customer has placed.

SELECT c.customer_id AS 'Customer id', CONCAT(c.first_name, ' ', c.last_name)  AS 'Customer', COUNT(o.order_id) AS 'Orders made'  
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.customer_id 
GROUP BY c.customer_id;

-- 3. Calculate the total order value (sum of product prices multiplied by their quantity) for each order.
SELECT o.order_id AS 'Order id', SUM(od.quantity * p.price) AS 'Total price of order'
FROM orders o
JOIN order_details od ON od.order_id = o.order_id
JOIN products p ON p.product_id = od.product_id 
GROUP BY o.order_id;

-- 4. Find the top two customers who spent the most money on purchases.

SELECT c.customer_id AS 'Customer id', CONCAT(c.first_name, ' ', c.last_name) AS 'Customer name', SUM(od.quantity * p.price) as 'Money spent on orders'
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_details od ON od.order_id = o.order_id
JOIN products p ON p.product_id = od.product_id
GROUP BY c.customer_id
ORDER BY SUM(od.quantity * p.price) DESC
LIMIT 2;

-- 5. Calculate the average price of products in each category.

SELECT p.category AS 'Category', AVG(p.price) as 'Average price of products'
FROM products p
GROUP BY p.category;

-- 6. Find average order count on each day e.g Monday: 10 in last year

SELECT day_of_week, AVG(order_count) as 'Average orders by day'
FROM (
	SELECT DAYOFWEEK(o.order_date) AS day_of_week, COUNT(o.order_id) as order_count
	FROM orders o 
	WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
	GROUP BY o.order_date
    ) AS count_of_orders_by_day
GROUP BY day_of_week;

-- 7. Identify products that have not been ordered yet.

SELECT p.product_id, p.product_name
FROM products p 
WHERE p.product_id NOT IN (
	SELECT product_id
    FROM order_details
);

-- 8. Select all customers who placed at least one order in the year 2023.

SELECT c.customer_id, c.first_name, c.last_name
FROM orders o 
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.order_date >= '2023-01-01' AND o.order_date < '2024-01-01'; 

-- 9. Find the product that has been ordered the most.

SELECT p.product_id, p.product_name, SUM(od.quantity) as order_count
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_id
ORDER BY order_count DESC
LIMIT 1;

-- 10. Calculate the total quantity of products in each category.

SELECT p.category, COUNT(*) as 'Products in category'
FROM products p
GROUP BY p.category;

-- 11. Find customers who have placed orders in two different categories

SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON od.order_id = o.order_id
JOIN products p ON p.product_id = od.product_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT(p.category)) = 2 


