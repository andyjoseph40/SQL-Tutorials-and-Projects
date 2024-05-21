-- Stored Procedures

SELECT *
FROM employee_salary
WHERE salary >= 50000;


CREATE PROCEDURE large_salaries
AS 
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
END;

EXEC large_salaries

