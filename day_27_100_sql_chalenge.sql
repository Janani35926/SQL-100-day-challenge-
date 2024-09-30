-- Day 27/100 Days SQL Challenge


-- You are working with a table called orders that tracks customer orders with their order dates and amounts. 

-- Write a query to find each customer’s latest order amount
-- along with the amount of the second latest order. 

-- Your output should be like 
-- customer_id, lastest_order_amount, second_lastest_order_amount    

USE challenge_day1_student;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10, 2)
);

INSERT INTO orders (order_id, customer_id, order_date, order_amount) VALUES
(1, 101, '2024-01-10', 150.00),
(2, 101, '2024-02-15', 200.00),
(3, 101, '2024-03-20', 180.00),
(4, 102, '2024-01-12', 200.00),
(5, 102, '2024-02-25', 250.00),
(6, 102, '2024-03-10', 320.00),
(7, 103, '2024-01-25', 400.00),
(8, 103, '2024-02-15', 420.00);

SELECT * FROM orders;

SELECT customer_id,
       MAX(CASE 
           WHEN  top_sales_Date=1 THEN order_amount END) AS lastest_order_amount,
	   MAX(CASE 
          WHEN  top_sales_Date=2 THEN order_amount END ) AS second_lastest_order_amount
          
FROM
		(SELECT customer_id,
                 order_date,
                 order_amount,
	             ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date DESC) AS top_sales_Date
		FROM orders) X
GROUP BY customer_id;


