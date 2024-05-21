
-- WHERE Clause

SELECT * 
FROM employee_salary

SELECT *
FROM employee_salary
WHERE first_name = 'Leslie'

-- equal to 50000
SELECT *
FROM employee_salary
WHERE salary = 50000


-- greater than or equals to
SELECT *
FROM employee_salary
WHERE salary >= 50000

SELECT *
FROM employee_demographics
WHERE gender != 'female'

SELECT *
FROM employee_demographics
WHERE birth_date > '1987-03-04'


-- Logical Operators -- AND OR NOT
-- AND means that both conditions have to be true
SELECT *
FROM employee_demographics
WHERE birth_date > '1987-03-04'
AND gender = 'male'

-- OR means that atleast one should be true
SELECT *
FROM employee_demographics
WHERE birth_date > '1987-03-04'
OR gender = 'male'

SELECT *
FROM employee_demographics
WHERE birth_date > '1987-03-04'
OR NOT gender = 'male'


SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55


-- LIKE Statement
-- Using % and _ with the LIKE Statement
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'jer%'

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a%'

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__'

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__%'

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%'