{{ config(materialized='table') }}

WITH states_data AS (
    SELECT 'AL' AS state_code, 'Alabama' AS state_name, 'South' AS region, 'East South Central' AS division
    UNION ALL SELECT 'AK', 'Alaska', 'West', 'Pacific'
    UNION ALL SELECT 'AZ', 'Arizona', 'West', 'Mountain'
    UNION ALL SELECT 'AR', 'Arkansas', 'South', 'West South Central'
    UNION ALL SELECT 'CA', 'California', 'West', 'Pacific'
    UNION ALL SELECT 'CO', 'Colorado', 'West', 'Mountain'
    UNION ALL SELECT 'CT', 'Connecticut', 'Northeast', 'New England'
    UNION ALL SELECT 'DE', 'Delaware', 'South', 'South Atlantic'
    UNION ALL SELECT 'FL', 'Florida', 'South', 'South Atlantic'
    UNION ALL SELECT 'GA', 'Georgia', 'South', 'South Atlantic'
    UNION ALL SELECT 'HI', 'Hawaii', 'West', 'Pacific'
    UNION ALL SELECT 'ID', 'Idaho', 'West', 'Mountain'
    UNION ALL SELECT 'IL', 'Illinois', 'Midwest', 'East North Central'
    UNION ALL SELECT 'IN', 'Indiana', 'Midwest', 'East North Central'
    UNION ALL SELECT 'IA', 'Iowa', 'Midwest', 'West North Central'
    UNION ALL SELECT 'KS', 'Kansas', 'Midwest', 'West North Central'
    UNION ALL SELECT 'KY', 'Kentucky', 'South', 'East South Central'
    UNION ALL SELECT 'LA', 'Louisiana', 'South', 'West South Central'
    UNION ALL SELECT 'ME', 'Maine', 'Northeast', 'New England'
    UNION ALL SELECT 'MD', 'Maryland', 'South', 'South Atlantic'
    UNION ALL SELECT 'MA', 'Massachusetts', 'Northeast', 'New England'
    UNION ALL SELECT 'MI', 'Michigan', 'Midwest', 'East North Central'
    UNION ALL SELECT 'MN', 'Minnesota', 'Midwest', 'West North Central'
    UNION ALL SELECT 'MS', 'Mississippi', 'South', 'East South Central'
    UNION ALL SELECT 'MO', 'Missouri', 'Midwest', 'West North Central'
    UNION ALL SELECT 'MT', 'Montana', 'West', 'Mountain'
    UNION ALL SELECT 'NE', 'Nebraska', 'Midwest', 'West North Central'
    UNION ALL SELECT 'NV', 'Nevada', 'West', 'Mountain'
    UNION ALL SELECT 'NH', 'New Hampshire', 'Northeast', 'New England'
    UNION ALL SELECT 'NJ', 'New Jersey', 'Northeast', 'Middle Atlantic'
    UNION ALL SELECT 'NM', 'New Mexico', 'West', 'Mountain'
    UNION ALL SELECT 'NY', 'New York', 'Northeast', 'Middle Atlantic'
    UNION ALL SELECT 'NC', 'North Carolina', 'South', 'South Atlantic'
    UNION ALL SELECT 'ND', 'North Dakota', 'Midwest', 'West North Central'
    UNION ALL SELECT 'OH', 'Ohio', 'Midwest', 'East North Central'
    UNION ALL SELECT 'OK', 'Oklahoma', 'South', 'West South Central'
    UNION ALL SELECT 'OR', 'Oregon', 'West', 'Pacific'
    UNION ALL SELECT 'PA', 'Pennsylvania', 'Northeast', 'Middle Atlantic'
    UNION ALL SELECT 'RI', 'Rhode Island', 'Northeast', 'New England'
    UNION ALL SELECT 'SC', 'South Carolina', 'South', 'South Atlantic'
    UNION ALL SELECT 'SD', 'South Dakota', 'Midwest', 'West North Central'
    UNION ALL SELECT 'TN', 'Tennessee', 'South', 'East South Central'
    UNION ALL SELECT 'TX', 'Texas', 'South', 'West South Central'
    UNION ALL SELECT 'UT', 'Utah', 'West', 'Mountain'
    UNION ALL SELECT 'VT', 'Vermont', 'Northeast', 'New England'
    UNION ALL SELECT 'VA', 'Virginia', 'South', 'South Atlantic'
    UNION ALL SELECT 'WA', 'Washington', 'West', 'Pacific'
    UNION ALL SELECT 'WV', 'West Virginia', 'South', 'South Atlantic'
    UNION ALL SELECT 'WI', 'Wisconsin', 'Midwest', 'East North Central'
    UNION ALL SELECT 'WY', 'Wyoming', 'West', 'Mountain'
    UNION ALL SELECT 'DC', 'District of Columbia', 'South', 'South Atlantic'
)

SELECT 
    ROW_NUMBER() OVER (ORDER BY state_code) AS state_key,
    state_code,
    state_name,
    region,
    division
FROM states_data