 WITH First12HoursPrescriptions AS (
    SELECT
        
        p.subject_id,
        p.hadm_id,
        p.drug
        
    FROM prescriptions p
    JOIN admissions a ON p.subject_id = a.subject_id AND p.hadm_id = a.hadm_id
    WHERE p.starttime>=a.admittime and p.starttime <= a.admittime + interval '12' hour
)

SELECT
    drug,
    COUNT(*) AS prescription_count
FROM First12HoursPrescriptions 
GROUP BY drug
ORDER BY prescription_count DESC
limit 1000;
