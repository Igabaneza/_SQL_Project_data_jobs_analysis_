/*Find job postings from the first quarter that have a salary 
greater than $70k
- Combine job posting tables from the first quarter or 2023(Jan-Mar)
-Gets jobs postings with an average yearly salary > $70.000
*/
SELECT 
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    quarter1_job_postings.salary_year_avg

FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT*
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings
WHERE 
    quarter1_job_postings.salary_year_avg > 70000 AND
    quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
     quarter1_job_postings.salary_year_avg DESC
LIMIT 5
