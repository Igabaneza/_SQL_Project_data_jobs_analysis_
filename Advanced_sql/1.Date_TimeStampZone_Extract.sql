/*SELECT job_posted_date
FROM job_postings_fact
LIMIT 10;
*/
-- ::(Est utlise quand il s'agit de changer la nature d'une colonne, en entier, caractere ou texte, ou string)
SELECT'2023-02-19'::DATE,
    '123':: INTEGER,
    'true':: BOOLEAN,
    '3.14':: REAL;

-- :: DATE
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date -- :: DATE va enlever les heures(ex: 17:35:07) du format et permettre qu'on garde les dates seulements dans la colonne concernee
FROM
    job_postings_fact; 

-- Timestamp without time zone
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time -- Ici il s'agit de changer l'affichage des erreurs en fonction fuseau horaire voulu, donc de UTC vers EST(-5h)
FROM
    job_postings_fact
LIMIT 5;
--Extract
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'EST' AS date_time, -- Ici il s'agit de changer l'affichage des erreurs en fonction fuseau horaire voulu, donc de UTC vers EST(-5h)
    EXTRACT(MONTH FROM job_posted_date) AS date_month -- ici c'est pour reperer et extraire la partie d'une date(mois, annee, jours) et creer une colonne avec la nouvelle donnee extraite
FROM
    job_postings_fact
LIMIT 5;--cette fonction peut etre utiliser pour l'analyse des tendances, par exemple voir le nombre d'offre d'emploi qui apparaisse par mois. Et comment ca change au fur de l'annee
--exemple de EXTRACT pour la tendance des offres d'
SELECT
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
        job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    GROUP BY
        month
ORDER BY
    job_posted_count DESC;-- The obtained result shows how many job offers are recorded for each month through the entire year 
