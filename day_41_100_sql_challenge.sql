-- Day 41/100 SQL Challenge


DROP TABLE IF EXISTS salaries;
CREATE TABLE Salaries (
    company_id INT, 
    employee_id INT, 
    employee_name VARCHAR(50), 
    salary INT
);

INSERT INTO Salaries (company_id, employee_id, employee_name, salary) VALUES
(1, 1, 'Tony', 2000),
(1, 2, 'Pronub', 21300),
(1, 3, 'Tyrrox', 10800),
(2, 1, 'Pam', 300),
(2, 7, 'Bassem', 450),
(2, 9, 'Hermione', 700),
(3, 7, 'Bocaben', 100),
(3, 2, 'Ognjen', 2200),
(3, 13, 'Nyancat', 3300),
(3, 15, 'Morninngcat', 7777);


-- Category Hard
-- Company Altasian
-- HSBC 

/*Problem
Write an SQL query to find the salaries of the employees after applying taxes.

The tax rate is calculated for each company based on the following criteria:

0% If the max salary of any employee in the company is less than 1000$.
24% If the max salary of any employee in the company is in the range [1000, 10000] inclusive.
49% If the max salary of any employee in the company is greater than 10000$.
Return the result table in any order. Round the salary to the nearest integer.*/

SELECT * FROM Salaries;

WITH max_salary_by_company AS (
    SELECT 
        company_id, 
        MAX(salary) AS maximun_sal              # CTE for identifying max salary for each company_id.
    FROM Salaries
    GROUP BY company_id
),
                                
Added_tax_salary AS(
                     SELECT mx.company_id AS  overall_company_id,
                            S.salary,
                            S.employee_name AS tax_reduced_emp_name,
                            S.employee_id AS tax_reduced_emp_id,
                            CASE WHEN mx.maximun_sal <1000 THEN S.salary
                                 WHEN mx.maximun_sal BETWEEN 1000 AND 10000 THEN ROUND(S.salary * (1 - 0.24), 0)    # 24% tax included for salary beweem 1000, 10000
                                 WHEN mx.maximun_sal > 10000 THEN ROUND(S.salary * (1 - 0.49),0)                    # 49% tax included for salary > 10000
							END AS tax_deduced_amount
					 FROM Salaries S 
					 JOIN max_salary_by_company mx 
                     ON S.company_id = mx.company_id
                     )
SELECT tax_deduced_amount, 
       overall_company_id,
       tax_reduced_emp_name,
       tax_reduced_emp_id
       FROM Added_tax_salary;
                     
                             

                           

