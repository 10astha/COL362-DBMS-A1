
with medications_prescribed as (
    select subject_id, hadm_id, drug 
    from prescriptions
    where drug ILIKE '%prochlorperazine%' OR drug ILIKE '%bupropion%'
),
heart_conditions as (
    select subject_id, hadm_id, count(distinct icd_code) as distinct_diagnoses_count
    from diagnoses_icd
    where LEFT(icd_code, 2) = 'V4'
    group by subject_id, hadm_id
    having count(distinct icd_code) > 1
)

select hc.subject_id, hc.hadm_id, hc.distinct_diagnoses_count, mp.drug
from  medications_prescribed mp
join heart_conditions hc  on 
mp.subject_id=hc.subject_id   and   mp.hadm_id=hc.hadm_id
group by   hc.distinct_diagnoses_count, hc.hadm_id,hc.subject_id,drug
order by distinct_diagnoses_count desc,subject_id desc,hadm_id desc,drug asc;
