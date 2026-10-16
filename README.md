# Project : Retail-Sales-SQL-Analytics
<br>

## Project Goal: 
This project analyzes retail sales data using **Microsoft SQL Server**.  

It demonstrates practical use of JOINs, CTEs, Window Functions, and advanced SQL techniques to answer real business questions.    

The dataset used is the classic **Sample Superstore** dataset.

<!--Dataset -->
## Dataset: 
- **Source**: [Kaggle Superstore Dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)
- **File Used**: `Sample - Superstore.csv`
- **Description**: Contains Retail Sales Information about Customers, Products, Orders & Order Details, etc in a Single                       Csv file.

<!-- Skills Demonstrated -->

## Skills Demonstrated
- Database Design & Normalization
- JOINs (INNER, LEFT, Multi-table)
- Common Table Expressions (CTEs)
- Window Functions (ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD, SUM/AVG OVER, NTILE)
- Aggregations & Business Analysis
- Data Cleaning
- Cloud readiness (AWS S3 + RDS)

<!-- Tech Stack -->

## Tech Stack
- Microsoft SQL Server (SSMS 2022)
- T-SQL
- AWS S3 (for dataset storage)
- AWS RDS (optional cloud database)

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
    ├── key_findings.md
    └── Images/                  
        ├── 01_overall_performance.png
        ├── 02_sales_by_region.png
        ├── 03_sales_by_category.png
        ├── 04_best_subcategory.png
        ├── 05_top_customers.png
        ├── 06_customer_segments.png
        ├── 07_churn_customers.png
        ├── 08_monthly_sales.png
        └── 09_mom_growth.png

    
```

 <!-- Database Schema -->
 
## Database Schema (Normalized)
- Customers    → Stores Customers Information
- Products     → Stores Product details
- Orders       → Stores Order Summary (one row per order)
- OrderDetails → Stores individual products sold in each order

<!-- How to Set Up Locally -->

## How to Set Up Locally
1. Create the database using `01_Local_Setup` scripts.
2. Import the Superstore CSV using **Import Flat File**.
3. Run `02_Data_Cleaning/cleaning.sql` to normalize the data.
4. Practice queries from Beginner and Intermediate folders.


<!-- Key Business Questions Answered -->

## Key Business Questions Answered
- Top customers by region
- Best performing products and categories
- Month-over-Month sales growth
- Customer segmentation
- Profitability analysis by Segment and Category
- Customers at risk of churn

<!-- Author Details -->

## Author :

**Rohit Bansode**

<u>Aspiring Data Analyst</u>

- Github : https://github.com/Rohit-Bansode
- Linkedin : https://www.linkedin.com/in/rohit-bansode-0861b8276
- Email : rohitbansode924@gmail.com

