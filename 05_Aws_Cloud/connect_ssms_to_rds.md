# Connect SSMS to Amazon RDS

## Steps

### 1. Get the Endpoint
1. Go to AWS Console → RDS
2. Click on your database (`retail-sql-db`)
3. Copy the **Endpoint**  
   Example: `retail-sql-db.xxxxxxxxxxxx.ap-south-1.rds.amazonaws.com`

### 2. Open SSMS
1. Open SQL Server Management Studio
2. Click **Connect** → Database Engine

### 3. Connection Details
- Server name: Paste the **Endpoint**
- Authentication: **SQL Server Authentication**
- Login: `admin`
- Password: The password we created while setting up RDS

### 4. Trust Server Certificate
- Click **Options** >>
- Go to **Connection Properties**
- Check **Trust server certificate**

### 5. Connect
- Click **Connect**

## After Connecting
You can now:
- Create the same database and tables
- Import data (or use the data already prepared locally)
- Run all your SQL queries on the cloud database

## Security Tip
- After finishing practice, you can stop the RDS instance from the AWS Console to avoid unnecessary charges.
