--Subqueries
SELECT*
FROM(--sUBQUERY STARTS HERE
    SELECT*
    FROM job_postings_fact
    where EXTRACT(Month from job_posted_date)=1
    )As january_jobs;
    --subqyery ends here

--Common table expressions (CTEs)
WITH january_jobs AS (-- CTE definition starts here
SELECT*
FROM jOb_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)-- CTE definition ends here

SELECT*
FROM january_jobs;
-- Subqueries 2
SELECT
    company_id,
    name AS company_name
FROM 
    company_dim
WHERE company_id IN (
SELECT
    company_id
FROM 
     job_postings_fact
 WHERE
    job_no_degree_mention = true    )

--CTEs
WITH company_job_count AS (
SELECT
    company_id,
    COUNT(*) AS total_jobs
FROM
    job_postings_fact
GROUP BY
    company_id
)
SELECT  
    company_dim.name AS company_name,
    company_job_count.total_jobs

FROM company_dim

LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
