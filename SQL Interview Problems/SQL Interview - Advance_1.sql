

-- MERCHANTS (DIM) Table
CREATE TABLE Merchants (
	merchant_id INTEGER PRIMARY KEY,
	marketplace VARCHAR(100),
	launch_date TIMESTAMP,
	product_desc VARCHAR(255),
	country_of_origin VARCHAR(100)
);

-- ORDERS (FACT) Table
CREATE TABLE Orders (
	merchant_id INTEGER,
	marketplace VARCHAR(100),
	order_id VARCHAR(50) PRIMARY KEY,
	sales DECIMAL(10,2),
	units INTEGER,
	order_date TIMESTAMP,
	FOREIGN KEY (merchant_id) REFERENCES Merchants(merchant_id)
);

-- Insert sample data into Merchants
INSERT INTO Merchants (merchant_id, marketplace, launch_date, product_desc, country_of_origin) VALUES
(1, 'Amazon', '2023-01-01 10:00:00', 'Electronics', 'USA'),
(2, 'eBay', '2022-06-15 12:30:00', 'Clothing', 'UK'),
(3, 'Walmart', '2021-09-10 08:45:00', 'Home Appliances', 'Canada');

-- Insert sample data into Orders
INSERT INTO Orders (merchant_id, marketplace, order_id, sales, units, order_date) VALUES
(1, 'Amazon', 'ORD123', 150.00, 2, '2024-03-01 14:20:00'),
(2, 'eBay', 'ORD124', 200.50, 3, '2024-03-02 16:10:00'),
(3, 'Walmart', 'ORD125', 75.00, 1, '2024-03-03 11:05:00'),
(1, 'Amazon', 'ORD126', 300.00, 5, '2024-03-04 18:30:00'),
(2, 'eBay', 'ORD127', 120.00, 2, '2024-03-05 09:15:00');
	


-- 1. What is the retention % and attrition % between February 2016 and February 2017?
	-- Retention % = (merchants active in both Feb 2016 and Feb 2017) ÷ (merchants active in Feb 2016) * 100
	-- Attrition % = (merchants from Feb 2016 who did NOT return in Feb 2017) ÷ (merchants active in Feb 2016) * 100
	
	WITH feb_2016 AS ( 
	SELECT DISTINCT merchant_id 
	FROM ORDERS 
	WHERE DATE(order_date) BETWEEN '2016-02-01' AND '2016-02-29' 
	), 
	feb_2017 AS ( 
	SELECT DISTINCT merchant_id 
	FROM ORDERS 
	WHERE DATE (order_date) BETWEEN '2017-02-01' AND '2017-02-28' 
	) 
	SELECT 
	(COUNT(f17.merchant_id) * 100.0/ COUNT(f16.merchant_id)) AS retention_rate, 
	((COUNT(f16.merchant_id) COUNT(f17.merchant_id)) * 100.0/ COUNT(f16.mercha 
	nt_id)) AS attrition_rate 
	FROM feb_2016 f16 
	LEFT JOIN feb_2017 f17 ON f16.merchant_id = f17.merchant_id;


-- 2. Write a SQL query to calculate the total sales for each marketplace.
	SELECT marketplace, SUM(sales) AS total_sales
	FROM Orders
	GROUP BY marketplace;
	
-- 3. Find the top 3 merchants with the highest total sales.
	SELECT merchant_id, SUM(sales) AS total_sales
	FROM Orders
	GROUP BY merchant_id
	ORDER BY total_sales DESC
	LIMIT 3;
	
-- 4. Write a query to find the total sales per month.
	SELECT DATE_TRUNC('month', order_date) AS month, SUM(sales) AS total_sales
	FROM Orders
	GROUP BY month
	ORDER BY month;
	
-- 5. Calculate the cumulative sales for each merchant over time.
	SELECT merchant_id, order_date, sales,
		   SUM(sales) OVER (PARTITION BY merchant_id ORDER BY order_date) AS cumulative_sales
	FROM Orders;
	
-- 6. Find the average sales per order for each marketplace.
	SELECT marketplace, AVG(sales) AS avg_order_value
	FROM Orders
	GROUP BY marketplace;
	
-- 7. Find the merchants who launched in the last year.
	SELECT * 
	FROM Merchants
	WHERE launch_date >= NOW() - INTERVAL '1 year';
	
-- 8. Find the number of orders each merchant has processed.
	SELECT merchant_id, COUNT(order_id) AS total_orders
	FROM Orders
	GROUP BY merchant_id;
	
-- 9. Find merchants whose total sales exceed the average total sales across all merchants.
	WITH MerchantSales AS (
		SELECT merchant_id, SUM(sales) AS total_sales
		FROM Orders
		GROUP BY merchant_id
	)
	SELECT merchant_id, total_sales
	FROM MerchantSales
	WHERE total_sales > (SELECT AVG(total_sales) FROM MerchantSales);
	
-- 10. Calculate the percentage contribution of each merchant's sales to the total sales.
	SELECT merchant_id, 
		   SUM(sales) AS merchant_sales,
		   (SUM(sales) * 100.0) / (SELECT SUM(sales) FROM Orders) AS percentage_contribution
	FROM Orders
	GROUP BY merchant_id;
	
-- 11. List merchants who have not received any orders.
	SELECT m.merchant_id, m.marketplace
	FROM Merchants m
	LEFT JOIN Orders o ON m.merchant_id = o.merchant_id
	WHERE o.merchant_id IS NULL;