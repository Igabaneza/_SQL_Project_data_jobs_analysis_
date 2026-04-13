/* if I need to use UNION All for these queries, 
all that needs to be added is "ALL" on "Union". 
It will bring all the duplicates
 */
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    january_jobs
UNION

--Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    february_jobs

UNION-- comnine another table

--Get jobs and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    march_jobs