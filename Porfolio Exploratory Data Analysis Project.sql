-- Exploratory Data Analysis

SELECT *
FROM layoffs_staging;

-- Maximum Total laid off
SELECT MAX(total_laid_off) max_total_laidoff
FROM layoffs_staging;


SELECT MAX(total_laid_off) AS total_laid_off, MAX(percentage_laid_off) AS [%_laid_off]
FROM  layoffs_staging


SELECT *
FROM layoffs_staging
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

SELECT company, SUM(total_laid_off) sum_total_laid_off
FROM layoffs_staging
GROUP BY company
ORDER BY 2 DESC


SELECT MIN([date]) min_date, MAX([date]) max_date
FROM layoffs_staging


SELECT industry, SUM(total_laid_off) sum_total_laid_off
FROM layoffs_staging
GROUP BY industry
ORDER BY 2 DESC

SELECT country, SUM(total_laid_off) sum_total_laid_off
FROM layoffs_staging
GROUP BY country
ORDER BY 2 DESC


SELECT [date], SUM(total_laid_off) sum_total_laid_off
FROM layoffs_staging
GROUP BY [date]
ORDER BY 1 DESC


SELECT YEAR([date]) year_date, SUM(total_laid_off) sum_total_laid_off
FROM layoffs_staging
GROUP BY YEAR([date])
ORDER BY 1 DESC;


SELECT stage, SUM(total_laid_off) sum_total_laid_off
FROM layoffs_staging
GROUP BY stage
ORDER BY 2 DESC;


SELECT CONVERT(varchar(7), [date], 120) AS [month], SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging
WHERE [date] IS NOT NULL
GROUP BY CONVERT(varchar(7), [date], 120)
ORDER BY [month] ASC;

-- Rolling_Total
WITH Rolling_Total AS
(
    SELECT CONVERT(varchar(7), [date], 120) AS [month], SUM(total_laid_off) AS total_laid_off
    FROM layoffs_staging
    WHERE [date] IS NOT NULL
    GROUP BY CONVERT(varchar(7), [date], 120)
)
SELECT [month], total_laid_off, SUM(total_laid_off) OVER (ORDER BY [month]) AS rolling_total
FROM Rolling_Total
ORDER BY [month] ASC;
;


-- Checking the layoffs based on company
SELECT company, YEAR([date]) AS [year], SUM(total_laid_off) sum_total_laid_off
FROM layoffs_staging
GROUP BY company, YEAR([date])
ORDER BY 3 DESC


-- Based on Ranking
WITH Company_Year AS 
(
    SELECT company, YEAR([date]) AS [year], SUM(total_laid_off) AS sum_total_laid_off
    FROM layoffs_staging
    GROUP BY company, YEAR([date])
), 
Company_Year_Rank AS
(
    SELECT company, [year], sum_total_laid_off,
           DENSE_RANK() OVER (PARTITION BY [year] ORDER BY sum_total_laid_off DESC) AS Ranking
    FROM Company_Year
)
SELECT company, [year], sum_total_laid_off, Ranking
FROM Company_Year_Rank
WHERE Ranking <= 5
ORDER BY [year], Ranking;

