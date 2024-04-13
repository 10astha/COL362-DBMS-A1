WITH LatestMeningitisAdmissions AS (
    SELECT
        p.gender,
        CASE 
            WHEN a.hospital_expire_flag = 1 THEN 1
            ELSE 0
        END AS died
    FROM
        admissions a
        JOIN diagnoses_icd d ON a.subject_id = d.subject_id AND a.hadm_id = d.hadm_id
        JOIN d_icd_diagnoses d2 ON d.icd_code = d2.icd_code AND d.icd_version = d2.icd_version
        JOIN patients p ON a.subject_id = p.subject_id
    WHERE
        d2.long_title LIKE '%Meningitis%'
        AND a.admittime = (
            SELECT MAX(admittime)
            FROM admissions
            WHERE subject_id = a.subject_id
        )
)

SELECT
    gender,
    ROUND(100.0 * SUM(died) / COUNT(*), 2) AS mortality_rate
FROM
    LatestMeningitisAdmissions
GROUP BY
    gender
ORDER BY
    mortality_rate ASC, gender DESC;
