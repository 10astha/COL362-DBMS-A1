SELECT subject_id, COUNT(*) AS num_admissions
FROM admissions
GROUP BY subject_id
ORDER BY  count(*)   DESC , subject_id ASC limit 1;