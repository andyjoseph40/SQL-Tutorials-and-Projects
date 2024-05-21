-- String Functions

-- Query 1: Using LEN function
SELECT LEN('skyfall');


-- Query 2: Using LEN function and correcting ORDER BY
SELECT first_name, LEN(first_name) AS name_length
FROM employee_demographics
ORDER BY LEN(first_name);

-- Query 3: Using UPPER and LOWER
SELECT UPPER('sky');
SELECT LOWER('sky');

SELECT first_name, UPPER(first_name)
FROM employee_demographics

SELECT first_name, LOWER(first_name)
FROM employee_demographics


-- Trim function
SELECT TRIM('          sky        ');


SELECT first_name,
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name, 3, 2)
FROM employee_demographics;


SELECT first_name,
       LEFT(first_name, 4) AS left_name,
       RIGHT(first_name, 4) AS right_name,
       SUBSTRING(first_name, 3, 2) AS substring_name,
       birth_date,
       SUBSTRING(CONVERT(varchar, birth_date, 120), 6, 2) AS birth_month
FROM employee_demographics;

-- Replace function
SELECT first_name, REPLACE(first_name, 'a', 'z')
FROM employee_demographics;

SELECT CHARINDEX('x', 'Alexander');

SELECT first_name, CHARINDEX('An', first_name)
FROM employee_demographics;

SELECT first_name, last_name,
CONCAT(first_name, ' ',last_name) AS full_name
FROM employee_demographics



-- 




