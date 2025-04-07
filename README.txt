Layoffs Exploratory Data Analysis project

📌 Project Overview
This project involves performing Exploratory Data Analysis (EDA) on a dataset of layoffs across various companies, industries, and countries. The objective is to uncover meaningful insights, trends, and patterns in layoffs, helping understand how they vary across different factors such as industry, time period, country, and funding stage.

📁 Repository Contents
- `layoffs_staging2.csv` – Cleaned dataset used for analysis  
- `EDA_project.sql` – Contains all SQL queries used for analysis  
- `outputs_eda/` – Directory with CSV exports of query results  
- `README.txt` – Summary of the project and usage instructions  

🎯 Key Analysis Performed
- Total layoffs across companies, industries, and countries  
- Layoffs over time (monthly/yearly trends)  
- Industry-wise and stage-wise breakdown  
- Top companies with the highest layoffs (overall and per year)  
- Use of window functions for rolling totals and ranking  
- Basic correlation analysis between total layoffs and percentage layoffs  
- Detection of missing/null values  

📈 Examples of Insights
- Which industries were most affected by layoffs  
- Timeline of layoff spikes (e.g., economic downturns)  
- Top 5 companies with the highest layoffs each year  
- Relationship between company size (proxy: % laid off) and total layoffs  

🧰 Tools Used
- SQL – For data exploration and analysis  
- MySQL – Database environment for executing queries  
- CSV – Cleaned dataset and exported query outputs  

📤 Data Export
- Cleaned dataset: `layoffs_staging2.csv`  
- Query results: Stored in `.csv` files under the `outputs_eda/` directory  
These files can be used for visualization or further analysis in Python, R, Excel, or Power BI.

✅ Conclusion
This SQL-based EDA project reveals how layoffs have impacted different sectors, timelines, and geographies. The queries and insights can help businesses or researchers understand workforce trends and economic shifts across industries.
