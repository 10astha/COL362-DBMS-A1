SELECT pharmacy_id, COUNT(DISTINCT subject_id) AS num_patients_visited
FROM prescriptions
GROUP BY pharmacy_id
ORDER BY num_patients_visited DESC, pharmacy_id ASC limit 497984;