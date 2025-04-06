Layoffs Data Analysis (EDA)
Project Overview
This project performs Exploratory Data Analysis (EDA) on a dataset of layoffs across various companies, industries, and countries. The goal of the analysis is to uncover patterns and trends in layoffs and understand how layoffs vary across industries, companies, stages, and time.

Files in this Repository
layoffs_staging2.sql: This file contains all the SQL queries used to perform the EDA and generate the results.

Outputs/: Directory containing CSV files that store the results of the queries.

README.md: Project overview and instructions.

SQL Queries Used
The following SQL queries were used for data analysis:

1. Basic Statistics: Finding Maximum and Minimum Layoffs
sql
Copy
Edit
SELECT MAX(total_laid_off), MAX(percentage_laid_off), MIN(total_laid_off), MIN(percentage_laid_off)
FROM layoffs_staging2;
2. Categorizing Industries: Counting Records per Industry
sql
Copy
Edit
SELECT industry, COUNT(*)
FROM layoffs_staging2
GROUP BY industry;
3. Summing Total Layoffs by Company
sql
Copy
Edit
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;
4. Summing Total Layoffs by Industry
sql
Copy
Edit
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;
5. Summing Total Layoffs by Country
sql
Copy
Edit
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;
6. Date Range Analysis: Finding Minimum and Maximum Layoff Dates
sql
Copy
Edit
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;
7. Summing Total Layoffs by Year
sql
Copy
Edit
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;
8. Using Window Functions to Calculate Total Layoffs per Stage
sql
Copy
Edit
SELECT DISTINCT stage, SUM(total_laid_off) OVER (PARTITION BY stage) AS total_per_stage
FROM layoffs_staging2
ORDER BY 2 DESC;
9. Rolling Total: Analyzing Layoffs Over Time Grouped by Month
sql
Copy
Edit
WITH rolling_total AS
(
  SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, SUM(total_laid_off) AS Total_off
  FROM layoffs_staging2
  WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
  GROUP BY `MONTH`
  ORDER BY `MONTH`
)
SELECT `MONTH`, Total_off, SUM(Total_off) OVER (PARTITION BY LEFT(`MONTH`, 4) ORDER BY `MONTH`) AS Rolling_Total
FROM rolling_total;
10. Ranking Companies by Total Layoffs
sql
Copy
Edit
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;
11. Ranking Companies by Total Layoffs by Year
sql
Copy
Edit
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;
12. Ranking Companies Based on Total Layoffs Per Year (Top 5)
sql
Copy
Edit
WITH company_year(company, years, total_laid_off) AS (
  SELECT company, YEAR(`date`), SUM(total_laid_off)
  FROM layoffs_staging2
  GROUP BY company, YEAR(`date`)
), company_year_rank AS (
  SELECT *,
    DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM company_year
  WHERE years IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE ranking <= 5;
13. Correlation Analysis Between Total Layoffs and Percentage Layoffs
sql
Copy
Edit
SELECT 
  (COUNT(*) * SUM(total_laid_off * percentage_laid_off) - SUM(total_laid_off) * SUM(percentage_laid_off)) / 
  SQRT((COUNT(*) * SUM(total_laid_off * total_laid_off) - SUM(total_laid_off) * SUM(total_laid_off)) * 
       (COUNT(*) * SUM(percentage_laid_off * percentage_laid_off) - SUM(percentage_laid_off) * SUM(percentage_laid_off))) AS correlation
FROM layoffs_staging2;
14. Visualizing Data: Summing Layoffs by Month
sql
Copy
Edit
SELECT SUBSTRING(`date`, 1, 7) AS `Month`, SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_staging2
GROUP BY `Month`
ORDER BY `Month`;
15. Checking for NULL Values in total_laid_off
sql
Copy
Edit
SELECT COUNT(*) 
FROM layoffs_staging2 
WHERE total_laid_off IS NULL;
Data Export
The outputs of the queries are exported to CSV files stored in the Outputs/ directory. These files can be used for further analysis or visualization in Python, R, or any other analytics tools.
