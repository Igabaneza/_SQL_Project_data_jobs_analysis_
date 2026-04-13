SELECT *
FROM job_postings_fact
LIMIT 5;
SELECT *
FROM skills_job_dim;
SELECT *
FROM skills_dim;


--Exercices 1
SELECT
sub_skills_job_dim.skill_id,
skills_dim.skills,
count(*) AS skill_times_occurence
FROM (
SELECT 
    skill_id
FROM skills_job_dim

) AS sub_skills_job_dim
JOIN skills_dim
ON sub_skills_job_dim.skill_id = skills_dim.skill_id
 
GROUP BY sub_skills_job_dim.skill_id, skills_dim.skills
ORDER BY
    skill_times_occurence DESC
LIMIT 5
--
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
--




--Exercices 2
SELECT
job_postings_comp.company_id,
company_dim.name AS company_name,
CASE
 WHEN total_job_postings < 10 THEN 'SMALL'
        WHEN total_job_postings BETWEEN 10 AND 50 THEN 'MEDIUM'
ELSE 'LARGE'
END AS company_size,
total_job_postings
FROM (
SELECT
    company_id,
    COUNT (*) as total_job_postings
FROM jOb_postings_fact

Group by
(company_id)) AS job_postings_comp
LEFT JOIN company_dim  ON job_postings_comp.company_id = company_dim.company_id;

--Exercice 3
 /* find the count of the number of remote job postings per skill job postings 
 - display the top 5 skills by their demand in remote jobs
 - Include Skill ID, name, and count of postings requiring the skill
 */
 WITH remote_job_skills AS (
 SELECT 
    skill_id,
    COUNT(*) AS skill_count
 FROM
    skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id =  skills_to_job.job_id
WHERE
    job_postings.job_work_from_home = TRUE
GROUP BY
    skill_id
) 
SELECT 
    skills.skill_id,
    skills AS skill_name,
    skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;









































