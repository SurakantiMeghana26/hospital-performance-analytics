\# 🏥 US Hospital Performance Analytics Platform



\[!\[Python](https://img.shields.io/badge/Python-3.11-3776AB?style=for-the-badge\&logo=python\&logoColor=white)](https://www.python.org/)

\[!\[Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=for-the-badge\&logo=snowflake\&logoColor=white)](https://www.snowflake.com/)

\[!\[dbt](https://img.shields.io/badge/dbt-FF694B?style=for-the-badge\&logo=dbt\&logoColor=white)](https://www.getdbt.com/)

\[!\[AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge\&logo=amazon-aws\&logoColor=white)](https://aws.amazon.com/)

\[!\[Airflow](https://img.shields.io/badge/Apache\_Airflow-017CEE?style=for-the-badge\&logo=apache-airflow\&logoColor=white)](https://airflow.apache.org/)

\[!\[Power BI](https://img.shields.io/badge/Power\_BI-F2C811?style=for-the-badge\&logo=powerbi\&logoColor=black)](https://powerbi.microsoft.com/)

\[!\[Healthcare](https://img.shields.io/badge/Healthcare-Domain-FF6B9D?style=for-the-badge)](#)



> \*\*An end-to-end production-grade healthcare data engineering platform analyzing US hospital performance using modern data stack — Snowflake, dbt, AWS, and Airflow. Built with HIPAA-aware patterns and real federal government data sources.\*\*



\---



\## 📋 Table of Contents



\- \[🎯 Project Overview](#-project-overview)

\- \[🏗️ Architecture](#️-architecture)

\- \[📊 Data Sources](#-data-sources)

\- \[🛠️ Tech Stack](#️-tech-stack)

\- \[📁 Project Structure](#-project-structure)

\- \[✨ Features](#-features)

\- \[🚀 Quick Start](#-quick-start)

\- \[📈 Insights \& Analytics](#-insights--analytics)

\- \[🔒 HIPAA Considerations](#-hipaa-considerations)

\- \[📚 Documentation](#-documentation)

\- \[🎯 Business Impact](#-business-impact)

\- \[🚧 Roadmap](#-roadmap)



\---



\## 🎯 Project Overview



This project demonstrates a complete end-to-end healthcare data engineering pipeline that integrates data from multiple federal government sources — CMS (Centers for Medicare \& Medicaid Services), CDC (Centers for Disease Control), and FDA (Food and Drug Administration) — to provide comprehensive analytics on US hospital performance.



\### 🎯 Business Goals



\- 📊 \*\*Hospital Performance Tracking\*\* — Monitor quality ratings across 4,000+ US hospitals

\- 💰 \*\*Cost Analysis\*\* — Compare healthcare costs by hospital, state, and procedure

\- ⭐ \*\*Quality Benchmarking\*\* — Identify top-performing hospitals and best practices

\- 🌍 \*\*Geographic Analysis\*\* — Understand healthcare disparities across states

\- 📈 \*\*Trend Identification\*\* — Track patient outcomes and readmission patterns

\- 💊 \*\*Drug Approval Analytics\*\* — Monitor FDA approval trends



\### 🎓 Learning Objectives



\- ✅ Modern data stack implementation (Snowflake + dbt)

\- ✅ Cloud architecture (AWS S3 + Glue)

\- ✅ Production patterns (Airflow orchestration)

\- ✅ Healthcare domain expertise

\- ✅ HIPAA-aware data handling

\- ✅ End-to-end ETL/ELT pipelines

\- ✅ Data quality \& testing

\- ✅ CI/CD with GitHub Actions



\---



\## 🏗️ Architecture



\### High-Level Architecture



```

┌─────────────────────────────────────────────────────────────┐

│                     DATA SOURCES (FREE!)                    │

│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐    │

│  │   CMS    │  │   CDC    │  │   FDA    │  │ Medicare │    │

│  │Hospital  │  │Healthcare│  │  Drugs   │  │  Costs   │    │

│  │ Compare  │  │   Data   │  │ Database │  │  Reports │    │

│  └────┬─────┘  └────┬─────┘  └────┬─────┘  └────┬─────┘    │

└───────┼─────────────┼─────────────┼─────────────┼──────────┘

&#x20;       │             │             │             │

&#x20;       └─────────────┴──────┬──────┴─────────────┘

&#x20;                            ▼

&#x20;       ┌─────────────────────────────────────────┐

&#x20;       │     🐍 PYTHON INGESTION LAYER            │

&#x20;       │   • REST API extraction                 │

&#x20;       │   • Data validation (Pydantic)          │

&#x20;       │   • Error handling \& retry logic        │

&#x20;       │   • Structured logging                  │

&#x20;       └────────────────┬────────────────────────┘

&#x20;                        ▼

&#x20;       ┌─────────────────────────────────────────┐

&#x20;       │     ☁️ AWS S3 DATA LAKE                  │

&#x20;       │   • Raw zone (JSON, CSV)                │

&#x20;       │   • Processed zone (Parquet)            │

&#x20;       │   • Date-partitioned                    │

&#x20;       └────────────────┬────────────────────────┘

&#x20;                        ▼

&#x20;       ┌─────────────────────────────────────────┐

&#x20;       │     ⚙️ AWS GLUE (PySpark ETL)            │

&#x20;       │   • Schema standardization              │

&#x20;       │   • Data cleaning                       │

&#x20;       │   • PHI handling                        │

&#x20;       └────────────────┬────────────────────────┘

&#x20;                        ▼

&#x20;       ┌─────────────────────────────────────────┐

&#x20;       │     ❄️ SNOWFLAKE WAREHOUSE               │

&#x20;       │   ┌─────────────────────────────────┐   │

&#x20;       │   │  🥉 RAW\_DATA (Bronze)           │   │

&#x20;       │   │  🥈 STAGING (Silver)            │   │

&#x20;       │   │  🥇 MARTS (Gold - Star Schema)  │   │

&#x20;       │   └─────────────────────────────────┘   │

&#x20;       └────────────────┬────────────────────────┘

&#x20;                        ▼

&#x20;       ┌─────────────────────────────────────────┐

&#x20;       │     🔧 dbt TRANSFORMATIONS               │

&#x20;       │   • Sources \& staging models            │

&#x20;       │   • Mart models (star schema)           │

&#x20;       │   • Tests (data quality)                │

&#x20;       │   • Documentation                       │

&#x20;       │   • Snapshots (SCD Type 2)              │

&#x20;       └────────────────┬────────────────────────┘

&#x20;                        ▼

&#x20;       ┌─────────────────────────────────────────┐

&#x20;       │     🌬️ AIRFLOW ORCHESTRATION            │

&#x20;       │   • Daily DAG scheduling                │

&#x20;       │   • Failure alerting                    │

&#x20;       │   • SLA monitoring                      │

&#x20;       └────────────────┬────────────────────────┘

&#x20;                        ▼

&#x20;       ┌─────────────────────────────────────────┐

&#x20;       │     📊 POWER BI DASHBOARD                │

&#x20;       │   • Executive scorecards                │

&#x20;       │   • Hospital comparisons                │

&#x20;       │   • Cost analytics                      │

&#x20;       │   • Geographic insights                 │

&#x20;       └─────────────────────────────────────────┘

```



\### Data Model (Star Schema)



\*\*Dimensions:\*\*

\- `dim\_hospitals` — Hospital master data with SCD Type 2

\- `dim\_states` — US states with demographics

\- `dim\_conditions` — Medical conditions and ICD codes

\- `dim\_procedures` — Medical procedures

\- `dim\_date` — Time dimension



\*\*Facts:\*\*

\- `fact\_hospital\_metrics` — Hospital performance metrics

\- `fact\_quality\_ratings` — Quality measurement scores

\- `fact\_cost\_analysis` — Cost and reimbursement data

\- `fact\_readmissions` — Readmission rates and patterns



\---



\## 📊 Data Sources



\### Federal Government APIs (All Free \& Public!)



| Source | Description | Volume | Update Frequency |

|--------|-------------|--------|------------------|

| 🏥 \*\*CMS Hospital Compare\*\* | US hospital quality ratings | 4,000+ hospitals | Quarterly |

| 💰 \*\*CMS Cost Reports\*\* | Medicare reimbursement data | 5,000+ reports | Annually |

| 🦠 \*\*CDC Healthcare Data\*\* | Disease and health surveillance | Multiple datasets | Weekly |

| 💊 \*\*FDA Drug Database\*\* | Drug approvals and recalls | 1,000s of drugs | Daily |



\### Data Includes:

\- ✅ Hospital quality ratings (1-5 stars)

\- ✅ Patient satisfaction scores

\- ✅ Readmission rates

\- ✅ Mortality rates

\- ✅ Cost data (Medicare/Medicaid)

\- ✅ FDA drug approvals

\- ✅ CDC disease metrics



\---



\## 🛠️ Tech Stack



\### Languages \& Frameworks

| Tool | Purpose |

|------|---------|

| 🐍 \*\*Python 3.11\*\* | Data ingestion \& ETL scripting |

| 🔥 \*\*PySpark\*\* | Large-scale data processing |

| 📊 \*\*SQL\*\* | Database queries \& transformations |

| 📋 \*\*Pydantic\*\* | Data validation |



\### Cloud \& Infrastructure

| Tool | Purpose |

|------|---------|

| ☁️ \*\*AWS S3\*\* | Data lake storage |

| ⚙️ \*\*AWS Glue\*\* | ETL processing |

| 🔐 \*\*AWS IAM\*\* | Access management |

| 🏗️ \*\*Terraform\*\* | Infrastructure as Code |



\### Data Warehouse \& Transformation

| Tool | Purpose |

|------|---------|

| ❄️ \*\*Snowflake\*\* | Cloud data warehouse |

| 🔧 \*\*dbt-core\*\* | Data transformations |

| 🧪 \*\*Great Expectations\*\* | Data quality |



\### Orchestration \& Monitoring

| Tool | Purpose |

|------|---------|

| 🌬️ \*\*Apache Airflow\*\* | Workflow orchestration |

| 🐳 \*\*Docker\*\* | Containerization |

| 📊 \*\*CloudWatch\*\* | Monitoring \& logs |



\### Visualization

| Tool | Purpose |

|------|---------|

| 📊 \*\*Power BI\*\* | Business intelligence |



\### CI/CD

| Tool | Purpose |

|------|---------|

| 🚀 \*\*GitHub Actions\*\* | Automated workflows |



\---



\## 📁 Project Structure



```

hospital-performance-analytics/

│

├── 📜 README.md                    # This file

├── 📜 LICENSE                      # MIT License

├── 📜 .gitignore                   # Git ignore patterns

│

├── 📂 src/                         # Python source code

│   ├── ingestion/                  # API extractors

│   ├── transformations/            # Data transformations

│   ├── storage/                    # Storage handlers

│   ├── quality/                    # Data quality checks

│   └── utils/                      # Utility functions

│

├── 📂 glue\_jobs/                   # AWS Glue PySpark jobs

│

├── 📂 dbt\_project/                 # dbt transformations

│   ├── models/

│   │   ├── staging/                # Bronze layer

│   │   ├── intermediate/           # Silver layer

│   │   └── marts/                  # Gold layer (star schema)

│   ├── tests/                      # dbt tests

│   ├── macros/                     # Reusable SQL

│   └── seeds/                      # Static data

│

├── 📂 airflow/                     # Workflow orchestration

│   ├── dags/                       # Airflow DAGs

│   └── plugins/                    # Custom operators

│

├── 📂 terraform/                   # Infrastructure as Code

│

├── 📂 dashboards/                  # Power BI files

│   └── screenshots/                # Dashboard images

│

├── 📂 docs/                        # Documentation

│

├── 📂 tests/                       # Python tests

│

└── 📂 .github/workflows/           # CI/CD pipelines

```



\---



\## ✨ Features



\### Core Features

\- ✅ \*\*Multi-source data integration\*\* (CMS + CDC + FDA)

\- ✅ \*\*Real-time data refresh\*\* capability

\- ✅ \*\*Production-grade orchestration\*\* with Airflow

\- ✅ \*\*Modern data stack\*\* (Snowflake + dbt)

\- ✅ \*\*Star schema\*\* dimensional modeling

\- ✅ \*\*SCD Type 2\*\* for slowly changing dimensions



\### Quality \& Reliability

\- ✅ \*\*Data quality testing\*\* with dbt tests

\- ✅ \*\*Schema validation\*\* with Pydantic

\- ✅ \*\*Error handling\*\* with retry logic

\- ✅ \*\*Comprehensive logging\*\* for debugging

\- ✅ \*\*Unit \& integration tests\*\*



\### Production Patterns

\- ✅ \*\*Infrastructure as Code\*\* (Terraform)

\- ✅ \*\*CI/CD pipelines\*\* (GitHub Actions)

\- ✅ \*\*Containerization\*\* (Docker)

\- ✅ \*\*Documentation as code\*\* (dbt docs)

\- ✅ \*\*Version control\*\* (Git workflow)



\### Healthcare-Specific

\- ✅ \*\*HIPAA-aware\*\* data handling

\- ✅ \*\*PHI considerations\*\* in code

\- ✅ \*\*Healthcare KPIs\*\* (LOS, readmissions, etc.)

\- ✅ \*\*Domain expertise\*\* demonstrated



\---



\## 🚀 Quick Start



\### Prerequisites



\- Python 3.11+

\- AWS Account (free tier)

\- Snowflake Account (free trial)

\- Docker Desktop

\- Power BI Desktop



\### Installation



```bash

\# Clone the repository

git clone https://github.com/SurakantiMeghana26/hospital-performance-analytics.git

cd hospital-performance-analytics



\# Install Python dependencies

pip install -r requirements.txt



\# Configure AWS credentials

aws configure



\# Setup Snowflake connection

\# (See docs/setup\_guide.md)



\# Initialize dbt

cd dbt\_project

dbt init

dbt deps

```



\### Run the Pipeline



```bash

\# Start Airflow (Docker)

cd airflow

docker-compose up -d



\# Access Airflow UI

\# http://localhost:8080



\# Trigger the DAG

\# Or wait for scheduled run

```



\---



\## 📈 Insights \& Analytics



\### Key Business Questions Answered



\#### Hospital Performance

1\. 🏆 Which hospitals have the highest quality ratings?

2\. 📊 What are the top hospitals by state?

3\. ⚠️ Which hospitals have the most readmissions?



\#### State Analysis  

4\. 🌍 Which US states have the best healthcare?

5\. 💵 How do healthcare costs vary by state?



\#### Cost Analysis

6\. 💸 What are the most expensive procedures?

7\. 💰 What are Medicare reimbursement patterns?

8\. 📊 Is there a cost-quality correlation?



\#### Quality Metrics

9\. ⭐ Average quality ratings by region?

10\. 💉 Patient satisfaction scores?

11\. ❤️ Mortality rates by condition?



\---



\## 🔒 HIPAA Considerations



This project demonstrates HIPAA-aware design patterns:



\- ✅ \*\*Public data only\*\* — No PHI in this demo

\- ✅ \*\*De-identification patterns\*\* demonstrated

\- ✅ \*\*Access control\*\* via IAM

\- ✅ \*\*Audit logging\*\* implemented

\- ✅ \*\*Encryption\*\* at rest and in transit

\- ✅ \*\*Compliance documentation\*\*



⚠️ \*\*Note:\*\* This is a demonstration project using publicly available data. For production HIPAA-compliant systems, additional controls are required.



\---



\## 📚 Documentation



Detailed documentation is available in the `/docs` folder:



\- 📖 \[Architecture Decisions](docs/architecture.md)

\- 📖 \[Data Dictionary](docs/data\_dictionary.md)

\- 📖 \[Deployment Guide](docs/deployment\_guide.md)

\- 📖 \[Operations Runbook](docs/operations\_runbook.md)

\- 📖 \[Data Quality Framework](docs/data\_quality\_framework.md)

\- 📖 \[Lessons Learned](docs/lessons\_learned.md)



\---



\## 🎯 Business Impact



\### For Healthcare Organizations:

\- 📊 \*\*Identify top performers\*\* for best practice adoption

\- 💰 \*\*Optimize costs\*\* through benchmarking

\- ⭐ \*\*Improve quality\*\* with targeted initiatives

\- 🌍 \*\*Expand strategically\*\* with geographic insights



\### For Patients:

\- 🏥 Choose better hospitals

\- 📊 Compare healthcare options

\- 💵 Understand cost transparency



\### For Policy Makers:

\- 📈 Track healthcare trends

\- 💰 Identify cost-saving opportunities

\- 🎯 Allocate resources effectively



\---



\## 🚧 Roadmap



\### Phase 1: Foundation ✅ (Weeks 1-2)

\- \[x] Project setup

\- \[x] GitHub repository

\- \[ ] AWS infrastructure setup

\- \[ ] Snowflake account configuration



\### Phase 2: Data Ingestion (Weeks 2-3)

\- \[ ] CMS hospital data extraction

\- \[ ] CMS quality data extraction

\- \[ ] CDC data integration

\- \[ ] FDA drug data integration



\### Phase 3: Data Warehouse (Weeks 3-4)

\- \[ ] Snowflake schema design

\- \[ ] S3 to Snowflake integration

\- \[ ] dbt project setup

\- \[ ] Staging models



\### Phase 4: Modeling (Weeks 4-5)

\- \[ ] Dimension models

\- \[ ] Fact models

\- \[ ] SCD Type 2 implementation

\- \[ ] Data quality tests



\### Phase 5: Orchestration (Week 5)

\- \[ ] Airflow setup

\- \[ ] DAG implementation

\- \[ ] Error handling

\- \[ ] Monitoring



\### Phase 6: Visualization (Week 6)

\- \[ ] Power BI connection

\- \[ ] Dashboard development

\- \[ ] Documentation

\- \[ ] Final polish



\---



\## 🤝 Contributing



This is a personal portfolio project, but feedback and suggestions are welcome!



\---



\## 📜 License



This project is licensed under the MIT License - see the \[LICENSE](LICENSE) file for details.



\---



\## 👤 Author



\*\*Surakanti Meghana\*\*  

Aspiring Healthcare Data Engineer | Specializing in Modern Data Stack



\- 🐙 \*\*GitHub:\*\* \[@SurakantiMeghana26](https://github.com/SurakantiMeghana26)

\- 💼 \*\*LinkedIn:\*\* \[Add your LinkedIn URL]

\- 📧 \*\*Email:\*\* musicroomlibrary@gmail.com

\- 🏥 \*\*Specialization:\*\* Healthcare Data Engineering

\- 📍 \*\*Location:\*\* Dublin, Ohio (Cardinal Health region!)



\---



\## 🙏 Acknowledgments



\- 🏥 \*\*CMS\*\* for hospital quality data

\- 🦠 \*\*CDC\*\* for healthcare surveillance data

\- 💊 \*\*FDA\*\* for drug approval data

\- 📚 Data engineering community for best practices



\---



\## 🌟 Project Status



🚧 \*\*Status:\*\* Active Development  

📅 \*\*Started:\*\* October 2024  

📅 \*\*Target Completion:\*\* December 2024  

📈 \*\*Progress:\*\* Phase 1 (Foundation)



\---



<div align="center">



\### ⭐ If you find this project interesting, please star it! ⭐



\*\*Built with 💜 by Surakanti Meghana\*\*



\---



\*"In data we trust, in healthcare we serve."\*



</div>

