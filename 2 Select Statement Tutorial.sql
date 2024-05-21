
SELECT *
FROM Parks_and_Recreation.dbo.employee_demographics;


SELECT first_name,
last_name,
birth_date,
age
FROM Parks_and_Recreation.dbo.employee_demographics;

-- PEMDAS, SQL uses PEMDAS for mathematical operations

SELECT first_name,
last_name,
birth_date,
age,
(age + 10) AS age_plus10
FROM Parks_and_Recreation.dbo.employee_demographics;

SELECT first_name,
last_name,
birth_date,
age,
(age + 10) * 10 AS age_plus10
FROM Parks_and_Recreation.dbo.employee_demographics;

-- Using distinct in Select statement

SELECT DISTINCT gender
FROM Parks_and_Recreation.dbo.employee_demographics;

SELECT DISTINCT first_name, gender
FROM Parks_and_Recreation.dbo.employee_demographics;

