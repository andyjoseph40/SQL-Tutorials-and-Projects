-- Temporary Tables
-- are tables only visible to the section that they are created at.

-- Create the temporary table
CREATE TABLE #temp_table
(
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    favorite_movie VARCHAR(100)
);

-- Insert a record into the temporary table
INSERT INTO #temp_table (first_name, last_name, favorite_movie)
VALUES ('Alex', 'Freberg', 'Lord of the Rings: The Two Towers');

-- Select all records from the temporary table
SELECT *
FROM #temp_table;



-- ANOTHER WAY TO USE THE TEMP TABLE
-- Select all records from the employee_salary table
SELECT *
FROM employee_salary;

-- Create a temporary table and insert records with salary >= 50000
SELECT *
INTO #salary_over_50k
FROM employee_salary
WHERE salary >= 50000;

-- Select all records from the temporary table to verify
SELECT *
FROM #salary_over_50k;
