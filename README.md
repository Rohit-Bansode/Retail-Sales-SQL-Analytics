# Project : Retail-Sales-SQL-Analytics
<br>

## Project Goal: 
This Project Analyse Superstore dataset and Peforms Some Sql Query Like Data Cleaning, Basic Sql Query, Joins, Aggregatation & Window Function that get Business Insight from That Dataset.

<!--Dataset -->
## Dataset: 
- **Source**: [Kaggle Superstore Dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)
- **File Used**: `Sample - Superstore.csv`
- **Contain**: It Contain Retail Sales Information about Cutomers, Product, Order & Order Details, etc in One Single Csv file.

<!-- Project Structure --->

## Project Structure :

```
Retail-Sales-SQL-Analytics/
│
├── README.md
├── data/
│   └── superstore.csv                    (or note: stored in S3)
│
├── 01_Local_Setup/
│   ├── 01_create_database.sql
│   ├── 02_create_tables.sql
│   └── 03_import_data.sql
│
├── 02_Data_Cleaning/
│   └── cleaning.sql
│
├── 03_Beginner_Queries/
│   ├── 01_basic_selects.sql
│   ├── 02_joins.sql
│   └── 03_aggregations.sql
│
├── 04_Intermediate_Queries/
│   ├── 01_ctes.sql
│   ├── 02_window_functions.sql
│   └── 03_business_questions.sql
│
├── 05_AWS_Cloud/
│   ├── s3_upload_guide.md
│   ├── rds_setup_guide.md
│   └── connect_ssms_to_rds.md
│
└── Insights/
    └── key_findings.md
```
