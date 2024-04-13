SELECT
        a.subject_id,
        a.hadm_id,
        d.icd_code,
       dd.long_title
    FROM admissions a
    JOIN diagnoses_icd d ON a.subject_id = d.subject_id AND a.hadm_id = d.hadm_id
    JOIN d_icd_diagnoses dd ON d.icd_code = dd.icd_code AND d.icd_version = dd.icd_version
    WHERE a.admission_type = 'URGENT' AND a.hospital_expire_flag = 1
    ORDER BY a.subject_id DESC, a.hadm_id DESC, d.icd_code DESC, dd.long_title DESC
LIMIT 1000;