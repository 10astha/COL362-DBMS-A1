SELECT patients.subject_id, anchor_age, COUNT(*) AS count
FROM icustays
join patients on icustays.subject_id=patients.subject_id
WHERE first_careunit = 'Coronary Care Unit (CCU)'
GROUP BY patients.subject_id, anchor_age
ORDER BY count(*) DESC,anchor_age DESC, subject_id DESC
LIMIT 3;