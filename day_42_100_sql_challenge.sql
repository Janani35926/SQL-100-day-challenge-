-- SQL Interview Question Day 42/100

-- EY Data Analyst SQL question.
-- SQL Mentor Question id 400

/*
Given a table named candidates with the following structure:
name (VARCHAR): Name of the candidate
skills (TEXT): List of skills the candidate possesses (stored as a comma-separated string)
Write a query to find candidates best suited for an open Data Science job.
A candidate is suitable if they possess all three required skills: Python, Tableau, and PostgreSQL.
*/
DROP TABLE IF EXISTS candidates;

CREATE TABLE candidates (
    name VARCHAR(100),
    skills TEXT
);

INSERT INTO candidates (name, skills) VALUES
('Alice', 'Python,Tableau,SQL'),
('Bob', 'Python,Tableau,PostgreSQL'),
('Charlie', 'R,Excel,Python'),
('Dave', 'Tableau,Python,PostgreSQL'),
('Eve', 'SQL,Python,Tableau,PostgreSQL');

SELECT * FROM  candidates;

SELECT name FROM candidates
WHERE FIND_IN_SET('Python',skills)>0 AND
	  FIND_IN_SET('Tableau',skills)>0 AND
      FIND_IN_SET('PostgreSQL',skills)>0;