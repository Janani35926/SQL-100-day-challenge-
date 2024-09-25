-- DAY1  30/08/2024
CREATE DATABASE challenge_day1_student;
USE challenge_day1_student;
CREATE TABLE student_batch (
    StudentID INT,
    CourseID INT,
    EnrollmentYear INT
);

INSERT INTO student_batch (StudentID, CourseID, EnrollmentYear) VALUES
(1, 101, 2019),
(1, 102, 2019),
(1, 103, 2019),
(1, 104, 2019),
(1, 105, 2019),
(1, 106, 2019),
(1, 107, 2019),
(1, 108, 2019),
(1, 109, 2019),
(1, 110, 2019),
(2, 101, 2019),
(2, 102, 2019),
(2, 103, 2019),
(2, 104, 2019),
(2, 105, 2019),
(2, 106, 2019),
(2, 107, 2019),
(2, 108, 2019),
(2, 109, 2019),
(2, 110, 2019),
(3, 101, 2019),
(3, 102, 2019),
(3, 103, 2019),
(3, 104, 2019),
(3, 105, 2019),
(3, 106, 2019),
(3, 107, 2019),
(3, 108, 2019),
(4, 101, 2019),
(4, 102, 2019),
(4, 103, 2019),
(4, 104, 2019),
(4, 105, 2019),
(4, 106, 2019),
(4, 107, 2019),
(4, 108, 2019),
(4, 109, 2019),
(1, 105, 2020),
(1, 106, 2020),
(3, 107, 2020),
(4, 108, 2019),
(4, 109, 2020),
(2, 106, 2020),
(1, 107, 2020),
(4, 110, 2020),
(4, 111, 2020);
SELECT * FROM student_batch;

-- Ques-1=To select the distinct course_id and student_id and its count
SELECT StudentID
FROM student_batch
WHERE EnrollmentYear=2019
GROUP BY 1
HAVING COUNT(DISTINCT(CourseID))= (SELECT COUNT(DISTINCT(CourseID))
								   FROM student_batch 
                                   WHERE EnrollmentYear=2019);
-- Ques2=performing right join in numeric columns
CREATE TABLE t1(c1 INT);

CREATE TABLE t2(c2 VARCHAR(3));

INSERT INTO t1
VALUES
(4),
(6),
(7),
(9),
(3),
(9);

INSERT INTO t2
VALUES
(1),
(5),
(9),
(2),
(2),
(11);
ALTER TABLE t2 
MODIFY C2 INT;
SELECT t1.c1 
FROM
t1 RIGHT JOIN t2 ON t1.c1=t2.c2;

/*                 02/09/2024
-- 02 of 100 Days Challenge
-- Amazon Interview questions by Abbas


--Considering the below three tables, write a query that would:

i. List out the department wise maximum salary, minimum salary, average salary of the employees. 
ii. List out employee having the third highest salary.
iii. List out the department having at least four employees.
iv. Find out the employees who earn greater than the average salary for their department.
*/
-- create table department.
DROP TABLE IF EXISTS department;
CREATE TABLE department (
    Department_ID INT PRIMARY KEY,
    Department VARCHAR(50),
    Location_ID INT
);

-- Insert data into department table
INSERT INTO department (Department_ID, Department, Location_ID)
VALUES 
    (10, 'Accounting', 122),
    (20, 'Research', 124),
    (30, 'Sales', 123),
    (40, 'Operations', 167);
    
-- Create emp_fact table
DROP TABLE IF EXISTS emp_fact;
CREATE TABLE emp_fact (
    Employee_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Job_ID INT,
    Manager_ID INT,
    Hired_Date DATE,
    Salary DECIMAL(10, 2),
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES department(Department_ID)
);

-- Insert data into emp_fact table
INSERT  INTO emp_fact (Employee_ID, Emp_Name, Job_ID, Manager_ID, Hired_Date, Salary, Department_ID)
VALUES 
    (7369, 'John', 667, 7902, '2006-02-20', 800.00, 10),
    (7499, 'Kevin', 670, 7698, '2008-11-24', 1550.00, 20),
    (7505, 'Jean', 671, 7839, '2009-05-27', 2750.00, 30),
    (7506, 'Lynn', 671, 7839, '2007-09-27', 1550.00, 30),
    (7507, 'Chelsea', 670, 7110, '2014-09-14', 2200.00, 30),
	(7521, 'Leslie', 672, 7698, '2012-02-06', 1250.00, 30);
    
-- Create jobs table
DROP TABLE IF EXISTS jobs;
CREATE TABLE jobs (
    Job_ID INT PRIMARY KEY,
    Job_Role VARCHAR(50),
    Salary DECIMAL(10, 2)
);

-- Insert data into jobs table
INSERT INTO jobs (Job_ID, Job_Role, Salary)
VALUES 
    (667, 'Clerk', 800.00),
    (668, 'Staff', 1600.00),
    (669, 'Analyst', 2850.00),
    (670, 'Salesperson', 2200.00),
    (671, 'Manager', 3050.00),
    (672, 'President', 1250.00);
    
SELECT * FROM department;
SELECT * FROM emp_fact;
SELECT * FROM jobs;

-- i. List out the department wise maximum salary, minimum salary, average salary of the employees.
CREATE TEMPORARY TABLE salary_wise AS (
SELECT D.Department, 
			   E.Department_ID, 
			   J.salary
		FROM emp_fact E
		LEFT JOIN jobs J
		ON E.Job_ID= J.Job_ID
		LEFT JOIN Department D
		ON E.Department_ID=D.Department_ID);
SELECT MAX(salary), 
       MIN(salary),
	   ROUND(AVG(salary),2),
       Department
FROM salary_wise
GROUP BY  Department;

-- ii. List out employee having the third highest salary.
SELECT Employee_ID,
       Emp_Name,
       Salary
FROM emp_fact
ORDER BY  Salary DESC
LIMIT 1
OFFSET 2;

-- List out the department having at least four employees.
SELECT COUNT(E.Employee_ID) AS SA_COUNT,
       E.Department_ID,
       D.Department
FROM emp_fact E 
LEFT JOIN Department D
ON E.Department_ID=D.Department_ID
GROUP BY D.Department, E.Department_ID
HAVING COUNT(E.Employee_ID) >=4;

-- iv. Find out the employees who earn greater than the average salary for their department.
SELECT E1.Employee_ID,
       E1.Emp_Name,
       E1.Salary,
       E1.Department_ID 
FROM emp_fact E1
WHERE E1.Salary>(SELECT AVG(E2.Salary)
                 FROM emp_fact E2
                 WHERE E1.Department_ID=E2.Department_ID);
     
SELECT
    AVG(salary)
FROM emp_fact
WHERE department_id = 30;

-- Day 03/100     02/09/2024

-- Create the student_details table
CREATE TABLE students (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Gender CHAR(1)
);

-- Insert the data into the student_details table
INSERT INTO students (ID, Name, Gender) VALUES
(1, 'Gopal', 'M'),
(2, 'Rohit', 'M'),
(3, 'Amit', 'M'),
(4, 'Suraj', 'M'),
(5, 'Ganesh', 'M'),
(6, 'Neha', 'F'),
(7, 'Isha', 'F'),
(8, 'Geeta', 'F');

/*
Given table student_details, 
write a query which displays names 
alternately by gender and sorted 
by ascending order of column ID.
*/
SELECT * FROM students;
WITH CTE AS(
    SELECT *, 
          RANK() OVER(PARTITION BY gender ORDER BY id) AS rn1
	FROM students),
CTE1 AS 
		(
		 SELECT ID,
				Name,
				Gender,
				rn1
		 FROM CTE
		 ORDER BY 
               rn1
				  )
SELECT ID,
		Name,
		Gender,
		rn1 FROM CTE1;
        
-- Day 04/100 days challenge


CREATE TABLE employees (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Manager_ID INT
);


INSERT INTO employees (Emp_ID, Emp_Name, Manager_ID) VALUES
(1, 'John', 3),
(2, 'Philip', 3),
(3, 'Keith', 7),
(4, 'Quinton', 6),
(5, 'Steve', 7),
(6, 'Harry', 5),
(7, 'Gill', 8),
(8, 'Rock', NULL);


-- 2.2 Given table employees, write a 
-- query to display employee names along with manager names
SELECT * FROM employees;
SELECT 
     E1.Emp_ID,
	 E1.Emp_Name,
     E1.Manager_ID,
     E2.Emp_Name AS man_name
FROM employees E1
LEFT JOIN employees E2 ON
E1.Emp_ID= E2.Manager_ID;

-- day 05/100 days SQL Interview questions
USE challenge_day1_student;
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    store_name VARCHAR(50),
    sale_date DATE,
    sales_amount DECIMAL(10, 2)
);


INSERT INTO sales (store_name, sale_date, sales_amount) 
VALUES
('A', '2024-01-01', 1000.00),
('A', '2024-02-01', 1500.00),
('A', '2024-03-01', 2000.00),
('A', '2024-04-01', 3000.00),
('A', '2024-05-01', 4500.00),
('A', '2024-06-01', 6000.00),
('B', '2024-01-01', 2000.00),
('B', '2024-02-01', 2200.00),
('B', '2024-03-01', 2400.00),
('B', '2024-04-01', 2600.00),
('B', '2024-05-01', 2800.00),
('B', '2024-06-01', 3000.00),
('C', '2024-01-01', 3000.00),
('C', '2024-02-01', 3100.00),
('C', '2024-03-01', 3200.00),
('C', '2024-04-01', 3300.00),
('C', '2024-05-01', 3400.00),
('C', '2024-06-01', 3500.00);

/* 
-- Walmart SQL question for Data Analyst


Calculate each store running total
Growth ratio compare to previous month
return store name, sales amount, running total, growth ratio
*/

SELECT * FROM sales ;
WITH CTE1 AS
			(SELECT *,
				   SUM(sales_amount) OVER(PARTITION BY store_name order by sale_date ) AS running_total,
				   LAG(sales_amount,1) OVER(PARTITION BY store_name order by sale_date ) AS last_month_sales
			 FROM  sales)
SELECT store_name,
       sale_date,
       sales_amount,
       running_total,
       last_month_sales,
       ((sales_amount-  last_month_sales)/last_month_sales) * 100 AS GROWTH_RATIO
FROM CTE1;

-- Day 06/100 days challenge!

-- Write SQL Query to Find Employees with at Least 3 Year-over-Year Salary Increases


DROP TABLE IF EXISTS employee_salary;
-- Create the table with employee name
CREATE TABLE employee_salary (
    employee_id INTEGER,
    name VARCHAR(255),
    year INTEGER,
    salary INTEGER,
    department VARCHAR(255)
);

-- Insert sample data with employee names
INSERT INTO employee_salary (employee_id, name, year, salary, department) VALUES
(125, 'John Doe', 2021, 50000, 'Sales'),
(125, 'John Doe', 2022, 52000, 'Sales'),
(125, 'John Doe', 2023, 54000, 'Sales'),
(125, 'John Doe', 2024, 56000, 'Sales'),
(102, 'Jane Smith', 2020, 45000, 'Marketing'),
(102, 'Jane Smith', 2021, 47000, 'Marketing'),
(102, 'Jane Smith', 2022, 49000, 'Marketing'),
(102, 'Jane Smith', 2023, 51000, 'Marketing'),
(165, 'Alice Johnson', 2021, 60000, 'Engineering'),
(165, 'Alice Johnson', 2022, 62000, 'Engineering'),
(165, 'Alice Johnson', 2023, 64000, 'Engineering'),
(200, 'Bob Brown', 2021, 55000, 'HR'),
(200, 'Bob Brown', 2022, 57000, 'HR'),
(200, 'Bob Brown', 2023, 58000, 'HR');
SELECT * FROM employee_salary;
SELECT employee_id,
       name,
       department,
       COUNT(count_of_1) AS total_count
FROM
     (SELECT *, 
			  LAG(salary) OVER(PARTITION BY employee_id ORDER BY YEAR) AS con_salary_over_year,
              CASE 
                  WHEN salary>LAG(salary) OVER(PARTITION BY employee_id ORDER BY YEAR) 
                      THEN 1 
                          ELSE 0 
              END AS count_of_1
              FROM employee_salary) AS subquery
GROUP BY employee_id,
		 name, 
         department
HAVING COUNT(count_of_1)>=3
ORDER BY employee_id;


-- Day 07/100 SQL Problems

DROP TABLE IF EXISTS orders;
CREATE TABLE ORDERS (
    order_id VARCHAR(10),
    customer_id INTEGER,
    order_datetime TIMESTAMP,
    item_id VARCHAR(10),
    order_quantity INTEGER,
    PRIMARY KEY (order_id, item_id)
);

-- Inserting sample data

-- Assuming the ORDERS table is already created as mentioned previously

-- Inserting the provided data
INSERT INTO ORDERS (order_id, customer_id, order_datetime, item_id, order_quantity) VALUES
('O-005', 1, '2023-01-12 11:48:00', 'C005', 1),
('O-005', 1, '2023-01-12 00:48:00', 'C008', 1),
('O-006', 4, '2023-01-16 02:52:00', 'C012', 2),
('O-001', 4, '2023-06-15 04:35:00', 'C004', 3),
('O-007', 1, '2024-07-13 09:15:00', 'C007', 2),
('O-010', 3, '2024-07-13 13:45:00', 'C008', 5),
('O-011', 3, '2024-07-13 16:20:00', 'C006', 2),
('O-012', 1, '2024-07-14 10:15:00', 'C005', 3),
('O-008', 1, '2024-07-14 11:00:00', 'C004', 4),
('O-013', 2, '2024-07-14 12:40:00', 'C007', 1),
('O-009', 3, '2024-07-14 14:22:00', 'C006', 3),
('O-014', 2, '2024-07-14 15:30:00', 'C004', 6),
('O-015', 1, '2024-07-15 05:00:00', 'C012', 4);
DROP TABLE IF EXISTS ITEMS;
CREATE TABLE ITEMS (
    item_id VARCHAR(10) PRIMARY KEY,
    item_category VARCHAR(50)
);
-- Inserting sample data
INSERT INTO ITEMS (item_id, item_category) VALUES
('C004', 'Books'),
('C005', 'Books'),
('C006', 'Apparel'),
('C007', 'Electronics'),
('C008', 'Electronics'),
('C012', 'Apparel');

SELECT * FROM ITEMS;
SELECT * FROM orders;
/*
-- Amazon Asked Interview Questions
1. How many units were ordered yesterday?
2. In the last 7 days (including today), how many units were ordered in each category?
3. Write a query to get the earliest order_id for all customers for each date they placed an order.
4. Write a query to find the second earliest order_id for each customer for each date they placed two or more orders.
*/
-- How many units were ordered yesterday?
SELECT COUNT(*)   -- current day and its previous day general syntax
FROM orders
WHERE DAY(order_datetime)= DAY(DATE_SUB(CURRENT_DATE(), INTERVAL 1 DAY));
SELECT COUNT(*)       -- mentioning date and then subtracting one day with interval 1.
FROM orders
WHERE DAY(order_datetime)= DAY(DATE_SUB('2024-07-15', INTERVAL 1 DAY));



-- 2. In the last 7 days (including today), how many units were ordered in each category?
SELECT SUM(E1.order_quantity) AS total_quantity,
       E2.item_category,
       E1.item_id
FROM orders E1
LEFT JOIN ITEMS E2
ON
E1.item_id=E2.item_id
WHERE order_datetime BETWEEN DATE_SUB('2024-07-15', INTERVAL 6 DAY) AND '2024-07-15'
GROUP BY  item_category, item_id;

-- 3. Write a query to get the earliest order_id for all customers for each date they placed an order.
SELECT customer_id,
       time_order, 
       date_order,
       order_id
FROM (SELECT order_id,
             customer_id,
             TIME(order_datetime) AS time_order,
             DATE(order_datetime) AS date_order,
             ROW_NUMBER() OVER(PARTITION BY customer_id, DATE(order_datetime) ORDER BY order_datetime) AS RN
             FROM orders) AS x
WHERE RN=1;


-- 4. Write a query to find the second earliest order_id for each customer for each date they placed two or more orders.


WITH CTE1
AS(
   SELECT *,
         ROW_NUMBER() OVER(PARTITION BY customer_id, DATE(order_datetime) ORDER BY order_datetime) R1
	FROM orders) 
SELECT customer_id,
       order_id,
       order_quantity
FROM CTE1
WHERE R1=2;

-- Day 08/100 Days Challenge



DROP TABLE IF EXISTS trips;

CREATE TABLE trips (
    id INT PRIMARY KEY,
    driver_id INT,
    city VARCHAR(50),
    trip_distance FLOAT,
    start_time TIMESTAMP,
    end_time TIMESTAMP,
    rating INT
);


INSERT INTO trips (id, driver_id, city, trip_distance, start_time, end_time, rating) VALUES
(1, 101, 'Mumbai', 5.2, '2024-07-01 08:00:00', '2024-07-01 08:20:00', 4),
(2, 101, 'Mumbai', 3.0, '2024-07-01 09:00:00', '2024-07-01 09:15:00', 5),
(3, 102, 'Delhi', 7.1, '2024-07-01 10:00:00', '2024-07-01 10:30:00', 4),
(4, 102, 'Delhi', 2.5, '2024-07-01 11:00:00', '2024-07-01 11:12:00', 2), -- Rating is 3 or below, should be ignored
(5, 103, 'Bangalore', 4.8, '2024-07-01 12:00:00', '2024-07-01 12:25:00', 4),
(6, 103, 'Bangalore', 6.2, '2024-07-01 13:00:00', '2024-07-01 13:40:00', 5),
(7, 101, 'Mumbai', 8.0, '2024-07-02 14:00:00', '2024-07-02 14:30:00', 5),
(8, 102, 'Delhi', 5.5, '2024-07-02 15:00:00', '2024-07-02 15:25:00', 4),
(9, 103, 'Bangalore', 3.6, '2024-07-02 16:00:00', '2024-07-02 16:18:00', 3),
(10, 104, 'Chennai', 6.5, '2024-07-02 09:30:00', '2024-07-02 10:00:00', 4),
(11, 103, 'Hyderabad', 3.2, '2024-07-02 11:00:00', '2024-07-02 11:20:00', 5),
(12, 104, 'Chennai', 4.9, '2024-07-03 13:00:00', '2024-07-03 13:35:00', 4),
(13, 104, 'Kolkata', 7.8, '2024-07-03 15:30:00', '2024-07-03 16:10:00', 5),
(14, 103, 'Hyderabad', 2.7, '2024-07-03 17:00:00', '2024-07-03 17:18:00', 3),
(15, 104, 'Kolkata', 5.4, '2024-07-04 08:45:00', '2024-07-04 09:15:00', 4),
(16, 104, 'Chennai', 3.3, '2024-07-04 10:30:00', '2024-07-04 10:50:00', 5);


SELECT * FROM trips;

/*
You are given a table trips that contains information about taxi trips. The table schema is as follows:

trips
---------
id INT PRIMARY KEY
driver_id INT
city VARCHAR(50)
trip_distance FLOAT
start_time TIMESTAMP
end_time TIMESTAMP
rating INT


Write an SQL query to find the average trip duration for each driver in each city excluding trips where the rating is below 3. The result should include driver_id, city, and average_trip_duration rounded to two decimal places. 

Note:
The average_trip_duration is calculated as the average of the differences between end_time and start_time for each trip.

-- Expected Output Schema:
driver_id INT
city VARCHAR(50)
average_trip_duration FLOAT

*/
-- option 1
SELECT driver_id,
       city,
        ROUND(AVG(time_difference)) AS average_trip_duration
FROM (
       SELECT *, TIMEDIFF(TIME(end_time), TIME(start_time))/60 AS time_difference
       FROM trips
       ) X
WHERE rating>=3
GROUP BY driver_id,
         city;
       
-- option 2
    
SELECT driver_id,
        city,
        ROUND(AVG(TIMEDIFF(TIME(end_time), TIME(start_time))),2)/60 AS time_difference
       FROM trips
GROUP BY driver_id,
        city;

-- Day 9/100 days challenge

-- Step 1: Create Tables

-- 1.1 Create `drivers` Table
DROP TABLE IF EXISTS drivers;
CREATE TABLE drivers (
    driver_id INT PRIMARY KEY,
    driver_name VARCHAR(100),
    driver_rating FLOAT,
    join_date DATE
);

-- 1.2 Create `passengers` Table

DROP TABLE IF EXISTS passenger;
CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY,
    passenger_name VARCHAR(100),
    passenger_rating FLOAT,
    join_date DATE
);

-- 1.3 Create `rides` Table
DROP TABLE IF EXISTS rides;
CREATE TABLE rides (
    ride_id INT PRIMARY KEY,
    driver_id INT,
    passenger_id INT,
    ride_date DATE,
    ride_distance FLOAT,
    ride_cost FLOAT,
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id)
);

-- Step 2: Insert Data

-- 2.1 Insert into `drivers` Table
INSERT INTO drivers (driver_id, driver_name, driver_rating, join_date) VALUES
(1, 'John Doe', 4.8, '2022-01-15'),
(2, 'Jane Smith', 4.5, '2021-07-22'),
(3, 'Bob Johnson', 4.9, '2020-11-30');

-- 2.2 Insert into `passengers` Table
INSERT INTO passengers (passenger_id, passenger_name, passenger_rating, join_date) VALUES
(1, 'Alice Brown', 4.7, '2022-03-11'),
(2, 'Charlie Green', 4.6, '2021-09-19'),
(3, 'David White', 4.8, '2020-05-25');

-- 2.3 Insert into `rides` Table
INSERT INTO rides (ride_id, driver_id, passenger_id, ride_date, ride_distance, ride_cost) VALUES
(1, 1, 1, '2023-06-01', 12.5, 25.0),
(2, 2, 2, '2023-06-02', 8.0, 16.0),
(3, 3, 3, '2023-06-03', 10.2, 20.4),
(4, 1, 2, '2023-06-04', 7.5, 15.0),
(5, 2, 3, '2023-06-05', 15.0, 30.0),
(6, 2, 3, '2023-06-07', 15.0, 30.0);


SELECT * FROM passengers;
SELECT * FROM drivers;
SELECT * FROM rides;

-- UBER Asked Questions 
-- Step 3: Interview Questions

-- Question 1: Find the driver with the highest Rating (return driver_name and rating)
-- option 1
SELECT R1.driver_id,
	   D1.driver_name,
       MAX(D1.driver_rating) AS highest_rating
FROM rides R1 LEFT JOIN drivers D1
ON R1.driver_id=D1.driver_id
GROUP BY driver_id
ORDER BY highest_rating DESC
LIMIT 1;

-- option 2
SELECT 
    driver_name,
    driver_rating
FROM drivers
ORDER BY driver_rating DESC
LIMIT 1;

-- Question 2: Calculate the Total Revenue Generated by Each Driver (return driver_name, id, revenue)
SELECT R1.driver_id,
	   D1.driver_name,
       ROUND(SUM(R1.ride_cost),2) AS total_revenue
FROM  rides R1 LEFT JOIN 
      drivers D1
ON 
     R1.driver_id=D1.driver_id
GROUP BY 1,2;

-- Question 3: Find the Passenger with the Highest Number of Rides (return passenger_name, id, no of rides)
       
SELECT R1.passenger_id,
       COUNT(R1.ride_id) AS Total_count,
       P1.passenger_name
FROM passengers P1
RIGHT JOIN rides R1 
     ON
R1.passenger_id= P1.passenger_id
GROUP BY R1.passenger_id, P1.passenger_name
ORDER BY Total_count DESC
LIMIT 1;

-- Question 4: Identify the Most Frequent Ride Distance (return ride_distance and number of frequency)

SELECT ride_distance, 
       COUNT(ride_distance) AS frequency_count
FROM rides
GROUP BY ride_distance
ORDER BY frequency_count DESC
LIMIT 1;


-- Day 10/100 Challenge

-- Write a SQL query to find the top 2 restaurants in each city with the highest average rating. If two restaurants have the same average rating, they should have the same rank.

DROP TABLE IF EXISTS cities;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS orders;
-- Create cities table
CREATE TABLE cities (
    city_id BIGINT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
    city_name VARCHAR(50)
);

-- Create restaurants table
CREATE TABLE restaurants (
    restaurant_id BIGINT UNSIGNED AUTO_INCREMENT  PRIMARY KEY,
    restaurant_name VARCHAR(100),
    city_id BIGINT UNSIGNED,
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- Create orders table with rating column
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    restaurant_id BIGINT UNSIGNED  ,
    order_value DECIMAL(10, 2),
    order_date DATE,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- Insert data into cities table
INSERT INTO cities (city_name) VALUES
('Mumbai'),
('Delhi'),
('Bengaluru');

-- Insert data into restaurants table
INSERT INTO restaurants (restaurant_name, city_id) VALUES
('Bademiya', 1),
('Bombay Canteen', 1),
('Trishna', 1),
('Karims', 2),
('Indian Accent', 2),
('Bukhara', 2),
('Toit', 3),
('Koshys', 3),
('MTR', 3);

-- Insert data into orders table with rating
INSERT INTO orders (restaurant_id, order_value, order_date, rating) VALUES
(1, 500.00, '2024-01-01', 4),
(1, 450.00, '2024-01-02', 5),
(1, 550.00, '2024-01-03', 4),
(2, 300.00, '2024-01-01', 3),
(2, 350.00, '2024-01-02', 4),
(2, 250.00, '2024-01-03', 3),
(3, 700.00, '2024-01-01', 5),
(3, 750.00, '2024-01-02', 4),
(3, 800.00, '2024-01-03', 5),
(4, 400.00, '2024-01-01', 4),
(4, 500.00, '2024-01-02', 5),
(4, 450.00, '2024-01-03', 4),
(5, 600.00, '2024-01-01', 5),
(5, 550.00, '2024-01-02', 4),
(5, 650.00, '2024-01-03', 5),
(6, 900.00, '2024-01-01', 5),
(6, 850.00, '2024-01-02', 5),
(6, 950.00, '2024-01-03', 4),
(7, 400.00, '2024-01-01', 3),
(7, 450.00, '2024-01-02', 4),
(7, 500.00, '2024-01-03', 3),
(8, 1000.00, '2024-01-01', 5),
(8, 1050.00, '2024-01-02', 4),
(8, 1100.00, '2024-01-03', 5),
(9, 800.00, '2024-01-01', 5),
(9, 850.00, '2024-01-02', 4),
(9, 900.00, '2024-01-03', 5);

SELECT * FROM cities;
SELECT * FROM restaurants;
SELECT * FROM orders;

-- -- Interview Question

-- Write a SQL query to find the top 2 restaurants in each city with the highest average rating. 
-- return city_id, city_name, restaurant id, restaurant_name and avg_rating

-- -- city_id, city_name cities,
-- r id, r_name r
-- average_rating -- order

-- step:1 Creating temporary table to join restaurants time and cities table on city_id
CREATE TEMPORARY TABLE join_cities_restaurants  AS 
 SELECT 
         R.restaurant_id AS restaurant_id_1,
         R.city_id AS city_id_1 ,
         R.restaurant_name AS restaurant_name_1, 
         C.city_name AS city_name_1
FROM restaurants R 
LEFT JOIN cities C
ON R.city_id= C.city_id 
;

-- step:2 combining temporary temple(join_cities_restuarants) and orders table to attain the avg(rating) for restaurant in each city.       
WITH Ranked_restaurants AS(
SELECT
	   jcr.restaurant_id_1,
       jcr.restaurant_name_1,
       jcr.city_id_1,
       jcr.city_name_1,
       AVG(O.rating) AS avg_rating, 
       ROW_NUMBER() OVER(PARTITION BY  jcr.city_id_1 ORDER BY AVG(O.rating) DESC) rank_1
FROM orders O
LEFT JOIN join_cities_restaurants jcr
      ON
O.restaurant_id=jcr. restaurant_id_1
GROUP BY jcr.city_id_1,
		 jcr.city_name_1,
         jcr.restaurant_id_1,
         jcr.restaurant_name_1)
         
-- step:3 Get top 2 restaurants by rating in each city
SELECT 
    restaurant_id_1,
    restaurant_name_1,
    city_id_1,
    city_name_1,
    avg_rating
FROM ranked_restaurants
WHERE rank_1 <= 2
ORDER BY city_id_1, rank_1;

-- day 11/100 

/*
Advanced Walmart Sales Analysis Question
Question:
Walmart wants to identify seasonal sales trends and understand customer purchasing behavior during different times of the year. You have the following tables: Sales, Products, and Customers.
*/

DROP TABLE IF EXISTS products;
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO Products (product_id, product_name, category, price) VALUES
(1, 'Laptop', 'Electronics', 999.99),
(2, 'Smartphone', 'Electronics', 799.99),
(3, 'Headphones', 'Electronics', 199.99),
(4, 'Refrigerator', 'Appliances', 1499.99),
(5, 'Microwave', 'Appliances', 299.99),
(6, 'T-shirt', 'Clothing', 19.99),
(7, 'Jeans', 'Clothing', 49.99),
(8, 'Blender', 'Appliances', 99.99),
(9, 'Coffee Maker', 'Appliances', 79.99),
(10, 'Shoes', 'Clothing', 89.99);

DROP TABLE IF EXISTS sales;
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    sale_date DATE,
    quantity INT,
    amount DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Sales (sale_id, product_id, customer_id, sale_date, quantity, amount) VALUES
(1, 1, 101, '2023-01-15', 1, 999.99),
(2, 2, 102, '2023-02-16', 2, 1599.98),
(3, 3, 103, '2023-03-17', 3, 599.97),
(4, 4, 104, '2023-04-18', 1, 1499.99),
(5, 5, 105, '2023-05-19', 2, 599.98),
(6, 6, 101, '2023-06-20', 5, 99.95),
(7, 7, 102, '2023-07-21', 3, 149.97),
(8, 8, 103, '2023-08-22', 1, 99.99),
(9, 9, 104, '2023-09-23', 2, 159.98),
(10, 10, 105, '2023-10-24', 1, 89.99),
(11, 1, 101, '2023-11-24', 1, 999.99),
(12, 2, 102, '2023-11-25', 2, 1599.98),
(13, 3, 103, '2023-11-26', 3, 599.97),
(14, 4, 104, '2023-11-27', 1, 1499.99),
(15, 5, 105, '2023-11-28', 2, 599.98);

/*
Interview Question
Tasks:

1. Write a query to find the top 3 products with the 
highest sales volume (total quantity sold) for each quarter of the year 2023.

*/
-- product_id, sale_date,quantity -- sales
-- product_name - products
-- quarter column sale_date
-- group by qtr,  each product and sum(qty)
-- WINDOW DENSE_RANK PARTITION BY product_id
-- SELECT * based drank <= 3 /*

WITH quarter_year AS (
    SELECT 
        S.product_id, 
        P.product_name,
        QUARTER(S.sale_date) AS quarter_wise,
        SUM(S.quantity) AS total_quantity,
        DENSE_RANK() OVER (PARTITION BY QUARTER(S.sale_date) ORDER BY SUM(S.quantity) DESC) AS r1
    FROM sales S
    LEFT JOIN products P ON P.product_id = S.product_id
    WHERE YEAR(S.sale_date) = 2023
    GROUP BY S.product_id, P.product_name, QUARTER(S.sale_date)
)
SELECT 
    product_id,
    product_name,
    quarter_wise,
    total_quantity
FROM quarter_year
WHERE r1 <= 3
ORDER BY quarter_wise, r1;

-- day 12/100 

/*
Advanced Flipkart Sales Analysis Question
Question:
Flipkart wants to identify seasonal sales trends and understand customer purchasing behavior during different times of the year. You have the following tables: Sales, Products, and Customers.
*/

DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_city VARCHAR(100),
    customer_state VARCHAR(100)
);

INSERT INTO Customers (customer_id, customer_name, customer_city, customer_state) VALUES
(101, 'Alice', 'New York', 'NY'),
(102, 'Bob', 'Los Angeles', 'CA'),
(103, 'Charlie', 'Chicago', 'IL'),
(104, 'David', 'Houston', 'TX'),
(105, 'Eve', 'Phoenix', 'AZ');

/*
Interview Question
Tasks:
1 Write a query to calculate the average monthly sales for each category!
return category that has highest average sale in each month!
*/

SELECT * FROM customers;
WITH category_monthly_sales AS (
    SELECT 
        MONTH(S.sale_date) AS month_wise, 
        P.category,
        SUM(S.amount) AS total_sales,
        AVG(S.amount) AS avg_sales
    FROM sales S 
    LEFT JOIN products P ON P.product_id = S.product_id
    GROUP BY MONTH(S.sale_date), P.category
),
ranked_categories AS (
    SELECT 
        month_wise,
        category,
        avg_sales,
        RANK() OVER (PARTITION BY month_wise ORDER BY avg_sales DESC) AS r2
    FROM category_monthly_sales
)
SELECT 
    month_wise, 
    category, 
    avg_sales
FROM ranked_categories
WHERE r2= 1
ORDER BY month_wise;

/*
2. Write a query to identify the customers who spent the most 
money during the Big Billion Days Sale (November 24-27) in 2023.
*/

SELECT 
    S.customer_id,
    C.customer_name,
    SUM(S.amount) AS total_spent
FROM sales S
LEFT JOIN customers C ON C.customer_id = S.customer_id
WHERE S.sale_date BETWEEN '2023-11-24' AND '2023-11-27'
GROUP BY S.customer_id, C.customer_name
ORDER BY total_spent DESC
LIMIT 1;

-- Day 13/100 SQL Challenge

DROP TABLE IF EXISTS employees;
CREATE TABLE Employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10, 2)
);



INSERT INTO Employees (name, salary) VALUES
('Alice', 60000.00),
('Bob', 75000.00),
('Charlie', 50000.00),
('David', 50000.00),
('Eva', 95000.00),
('Frank', 80000.00),
('Grace', 80000.00),
('Hank', 90000.00),
('Hank', 75000.00);

SELECT * FROM Employees;

WITH salary_ranks
AS
(
SELECT 
    *,
    ROW_NUMBER() OVER(ORDER BY salary DESC) as rn,
    RANK() OVER(ORDER BY salary DESC) as rans,
    DENSE_RANK() OVER(ORDER BY salary DESC) as d_ranks    
FROM employees
)

SELECT 
    *
FROM salary_ranks
WHERE rans = 3;

-- Day 14/100 

-- Write a SQL query to find the customer IDs who have made purchases consecutively in every month up to the current month (July 2024) of this year.

DROP TABLE IF EXISTS amazon_sales;
-- Create the amazon_sales table
CREATE TABLE amazon_sales (
    customer_id INT,
    purchase_date DATE,
    amount FLOAT
);

-- Insert sample data into the amazon_sales table
INSERT INTO amazon_sales (customer_id, purchase_date, amount) VALUES
(1, '2024-01-15', 150.0),
(1, '2024-02-10', 200.0),
(1, '2024-03-05', 300.0),
(1, '2024-04-01', 400.0),
(1, '2024-03-05', 350.0),
(1, '2024-04-04', 650.0),
(1, '2024-05-11', 500.0),
(1, '2024-06-01', 600.0),
(1, '2024-07-01', 700.0),
(2, '2023-01-20', 250.0),
(2, '2022-02-15', 350.0),
(2, '2024-03-10', 450.0),
(2, '2024-04-05', 550.0),
(2, '2024-04-08', 650.0),
(2, '2024-04-03', 350.0),
(2, '2024-05-12', 650.0),
(2, '2024-06-15', 750.0),
(2, '2024-07-10', 850.0),
(3, '2024-03-12', 500.0),
(3, '2024-04-25', 600.0),
(3, '2024-05-18', 700.0),
(3, '2024-06-22', 800.0),
(3, '2024-07-15', 900.0),
(4, '2024-01-30', 800.0),
(4, '2024-02-28', 900.0),
(4, '2024-03-20', 1000.0),
(4, '2024-04-15', 1100.0),
(4, '2024-05-10', 1200.0),
(4, '2024-06-05', 1300.0),
(4, '2024-07-01', 1400.0),
(5, '2024-01-15', 2200.0),
(5, '2024-02-10', 2300.0),
(5, '2024-03-05', 2400.0),
(5, '2024-04-01', 2500.0),
(5, '2024-05-15', 2600.0),
(5, '2024-06-10', 2700.0),
(5, '2024-07-10', 2200.0);


SELECT * FROM amazon_sales;

SELECT 
    customer_id
FROM amazon_sales 
WHERE YEAR(purchase_date) = 2024 AND
MONTH(purchase_date) <= 7
GROUP BY customer_id
HAVING COUNT(DISTINCT MONTH(purchase_date)) = 7;

-- day 15/100 days challenge

DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS orders;


CREATE TABLE Restaurants (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    location VARCHAR(100)
);

CREATE TABLE Orders (
    id SERIAL PRIMARY KEY,
    restaurant_id INT REFERENCES Restaurants(id),
    order_time TIMESTAMP,
    dispatch_time TIMESTAMP
);

INSERT INTO Restaurants (name, location) VALUES
('Restaurant A', 'Delhi'),
('Restaurant B', 'Delhi'),
('Restaurant C', 'Delhi'),
('Restaurant D', 'Delhi'),
('Restaurant E', 'Delhi');

INSERT INTO Orders (restaurant_id, order_time, dispatch_time) VALUES
(1, '2024-07-23 12:00:00', '2024-07-23 12:14:00'),
(1, '2024-07-23 12:30:00', '2024-07-23 12:48:00'),
(1, '2024-07-23 13:00:00', '2024-07-23 13:16:00'),
(2, '2024-07-23 13:30:00', '2024-07-23 13:50:00'),
(2, '2024-07-23 14:00:00', '2024-07-23 14:14:00'),
(3, '2024-07-23 14:30:00', '2024-07-23 14:49:00'),
(3, '2024-07-23 15:00:00', '2024-07-23 15:16:00'),
(3, '2024-07-23 15:30:00', '2024-07-23 15:40:00'),
(4, '2024-07-23 16:00:00', '2024-07-23 16:10:00'),
(4, '2024-07-23 16:30:00', '2024-07-23 16:50:00'),
(5, '2024-07-23 17:00:00', '2024-07-23 17:25:00'),
(5, '2024-07-23 17:30:00', '2024-07-23 17:55:00'),
(5, '2024-07-23 18:00:00', '2024-07-23 18:19:00'),
(1, '2024-07-23 18:30:00', '2024-07-23 18:44:00'),
(2, '2024-07-23 19:00:00', '2024-07-23 19:13:00');


/*
You are given two tables: Restaurants and Orders. After receiving an order, 
each restaurant has 15 minutes to dispatch it. Dispatch times are categorized as follows:

on_time_dispatch: Dispatched within 15 minutes of order received.
late_dispatch: Dispatched between 15 and 20 minutes after order received.
super_late_dispatch: Dispatched after 20 minutes.
Task: Write an SQL query to count the number of dispatched orders in each category for each restaurant.
*/

SELECT * FROM restaurants;
SELECT * FROM orders;

WITH initial_table AS (
    SELECT 
        R.name AS restaurant_name,
        O.restaurant_id AS restaurant_id,
        CASE 
            WHEN TIMESTAMPDIFF(MINUTE, O.order_time, O.dispatch_time) < 15 THEN 'on_time_dispatch'
            WHEN TIMESTAMPDIFF(MINUTE, O.order_time, O.dispatch_time) BETWEEN 15 AND 20 THEN 'late_dispatch'
            WHEN TIMESTAMPDIFF(MINUTE, O.order_time, O.dispatch_time) > 20 THEN 'super_late_dispatch'
        END AS delivery_status
    FROM orders O
    -- Assuming R.id is the correct column in the restaurants table for the join
    LEFT JOIN restaurants R ON R.id = O.restaurant_id
)
SELECT 
    restaurant_name,
    COUNT(CASE WHEN delivery_status = 'on_time_dispatch' THEN 1 END) AS on_time_dispatch_count,
    COUNT(CASE WHEN delivery_status = 'late_dispatch' THEN 1 END) AS late_dispatch_count,
    COUNT(CASE WHEN delivery_status = 'super_late_dispatch' THEN 1 END) AS super_late_dispatch_count
FROM initial_table
GROUP BY restaurant_name;

-- Day 16 of 100 days challenge

-- write a query to find users whose transactions has breached their credit limit
DROP TABLE IF EXISTS users;

create table users
(
	user_id int,
	user_name varchar(20),
	credit_limit int
);
DROP TABLE IF EXISTS  transactions;
CREATE TABLE transactions (
    trans_id INT,
    paid_by INT,
    paid_to INT,
    amount INT,
    trans_date VARCHAR(10),
    CHECK (trans_date REGEXP '^[0-3][0-9]-[0-1][0-9]-[0-9]{4}$')
);


insert into users(user_id,user_name,credit_limit)values
(1,'Peter',100),
(2,'Roger',200),
(3,'Jack',10000),
(4,'John',800);

insert into transactions(trans_id,paid_by,paid_to,amount,trans_date)values
(1,1,3,400,'01-01-2024'),
(2,3,2,500,'02-01-2024'),
(3,2,1,200,'02-01-2024');

SELECT * FROM users;
SELECT * FROM transactions;

WITH total_paid AS (
    SELECT paid_by, 
           SUM(amount) AS total_given
    FROM transactions
    GROUP BY paid_by
),
total_received AS (
    SELECT paid_to,
           SUM(amount) AS total_get
    FROM transactions
    GROUP BY paid_to
),
userspending AS (
    SELECT U.user_id,
           U.user_name,
           U.credit_limit AS credit_limit_1,
           COALESCE(TP.total_given, 0) AS total_given,   -- total_given for the user
           COALESCE(TR.total_get, 0) AS total_received,  -- total_received for the user
           (COALESCE(TP.total_given, 0) - COALESCE(TR.total_get, 0)) AS total_spent -- COALESCE  for handeling null values.
    FROM users U 
    LEFT JOIN total_paid TP ON U.user_id = TP.paid_by
    LEFT JOIN total_received TR ON U.user_id = TR.paid_to
)
SELECT 
    user_name,
    credit_limit_1,
    total_spent
FROM userspending
WHERE total_spent > credit_limit_1;


-- day 17/100 days challenge


DROP TABLE IF EXISTS user_activities;

CREATE TABLE user_activities (
    user_id INT,
    activity VARCHAR(10), -- Either 'Login' or 'Logout'
    activity_time TIMESTAMP
);



INSERT INTO user_activities (user_id, activity, activity_time) VALUES
(1, 'Login', '2024-01-01 08:00:00'),
(1, 'Logout', '2024-01-01 12:00:00'),
(1, 'Login', '2024-01-01 13:00:00'),
(1, 'Logout', '2024-01-01 17:00:00'),
(2, 'Login', '2024-01-01 09:00:00'),
(2, 'Logout', '2024-01-01 11:00:00'),
(2, 'Login', '2024-01-01 14:00:00'),
(2, 'Logout', '2024-01-01 18:00:00'),
(3, 'Login', '2024-01-01 08:30:00'),
(3, 'Logout', '2024-01-01 12:30:00');

SELECT * FROM user_activities;


-- Find out each users and productivity time in hour!
-- productivity time = login - logout time


WITH login_logout_table AS(
                           SELECT *,
                           LAG(activity_time) OVER(PARTITION BY user_id ORDER BY activity_time) previous_login_time,
                           LAG(activity) OVER(PARTITION BY user_id ORDER BY activity_time) previous_login_activity
                           FROM  user_activities
                           ),
productivity_table AS(
                         SELECT user_id,
                          previous_login_time AS login_time,
                          previous_login_activity AS login_activity,
                          activity_time AS logout_time,
                          activity AS logout_activity,
                         (TIMESTAMPDIFF(SECOND, previous_login_time,activity_time)/3600) AS productivity_time
                          FROM login_logout_table 
                          WHERE previous_login_activity='login'
                                AND
                                activity='logout'
						)
SELECT user_id,
        CONCAT(ROUND(SUM(productivity_time),0),'hrs') AS total_productivity_time
       FROM productivity_table
       GROUP BY user_id;
       
-- DAY 18/100

DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    mail VARCHAR(100)
);


INSERT INTO Users (user_id, name, mail) VALUES
(1, 'Winston', 'winston@ymail.com'),
(2, 'Jonathan', 'jonathanisgreat'),
(3, 'Annabelle', 'bella-@ymail.com'),
(4, 'Sally', 'sally.come@ymail.com'),
(5, 'Marwan', 'quarz#2020@ymail.com'),
(6, 'David', 'john@gmail.com'),
(7, 'David', 'sam25@gmail.com'),
(8, 'David', 'david69@gmail.com'),
(9, 'Shapiro', '.shapo@ymail.com');

SELECT * FROM Users;
-- You are given table below
-- Write SQL Query to find users whose email addresses contain only lowercase letters before the @ symbol

SELECT * FROM Users 
WHERE mail REGEXP '^[a-z]+@[a-z0-9.-]+\\.[a-z]{2,}$';

-- Day 19/100 days challenge

-- Spotify Data Analyst Interview question

/*
Question:
Analyze Spotify's user listening data to find out 
which genre of music has the highest average listening time per user.
*/

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS plays;

-- Create users table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100),
    country VARCHAR(100)
);

-- Insert sample data into users table
INSERT INTO users (user_id, user_name, country) VALUES
(1, 'Alice', 'USA'),
(2, 'Bob', 'Canada'),
(3, 'Charlie', 'UK'),
(4, 'David', 'Germany'),
(5, 'Eva', 'France'),
(6, 'Frank', 'Australia'),
(7, 'Grace', 'Italy');

-- Create plays table
CREATE TABLE plays (
    user_id INT,
    song_id INT,
    genre VARCHAR(100),
    listening_time INT
);

-- Insert sample data into plays table
INSERT INTO plays (user_id, song_id, genre, listening_time) VALUES
(1, 101, 'Rock', 120),
(1, 102, 'Pop', 80),
(2, 103, 'Rock', 90),
(2, 104, 'Jazz', 60),
(3, 105, 'Classical', 150),
(3, 106, 'Rock', 110),
(4, 107, 'Pop', 90),
(4, 108, 'Classical', 70),
(5, 109, 'Jazz', 80),
(5, 110, 'Pop', 65),
(1, 111, 'Jazz', 50),
(2, 112, 'Classical', 40),
(3, 113, 'Pop', 100),
(4, 114, 'Rock', 70),
(5, 115, 'Classical', 60),
(6, 116, 'Rock', 130),
(6, 117, 'Pop', 120),
(7, 118, 'Jazz', 75),
(7, 119, 'Classical', 50),
(7, 120, 'Rock', 65);

SELECT * FROM users;
SELECT * FROM plays;

-- calculating most heared genre for each user under avg_listening_time.

WITH avg_time AS(

SELECT U.user_id AS user_id,
       U.user_name AS user_name,
       P.genre AS each_genre,
       AVG(P.listening_time) AS avg_listening_time,
       ROW_NUMBER() OVER(PARTITION BY user_id  ORDER BY AVG(P.listening_time) DESC) AS rn
       FROM  users U 
       RIGHT JOIN plays P 
       ON
       U.user_id=P.user_id
       GROUP BY user_id, user_name,P.genre
      )
SELECT * FROM  avg_time
WHERE rn=1
;
-- calculating most heared genre  under avg_listening_time.

WITH genre_avg_listening_time AS (
    SELECT 
        P.genre,
        AVG(P.listening_time) AS avg_listening_time
    FROM 
        plays P
    GROUP BY 
        P.genre
)
SELECT 
    genre,
    avg_listening_time
FROM 
    genre_avg_listening_time
ORDER BY 
    avg_listening_time DESC
LIMIT 1;

-- 22/100 Days SQL Challenge

-- Given a user_activity table, write a SQL query to find all users who have logged in on at least 3 consecutive days.

DROP TABLE IF EXISTS user_activity;
CREATE TABLE user_activity (
    user_id INT,
    login_date DATE
);

INSERT INTO user_activity (user_id, login_date) VALUES
(1, '2024-08-01'),
(1, '2024-08-02'),
(1, '2024-08-05'),
(1, '2024-08-07'),
(2, '2024-08-01'),
(2, '2024-08-02'),
(2, '2024-08-03'),
(2, '2024-08-04'),
(2, '2024-08-06'),
(3, '2024-08-01'),
(3, '2024-08-02'),
(3, '2024-08-03'),
(3, '2024-08-07'),
(4, '2024-08-02'),
(4, '2024-08-05'),
(4, '2024-08-07');
SELECT * FROM user_activity;

-- Given a user_activity table, write a SQL query to find all users who have logged in on at least 3 consecutive days.

WITH previous_date  AS
         (
          SELECT user_id,
                 login_date,
                 LAG(login_date) OVER(PARTITION BY user_id ORDER BY user_id) AS previous_login_date,
                 DATEDIFF(login_date,LAG(login_date) OVER(PARTITION BY user_id ORDER BY user_id)) AS day_diff
		 FROM user_activity
		),
consecutive AS
         (
          SELECT user_id,
                 login_date,
                 CASE WHEN day_diff=1 THEN 1 ELSE 0 END AS is_consecutive
		  FROM previous_date
          ),
3_consecutive_days AS
          (
           SELECT user_id,
           login_date,
           SUM( is_consecutive) OVER(PARTITION BY user_id ORDER BY  login_date 
                                                         ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 3_consecutive
			FROM consecutive
		  )
SELECT DISTINCT user_id
FROM 3_consecutive_days
WHERE 3_consecutive=2;



                 




       





                                

       
        
       
       
                        
                        



                   





       





             




