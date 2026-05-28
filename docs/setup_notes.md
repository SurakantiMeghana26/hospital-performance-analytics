\# 🏗️ Infrastructure Setup Notes



\## 📅 Setup Date: May 28, 2026



This document tracks the infrastructure setup for the US Hospital Performance Analytics Platform.



\---



\## ✅ Day 1: Project Foundation



\### GitHub Repository

\- ✅ Repository created: `hospital-performance-analytics`

\- ✅ Public repository (recruiter visible)

\- ✅ Professional README written

\- ✅ 25+ folder structure created

\- ✅ Initial commit pushed



\### Project Structure



\---



\## ✅ Day 2: Cloud Infrastructure



\### Snowflake Setup ❄️



\*\*Account Details:\*\*

\- Edition: Standard

\- Cloud Provider: AWS

\- Region: US East 2 (Ohio)

\- Status: Active (30-day free trial)



\*\*Database Created:\*\*

\- Name: `HEALTHCARE\_ANALYTICS`

\- Purpose: Main database for healthcare data



\*\*Schemas Created (Medallion Architecture):\*\*



| Schema | Layer | Purpose |

|--------|-------|---------|

| 🥉 `RAW\_DATA` | Bronze | Raw data from CMS, CDC, FDA |

| 🥈 `STAGING` | Silver | Cleaned and validated data |

| 🥇 `MARTS` | Gold | Business-ready dimensional models |



\*\*Warehouse:\*\*

\- Name: `COMPUTE\_WH`

\- Size: X-Small (free tier)



\### AWS S3 Setup ☁️



\*\*Bucket Created:\*\*

\- Name: `hospital-analytics-meghana-2026`

\- Region: US East 2 (Ohio)

\- Same region as Snowflake (fast data transfer!)



\*\*Folder Structure:\*\*



hospital-analytics-meghana-2026/

├── raw/

│   ├── cms/              # CMS hospital data

│   ├── cdc/              # CDC health data

│   ├── fda/              # FDA drug data

│   └── medicare/         # Medicare cost data

└── processed/            # Processed Parquet files

---

## ✅ Day 4: Snowflake Integration

### S3 to Snowflake Pipeline

**Steps Completed:**
- ✅ Created CSV file format
- ✅ Created external stage (S3 connection)
- ✅ Created raw_hospitals table
- ✅ Loaded 5,000 hospitals from S3 → Snowflake
- ✅ Verified data with SQL queries

**Data Loaded:**
- Total Records: 5,000 US hospitals
- Source: CMS Hospital Compare API
- Format: CSV with 30 columns
- Storage: HEALTHCARE_ANALYTICS.RAW_DATA.raw_hospitals

**SQL Files Created:**
- `src/storage/snowflake_setup.sql` - Complete Snowflake setup

**Key Learnings:**
- Schema flexibility in raw layer (Bronze)
- Importance of ON_ERROR = 'CONTINUE' for resilient loading
- Medallion architecture: Raw → Staging → Marts
- File format objects for reusability
- External stages for S3 integration

---

*Last Updated: May 28, 2026 - Day 4 Complete*

