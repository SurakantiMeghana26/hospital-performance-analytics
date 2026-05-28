{{ config(materialized='view') }}

SELECT 
    TRIM(col_1) AS facility_id,
    INITCAP(TRIM(col_2)) AS facility_name,
    INITCAP(TRIM(col_4)) AS city,
    UPPER(TRIM(col_5)) AS state,
    TRIM(col_6) AS zip_code,
    INITCAP(TRIM(col_9)) AS hospital_type,
    INITCAP(TRIM(col_10)) AS hospital_ownership,
    INITCAP(TRIM(col_11)) AS emergency_services,
    TRY_CAST(col_13 AS INTEGER) AS hospital_overall_rating,
    CURRENT_TIMESTAMP() AS dbt_loaded_at
FROM HEALTHCARE_ANALYTICS.RAW_DATA.raw_hospitals
WHERE col_1 IS NOT NULL