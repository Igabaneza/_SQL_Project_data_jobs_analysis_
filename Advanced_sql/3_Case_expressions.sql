SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
    WHEN job_location = 'Anywhere' THEN 'REMOTE'
    WHEN job_location = 'New York, NY' THEN 'LOCAL'
    ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;
