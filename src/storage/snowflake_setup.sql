-- =====================================================
-- HEALTHCARE ANALYTICS - SNOWFLAKE SETUP
-- =====================================================
-- Project: US Hospital Performance Analytics Platform
-- Author: Surakanti Meghana
-- Date: May 2026
-- Description: Complete Snowflake setup including file format,
--              external stage, and raw data loading from S3
-- =====================================================

-- =====================================================
-- 1. DATABASE & SCHEMA SETUP
-- =====================================================
USE DATABASE HEALTHCARE_ANALYTICS;
USE SCHEMA RAW_DATA;

-- Verify context
SELECT 
    CURRENT_DATABASE() as database,
    CURRENT_SCHEMA() as schema,
    CURRENT_WAREHOUSE() as warehouse,
    CURRENT_ROLE() as role;

-- =====================================================
-- 2. CREATE FILE FORMAT
-- =====================================================
-- Defines how Snowflake should parse CSV files
CREATE OR REPLACE FILE FORMAT csv_format
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    NULL_IF = ('NULL', 'null', '')
    EMPTY_FIELD_AS_NULL = TRUE
    TRIM_SPACE = TRUE
    REPLACE_INVALID_CHARACTERS = TRUE
    DATE_FORMAT = 'AUTO'
    TIMESTAMP_FORMAT = 'AUTO';

-- =====================================================
-- 3. CREATE EXTERNAL STAGE
-- =====================================================
-- Connects Snowflake to AWS S3 bucket
-- NOTE: Credentials should be stored securely (use IAM roles in production)
CREATE OR REPLACE STAGE hospital_data_stage
    URL = 's3://hospital-analytics-meghana-2026/raw/cms/'
    CREDENTIALS = (
        AWS_KEY_ID = '<AWS_ACCESS_KEY>'
        AWS_SECRET_KEY = '<AWS_SECRET_KEY>'
    )
    FILE_FORMAT = csv_format;

-- Verify stage works
LIST @hospital_data_stage;

-- =====================================================
-- 4. CREATE RAW TABLE
-- =====================================================
-- Flexible structure to accept all CMS data
CREATE OR REPLACE TABLE raw_hospitals (
    col_1 VARCHAR(500),
    col_2 VARCHAR(500),
    col_3 VARCHAR(500),
    col_4 VARCHAR(500),
    col_5 VARCHAR(500),
    col_6 VARCHAR(500),
    col_7 VARCHAR(500),
    col_8 VARCHAR(500),
    col_9 VARCHAR(500),
    col_10 VARCHAR(500),
    col_11 VARCHAR(500),
    col_12 VARCHAR(500),
    col_13 VARCHAR(500),
    col_14 VARCHAR(500),
    col_15 VARCHAR(500),
    col_16 VARCHAR(500),
    col_17 VARCHAR(500),
    col_18 VARCHAR(500),
    col_19 VARCHAR(500),
    col_20 VARCHAR(500),
    col_21 VARCHAR(500),
    col_22 VARCHAR(500),
    col_23 VARCHAR(500),
    col_24 VARCHAR(500),
    col_25 VARCHAR(500),
    col_26 VARCHAR(500),
    col_27 VARCHAR(500),
    col_28 VARCHAR(500),
    col_29 VARCHAR(500),
    col_30 VARCHAR(500),
    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- =====================================================
-- 5. LOAD DATA FROM S3
-- =====================================================
COPY INTO raw_hospitals (
    col_1, col_2, col_3, col_4, col_5, col_6, col_7, col_8, col_9, col_10,
    col_11, col_12, col_13, col_14, col_15, col_16, col_17, col_18, col_19, col_20,
    col_21, col_22, col_23, col_24, col_25, col_26, col_27, col_28, col_29, col_30
)
FROM @hospital_data_stage/2026-05-27/hospitals.csv
FILE_FORMAT = (FORMAT_NAME = csv_format)
ON_ERROR = 'CONTINUE';

-- =====================================================
-- 6. VERIFICATION QUERIES
-- =====================================================

-- Count total records
SELECT COUNT(*) AS total_hospitals 
FROM raw_hospitals;
-- Expected: 5,000

-- View sample data
SELECT * 
FROM raw_hospitals 
LIMIT 5;

-- Top 10 states by hospital count
SELECT 
    col_5 AS state,
    COUNT(*) AS hospital_count
FROM raw_hospitals
WHERE col_5 IS NOT NULL
GROUP BY col_5
ORDER BY hospital_count DESC
LIMIT 10;

-- =====================================================
-- END OF SETUP
-- =====================================================