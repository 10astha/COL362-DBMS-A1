WITH ICUCounts AS (
    SELECT distinct subject_id, COUNT( stay_id) AS ICUCount
    FROM icustays
    GROUP BY subject_id
    HAVING COUNT(DISTINCT stay_id) >= 5
)

SELECT 
    subject_id,
    ICUCount AS count
FROM ICUCounts
ORDER BY ICUCount DESC, subject_id DESC limit 1000;
