SELECT DISTINCT p.subject_id, p.anchor_age
FROM admissions a
JOIN diagnoses_icd d ON a.subject_id = d.subject_id 
JOIN patients p ON a.subject_id = p.subject_id
JOIN icustays i ON a.subject_id = i.subject_id 
JOIN d_icd_diagnoses dd ON d.icd_code = dd.icd_code 
WHERE dd.long_title = 'Typhoid fever' 
ORDER BY p.subject_id ASC, p.anchor_age ASC ;
