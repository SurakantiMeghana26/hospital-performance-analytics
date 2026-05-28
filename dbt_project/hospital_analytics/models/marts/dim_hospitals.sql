{{ config(materialized='table') }}

SELECT 
    ROW_NUMBER() OVER (ORDER BY facility_id) AS hospital_key,
    facility_id,
    facility_name,
    city,
    state,
    zip_code,
    hospital_type,
    hospital_ownership,
    emergency_services,
    CURRENT_TIMESTAMP() AS effective_start_date,
    NULL AS effective_end_date,
    TRUE AS is_current
FROM {{ ref('stg_hospitals') }}