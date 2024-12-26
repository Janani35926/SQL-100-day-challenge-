-- Day 40/100
-- Amazon 


CREATE TABLE IF NOT EXISTS Delivery (
    delivery_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);


INSERT INTO Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) VALUES
(1, 1, '2019-08-01', '2019-08-02'),
(2, 2, '2019-08-02', '2019-08-02'),
(3, 1, '2019-08-11', '2019-08-12'),
(4, 3, '2019-08-24', '2019-08-24'),
(5, 3, '2019-08-21', '2019-08-22'),
(6, 2, '2019-08-11', '2019-08-13'),
(7, 4, '2019-08-09', '2019-08-09');

SELECT * FROM delivery;


-- Problem Statement
-- SQL Query
-- Write an SQL query to calculate the percentage of immediate orders 
-- among the first orders of all customers. 
-- The result should be rounded to 2 decimal places.

-- Definitions:
-- If the preferred delivery date of the customer is the same as the order date,
-- then the order is classified as "immediate." Otherwise, it is classified as "scheduled."


WITH allocating_immediate_orders AS(
                                     SELECT *,
                                            ROW_NUMBER() OVER(PARTITION BY delivery_id ORDER BY order_date) AS rn
									FROM delivery
                                    ),
classified_orders_immediate AS(
                                SELECT CASE WHEN order_date = customer_pref_delivery_date THEN 'immediate'
                                            ELSE 'scheduled' 
                                            END AS status
								FROM allocating_immediate_orders
							   ),
                               
immediate_status_percent AS(
                             SELECT ROUND(SUM(CASE WHEN status = 'immediate' THEN 1 ELSE 0 END ) * 100 / COUNT(*), 2) AS orders
                             FROM classified_orders_immediate
                             )
SELECT * FROM immediate_status_percent








