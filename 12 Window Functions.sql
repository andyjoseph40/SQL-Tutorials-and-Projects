-- Window Functions
SELECT *
FROM employee_demographics

SELECT *
FROM employee_salary

SELECT gender, AVG(salary) avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender


SELECT gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id


SELECT dem.first_name, 
		dem.last_name, 
		gender, 
		AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id


SELECT dem.first_name, 
		dem.last_name, 
		gender, 
		salary,
		SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS Rolling_Total
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id

-- Rank and Dense Rank
SELECT 
    dem.first_name, 
    dem.last_name, 
    dem.gender, 
    sal.salary,
    ROW_NUMBER() OVER(PARTITION BY dem.gender ORDER BY sal.salary DESC) AS row_num
FROM 
    employee_demographics dem
JOIN 
    employee_salary sal ON dem.employee_id = sal.employee_id;


SELECT 
    dem.first_name, 
    dem.last_name, 
    dem.gender, 
    sal.salary,
    ROW_NUMBER() OVER(PARTITION BY dem.gender ORDER BY sal.salary DESC) AS row_num,
	RANK() OVER(PARTITION BY dem.gender ORDER BY salary DESC) rank_num,
	DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) dense_rank_num
FROM 
    employee_demographics dem
JOIN 
    employee_salary sal ON dem.employee_id = sal.employee_id;
