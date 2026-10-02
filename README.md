# nova-retail-data-analytics
End-to-end data analytics project for Nova Retail Group, covering data integrity checks, SQL analysis, Python-based exploration, and Power BI dashboards to uncover retail business insights.

# Nova Retail Data Analytics

> 🚧 **Project Status: In Progress**


## 📌 Project Overview

**Nova Retail Data Analytics** is an end-to-end retail analytics project built from scratch to simulate a real-world business data environment.

The goal is to take a retail business dataset through the complete analytics workflow:

**Data Generation → Data Integrity & SQL → Python Analysis → Power BI → Business Insights**

Rather than starting with an existing dataset, the database and synthetic retail data were **created from scratch using Python** to simulate a realistic retail business environment.

The project covers customers, products, orders, order items, payments, returns, and cities.

---

## 🎯 Project Vision

The objective of this project is to build a complete analytics workflow similar to one used in a real business environment.

The project aims to:

* Build a structured retail database from scratch
* Perform data integrity and quality checks
* Use SQL to explore and analyze business data
* Use Python, NumPy, and Pandas for deeper analysis
* Identify patterns in customers, products, sales, payments, and returns
* Build interactive Power BI dashboards
* Convert data findings into meaningful business insights
* Document the complete analytics process from raw data to business decision-making

---

## 🗂️ Current Project Structure


nova-retail-data-analytics/
│
├── README.md
├── .gitignore
│
├── database_generation/
│   └── generate_tables.py
│
└── tables/
    ├── cities.csv
    ├── customers.csv
    ├── products.csv
    ├── orders.csv
    ├── order_items.csv
    ├── payments.csv
    └── returns.csv

The repository structure will expand as the project moves into the SQL, Python, and Power BI stages.

---

## 🐍 Database Generation

The Nova Retail database was **created from scratch using Python**.

Python was used to generate the synthetic retail data and create the CSV files representing the database tables.

The generated dataset contains:

* **Cities**
* **Customers**
* **Products**
* **Orders**
* **Order Items**
* **Payments**
* **Returns**

The generated CSV files are stored in the `tables/` directory, while the Python generation script is stored in `database_generation/`.

This approach allows the project to simulate a complete business dataset instead of relying on a pre-existing dataset.

---

## 🛠️ Technology Stack

### Current / Planned

* **Python** — Data generation and analysis
* **NumPy** — Numerical analysis
* **Pandas** — Data manipulation and exploration
* **MySQL** — Database management and SQL analysis
* **Power BI** — Data visualization and business intelligence
* **Git & GitHub** — Version control and project documentation

---

## 🔄 Project Workflow


Python
   ↓
Synthetic Retail Data Generation
   ↓
CSV Tables
   ↓
MySQL Database
   ↓
Data Integrity Checks
   ↓
SQL Analysis
   ↓
Python / NumPy / Pandas Analysis
   ↓
Power BI Dashboard
   ↓
Business Insights
```

---

## 📊 Current Progress

### ✅ Completed

* [x] Designed the retail database structure
* [x] Created the synthetic retail dataset from scratch using Python
* [x] Generated the database tables as CSV files
* [x] Created the MySQL database
* [x] Imported the CSV tables into MySQL
* [x] Established the initial project repository
* [x] Began data integrity validation using MySQL

### 🔄 In Progress

* [ ] Complete data integrity and quality checks
* [ ] Perform SQL-based exploratory analysis
* [ ] Analyze relationships between tables
* [ ] Move the dataset into Python for deeper analysis
* [ ] Perform NumPy/Pandas analysis
* [ ] Identify key business insights
* [ ] Build Power BI dashboards
* [ ] Document final findings and recommendations

### ⏳ Planned

* [ ] Complete end-to-end analysis
* [ ] Build final Power BI dashboard
* [ ] Add visualizations and dashboard screenshots
* [ ] Document major business insights
* [ ] Finalize project documentation

---

## 🚧 Project Status

**This project is not complete yet.**

It is being developed step-by-step as an end-to-end analytics project. The repository will be updated as new stages of the analysis are completed.

The current repository represents the **early development stage**, including the Python-generated database and the beginning of the MySQL data validation process.

---

## 👩‍💻 Project Author

**Nandini Pandey**

This project is being developed as part of my journey toward building practical skills in **Data Analytics, Business Intelligence, SQL, Python, and Data Visualization**.
