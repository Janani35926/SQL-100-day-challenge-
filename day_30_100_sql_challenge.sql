-- Day 30/100 Challenge
-- Google Data Analyst Interview Question

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);


INSERT INTO Employees (id, name, manager_id)
VALUES
    (1, 'Alice', NULL),
    (2, 'Bob', 1),
    (3, 'Charlie', 2),
    (4, 'David', 2),
    (5, 'Eve', 3),
    (6, 'Frank', 3),
    (7, 'Grace', 4);


SELECT * FROM Employees

/*
Question:
You have a table called Employees with the following columns:
id: A unique number for each employee.
name: The name of the employee.
manager_id: The id of the employee’s manager (this can be NULL if the employee has no manager).

Write a SQL query to show each employee's name along with their level in the company hierarchy. 
The level should start at 1 for employees who don’t have a manager (they are at the top of the hierarchy).

*/;

WITH RECURSIVE initial_case AS (
      #BASE CASE
       SELECT id,
			  name,
              manager_id,
              1 AS level
	     FROM Employees
         WHERE manager_id IS NULL
	#RECURSIVE CASE joining employees with their manager and incrementing its level
      UNION ALL
       SELECT E.id,
              E.name,
              E.manager_id,
              I_c.level+1 AS level 
		FROM Employees E
        JOIN
         initial_case I_c 
         ON
         E.manager_id= I_C.id)
SELECT id,
       name,
       manager_id,
       level
FROM initial_case
      
              