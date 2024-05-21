-- CTEs (Common Table Expressions)



WITH CTE_Example AS 
(
    SELECT 
        gender, 
        AVG(salary) AS avg_salary, 
        MAX(salary) AS max_salary, 
        MIN(salary) AS min_salary, 
        COUNT(salary) AS count_salary
    FROM 
        employee_demographics dem
    JOIN 
        employee_salary sal
    ON 
        dem.employee_id = sal.employee_id
    GROUP BY 
        gender
)
SELECT *
FROM CTE_Example;


-- Average between both males and females
WITH CTE_Example AS 
(
    SELECT 
        gender, 
        AVG(salary) AS avg_salary, 
        MAX(salary) AS max_salary, 
        MIN(salary) AS min_salary, 
        COUNT(salary) AS count_salary
    FROM 
        employee_demographics dem
    JOIN 
        employee_salary sal
    ON 
        dem.employee_id = sal.employee_id
    GROUP BY 
        gender
)
SELECT AVG(avg_salary) avg_sal
FROM CTE_Example;


-- CTE helps with more advanced calculations
-- Readability i.e subquery


-- Using subquery to compare CTE
SELECT AVG(avg_salary)
FROM
    (SELECT 
        gender, 
        AVG(salary) AS avg_salary, 
        MAX(salary) AS max_salary, 
        MIN(salary) AS min_salary, 
        COUNT(salary) AS count_salary
    FROM 
        employee_demographics dem
    JOIN 
        employee_salary sal
    ON 
        dem.employee_id = sal.employee_id
    GROUP BY 
        gender) example_subquery
;


-- Building complex CTE query

WITH CTE_Example1 AS 
(
    SELECT 
        employee_id,
        gender,
        birth_date
    FROM 
        employee_demographics
    WHERE 
        birth_date > '1985-01-01'
),
CTE_Example2 AS
(
    SELECT 
        employee_id, 
        salary
    FROM 
        employee_salary
    WHERE 
        salary > 50000
)
SELECT AVG(salary) AS avg_sal
FROM 
    CTE_Example1
JOIN 
    CTE_Example2
    ON CTE_Example1.employee_id = CTE_Example2.employee_id;
