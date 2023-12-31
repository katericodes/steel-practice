-- 1. What are the names of all the countries in the country table?
SELECT DISTINCT country_name
FROM country;
-- UK, USA, and China

-- 2. What is the total number of customers in the customers table?
SELECT COUNT(*) AS total_customers
FROM customers;
-- 8 total customers

-- 3. What is the average age of customers who can receive marketing emails (can_email is set to 'yes')?
SELECT AVG(age) AS average_age
FROM customers
WHERE can_email = "yes";
-- 37 years old

-- 4. How many orders were made by customers aged 30 or older?
SELECT COUNT(*) as total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.age >= 30;
-- 3 total orders made by customers aged 30 or older

-- 5. What is the total revenue generated by each product category?
SELECT p.product_id, SUM(price) AS revenue
FROM baskets b
JOIN products p
ON b.product_id = p.product_id
GROUP BY product_id
ORDER BY revenue desc;

/*
| product_id | revenue |
| ---------- | ------- |
| 2          | 37.47   |
| 3          | 34.95   |
| 5          | 31.98   |
| 1          | 23.96   |
| 4          | 1.78    |
*/

-- Product 2 had the most revenue, while Product 4 had the least.

-- 6. What is the average price of products in the 'food' category?
SELECT avg(price) as average_price
FROM products
WHERE category = 'food';
-- The average price of 'food' products is 3.44.

-- 7. How many orders were made in each sales channel (sales_channel column) in the orders table?
SELECT sales_channel, COUNT(*) AS total_orders
FROM orders
GROUP BY sales_channel;
-- There were 3 'online' orders, and 5 'retail' orders.

-- 8.What is the date of the latest order made by a customer who can receive marketing emails?
SELECT date_shop
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
WHERE can_email = 'yes'
ORDER BY date_shop desc
LIMIT 1;
-- The latest date is 2023-02-02.

-- 9. What is the name of the country with the highest number of orders?
SELECT country_name, count(*) as total_orders
FROM country c
JOIN orders o
ON c.country_id = o.country_id
GROUP BY country_name
ORDER BY total_orders desc
LIMIT 1;
-- The UK had the highest number of orders, at 5 total orders.

-- 10. What is the average age of customers who made orders in the 'vitamins' product category?
WITH baskets_vitamins AS ( -- tells us which baskets had vitamins
  SELECT DISTINCT b.order_id, category
  FROM baskets b
  JOIN products p
  ON b.product_id = p.product_id
  WHERE category = 'vitamins'
),
	customers_vitamins AS ( -- tells us which orders had the bsakets with vitamins and their details
      SELECT DISTINCT o.customer_id
      FROM orders o
      JOIN baskets_vitamins b
      ON o.order_id = b.order_id
      WHERE category = 'vitamins'
) 
SELECT avg(age) as average_age
FROM customers_vitamins v
JOIN customers c
ON v.customer_id = c.customer_id;
-- The average age is 32.5.