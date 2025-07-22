-- Let's assume we have the following tables:

1. Customers
+-------------+--------------+-----------------+---------+-------------+
| customer_id |     name     |      email      | country | signup_date |
+-------------+--------------+-----------------+---------+-------------+
| 1           | John Doe     | john@email.com  | USA     | 2022-05-10  |
+-------------+--------------+-----------------+---------+-------------+
| 2           | Alice Smith  | alice@email.com | UK      | 2021-09-21  |
+-------------+--------------+-----------------+---------+-------------+
| 3           | Bob Johnson  | bob@email.com   | Canada  | 2023-03-05  |
+-------------+--------------+-----------------+---------+-------------+
| 4           | Maria Garcia | maria@email.com | Spain   | 2022-11-12  |
+-------------+--------------+-----------------+---------+-------------+

2. Orders
+----------+-------------+------------+--------+------------+
| order_id | customer_id | order_date | amount |   status   |
+----------+-------------+------------+--------+------------+
| 101      | 1           | 2023-01-15 | 250.50 | Shipped    |
+----------+-------------+------------+--------+------------+
| 102      | 2           | 2023-02-10 | 120.00 | Pending    |
+----------+-------------+------------+--------+------------+
| 103      | 3           | 2023-05-20 | 799.99 | Delivered  |
+----------+-------------+------------+--------+------------+
| 104      | 4           | 2023-07-22 | 999.98 | Processing |
+----------+-------------+------------+--------+------------+


3. Products
+------------+------------+-------------+--------+
| product_id |    name    |   category  |  price |
+------------+------------+-------------+--------+
| 1001       | Laptop     | Electronics | 999.99 |
+------------+------------+-------------+--------+
| 1002       | Phone      | Electronics | 499.99 |
+------------+------------+-------------+--------+
| 1003       | Headphones | Accessories | 149.99 |
+------------+------------+-------------+--------+
| 1004       | Monitor    | Electronics | 199.99 |
+------------+------------+-------------+--------+
| 1005       | Mouse      | Accessories | 49.99  |
+------------+------------+-------------+--------+


4. Order_Details (Many-to-Many Relationship)
+----------+------------+----------+
| order_id | product_id | quantity |
+----------+------------+----------+
| 101      | 1001       | 1        |
+----------+------------+----------+
| 102      | 1002       | 2        |
+----------+------------+----------+
| 103      | 1003       | 3        |
+----------+------------+----------+
| 103      | 1005       | 2        |
+----------+------------+----------+
| 104      | 1002       | 2        |
+----------+------------+----------+
| 104      | 1004       | 1        |
+----------+------------+----------+


--Questions


--1. List all customers who have placed an order
	SELECT DISTINCT c.customer_id, c.name
	FROM Customers c
	JOIN Orders o ON c.customer_id = o.customer_id;
	
	
--2. Find the most frequently purchased product
	SELECT p.name, SUM(od.quantity) AS total_quantity
	FROM Order_Details od
	JOIN Products p ON od.product_id = p.product_id
	GROUP BY p.name
	ORDER BY total_quantity DESC
	LIMIT 1;
	
	
--3. Identify customers who have not placed an order
	SELECT c.customer_id, c.name
	FROM Customers c
	LEFT JOIN Orders o ON c.customer_id = o.customer_id
	WHERE o.order_id IS NULL;
	
	
--4. Get the top 3 highest spending customers
	SELECT c.customer_id, c.name, SUM(o.amount) AS total_spent
	FROM Customers c
	JOIN Orders o ON c.customer_id = o.customer_id
	GROUP BY c.customer_id, c.name
	ORDER BY total_spent DESC
	LIMIT 3;
	
	
--5. Find the number of orders placed per month
	SELECT DATE_TRUNC('month', order_date) AS month, COUNT(*) AS order_count
	FROM Orders
	GROUP BY month
	ORDER BY month;
	
	
-- 6. Retrieve all orders placed in the last 6 months
	SELECT * FROM Orders
	WHERE order_date >= DATEADD(month, -6, GETDATE());


-- 7. Get the percentage of orders that are pending
	SELECT 
		(COUNT(CASE WHEN status = 'Pending' THEN 1 END) * 100.0 / COUNT(*)) AS pending_percentage
	FROM Orders;
	

-- 8. Find the second highest order amount
	SELECT DISTINCT amount FROM Orders
	ORDER BY amount DESC
	LIMIT 1 OFFSET 1;
	

-- 9. Rank customers by their total spending
	SELECT c.customer_id, c.name, SUM(o.amount) AS total_spent,
		   RANK() OVER (ORDER BY SUM(o.amount) DESC) AS spending_rank
	FROM Customers c
	JOIN Orders o ON c.customer_id = o.customer_id
	GROUP BY c.customer_id, c.name;


--10. Find the cumulative revenue per month
	SELECT DATE_TRUNC('month', order_date) AS month, 
		   SUM(amount) OVER (ORDER BY DATE_TRUNC('month', order_date)) AS cumulative_revenue
	FROM Orders;
	

--11. Get the first order date for each customer
	SELECT customer_id, MIN(order_date) AS first_order_date
	FROM Orders
	GROUP BY customer_id;
	
	
--12. Show the difference between each customer's first and last order
	SELECT customer_id, 
		   MIN(order_date) AS first_order, 
		   MAX(order_date) AS last_order,
		   DATEDIFF(day, MIN(order_date), MAX(order_date)) AS days_between_orders
	FROM Orders
	GROUP BY customer_id;


--13. Count the number of products ordered per category
	SELECT p.category, COUNT(od.product_id) AS total_products_ordered
	FROM Order_Details od
	JOIN Products p ON od.product_id = p.product_id
	GROUP BY p.category;


--14. Find the most recent orders along with customer details
	SELECT o.order_id, o.order_date, c.name, c.email
	FROM Orders o
	JOIN Customers c ON o.customer_id = c.customer_id
	ORDER BY o.order_date DESC
	LIMIT 5;


--15. Retrieve all orders along with their products in a single row per order
	SELECT o.order_id, 
			STRING_AGG(p.name, ', ') AS products_ordered
	FROM Orders o
	JOIN Order_Details od ON o.order_id = od.order_id
	JOIN Products p ON od.product_id = p.product_id
	GROUP BY o.order_id;


--16. Find customers who have placed more than 3 orders
	SELECT customer_id,
			COUNT(order_id) AS order_count
	FROM Orders
	GROUP BY customer_id
	HAVING COUNT(order_id) > 3;


--17. Calculate the running total of orders by date
	SELECT order_date, COUNT(*) AS daily_orders,
		   SUM(COUNT(*)) OVER (ORDER BY order_date) AS running_total
	FROM Orders
	GROUP BY order_date;


--18. Create a new table1 exactly like table2 without Data
	Create table table1 as
	select * from table2 
	where false;