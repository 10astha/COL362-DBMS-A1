
with bruh as(
 SELECT 
                
              
                diagnoses_icd.icd_code, 
                diagnoses_icd.icd_version, 
                COUNT(DISTINCT CASE WHEN admissions.hospital_expire_flag = 1 THEN (admissions.subject_id, admissions.hadm_id) END) * 100.0 / COUNT(DISTINCT (diagnoses_icd.subject_id, diagnoses_icd.hadm_id)) AS mortality_rate
            FROM 
                admissions
                JOIN diagnoses_icd   ON  admissions.hadm_id=diagnoses_icd.hadm_id  and admissions.subject_id=diagnoses_icd.subject_id 
            GROUP BY 
                diagnoses_icd.icd_code, diagnoses_icd.icd_version
            ORDER BY 
                COUNT(DISTINCT CASE WHEN admissions.hospital_expire_flag = 1 THEN (admissions.subject_id, admissions.hadm_id) END) * 100.0 / COUNT(DISTINCT (diagnoses_icd.subject_id, diagnoses_icd.hadm_id)) 
           DESC 
            LIMIT 245),

 diagnoses AS (
   SELECT d_icd_diagnoses.long_title ,d_icd_diagnoses.icd_version, d_icd_diagnoses.icd_code
    FROM d_icd_diagnoses
    JOIN bruh    ON d_icd_diagnoses.icd_code = bruh.icd_code AND d_icd_diagnoses.icd_version = bruh.icd_version
),
queer as (
    (SELECT diagnoses_icd.icd_code, diagnoses_icd.icd_version ,admissions.subject_id    
            FROM diagnoses_icd 
            JOIN  admissions  ON admissions.subject_id = diagnoses_icd.subject_id AND admissions.hadm_id = diagnoses_icd.hadm_id 
            WHERE admissions.hospital_expire_flag = 0
)
),
mareez AS (
    
    SELECT 
        p.subject_id, 
        p.anchor_age, 
        queer.icd_code, 
        queer.icd_version 
    FROM 
        patients AS p 
        JOIN   queer ON p.subject_id = queer.subject_id
)
SELECT 
    diagnoses.long_title AS long_title, 
    ROUND(AVG(mareez.anchor_age) ,2)AS survived_avg_age 
FROM 
   diagnoses
    JOIN mareez ON   diagnoses.icd_code=mareez.icd_code
     AND   diagnoses.icd_version =mareez.icd_version
GROUP BY 
    mareez.icd_code, mareez.icd_version, diagnoses.long_title
ORDER BY 
    long_title, survived_avg_age DESC;
