WITH PatientAdmissions AS (
    SELECT
        p.subject_id,
        p.gender,
        COUNT(DISTINCT a.hadm_id) AS total_admissions,
        MAX(a.admittime) AS last_admission,
        MIN(a.admittime) AS first_admission
    FROM
        patients p
    JOIN
        admissions a ON p.subject_id = a.subject_id
    WHERE
        p.subject_id IN (
            SELECT DISTINCT subject_id
            FROM diagnoses_icd
            WHERE icd_code = '5723'
        )
    GROUP BY
        p.subject_id, p.gender
    HAVING
        COUNT(DISTINCT a.hadm_id) > 0
),
DiagnosisCount AS (
    SELECT
        di.subject_id,
        COUNT(DISTINCT di.hadm_id) AS diagnosis_count
    FROM
        diagnoses_icd di
    WHERE
        di.icd_code = '5723'
    GROUP BY
        di.subject_id
)
SELECT
    pa.subject_id,
    pa.gender,
    pa.total_admissions,
    pa.last_admission,
    pa.first_admission,
    COALESCE(dc.diagnosis_count, 0) AS diagnosis_count
FROM
    PatientAdmissions pa
LEFT JOIN
    DiagnosisCount dc ON pa.subject_id = dc.subject_id
ORDER BY
    pa.total_admissions DESC,
    COALESCE(dc.diagnosis_count, 0) DESC,
    pa.last_admission DESC,
    pa.first_admission DESC,
    pa.gender DESC,
    pa.subject_id DESC
    limit 1000;

