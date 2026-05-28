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

