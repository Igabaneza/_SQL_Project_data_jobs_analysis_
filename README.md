# Introduction
Dive into the data job market! Focusing on data analyst roles, this project explores top paying jobs, in-demand skills, and where high demand meets high salary in data analytics.
SQL queries? Check them out here:[Projet_SQL folder](/Projet_SQL/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top -paid and in-demand skills, streamlining others work to find optimal jobs.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?
# Tools I used
- **SQL:** The backbone of my analysis, allowing me to query the databse and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual studio Code:** My go-to for database management and executing SQL queries.
-** Git & GitHub :** Essential fr version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking
# The Analysis

Each query for this project aimed at investigating specific aspects of the data analysr job market. Here's how I approached each question:

### 1.  Top paying Data Analyst Jobs
To identify the highest-paying roles. I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunies in the field.
```SQL
SELECT
    job_id,
    name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
    
FROM
    Job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT &T are among those offering high salaries, showing a broad interest across different industries.
- **Job Titke Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analystics, reflecting varied roles and specializations withm data analytics.

### 2. Top job paying skills
The goal of this analysis is to identify **which skills are required for the highest-paying Data Analyst jobs**. By focusing on the top 10 salaries and linking them to their required skills, the objective is to understand **what technical competencies are most valued in high-paying roles**, helping guide skill development toward better career opportunities.

```SQL
WITH top_paying_jobs AS (
SELECT
    job_id,
    name AS company_name,
    job_title,
    salary_year_avg
    
FROM
    Job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
)
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
**Key takeaways:**
- **SQL is non-negotiable**: It appears in nearly every top-paying role, making it the most essential skill for high-level data analysts.
- **Programming skills drive higher salaries**: Knowledge of Python and R strongly correlates with top-paying positions, highlighting the importance of advanced data manipulation and analysis.
- **Data visualization remains critical**: Tools like Tableau and Power BI are consistently required, showing that the ability to communicate insights is just as valuable as analyzing data.
- **Cloud and big data tools are increasingly valued**: Skills in platforms like AWS, Azure, Snowflake, and Databricks are common in higher-paying roles, reflecting the shift toward scalable data environments.
- **Senior roles require a broader tech stack**: Higher-paying positions (e.g., Director or Principal roles) demand a mix of technical, analytical, and workflow tools (e.g., Git, Jira, Excel), indicating that versatility is key at advanced levels.

### 3. The Top in-demand skills for Data Analysts

The goal of this analysis is to identify the most in-demand skills for Data Analysts by counting how often each skill appears across all job postings (specifically remote roles). This helps determine which skills are most frequently requested by employers, giving a clear view of what candidates should prioritize to stay competitive in the job market.
``` SQL
SELECT
    skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills  
ORDER BY
    demand_count DESC
LIMIT 5
```
**Key takeaways**:
- **SQL dominates the job market**: It is by far the most requested skill, confirming its role as the foundation of data analysis.
- **Excel remains highly relevant**: Despite more advanced tools, Excel is still widely demanded, especially for reporting and quick analysis tasks.
- **Python is a key differentiator**: Its strong presence shows that programming skills are increasingly expected, not just optional.
- **Visualization tools are essential**: Tableau and Power BI both rank in the top 5, emphasizing the importance of communicating data insights effectively.
- **Core toolkit is well-defined**: The top 5 skills (SQL, Excel, Python, Tableau, Power BI) form a clear baseline that most data analyst roles expect candidates to master.

### 4. Highest-Paying Skills for Data Analyst Roles

The goal of this analysis is to determine which skills are associated with the highest salaries for Data Analyst roles. By calculating the average salary per skill across job postings, it helps identify which technical competencies have the greatest financial impact, guiding professionals toward the most lucrative skill sets.
```SQL
SELECT
    skills,
    ROUND (AVG(salary_year_avg), 0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
   AND job_work_from_home = TRUE
GROUP BY
    skills  
ORDER BY
    avg_salary DESC
LIMIT 25
```
**Key takeaways**:

- **High salaries are linked to advanced, not basic skills**: Top-paying skills (e.g., PySpark, Databricks, Airflow) go beyond traditional analysis, indicating that basic tools alone are not enough to reach higher salary levels.
Data engineering skills significantly boost pay: Many top skills relate to data pipelines, big data processing, and infrastructure, showing that analysts who can handle data at scale are more valuable.
- **Cloud and distributed systems are major differentiators**: Knowledge of tools like Kubernetes and GCP highlights the importance of working with modern, scalable cloud environments.
- **Machine learning and production tools increase value**: Skills like scikit-learn, GitLab, and Jenkins suggest that high-paying roles often involve deploying models and working in production settings.
- **The role is evolving into a hybrid profile**: The highest-paying “Data Analyst” jobs increasingly overlap with data engineering and data science, meaning versatility and deeper technical expertise lead to better compensation.

### 5. Most Optimal Skills for Data Analysts (High Demand & High Paying)

Purpose of the analysis:
The goal of this analysis is to identify the most optimal skills for Data Analysts, meaning skills that are both high in demand and associated with high salaries. By combining demand (frequency in job postings) and average salary, this analysis highlights the best skills to learn for both job security and financial growth, especially in remote roles.

```SQL
WITH skills_demand AS (
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT (skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id

), average_salary AS(
SELECT
    skills_job_dim.skill_id,
    ROUND (AVG(salary_year_avg), 0) as avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
   AND job_work_from_home = TRUE
GROUP BY
    skills_job_dim.skill_id  

)
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand

INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
 demand_count DESC,
 avg_salary DESC
 LIMIT 25;
 ```
**Key takeaways**:

- **The best skills balance demand and salary**: The most valuable skills are not just high-paying or popular—they combine both, making them strategic investments for career growth.
- **Core tools still dominate the market**: Skills like SQL, Python, and Tableau continue to appear frequently, confirming they are essential even when considering salary optimization.
- **Advanced tools increase earning potential**: Skills related to big data, cloud, and engineering (e.g., Spark, cloud platforms) tend to push salaries higher while maintaining solid demand.
- **There is a clear “sweet spot” for learning**: Some skills may pay well but have low demand, while others are common but lower-paying—this analysis identifies the optimal middle ground.
**Versatility leads to better opportunities**: Combining foundational skills with more advanced or specialized tools gives candidates a strong advantage in both employability and salary potential.
# What I learned
- **How to translate business questions into SQL queries**: I learned how to take abstract questions (e.g., “What skills are most valuable?”) and break them down into structured queries using filtering, grouping, and joins.
- **Mastering SQL joins and CTEs**: Working with multiple tables (job postings, companies, and skills) helped me understand how to combine datasets effectively and use CTEs to simplify complex queries.
- **How to analyze data beyond just querying**: I didn’t just extract data—I learned how to interpret results, identify patterns (e.g., high-demand vs high-paying skills), and turn them into meaningful insights.
- **Understanding the data job market**: This project gave me a clear view of which skills are essential (SQL, Python), which are in demand, and how more advanced tools (cloud, data engineering) impact salaries.
- **Building a complete data project workflow**: From writing queries to structuring a GitHub project, I learned how to present my work clearly, document my analysis, and communicate insights effectively.

# Conclusions

### Insights
- The data analyst job market is strongly anchored around a core set of technical skills, with SQL, Python, Excel, Tableau, and Power BI consistently appearing as the most in-demand tools across job postings.
- While foundational skills remain essential, the highest-paying roles require more advanced capabilities, including cloud platforms (AWS, GCP, Azure), big data tools (Spark, Databricks), and engineering workflows.
- The analysis shows a clear distinction between “common skills” and “high-value skills”: basic tools ensure employability, while advanced tools significantly increase salary potential.
- The most optimal career strategy is to target skills that sit at the intersection of high demand and high salary, rather than focusing on only one dimension.
- Overall, the data suggests that the Data Analyst role is evolving into a hybrid profile, increasingly overlapping with data engineering and data science responsibilities.

### Closing thoughts

This project highlights that succeeding in the data analytics job market is not just about learning tools, but about learning the right combination of skills strategically.

SQL and Python remain non-negotiable foundations, but long-term career growth comes from expanding into cloud technologies, scalable data systems, and production-level workflows.

Ultimately, the most competitive candidates are those who combine strong analytical fundamentals with modern data engineering capabilities, positioning themselves for both high employability and high compensation.