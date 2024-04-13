select subject_id, count(hadm_id) as diagnoses_count

from drgcodes

where lower(description) like '%alcoholic%'

group by subject_id

having count(distinct hadm_id) > 1

order by diagnoses_count desc, subject_id desc;
