-- Day 37/100
-- Flipkart

Create table If Not Exists Logs (Id int, Num int);

insert into Logs (Id, Num) values ('1', '1');
insert into Logs (Id, Num) values ('2', '1');
insert into Logs (Id, Num) values ('3', '1');
insert into Logs (Id, Num) values ('4', '2');
insert into Logs (Id, Num) values ('5', '1');
insert into Logs (Id, Num) values ('6', '2');
insert into Logs (Id, Num) values ('7', '2');


-- Problem statement
-- Table: Logs

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | num         | varchar |
-- +-------------+---------+
-- id is the primary key for this table.

-- Write an SQL query to find all numbers that appear at least three times consecutively.

-- Return the result table in any order.
SELECT * FROM Logs;

WITH lag_lead_logs AS(
                  SELECT Id,
                         Num,
                         LAG(Num) OVER(ORDER BY Id ) AS previous_log,             # fetching previous value for matching
                         LEAD(Num) OVER(ORDER BY Id) AS Succeeding_log            # fetching preceeding value for matching
				 FROM Logs
                         )
SELECT Num FROM lag_lead_logs
WHERE Num=previous_log AND
      Num=Succeeding_log
