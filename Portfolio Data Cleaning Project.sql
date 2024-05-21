
-- Data Cleaning
-- https://www.kaggle.com/datasets/swaptr/layoffs-2022?resource=download



CREATE DATABASE world_layoffs
USE world_layoffs

SELECT *
FROM dbo.layoffs

-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or blank values
-- 4. Remove Any Columns


-- Step 1: Create the layoffs_staging table with the same structure as dbo.layoffs
SELECT TOP 0 *
INTO layoffs_staging
FROM dbo.layoffs;

-- Step 2: Insert data into layoffs_staging from dbo.layoffs
INSERT INTO layoffs_staging
SELECT *
FROM dbo.layoffs;


-- Verify the contents of layoffs_staging
SELECT *
FROM layoffs_staging;


-- 1. Removing Duplicates
SELECT *,
ROW_NUMBER() OVER (
		PARTITION BY company, industry, total_laid_off, percentage_laid_off, [date]
		ORDER BY (SELECT NULL)
			) AS row_num
FROM layoffs_staging;

-- Using CTE (common table expressions) or subquery to check for row_num above 1

WITH duplicate_cte AS 
(
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY company, industry, total_laid_off, percentage_laid_off, [date]
            ORDER BY (SELECT NULL)
        ) AS row_num
    FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Checking for confirmation
-- Using the company column

SELECT *
FROM layoffs_staging
WHERE company = 'Oda'
;

-- Based on the result I noticed that not all the columns are duplicated which implies that I need to check all the columns and not just a few column.
WITH duplicate_cte AS 
(
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY company, [location], industry, total_laid_off, percentage_laid_off, [date], stage, country, funds_raised
            ORDER BY (SELECT NULL)
        ) AS row_num
    FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Checking
SELECT *
FROM layoffs_staging
WHERE company = 'Casper'
;


-- Now we have duplicates but we can't drop all. We will keep the original rows and drop the duplicates 
-- To delete the duplicate, follow the steps below
-- 1. Add a temporary unique identifier
-- 2. Use the temporary identifier to delete duplicates
-- 3. Remove the temporary Identifier

-- Step 1: Add a temporary unique identifier
ALTER TABLE layoffs_staging
ADD temp_id INT IDENTITY(1,1);

-- Step 2: Use the temporary identifier to delete duplicates
WITH duplicate_cte AS 
(
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY company, [location], industry, total_laid_off, percentage_laid_off, [date], stage, country, funds_raised
            ORDER BY (SELECT NULL)
        ) AS row_num
    FROM layoffs_staging
)
DELETE FROM layoffs_staging
WHERE temp_id IN (
    SELECT temp_id
    FROM duplicate_cte
    WHERE row_num > 1
);

-- Step 3: Display rows with row_num = 1
WITH duplicate_cte AS 
(
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY company, [location], industry, total_laid_off, percentage_laid_off, [date], stage, country, funds_raised
            ORDER BY (SELECT NULL)
        ) AS row_num
    FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num = 1;

SELECT *
FROM layoffs_staging


-- Step 4: Drop the temporary unique identifier
ALTER TABLE layoffs_staging
DROP COLUMN temp_id;


-- Standardizing Data

SELECT *
FROM layoffs_staging

SELECT DISTINCT (company)
FROM layoffs_staging

SELECT company, TRIM(company)
FROM layoffs_staging

UPDATE layoffs_staging
SET company = TRIM(company)

SELECT DISTINCT industry
FROM layoffs_staging
ORDER BY 1

SELECT DISTINCT [location]
FROM layoffs_staging


SELECT location, TRIM([location])
FROM layoffs_staging

UPDATE layoffs_staging
SET [location] = TRIM([location])

SELECT DISTINCT country
FROM layoffs_staging
ORDER BY 1;

SELECT [date],
	TRY_CONVERT(DATE, [date], 101) AS formatted_date
FROM layoffs_staging;

UPDATE layoffs_staging
SET [date] =  TRY_CONVERT(DATE, [date], 101)

SELECT *
FROM layoffs_staging


-- Step 3: Handling NULL and BLANK rows/values
SELECT *
FROM layoffs_staging
WHERE total_laid_off IS NULL;

-- Checking for NULL and BLANK values in each of the columns
SELECT *
FROM layoffs_staging
WHERE total_laid_off IS NULL
AND percentage_laid_off is NULL
;

SELECT DISTINCT industry
FROM layoffs_staging
WHERE industry IS NULL
OR industry = '';


SELECT company
FROM layoffs_staging
WHERE company IS NULL
OR company = ''

-- For example if I have a NULL/BLANK values you can join the to itself
-- let's see an example syntax

SELECT *
FROM layoffs_staging
WHERE company = 'Airbnb';

-- Set Blank as Null Values
-- For Example
UPDATE layoffs_staging
SET industry = NULL
WHERE industry = ''


-- Then you can proceed with handling the null values


-- SELECT *
-- FROM layoffs_staging t1
-- JOIN layoffs_staging t2
	-- ON t1.company = t2.company
-- WHERE (t1.industry IS NULL OR t1.industry = '')
-- AND t2.industry IS NOT NULL

-- SELECT t1.industry, t2.industry
-- FROM layoffs_staging t1
-- JOIN layoffs_staging t2
	-- ON t1.company = t2.company
-- WHERE (t1.industry IS NULL OR t1.industry = '')
-- AND t2.industry IS NOT NULL;


-- Translate the above into an update 
-- UPDATE layoffs_staging t1
-- JOIN layoffs_staging t2
	-- ON t1.industry = t2.company
-- SET t1.industry = t2.industry
-- WHERE t1.industry IS NULL
-- AND t2.industry IS NOT NULL

SELECT *
FROM layoffs_staging
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


DELETE 
FROM layoffs_staging
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;


SELECT *
FROM layoffs_staging

ALTER TABLE layoffs_staging
DROP COLUMN temp_id;

UPDATE layoffs_staging
SET percentage_laid_off = ROUND(percentage_laid_off, 3);




