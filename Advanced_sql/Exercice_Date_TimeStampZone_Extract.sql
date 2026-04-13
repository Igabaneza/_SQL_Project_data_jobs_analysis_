/*Question 1:
Write a query to find the average
salary both yearly (salary_year_avg) and hourly (salary_hour_avg) 
for job postings that were posted after june 1, 2023. 
Group the results by job schedule type.
____________________________________________________________________________
*/
SELECT 
    job_schedule_type,
    AVG(salary_year_avg),
    AVG(salary_hour_avg),
    Extract (DAY FROM job_posted_date::DATE) AS Day_posted_job,
    Extract (MONTH FROM job_posted_date::DATE) AS Month_posted_job,
    Extract (YEAR FROM job_posted_date::DATE) AS Year_posted_job
FROM job_postings_fact
GROUP BY
    job_schedule_type,
    Month_posted_job,
    Day_posted_job,
    Year_posted_job
HAVING
  (Extract (DAY FROM job_posted_date::DATE)> '1'
And
    Extract (MONTH FROM job_posted_date::DATE) >= '6'
And
    Extract (YEAR FROM job_posted_date::DATE) >= '2023');
--________________________________
/*Question 2:
Write a query to count the number of job postings for each month in 2023, adjusting the job_posted_date to be in America/New_york time zone before extracting(hint)the month.
Assume the job_posted_date is stored in UTC. 
Group by and order by the month.
*/
 SELECT
    
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS Month_posted_job,
    COUNT(job_id)
FROM
    job_postings_fact
GROUP BY 
    Month_posted_job
ORDER BY
    Month_posted_job ASC;
 --_______________________________

 /*Question 3:
Write a query to find companies (Include Company name) that 
have posted jobs offering health insurance,
 where these postings were made in the second quarter of 2023. 
Use date extraction to filter by quarter
*/

SELECT*
from job_postings_fact
LIMIT 5;

CREATE TABLE january_jobs AS
SELECT*
FROM job_postings_fact
WHERE Extract(MONTH FROM job_posted_date) = 1;

CREATE TABLE February_jobs AS
SELECT*
FROM job_postings_fact
WHERE Extract(MONTH FROM job_posted_date) = 2;

CREATE TABLE March_jobs AS
SELECT*
FROM job_postings_fact
WHERE Extract(MONTH FROM job_posted_date) = 3;

