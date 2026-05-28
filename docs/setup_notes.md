# 🏗️ Infrastructure Setup Notes

> **Project:** US Hospital Performance Analytics Platform  
> **Author:** Surakanti Meghana  
> **Started:** May 27, 2026  
> **Status:** Active Development - Week 1 Complete

---

## 📋 Table of Contents

- [Day 1: Project Foundation](#-day-1-project-foundation)
- [Day 2: Cloud Infrastructure](#-day-2-cloud-infrastructure)
- [Day 3: Python ETL Pipeline](#-day-3-python-etl-pipeline)
- [Day 4: Snowflake Bronze Layer](#-day-4-snowflake-bronze-layer)
- [Day 5: Staging Silver Layer](#-day-5-staging-silver-layer)
- [Day 6: Star Schema Gold Layer](#-day-6-star-schema-gold-layer)
- [Bugs & Solutions](#-bugs--solutions)
- [Architecture Overview](#-architecture-overview)
- [Key Learnings](#-key-learnings)

---

## ✅ Day 1: Project Foundation

### 📅 Date: May 27, 2026

### Tasks Completed:
- ✅ Created public GitHub repository: `hospital-performance-analytics`
- ✅ Set up production-grade folder structure (25+ folders)
- ✅ Wrote comprehensive README with project vision
- ✅ Configured `.gitignore` for Python and data files
- ✅ Made initial commits with meaningful messages

### Project Structure Created:

hospital-performance-analytics/
├── src/                    # Python source code
│   ├── ingestion/          # API extractors
│   ├── transformations/    # Data transformations
│   ├── storage/            # Storage handlers
│   ├── quality/            # Data quality checks
│   └── utils/              # Utility functions
├── glue_jobs/              # AWS Glue PySpark scripts
├── dbt_project/            # dbt transformations (Week 2)
├── airflow/                # Workflow orchestration (Week 3)
├── terraform/              # Infrastructure as Code
├── dashboards/             # Power BI files (Week 4)
├── docs/                   # Documentation
├── tests/                  # Tests
├── data/                   # Sample data (gitignored)
└── .github/                # CI/CD workflows

### Tools/Technologies:
- Git
- GitHub
- Markdown
- VS Code / Notepad

---

## ✅ Day 2: Cloud Infrastructure

### 📅 Date: May 27, 2026

### Snowflake Setup ❄️

**Account Configuration:**
- **Edition:** Standard
- **Cloud Provider:** AWS
- **Region:** US East 2 (Ohio)
- **Trial:** 30 days free + $400 credit
- **Status:** Active

**Database Created:**
- **Name:** `HEALTHCARE_ANALYTICS`
- **Purpose:** Main database for healthcare data pipeline

**Schemas Created (Medallion Architecture):**

| Schema | Layer | Purpose |
|--------|-------|---------|
| 🥉 `RAW_DATA` | Bronze | Raw data from CMS, CDC, FDA sources |
| 🥈 `STAGING` | Silver | Cleaned and validated data |
| 🥇 `MARTS` | Gold | Business-ready dimensional models |

**Compute Warehouse:**
- **Name:** `COMPUTE_WH`
- **Size:** X-Small (free tier)

### AWS S3 Setup ☁️

**Bucket Created:**
- **Name:** `hospital-analytics-meghana-2026`
- **Region:** US East 2 (Ohio) - Same as Snowflake for fast transfer
- **Access:** Private (IAM-controlled)

**Folder Structure:**
hospital-analytics-meghana-2026/
├── raw/
│   ├── cms/              # CMS hospital data
│   ├── cdc/              # CDC health data
│   ├── fda/              # FDA drug data
│   └── medicare/         # Medicare cost data
└── processed/            # Processed Parquet files

### Cost Analysis:

| Service | Cost | Status |
|---------|------|--------|
| GitHub | $0 | Free public repo |
| AWS S3 | $0 | Free tier (5GB free) |
| Snowflake | $0 | 30-day trial |
| **TOTAL** | **$0** | All free! |

---

## ✅ Day 3: Python ETL Pipeline

### 📅 Date: May 28, 2026

### Python Environment Setup

**Libraries Installed:**
- `pandas` - Data manipulation
- `requests` - HTTP/API calls
- `boto3` - AWS SDK
- `python-dotenv` - Environment variables

### Data Source: CMS Hospital Compare

**API Used:**
- **URL:** `https://data.cms.gov/provider-data/api/1/datastore/query/xubh-q36u/0`
- **Type:** REST API (JSON)
- **Authentication:** None (public data)
- **Update Frequency:** Quarterly

### Scripts Created:

#### 1. `src/ingestion/test_cms_api.py`
- Tests CMS API connectivity
- Validates response structure
- Verifies data accessibility

#### 2. `src/ingestion/extract_cms_hospitals.py`
**Features:**
- ✅ Paginated extraction (500 records per page)
- ✅ Extracts up to 5,000 hospital records
- ✅ Saves as both CSV and JSON formats
- ✅ Date-partitioned output (`data/raw/cms/YYYY-MM-DD/`)
- ✅ Comprehensive logging
- ✅ Error handling with retry logic
- ✅ Data summary statistics

**Output:**
- `data/raw/cms/2026-05-27/hospitals.csv` (~2.5 MB)
- `data/raw/cms/2026-05-27/hospitals.json` (~5.2 MB)

#### 3. `src/ingestion/upload_to_s3.py`
**Features:**
- ✅ Uploads files to AWS S3
- ✅ Preserves folder structure
- ✅ Calculates file sizes
- ✅ Verifies uploads
- ✅ Professional logging

### Data Extracted:

| Metric | Value |
|--------|-------|
| Total Records | 5,000 hospitals |
| File Size (CSV) | 2.5 MB |
| File Size (JSON) | 5.2 MB |
| Time Taken | ~3 minutes |
| Errors | 0 |

### S3 Upload Results:
- ✅ `s3://hospital-analytics-meghana-2026/raw/cms/2026-05-27/hospitals.csv`
- ✅ `s3://hospital-analytics-meghana-2026/raw/cms/2026-05-27/hospitals.json`

---

## ✅ Day 4: Snowflake Bronze Layer

### 📅 Date: May 28, 2026

### S3 to Snowflake Integration

**Components Created:**

#### 1. File Format
```sql
CREATE OR REPLACE FILE FORMAT csv_format
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    NULL_IF = ('NULL', 'null', '')
    EMPTY_FIELD_AS_NULL = TRUE
    TRIM_SPACE = TRUE
    REPLACE_INVALID_CHARACTERS = TRUE;
```

#### 2. External Stage
- **Name:** `hospital_data_stage`
- **URL:** `s3://hospital-analytics-meghana-2026/raw/cms/`
- **Credentials:** AWS Access Key + Secret Key
- **File Format:** csv_format

#### 3. Raw Table
- **Name:** `raw_hospitals`
- **Schema:** Originally created in PUBLIC, moved to RAW_DATA
- **Structure:** 30 generic VARCHAR columns + loaded_at timestamp
- **Approach:** Flexible schema for unknown column structure

### Data Loading

**COPY INTO Command:**
- Loaded 5,000 records from S3
- Status: LOADED
- Errors: 0
- Time: ~2 seconds

### Verification Queries Run:
- ✅ COUNT(*) showed 5,000 records
- ✅ Sample data verified
- ✅ Column structure explored

### Files Created:
- `src/storage/snowflake_setup.sql` - Complete Snowflake setup SQL

---

## ✅ Day 5: Staging Silver Layer

### 📅 Date: May 28, 2026

### Data Cleaning & Transformation

**Goal:** Transform raw flexible columns into properly named, cleaned data

### Staging Table Created:
- **Name:** `STAGING.stg_hospitals`
- **Rows:** 5,000
- **Primary Key:** facility_id

**Schema:**
```sql
CREATE TABLE stg_hospitals (
    facility_id VARCHAR(50) NOT NULL,
    facility_name VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(2),
    zip_code VARCHAR(20),
    county_name VARCHAR(100),
    phone_number VARCHAR(50),
    hospital_type VARCHAR(100),
    hospital_ownership VARCHAR(100),
    emergency_services VARCHAR(10),
    hospital_overall_rating INTEGER,
    mortality_comparison VARCHAR(100),
    safety_comparison VARCHAR(100),
    readmission_comparison VARCHAR(100),
    patient_experience_comparison VARCHAR(100),
    effectiveness_comparison VARCHAR(100),
    timeliness_comparison VARCHAR(100),
    data_source VARCHAR(50),
    ingested_at TIMESTAMP,
    PRIMARY KEY (facility_id)
);
```

### Transformations Applied:

| Function | Purpose | Example |
|----------|---------|---------|
| `TRIM()` | Remove whitespace | "  Mayo Clinic  " → "Mayo Clinic" |
| `INITCAP()` | Proper case | "MAYO CLINIC" → "Mayo Clinic" |
| `UPPER()` | Uppercase state codes | "oh" → "OH" |
| `TRY_CAST()` | Safe type conversion | "5" → 5 (or NULL if invalid) |

### Data Quality Checks:
- ✅ All facility_ids present
- ✅ State coverage: 51 (states + DC)
- ✅ After bug fix: 2,947 valid ratings

### Files Created:
- `src/storage/staging_setup.sql` - Staging layer transformation SQL

---

## ✅ Day 6: Star Schema Gold Layer

### 📅 Date: May 28, 2026

### Dimensional Model Built

**Architecture:** Star Schema in MARTS schema

### Tables Created:

#### Dimension Tables:

**1. `dim_hospitals` (5,000 rows)**
- Hospital master data
- SCD Type 2 ready (effective_start_date, effective_end_date, is_current)
- Surrogate key: hospital_key (AUTOINCREMENT)

**2. `dim_states` (51 rows)**
- US states + DC
- Geographic hierarchy: state → division → region
- Surrogate key: state_key

**3. `dim_date` (1,095 rows)**
- 3 years of dates (2024-2026)
- Includes year, quarter, month, day_name, is_weekend
- Surrogate key: date_key (YYYYMMDD format)

#### Fact Table:

**4. `fact_hospital_metrics` (5,000 rows)**
- Connects dimensions via foreign keys
- Contains quality metrics:
  - overall_rating (1-5)
  - mortality_score
  - safety_score
  - readmission_score
  - patient_experience_score
  - effectiveness_score
  - timeliness_score

### Star Schema Diagram:
┌─────────────────────┐
                          │    dim_states       │
                          │   (51 records)      │
                          │                     │
                          │  state_key (PK)     │
                          │  state_code         │
                          │  state_name         │
                          │  region             │
                          │  division           │
                          └──────────┬──────────┘
                                     │
                                     │
                                     ▼
   ┌─────────────────┐    ┌──────────────────────┐    ┌─────────────────┐
   │  dim_hospitals  │    │ fact_hospital_metrics│    │   dim_date      │
   │  (5,000 records)│◄──►│    (5,000 records)   │◄──►│ (1,095 records) │
   │                 │    │                      │    │                 │
   │  hospital_key   │    │  metric_id (PK)      │    │  date_key (PK)  │
   │  facility_id    │    │  hospital_key (FK)   │    │  full_date      │
   │  facility_name  │    │  state_key (FK)      │    │  year           │
   │  city, state    │    │  date_key (FK)       │    │  quarter        │
   │  hospital_type  │    │  overall_rating      │    │  month          │
   │  emergency_svc  │    │  mortality_score     │    │  day_name       │
   │  is_current     │    │  safety_score        │    │  is_weekend     │
   └─────────────────┘    │  readmission_score   │    └─────────────────┘
                          │  patient_experience  │
                          │  effectiveness_score │
                          │  timeliness_score    │
                          └──────────────────────┘



### Business Intelligence Queries Verified:

✅ Top 5-star hospitals by region  
✅ Performance metrics by region  
✅ Ohio hospital analysis (Cardinal Health territory)  
✅ Hospital type performance comparison  
✅ Ownership analysis  
✅ State-level rankings  

### Files Created:
- `src/storage/gold_layer_setup.sql` - Complete star schema setup

---

## 🐛 Bugs & Solutions

### Bug #1: Schema Context Reverting to PUBLIC

**Symptom:**
- Created table with `USE SCHEMA RAW_DATA` but table appeared in PUBLIC schema
- Query failed: "Object HEALTHCARE_ANALYTICS.RAW_DATA.raw_hospitals does not exist"

**Root Cause:**
- Snowflake's USE SCHEMA doesn't always persist across queries
- Default schema can revert to PUBLIC

**Solution:**
- Used `ALTER TABLE ... RENAME TO` to move table to correct schema
- Adopted best practice: Use fully qualified names (`DATABASE.SCHEMA.TABLE`)
- Set schema context explicitly at start of each session

**Lesson Learned:** Always use fully qualified names in production SQL!

---

### Bug #2: Initial Schema Mismatch in COPY INTO

**Symptom:**
- Status: LOAD_FAILED
- 5,000 rows parsed, 0 loaded
- 5,000 errors

**Root Cause:**
- Hard-coded specific column names in table definition didn't match actual CMS CSV structure
- CMS column names varied from documentation

**Solution:**
- Created flexible table with generic VARCHAR columns (col_1, col_2, ...col_30)
- Used `ON_ERROR = 'CONTINUE'` for resilient loading
- This is a common professional pattern: Bronze layer accepts anything, transformations in Silver

**Lesson Learned:** Bronze layer should be flexible and forgiving!

---

### Bug #3: Column Mapping Error (CRITICAL)

**Symptom:**
- Star schema query returned 0 results for 5-star hospitals
- All `overall_rating` values were NULL
- 4,938 records had NULL ratings (98.8%)

**Investigation Process:**
1. Counted records in fact table: 4,938 (good)
2. Checked rating distribution: ALL NULL
3. Traced back to staging: ALSO ALL NULL
4. Examined raw data columns one by one
5. Discovered col_12 contained Y/N (boolean), not 1-5 ratings
6. **Found ratings in col_13!**

**Root Cause:**
- Assumed col_12 was hospital_overall_rating based on typical CMS structure
- Actual CMS API response had ratings in col_13
- Both staging AND fact table had same incorrect column reference

**Solution:**
1. Re-ran exploration query to identify rating column
2. DROPPED and rebuilt staging table with correct column (col_13)
3. DROPPED and rebuilt fact table with correct column (col_13)
4. Verified both layers had consistent rating counts:
   - Staging: 2,947 valid ratings
   - Fact: 2,938 valid ratings (99.7% consistency)

**Lesson Learned:**
- ALWAYS investigate raw data structure before assuming column mappings
- Cross-check data quality across all layers
- Real data engineering involves a lot of detective work!

---

### Bug #4: Schema Issue Pattern Recognition

**Symptom:**
- After fixing fact table, realized staging might have same issue

**Investigation:**
- Checked staging: Confirmed same NULL rating issue
- Pattern: Same column mapping bug existed in both layers

**Solution:**
- Fixed both layers proactively
- Verified consistency between layers
- Added cross-layer validation queries

**Lesson Learned:**
- **Senior engineer thinking:** Question previous work, look for patterns
- One bug often indicates similar bugs elsewhere
- Always verify consistency across pipeline layers

---

## 🏗️ Architecture Overview

### Complete Data Flow:

═══════════════════════════════════════════════════════════════
PRODUCTION DATA PIPELINE
═══════════════════════════════════════════════════════════════
📊 CMS Hospital Compare API
│ (REST API - JSON)
▼
🐍 Python Extraction Script
│ (paginated, 5,000 records)
▼
💾 Local Storage
│ (data/raw/cms/YYYY-MM-DD/)
│ - hospitals.csv
│ - hospitals.json
▼
☁️ AWS S3 Data Lake
│ (s3://hospital-analytics-meghana-2026/raw/cms/)
▼
❄️ Snowflake Warehouse (HEALTHCARE_ANALYTICS)
│
├── 🥉 RAW_DATA Schema (Bronze)
│   └── raw_hospitals (5,000 rows)
│
├── 🥈 STAGING Schema (Silver)
│   └── stg_hospitals (5,000 rows, 2,947 with ratings)
│
└── 🥇 MARTS Schema (Gold - Star Schema)
├── dim_hospitals (5,000 rows)
├── dim_states (51 rows)
├── dim_date (1,095 rows)
└── fact_hospital_metrics (5,000 rows)
↓
📊 Business Intelligence Queries
├── Top hospitals by region
├── State performance
├── Hospital type analysis
└── Ohio analytics (Cardinal Health)
═══════════════════════════════════════════════════════════════

---

## 🎓 Key Learnings

### Technical Skills Gained:

1. **Modern Data Stack:**
   - Snowflake cloud warehouse
   - Medallion architecture (Bronze/Silver/Gold)
   - Star schema dimensional modeling
   - AWS S3 data lake

2. **Python ETL:**
   - REST API integration
   - Pagination handling
   - Error handling and retry logic
   - Structured logging
   - boto3 for AWS

3. **SQL Mastery:**
   - DDL (CREATE, ALTER, DROP)
   - Complex SELECT with JOINs
   - Window functions
   - Type conversions (TRY_CAST)
   - Snowflake-specific functions

4. **Data Engineering Patterns:**
   - Schema evolution
   - SCD Type 2
   - Surrogate keys
   - Foreign key relationships
   - Data quality validation

### Soft Skills Developed:

1. **Debugging Mindset:**
   - Systematic investigation
   - Hypothesis testing
   - Cross-layer validation

2. **Pattern Recognition:**
   - Identifying similar bugs across systems
   - Proactive problem-solving

3. **Documentation:**
   - Clear, professional documentation
   - Architecture diagrams
   - Bug tracking

4. **Engineering Best Practices:**
   - Use fully qualified names
   - Test data quality at every layer
   - Document everything

### Real-World Insights:

- 🏥 **Healthcare data is messy**: 40% of hospitals had NULL ratings (expected)
- 📊 **Real data has gaps**: Don't expect 100% complete data
- 🔍 **Always investigate first**: Don't assume column mappings
- ✅ **Cross-validate layers**: Check consistency between stages
- 💼 **Production patterns matter**: Bronze flexibility, Silver cleaning, Gold business-ready

---

## 📊 Final Status: Week 1 Complete

### What's Working:
- ✅ End-to-end pipeline from API → S3 → Snowflake → Star Schema
- ✅ 5,000 US hospital records processed
- ✅ Business intelligence queries running
- ✅ Production-grade error handling
- ✅ Comprehensive documentation
- ✅ Version controlled in Git

### What's Next (Week 2):
- 🔄 Convert manual SQL to dbt models
- 🧪 Add dbt tests for data quality
- 📚 Generate dbt documentation
- 📦 Reusable, modular code
- 🎯 Industry-standard practices

---

## 📈 Project Statistics

| Metric | Value |
|--------|-------|
| Days Worked | 6 |
| GitHub Commits | 12+ |
| Files Created | 15+ |
| Lines of Code | 1,500+ |
| Data Sources | 1 (CMS) |
| Hospitals Analyzed | 5,000 |
| US States Covered | 51 |
| Cost So Far | $0 |
| Skills Demonstrated | 12+ |

---

## 🔗 Related Files

- [README.md](../README.md) - Project overview
- [src/ingestion/extract_cms_hospitals.py](../src/ingestion/extract_cms_hospitals.py) - Data extraction
- [src/ingestion/upload_to_s3.py](../src/ingestion/upload_to_s3.py) - S3 upload
- [src/storage/snowflake_setup.sql](../src/storage/snowflake_setup.sql) - Snowflake setup
- [src/storage/staging_setup.sql](../src/storage/staging_setup.sql) - Staging layer
- [src/storage/gold_layer_setup.sql](../src/storage/gold_layer_setup.sql) - Gold layer

---

*Last Updated: May 28, 2026*  
*Next Update: After Week 2 (dbt Integration)*  
*Status: 🟢 Active Development - On Track*
