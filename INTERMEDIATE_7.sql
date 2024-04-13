WITH avg_icu AS (    
    SELECT 
        subject_id, 
        COUNT(DISTINCT stay_id) AS total_stays, 
        AVG(los) AS avg_length_of_stay
    FROM 
        icustays
    WHERE 
        LOWER(icustays.first_careunit) LIKE '%micu%' OR LOWER(icustays.last_careunit) LIKE '%micu%'
    GROUP BY 
        subject_id
    HAVING 
        COUNT(DISTINCT stay_id) >= 5
) 
SELECT 
    DISTINCT avg_icu.subject_id, 
    avg_icu.total_stays, 
    avg_icu.avg_length_of_stay
FROM 
    icustays  
JOIN 
    avg_icu  
ON 
    icustays.subject_id = avg_icu.subject_id
ORDER BY 
    avg_length_of_stay DESC, total_stays DESC, subject_id DESC;

