SELECT DISTINCT p.subject_id, p.anchor_age
FROM admissions a
JOIN patients p ON a.subject_id = p.subject_id 
JOIN procedures_icd pr1 ON a.subject_id = pr1.subject_id and a.hadm_id = pr1.hadm_id
JOIN procedures_icd pr2 ON pr1.icd_code = pr2.icd_code AND pr1.icd_version = pr2.icd_version
WHERE p.anchor_age < 50
AND a.subject_id IN (
    SELECT subject_id
    FROM admissions
    GROUP BY subject_id
    HAVING COUNT(DISTINCT hadm_id) > 1
)
AND pr1.hadm_id <> pr2.hadm_id and pr1.subject_id = pr2.subject_id
ORDER BY p.subject_id ASC, p.anchor_age ASC 