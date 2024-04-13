SELECT COUNT(*) AS count
FROM diagnoses_icd
JOIN d_icd_diagnoses ON diagnoses_icd.icd_code = d_icd_diagnoses.icd_code AND diagnoses_icd.icd_version = d_icd_diagnoses.icd_version
WHERE long_title = 'Cholera due to vibrio cholerae';