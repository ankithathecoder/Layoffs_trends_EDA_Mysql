#EDA project

SELECT *
FROM layoffs_staging2;

-- Basic Statistics: Finding the maximum and minimum values for total layoffs and percentage layoffs
SELECT MAX(total_laid_off),MAX(percentage_laid_off),MIN(total_laid_off),MIN(percentage_laid_off)
FROM layoffs_staging2;

-- Categorizing industries: Counting how many records exist in each industry category
SELECT industry, COUNT(*)
FROM layoffs_staging2
GROUP BY industry;


SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off=1
ORDER BY funds_raised_millions DESC;

-- Summing total layoffs by company: Summing up the number of layoffs per company
SELECT company,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Summing total layoffs by industry: Summing the layoffs across different industries
SELECT industry,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Summing total layoffs by country: Summing the layoffs across different countries
SELECT country,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Summing total layoffs by stages: Summing the layoffs across different stages
SELECT stage,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- Date Range Analysis: Finding the minimum and maximum dates of layoffs in the dataset
SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging2;

-- Summing total layoffs by year: Grouping layoffs by year to observe trends over time
SELECT YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

-- Window function: Summing total layoffs partitioned by 'stage', this will allow us to see the total layoffs for each stage
SELECT DISTINCT stage, SUM(total_laid_off) OVER (PARTITION BY stage) AS total_per_stage
FROM layoffs_staging2
ORDER BY 2 DESC;

#rolling total
SELECT SUBSTRING(`date`,1,7) AS `MONTH`,SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY `MONTH`;

-- Rolling Totals:Using a rolling total to analyze layoffs over time, grouped by month.
WITH rolling_total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`,SUM(total_laid_off) AS Total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY `MONTH`
)
#SELECT `MONTH`,Total_off,SUM(Total_off) OVER(ORDER BY `MONTH`) AS Rolling_Total
SELECT `MONTH`,Total_off,SUM(Total_off) OVER (PARTITION BY LEFT(`MONTH`,4) ORDER BY `MONTH`) AS Rolling_Total
FROM rolling_total;

-- Ranking companies by total layoffs: This ranks companies by the number of layoffs in descending order.
SELECT company,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Ranking companies by total layoffs by year
SELECT company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 3 DESC;

-- Ranking companies based on total layoffs per year: This ranks companies for each year and picks the top 5
WITH company_year(company,years,total_laid_off) AS(
SELECT company,YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company,YEAR(`date`)
), company_year_rank AS(
SELECT *,
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE ranking<=5;

-- Correlation Analysis: Calculating correlation between total layoffs and percentage layoffs
-- This query manually computes the correlation coefficient for total layoffs and percentage layoffs
SELECT 
    (COUNT(*) * SUM(total_laid_off * percentage_laid_off) - SUM(total_laid_off) * SUM(percentage_laid_off)) / 
    SQRT((COUNT(*) * SUM(total_laid_off * total_laid_off) - SUM(total_laid_off) * SUM(total_laid_off)) * 
         (COUNT(*) * SUM(percentage_laid_off * percentage_laid_off) - SUM(percentage_laid_off) * SUM(percentage_laid_off))) AS correlation
FROM layoffs_staging2;

-- Visualizing Data: Summing layoffs by month for visualizing trends in tools like Tableau or Power BI
SELECT SUBSTRING(`date`, 1, 7) AS `Month`, SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_staging2
GROUP BY `Month`
ORDER BY `Month`;

-- Checking for NULL values: Identifying rows where 'total_laid_off' is NULL, as it can affect analysis
-- There are 378 rows with NULL values in the 'total_laid_off' column.
SELECT COUNT(*) 
FROM layoffs_staging2 
WHERE total_laid_off IS NULL;
