SELECT COUNT(DISTINCT a.hadm_id) AS count
FROM admissions a
JOIN labevents l ON a.subject_id = l.subject_id AND a.hadm_id = l.hadm_id
WHERE l.flag = 'abnormal' 
AND a.hospital_expire_flag = 1;
