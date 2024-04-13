 WITH RECURSIVE 
    Nodes AS (
        SELECT DISTINCT subject_id, hadm_id, admittime, dischtime
        FROM admissions 
        WHERE dischtime IS NOT NULL
        ORDER BY admittime
        LIMIT 500
    ),
    Edges AS (
        SELECT DISTINCT adm1.subject_id AS p1, adm2.subject_id AS p2
        FROM Nodes adm1
        JOIN Nodes adm2 ON adm1.subject_id <> adm2.subject_id  
       
            AND  (adm1.dischtime >= adm2.admittime AND adm1.admittime <= adm2.dischtime  ) 
        JOIN diagnoses_icd d1 ON  d1.subject_id=adm1.subject_id  AND   d1.hadm_id=adm1.hadm_id
        JOIN diagnoses_icd d2 ON   d2.subject_id=adm2.subject_id AND   d2.hadm_id=adm2.hadm_id
            AND d1.icd_code = d2.icd_code AND d1.icd_version = d2.icd_version
    ),
    MyPath AS (
        SELECT 0 AS pathlen, subject_id
        FROM Nodes WHERE subject_id = 10001725
        UNION ALL
        SELECT node.subject_id,pat.pathlen + 1
        FROM MyPath pat
        JOIN Edges edge ON   edge.p1=pat.subject_id
        JOIN Nodes node ON   node.subject_id=edge.p2
        WHERE pat.pathlen < 5
    )

SELECT COUNT(*) > 0 AS result
FROM MyPath
WHERE pathlen <= 5 AND subject_id = 19438360;

