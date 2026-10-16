# Amazon S3 Upload Guide

This guide explains how the Superstore dataset was uploaded to Amazon S3 for this project.

## Steps to Upload Dataset in AWS S3 Bucket

### 1. Create an S3 Bucket
1. Login to AWS Console → search **S3**
2. Click **Create bucket**
3. Bucket name: `retail-sql-analytics-rohit` (must be unique)
4. Region: US East (N. Virginia) - `us-east-1`
5. Keep other settings as default
6. Click **Create bucket**

### 2. Upload the Dataset
1. Open the bucket we just created
2. Click **Upload**
3. Add the file `superstore.csv` (or Superstore.xlsx)
4. Click **Upload**

### 3. File path

My dataset is stored at : `s3://retail-sql-analytics-rohit/Superstore.csv`
