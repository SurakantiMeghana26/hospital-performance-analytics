{{ config(materialized='table') }}

SELECT 
    ROW_NUMBER() OVER (ORDER BY stg.facility_id) AS metric_id,
    h.hospital_key,
    s.state_key,
    TO_NUMBER(TO_CHAR(CURRENT_DATE(), 'YYYYMMDD')) AS date_key,
    stg.hospital_overall_rating AS overall_rating,
    CURRENT_TIMESTAMP() AS created_at
FROM {{ ref('stg_hospitals') }} stg
JOIN {{ ref('dim_hospitals') }} h 
    ON stg.facility_id = h.facility_id
JOIN {{ ref('dim_states') }} s 
    ON stg.state = s.state_code
WHERE h.is_current = TRUE