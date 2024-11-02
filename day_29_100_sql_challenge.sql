-- 29/100 days challenge
/*
Zomato's delivery system encountered an issue where each item's order was swapped with the next item's order. 
Your task is to correct this swapping error and return the proper pairing of order IDs and items. 
If the last item has an odd order ID, it should remain as the last item in the corrected data.
Write an SQL query to correct the swapping error and produce the corrected order pairs.
*/
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    item VARCHAR(255) NOT NULL
);

INSERT INTO orders (order_id, item) VALUES
(1, 'Chow Mein'),
(2, 'Pizza'),
(3, 'Veg Nuggets'),
(4, 'Paneer Butter Masala'),
(5, 'Spring Rolls'),
(6, 'Veg Burger'),
(7, 'Paneer Tikka');
SELECT * FROM orders;
#method 1

WITH paried_orders AS(
	SELECT order_id AS incorrect_order_id,
           CASE
               WHEN MOD(order_id,2) <> 0 AND EXISTS (SELECT 1 FROM orders O1 WHERE O1.order_id=orders.order_id+1)
                            THEN order_id+1
			   WHEN MOD(order_id,2) = 0 THEN  order_id - 1
              ELSE order_id
			END AS correct_order_id,
            item
	FROM orders)
SELECT correct_order_id AS order_id,
       item
FROM paried_orders
ORDER BY order_id;

# method 2 using JOIN.

WITH ordered_items AS(
        SELECT 
               COUNT(*)
		FROM orders)
SELECT * FROM ordered_items;

WITH new_orders
AS
(
SELECT 
	COUNT(*) as total_orders 
FROM orders
)
SELECT 
	 order_id as incorrect_order_id,
	 CASE
	 	WHEN order_id % 2 <> 0 AND order_id <> total_orders 
		 	THEN order_id + 1
		 WHEN order_id % 2 <> 0 AND order_id = total_orders 
		 	THEN order_id
		ELSE order_id - 1
	 END as correct_order_id,
	 item
FROM new_orders
JOIN 
orders
ORDER BY 2
