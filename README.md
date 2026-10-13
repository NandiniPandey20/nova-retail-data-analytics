# Nova Retail Data Analytics

An end-to-end retail data analytics project focused on data quality, SQL analysis, Python exploration, and Power BI business intelligence.

> 🚧 **Project Status: In Progress**

## 📌 Project Overview

**Nova Retail Data Analytics** is an end-to-end portfolio project designed to simulate a real-world retail business analytics environment.

The project follows the complete data analytics workflow, from generating synthetic retail data to investigating data quality issues, analyzing business performance, and developing interactive dashboards.

Unlike projects that begin with an existing dataset, this project generates its own synthetic retail data using Python, with intentional data-quality anomalies introduced to practice SQL-based data validation and cleaning.

**Project Workflow:**

`Data Generation → MySQL Staging Tables → Data Quality Checks → SQL Analysis → Python Analysis → Power BI → Business Insights`

## 🎯 Project Objectives

* Generate a structured retail dataset from scratch using Python.
* Investigate data quality issues and data integrity violations.
* Identify duplicate records, missing values, and invalid references.
* Develop SQL skills through hands-on data cleaning and analysis.
* Use Python, NumPy, and Pandas for data exploration.
* Analyze retail sales, customer behavior, product performance, payments, and returns.
* Build interactive Power BI dashboards.
* Translate analytical findings into actionable business recommendations.

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
└── TABLES/
    ├── cities.csv
    ├── customers.csv
    ├── products.csv
    ├── orders.csv
    ├── order_items.csv
    ├── payments.csv
    └── returns.csv
```

The `TABLES/` directory contains the raw synthetic CSV files used as the source data for the project.

Additional directories for SQL scripts, Python analysis, and Power BI dashboards will be added as development progresses.

## 🐍 Data Generation

The synthetic retail dataset was generated from scratch using Python, NumPy, and Pandas.

The dataset represents seven related tables:

| Table       | Expected Records |
| ----------- | ---------------: |
| Cities      |               12 |
| Customers   |            5,000 |
| Products    |              500 |
| Orders      |           25,000 |
| Order Items |           50,000 |
| Payments    |           25,000 |
| Returns     |            2,500 |
| **Total**   |      **108,012** |

These are the generated dataset's expected row counts. The CSV files contain deliberately introduced data-quality anomalies for investigation and cleaning during the SQL phase.

### Data Quality Scenarios

The dataset is designed to support investigation of issues such as:

* Duplicate identifiers
* Missing or blank values
* Invalid foreign key references
* Invalid prices and quantities
* Data integrity violations across related tables

The raw CSV files are retained as source data so that cleaning decisions can be documented and the original records can be compared with the cleaned data.

## 🗄️ Database and SQL

**Database:** MySQL
**Database name:** `nova_retail_analytics`

The CSV files have been imported into MySQL staging tables. These tables preserve the raw values, including intentional anomalies, so they can be investigated before records are loaded into the final relational schema.

### Planned SQL Work

* Validate record counts.
* Identify duplicate primary key candidates.
* Investigate missing and invalid values.
* Check referential integrity between related tables.
* Document appropriate cleaning rules.
* Clean and validate the data using SQL.
* Load valid records into the final tables.
* Perform exploratory and business-focused SQL analysis.

The data-quality investigation is being developed incrementally, with an emphasis on understanding each issue and justifying the chosen cleaning approach.

## 🛠️ Technology Stack

| Technology   | Purpose                                                    |
| ------------ | ---------------------------------------------------------- |
| Python       | Synthetic data generation and analysis                     |
| NumPy        | Numerical operations                                       |
| Pandas       | Data manipulation and exploration                          |
| MySQL        | Relational database, data quality checks, and SQL analysis |
| Power BI     | Interactive dashboards and business intelligence           |
| Git & GitHub | Version control and project documentation                  |

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

* [x] Designed the retail dataset and its seven related tables.
* [x] Generated synthetic retail data using Python.
* [x] Created seven CSV files.
* [x] Created the `nova_retail_analytics` MySQL database.
* [x] Imported the CSV files into MySQL staging tables.
* [x] Verified the expected row counts across all seven staging tables.
* [x] Set up the GitHub repository and uploaded the raw dataset.

### 🔄 In Progress

* [ ] Complete SQL data-quality and integrity checks.
* [ ] Investigate and document detected anomalies.
* [ ] Define and apply appropriate data-cleaning rules.
* [ ] Load cleaned records into the final relational tables.
* [ ] Validate primary keys, foreign keys, and business rules.
* [ ] Perform SQL exploratory data analysis.
* [ ] Conduct Python analysis using Pandas and NumPy.

### ⏳ Planned

* [ ] Analyze sales and revenue performance.
* [ ] Investigate customer and product trends.
* [ ] Analyze payment and return patterns.
* [ ] Develop interactive Power BI dashboards.
* [ ] Document business findings and recommendations.
* [ ] Complete the project documentation.

## 🚧 Project Status

This project is currently in the **data quality and SQL validation stage**.

The raw dataset has been generated and imported into MySQL staging tables. The next phase focuses on investigating data-quality issues, developing defensible cleaning rules, and validating the cleaned dataset before proceeding to business analysis.

The repository will be updated as each stage is completed.

## 👩‍💻 Project Author

**Nandini Pandey**

This project is part of my ongoing development of practical skills in Data Analytics, SQL, Python, and Business Intelligence, with a focus on building reproducible, well-documented analytical workflows.
