# Amazon RDS SQL Server Setup Guide

## What is Amazon RDS?
Amazon RDS (Relational Database Service) is a managed database service.  
Instead of installing SQL Server on your computer, AWS creates and manages a SQL Server database for you in the cloud.

## Steps to Create RDS SQL Server Instance

### 1. Go to RDS
- AWS Console → search **RDS**
- Click **Aurora and RDS**
- Select **Create with full configuration and then Create Database**

### 2. Engine Options
- Engine type: **Microsoft SQL Server**
- Choose a database creation method: **Easy create**

### 3. Configuration
- **DB instance size**: Select **Free tier** (`db.t3.micro`)
- **DB instance identifier**: `retail-sql-db` (or any name you like)
- **Master username**: `admin`
- **Credentials management**: Select **Self managed**
- Uncheck **Auto generate password**
- Enter a strong **Master password** and confirm it  
  (Save this password carefully)

### 4. Connectivity (Important)
- Leave **Don’t connect to an EC2 compute resource** selected
- You can change Public Access later if needed

### 5. Create Database
- Click the orange **Create database** button
- Wait 5–10 minutes until the status becomes **Available**


## Important Notes
- Free tier is available for new AWS accounts
- Always stop the RDS instance when not in use (to avoid charges after free tier)
- Keep your Master password safe — you will need it to connect from SSMS
