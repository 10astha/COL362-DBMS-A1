SELECT icustays.subject_id, AVG(icustays.los) as avg_stay_duration
FROM  labevents 
JOIN icustays  on labevents.subject_id=icustays.subject_id and labevents.hadm_id=icustays.hadm_id 
WHERE   icustays.los is not NULL and labevents.itemid = 50878
GROUP BY  icustays.hadm_id,icustays.subject_id
ORDER BY avg_stay_duration desc, icustays.subject_id desc limit 1000;