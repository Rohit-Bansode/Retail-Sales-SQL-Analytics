
/*====================================================
	02_Data_Cleaning
	Purpose: Clean Data + Create 4 Normalized Tables
======================================================*/

Use RetailSalesAnalytics

/*-------------------------------------------------------
   1. BASIC DATA QUALITY CHECKS
-------------------------------------------------------*/

Select * from Superstore;

----------------- Check for Null values in column -------------------

select 
	SUM(CASE WHEN ORDER_ID IS NULL THEN 1 ELSE 0 END) AS Null_Order_ID,
	SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Null_Customer_Id,
	SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS Null_Product_Id,
	SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS Null_Order_Date,
	SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Null_Sales

from Superstore;

-------------------- Check Duplicates ROW ID -----------------------

Select Row_ID,count(*) As Duplicate_count
from Superstore
Group by Row_ID
having COUNT(*) > 1;

---------------Check how many unique Customer we should have. ------------------

Select Count(DISTINCT [Customer_ID]) As Unique_Customers from superstore;

----------------- Check Duplicate Customer_ID ----------------------------------

select Customer_ID,count(*) 
from Superstore
Group by Customer_ID
Having COUNT(*) > 1;

------------------- Check Date range --------------------------------

SELECT 
    MIN(Order_Date) AS First_Order,
    MAX(Order_Date) AS Last_Order
FROM superstore;

------------ Check Postal Code -- Bcoz It's some Postal Code Start with 0 (Example:01101) ------------------

Select * from Superstore where Postal_Code Like '0%';


/*-------------------------------------------------------
   2. DROP EXISTING TABLES (safe to re-run)
-------------------------------------------------------*/

IF OBJECT_ID('OrderDetails','U') IS NOT NULL DROP TABLE OrderDetails;
IF OBJECT_ID('Orders','U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Products','U') IS NOT NULL DROP TABLE Products;
IF OBJECT_ID('Customers','U') IS NOT NULL DROP TABLE Customers;


/*--------------------------------------------------------------------
3. Create NORMALISED TABLE (Order, OrderDetails, Product, Customer)
----------------------------------------------------------------------*/

------------- 3.1 Create Table of Customers -----------------

Create Table Customers(
	Customer_ID NVarchar(50) PRIMARY KEY,
	Customer_Name NVARCHAR(100),
	Segment NVARCHAR(50),
	Country NVARCHAR(50),
	City NVARCHAR(50),
	State NVARCHAR(50),
	Postal_Code Int,
	Region NVARCHAR(20),
);

------------------- 3.2 Create Table of Products --------------------

Create Table Products(
	Product_ID NVARCHAR(50) PRIMARY KEY,
	Product_Name NVARCHAR(255),
	Category NVARCHAR(50),
	Sub_Category NVARCHAR(50)	
);

--------------------- 3.3 Create Table of Orders --------------------

Create Table Orders(
	Order_ID NVARCHAR(50) PRIMARY KEY,
	Order_Date DATE,
	Ship_Date DATE,
	Ship_Mode NVARCHAR(50),
	Customer_ID NVARCHAR(50),
	CONSTRAINT FK_Orders_Customers FOREIGN KEY (Customer_ID)
	REFERENCES Customers(Customer_ID)
);

------------------- 3.4 Create Table of Orders Details ---------------------

Create Table OrderDetails(
	OrderDetails_ID INT IDENTITY(1,1) PRIMARY KEY,
	Order_ID NVARCHAR(50),
	Product_ID NVARCHAR(50),
	Sales DECIMAL(12,4),
	Quantity INT,
	Discount DECIMAL(5,2),
	Profit DECIMAL(12,4),

	CONSTRAINT Fk_OrderDetails_Orders FOREIGN KEY (Order_ID)
	REFERENCES Orders(Order_ID),

	CONSTRAINT Fk_OrderDetails_Products FOREIGN KEY (Product_ID)
	REFERENCES Products(Product_ID),
);


/*-----------------------------------------------------------------------------
4. Insert Data Into Normalized TABLE (Order, OrderDetails, Product, Customer)
------------------------------------------------------------------------------*/

----------------- 4.1 Insert Unique Customers -------------------

INSERT INTO Customers (Customer_ID, Customer_Name, Segment, Country, City, State, Postal_Code, Region)
SELECT 
    Customer_ID,
    Customer_Name,
    Segment,
    Country,
    City,
    State,
    Postal_Code,
    Region
FROM (
	SELECT
		Customer_ID,
		Customer_Name,
		Segment,
		Country,
		City,
		State,
		Postal_Code,
		Region,
		ROW_NUMBER() Over (Partition By Customer_ID Order by Order_Date Desc) As rn
FROM superstore
WHERE Customer_ID IS NOT NULL
) t 
Where rn=1;


----------------- 4.2 Insert Unique Products ---------------------

INSERT INTO Products (Product_ID, Product_Name, Category, Sub_Category)
	SELECT
	Product_ID,
	Product_Name,
	Category,
	Sub_Category
FROM (
	SELECT
		Product_ID,
		Product_Name,
		Category,
		Sub_Category,
ROW_NUMBER() OVER (PARTITION BY Product_ID ORDER BY Order_Date) As rn
	FROM superstore
WHERE Product_ID IS NOT NULL
)t
WHERE rn =1;


----------------- 4.3 Insert Unique Orders --------------------------

INSERT INTO Orders (Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID)
SELECT 
    Order_ID,
    Order_Date,
    Ship_Date,
    Ship_Mode,
    Customer_ID
FROM (
	SELECT
		Order_ID,
		Order_Date,
		Ship_Date,
		Ship_Mode,
		Customer_ID,
ROW_NUMBER() OVER (PARTITION BY Order_ID ORDER BY Order_Date DESC) As rn
FROM superstore
WHERE Order_ID IS NOT NULL
) t
WHERE rn = 1;


----------------- 4.4 Insert Order Details (all line items) ----------------------------

INSERT INTO OrderDetails (Order_ID, Product_ID, Sales, Quantity, Discount, Profit)
SELECT 
    Order_ID,
    Product_ID,
    Sales,
    Quantity,
    Discount,
    Profit
FROM superstore;


/*-------------------------------------------------------
   5. FINAL VERIFICATION
-------------------------------------------------------*/

SELECT 'Customers' As TableName, COUNT(*) As TotalRows FROM Customers
UNION ALL
SELECT 'Products',COUNT(*) FROM Products
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'OrderDetails', COUNT(*) FROM OrderDetails

/*---------------------------------------
		6. Sample Data Check 	
-----------------------------------------*/

SELECT TOP 5 * FROM Customers;

SELECT TOP 5 * FROM Products;

SELECT TOP 5 * FROM Orders;

SELECT TOP 5 * FROM OrderDetails;