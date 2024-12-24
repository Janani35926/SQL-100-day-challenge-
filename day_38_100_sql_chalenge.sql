-- Day 38/100 DAYS SQL CHALLENGE

-- Walmart SQL Question

DROP TABLE IF EXISTS Transactions;

CREATE TABLE Transactions
(transaction_id int, day timestamp, amount int);

insert into Transactions (transaction_id, day, amount) 
values 
('8', '2021-4-3 15:57:28', '57'),
('9', '2021-4-28 08:47:25', '21'),
('1', '2021-4-29 13:28:30', '58'),
('5', '2021-4-28 16:39:59', '40'),
('6', '2021-4-29 23:39:28', '58'),
('10', '2021-4-3 16:57:28', '57');

SELECT * FROM transactions;


-- Write an SQL query to report the IDs of the transactions
-- with the maximum amount on their respective day. 

-- If in one day there are multiple such transactions, return all of them.

                            
-- APPROACH ONE USING JOINS                            
SELECT t1.transaction_id, 
       DATE(t1.day) AS derived_date,
       t1.day,
       t1.amount
FROM transactions t1
JOIN (
    SELECT DATE(day) AS derived_date, 
           MAX(amount) AS max_amount
    FROM transactions
    GROUP BY DATE(day)
) t2
ON DATE(t1.day) = t2.derived_date AND t1.amount = t2.max_amount
ORDER BY derived_date;

-- APPROACH TWO USING CTE AND WINDOWS FUNCTION
WITH RankedTransactions AS (
    SELECT 
        transaction_id,
        DATE(day) AS derived_date,
        day,
        amount,
        DENSE_RANK() OVER (PARTITION BY DATE(day) ORDER BY amount DESC) AS r
    FROM transactions
)
SELECT transaction_id, 
       derived_date, 
       day
FROM RankedTransactions
WHERE r = 1;


