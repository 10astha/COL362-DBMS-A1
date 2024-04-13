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
 RecursivePath AS (
    SELECT 0 AS subject_id,path_length
    FROM Nodes
    WHERE subject_id = 10001725

    UNION ALL

    SELECT node.subject_id,pat.path_length + 1
    FROM RecursivePath pat
    JOIN Edges edge ON edge.p1=pat.subject_id
    JOIN Nodes node ON node.subject_id=edge.p2
    WHERE pat.path_length < 5
)
SELECT COALESCE(
    (SELECT MIN(path_length) FROM RecursivePath WHERE subject_id = 14370607),
    0
) AS pathlength;


