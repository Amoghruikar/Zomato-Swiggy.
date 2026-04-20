CREATE DATABASE Zomato_Swiggy;
USE Zomato_Swiggy;

CREATE TABLE Customers (
     customer_id INT PRIMARY KEY,
     name VARCHAR(50),
     city VARCHAR(50)
);

INSERT INTO Customers
(customer_id, name, city)
VALUES
(1,"Rahul","Mumbai"),
(2,"Priya","Delhi"),
(3,"Amit","Bangalore"),
(4,"Sneha","Pune"),
(5,"Arjun","Mumbai");


CREATE TABLE Restaurant (
	 restaurant_id INT PRIMARY KEY,
     name VARCHAR(50),
     cuisine VARCHAR(50)
);

INSERT INTO Restaurant 
(restaurant_id, name, cuisine)
VALUES
(101,"Spice Hub","Indian"),
(102,"Pizza Palace","Italian"),
(103,"Burger Point","Fast Food"),
(104,"Biryani House","Mughlai"),
(105,"Sushi World","Japanese");


CREATE TABLE Orders (
     order_id INT PRIMARY KEY,
     customer_id INT,
     restaurant_id INT,
     order_date DATETIME,
     order_amount DECIMAL
);

INSERT INTO orders
(order_id, customer_id, restaurant_id, order_date, order_amount)
VALUES
(1001,1,101,"2024-01-10 19:30:00","450"),
(1002,2,102,"2024-01-11 20:00:00","600"),
(1003,3,103,"2024-01-12 21:15:00","300"),
(1004,1,104,"2024-01-15 21:15:00","700"),
(1005,4,101,"2024-02-01 18:45:00","250"),
(1006,5,105,"2024-02-01 13:00:00","900"),
(1007,2,103,"2024-02-05 21:00:00","350"),
(1008,3,104,"2024-02-10 19:00:00","800");


CREATE TABLE Order_Items (
     order_id INT,
     item_name VARCHAR(50),
     quantity INT,
     price DECIMAL
);

INSERT INTO order_items
(order_id, item_name, quantity, price)
VALUES
(1001,"Paneer Butter Masala",1,"250"),
(1001,"Naan",2,"100"),
(1002,"Margherita Pizza",1,"600"),
(1003,"Veg Burger",2,"150"),
(1004,"Chicken Biryani",1,"700"),
(1005,"Dal Fry",1,"250"),
(1006,"Sushi Roll",2,"450"),
(1007,"Chicken Burger",1,"350"),
(1008,"Mutton Biryani",1,"800");

-- Total Number of Orders
SELECT COUNT(*) FROM orders;

-- Total revenue
SELECT SUM(order_amount) FROM orders;

-- Average order values
SELECT AVG(order_amount) FROM orders;

-- Unique Customers 
SELECT COUNT(DISTINCT customer_id) FROM orders;

-- orders from mumbai customers
SELECT * FROM orders o
JOIN customers C ON O.customer_id =
c.customer_id
WHERE c.city = 'Mumbai';

-- List all restraunts
SELECT * FROM restaurant;

-- Highest order amount
SELECT MAX(order_amount) FROM orders;

-- Lowest order amount
SELECT MIN(order_amount) FROM orders;

-- Total item ordered
SELECT SUM(quantity) FROM order_items;

-- List all item names
SELECT DISTINCT item_name FROM
order_items;

-- Data Cleaning
-- Find null values
SELECT * FROM orders
WHERE order_amount IS NULL;

-- Replace NULL with 0
SELECT IFNULL(order_amount, 0) FROM orders;

-- Count NULLs
SELECT COUNT(*)
FROM orders
WHERE order_amount IS NULL;

-- Remove duplicates
SELECT DISTINCT * FROM customers;

-- Detect duplicate customers
SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Fix date formate 
SELECT DATE(order_date) FROM orders;

-- Extract month 
SELECT MONTH(order_date) FROM orders;

-- Extract Years
SELECT YEAR(order_date) FROM orders;

-- Trim Space
SELECT TRIM(name) FROM customers;

-- Convert to uppercase
SELECT UPPER(name) FROM customers;

-- 	GROUP BY
-- Revenue per customer
SELECT customer_id, SUM(order_amount)
FROM orders
GROUP BY customer_id;

-- Revenue per restaurant
SELECT restaurant_id, SUM(order_amount)
FROM orders
GROUP BY restaurant_id;

-- Orders per city
SELECT c.city, COUNT(*)
FROM orders o
JOIN customers c ON o.customer_id = 
c.customer_id
GROUP BY c.city;

-- Avg order per city
SELECT c.city, AVG(order_amount)
FROM orders o
JOIN customers c ON o.customer_id =
c.customer_id
GROUP BY c.city;

-- Items count per order
SELECT order_id, SUM(quantity)
FROM order_items
GROUP BY order_id;  

-- Top selling item
SELECT item_name, SUM(quantity)
FROM order_items
GROUP BY item_name
ORDER BY SUM(quantity) DESC
LIMIT 1;

-- Orders per restaurant
SELECT restaurant_id, COUNT(*)
FROM orders
GROUP BY restaurant_id;

-- Max order per customer
SELECT customer_id, MAX(order_amount)
FROM orders
GROUP BY customer_id;

-- Min order per customer
SELECT customer_id, MIN(order_amount)
FROM orders
GROUP BY customer_id;

-- Total revenue per city
SELECT c.city, SUM(order_amount)
FROM orders o
JOIN customers c ON o.customer_id =
c.customer_id
GROUP BY c.city;

-- JOINS
-- Orders with customer name
SELECT o.order_id, c.name
FROM orders o
JOIN customers c ON o.customer_id = 
c.customer_id;

-- Orders with restaurant name
SELECT o.order_id, r.name
FROM orders o 
JOIN restaurant r ON o.restaurant_id = 
r.restaurant_id;

-- Full order details
SELECT o.*, c.name, r.name
FROM orders o
JOIN customers c ON o.customer_id = 
c.customer_id
JOIN restaurant r ON o.restaurant_id = 
r.restaurant_id;

-- Orders + items
SELECT o.order_id, oi.item_name
FROM orders o
JOIN order_items oi ON o.order_id =
oi.order_id;

-- Left join example
SELECT c.name, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = 
o.customer_id;

-- Customers without orders 
SELECT c.name
FROM customers c
LEFT JOIN orders o ON c.customer_id = 
o.customer_id
WHERE o.order_id IS NULL;

-- Restaurant-wise items
SELECT r.name, oi.item_name
FROM restaurant r
JOIN orders o ON r.restaurant_id = 
o.restaurant_id
JOIN order_items oi ON o.order_id =
oi.order_id;
   
-- Customer + item list
SELECT c.name, oi.item_name
FROM customers c
JOIN orders o ON c.customer_id = 
o.customer_id
JOIN order_items oi ON o.order_id = 
oi.order_id;

-- Orders with city
SELECT o.order_id, c.city
FROM orders o
JOIN customers c ON o.customer_id = 
c.customer_id;
 
-- Revenue by restaurant name
SELECT r.name, SUM(order_amount)
FROM orders o
JOIN restaurant r ON o.restaurant_id = 
r.restaurant_id
GROUP BY r.name;

-- Subqueries
-- Customers with highest order
SELECT customer_id
FROM orders 
WHERE order_amount = (SELECT 
MAX(order_amount) FROM orders);

-- Orders above average 
SELECT * 
FROM orders 
WHERE order_amount > (SELECT 
AVG(order_amount) FROM orders);

-- Restaurants with high revenue
SELECT restaurant_id
FROM orders
GROUP BY restaurant_id
HAVING SUM(order_amount) > 1000;

-- Customers with more than 1 order
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Items ordered in max order
SELECT * 
FROM order_items
WHERE order_id = (SELECT order_id FROM 
orders ORDER BY order_amount DESC LIMIT
1);

-- Orders of top customer
SELECT * 
FROM orders
WHERE customer_id = (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id 
    ORDER BY SUM(order_amount) DESC
    LIMIT 1 
);

-- Restaurant with max orders
SELECT restaurant_id
FROM orders 
GROUP BY restaurant_id
ORDER BY COUNT(*) DESC 
LIMIT 1;

-- Items with max quantity
SELECT *
FROM order_items
WHERE quantity = (SELECT MAX(quantity)
FROM order_items);

-- Customers with minimum speed
SELECT customer_id
FROM orders
GROUP BY customer_id
ORDER BY SUM(order_amount)
LIMIT 1;

-- Orders in latest date
SELECT *
FROM orders 
WHERE order_date = (SELECT
MAX(order_date) FROM orders);

-- Window Functions + CTE 
-- Rank orders by amount
SELECT order_id, order_amount,
RANK() OVER (order by order_amount DESC)
AS rank_no
FROM orders;

-- Row number
SELECT order_id,
ROW_NUMBER() OVER (ORDER BY order_amount
DESC)  
FROM orders;

-- Dense rank
SELECT order_id,
DENSE_RANK() OVER (ORDER BY order_amount DESC)
FROM orders;

-- Running total
SELECT order_id,
SUM(order_amount) OVER (ORDER BY
order_id)
FROM orders;

-- Avg per customer (window)
SELECT customer_id,
AVG(order_amount) OVER (PARTITION BY customer_id)
FROM orders;

-- CTE example
WITH revenue AS (
   SELECT customer_id,
SUM(order_amount) AS total
   FROM orders
   GROUP BY customer_id
)
SELECT * FROM revenue;

-- Top customer using CTE
WITH t AS (
    SELECT customer_id,
SUM(order_amount) total
    FROM orders
    GROUP BY customer_id
)
SELECT * FROM t ORDER BY total DESC 
LIMIT 1;

-- Rank per restaurant
SELECT restaurant_id,
RANK() OVER (PARTITION BY restaurant_id ORDER BY order_amount DESC)
FROM orders;

-- Lag function
SELECT order_id, order_amount,
LAG(order_amount) OVER (ORDER BY order_id)
FROM orders;

-- Lead function 
SELECT order_id, order_amount,
LEAD(order_amount) OVER (ORDER BY order_id)
FROM orders;