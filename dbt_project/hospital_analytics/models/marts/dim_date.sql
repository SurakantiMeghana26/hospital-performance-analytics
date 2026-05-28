{{ config(materialized='table') }}

WITH date_spine AS (
    SELECT 
        DATEADD(day, SEQ4(), '2024-01-01'::DATE) AS full_date
    FROM TABLE(GENERATOR(ROWCOUNT => 1095))
)

SELECT 
    TO_NUMBER(TO_CHAR(full_date, 'YYYYMMDD')) AS date_key,
    full_date,
    YEAR(full_date) AS year,
    QUARTER(full_date) AS quarter,
    MONTH(full_date) AS month,
    MONTHNAME(full_date) AS month_name,
    DAY(full_date) AS day,
    DAYOFWEEK(full_date) AS day_of_week,
    DAYNAME(full_date) AS day_name,
    CASE WHEN DAYOFWEEK(full_date) IN (0, 6) THEN TRUE ELSE FALSE END AS is_weekend,
    YEAR(full_date) AS fiscal_year
FROM date_spine