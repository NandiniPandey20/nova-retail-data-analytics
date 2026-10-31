# Nova Retail Data Analytics

An end-to-end retail data analytics project focused on data quality, SQL analysis, Python exploration, and Power BI business intelligence.

> 🚧 **Project Status: In Progress**

## 📌 Project Overview

**Nova Retail Data Analytics** is an end-to-end portfolio project designed to simulate a real-world retail business analytics environment.

The project follows the complete data analytics workflow, from generating synthetic retail data to investigating data quality issues, analyzing business performance, and developing interactive dashboards.

Unlike projects that begin with an existing dataset, this project generates its own synthetic retail data using Python, with intentional data-quality anomalies introduced to practice SQL-based data validation and cleaning.

**Project Workflow:**

`Data Generation → MySQL Staging Tables → Data Quality Checks → SQL Cleaning & Analysis → Python Analysis → Power BI → Business Insights`

## 🎯 Project Objectives

- Generate a structured retail dataset from scratch using Python.
- Investigate data quality issues and data integrity violations.
- Identify duplicate records, missing values, and invalid references.
- Develop SQL skills through hands-on data cleaning and analysis.
- Use Python, NumPy, and Pandas for data exploration.
- Analyze retail sales, customer behavior, product performance, payments, and returns.
- Build interactive Power BI dashboards.
- Translate analytical findings into actionable business recommendations.

## 🗂️ Repository Structure

```text
nova-retail-data-analytics/
│
├── README.md
├── .gitignore
│
├── database_generation/
│   └── generate_tables.py
│
├── TABLES/
│   ├── cities.csv
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   ├── order_items.csv
│   ├── payments.csv
│   └── returns.csv
│
└── SQL/
    ├── 01_data_quality_checks.sql
    └── 02_data_cleaning.sql
```

**Directory Description:**

- `database_generation/` – Python script used to generate synthetic retail data.
- `TABLES/` – Raw CSV files containing the seven related retail tables.
- `SQL/` – SQL scripts for investigating data quality issues and performing data cleaning.

Additional directories for Python analysis and Power BI dashboards will be added as development progresses.

## 🐍 Data Generation

The synthetic retail dataset was generated from scratch using Python, NumPy, and Pandas.

The dataset represents seven related tables:

| Table | Expected Records |
|---|---:|
| Cities | 12 |
| Customers | 5,000 |
| Products | 500 |
| Orders | 25,000 |
| Order Items | 50,000 |
| Payments | 25,000 |
| Returns | 2,500 |
| **Total** | **108,012** |

These are the generated dataset's expected row counts. The CSV files contain deliberately introduced data-quality anomalies for investigation and cleaning during the SQL phase.

### Data Quality Scenarios

The dataset is designed to support investigation of issues such as:

- Duplicate identifiers
- Missing or blank values
- Invalid foreign key references
- Invalid prices and quantities
- Data integrity violations across related tables

The raw CSV files are retained as source data so that cleaning decisions can be documented and the original records can be compared with the cleaned data.

## 🗄️ Database and SQL

**Database Management System:** MySQL

The project uses three separate MySQL databases to support different learning and analysis requirements.

### Database Usage Guide

Depending on what you want to practice or explore, you can use the following databases:

**1. `nova_retail_analytics` – Raw Dataset**

Use this database if you want to:

- Practice SQL data-quality checks.
- Identify duplicate records and missing values.
- Investigate invalid foreign key references.
- Practice data integrity validation.
- Perform your own data-cleaning operations.

```sql
USE nova_retail_analytics;
```

**2. `nova_retail_cleaned` – Cleaned Dataset**

Use this database if you want to:

- Work directly with cleaned retail tables.
- Practice SQL queries and exploratory data analysis.
- Analyze sales, customers, products, payments, and returns.
- Perform business-focused data analysis without cleaning the raw dataset first.

```sql
USE nova_retail_cleaned;
```

**3. `nova_retail_verification` – Data Comparison**

Use this database if you want to:

- Compare raw and cleaned datasets.
- Understand the impact of data-cleaning operations.
- Verify changes in records and values.
- Examine differences between the original and cleaned data.

```sql
USE nova_retail_verification;
```

> **Note:** These databases serve different purposes. Choose the one that matches your learning objective. The raw database is intended for practicing data cleaning, the cleaned database is intended for direct analysis, and the verification database is intended for comparing the results.

### Data Import and Datatype Handling

An important part of this project was understanding how raw data should be handled during database ingestion.

- All columns in the initial MySQL staging tables were imported using the `VARCHAR` datatype.
- This approach preserved the original imported values without immediately forcing them into specific numeric or date formats.
- Datatypes were subsequently reviewed and changed wherever required.
- Appropriate datatypes were assigned based on the nature of the data and its intended use.

This approach helped separate the initial data ingestion process from datatype correction and subsequent data-quality investigation.

### SQL Scripts

The `SQL/` directory contains the following scripts:

| Script | Purpose |
|---|---|
| `01_data_quality_checks.sql` | Investigating data quality, duplicate records, missing values, and referential integrity. |
| `02_data_cleaning.sql` | Applying appropriate data-cleaning rules based on the findings from the quality checks. |

### SQL Work Completed

- Completed initial record count validation.
- Investigated duplicate primary key candidates.
- Checked missing and invalid values.
- Performed referential integrity checks between related tables.
- Investigated and documented detected data anomalies.

### Next Steps in SQL

- Define appropriate data-cleaning rules.
- Apply data-cleaning operations using SQL.
- Load cleaned records into the final relational tables.
- Validate primary keys, foreign keys, and business rules.
- Perform exploratory and business-focused SQL analysis.

## 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Python | Synthetic data generation and analysis |
| NumPy | Numerical operations |
| Pandas | Data manipulation and exploration |
| MySQL | Relational database, data quality checks, and SQL analysis |
| Power BI | Interactive dashboards and business intelligence |
| Git & GitHub | Version control and project documentation |

## 🔄 End-to-End Workflow

```text
Python Data Generation
          ↓
     Raw CSV Tables
          ↓
   MySQL Staging Tables
          ↓
 Data Quality Investigation
          ↓
    SQL Data Cleaning
          ↓
  Final Relational Tables
          ↓
     SQL Analysis
          ↓
  Python Data Exploration
          ↓
    Power BI Dashboards
          ↓
     Business Insights
```

## 📊 Project Progress

### ✅ Completed

- [x] Designed the retail dataset and its seven related tables.
- [x] Generated synthetic retail data using Python.
- [x] Created seven CSV files.
- [x] Created the `nova_retail_analytics` MySQL database.
- [x] Imported the CSV files into MySQL staging tables.
- [x] Imported initial staging data using VARCHAR datatypes.
- [x] Reviewed and corrected datatypes where required.
- [x] Verified the expected row counts across all seven staging tables.
- [x] Set up the GitHub repository and uploaded the raw dataset.
- [x] Created the SQL directory and initial SQL scripts.
- [x] Completed SQL data-quality and integrity checks.
- [x] Investigated and documented detected data anomalies.

### 🔄 In Progress

- [ ] Define and apply appropriate data-cleaning rules.
- [ ] Load cleaned records into the final relational tables.
- [ ] Validate primary keys, foreign keys, and business rules.
- [ ] Perform SQL exploratory data analysis.
- [ ] Conduct Python analysis using Pandas and NumPy.

### ⏳ Planned

- [ ] Analyze sales and revenue performance.
- [ ] Investigate customer and product trends.
- [ ] Analyze payment and return patterns.
- [ ] Develop interactive Power BI dashboards.
- [ ] Document business findings and recommendations.
- [ ] Complete the project documentation.

## 🚧 Project Status

This project is currently in the **SQL data-cleaning stage**.

The synthetic retail dataset has been generated, imported into MySQL staging tables, and investigated for data-quality issues. Initial SQL data-quality checks and anomaly investigations have been completed.

The next phase focuses on applying appropriate cleaning rules, creating validated relational tables, and preparing the dataset for SQL and Python-based business analysis.

The repository will be updated as each stage is completed.

## 👩‍💻 Project Author

**Nandini Pandey**

This project is part of my ongoing development of practical skills in Data Analytics, SQL, Python, and Business Intelligence, with a focus on building reproducible, well-documented analytical workflows.

