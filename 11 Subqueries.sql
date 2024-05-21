-- Subqueries
-- query within another query

-- Subquery in a Where Statement
SELECT *
FROM employee_demographics
WHERE employee_id IN 
				(SELECT employee_id
					FROM employee_salary
						WHERE dept_id = 1)
;

-- Subquery in a Select Statement

SELECT first_name, AVG(salary) AS avg_salary
FROM employee_salary
GROUP BY first_name;



SELECT first_name,
		salary, 
		(SELECT AVG(Salary) FROM employee_salary) AS avg_salary
FROM employee_salary;


-- Subquery in the From Statement
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender

Select AVG(max_age) AS avg_max_age
FROM
(SELECT gender, AVG(age) AS avg_age, 
MAX(age) AS max_age, 
MIN(age) AS min_age,
COUNT(age) AS count_age
FROM employee_demographics
GROUP BY gender) AS Agg_table