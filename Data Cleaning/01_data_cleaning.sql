
/*=================================
	02.Data Cleaning
===================================*/

Use RetailSalesAnalytics

Select * from Superstore;

-- Check for Null values in column

select 
	SUM(CASE WHEN ORDER_ID IS NULL THEN 1 ELSE 0 END) AS Null_Order_ID,
	SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Null_Customer_Id,
	SUM(CASE WHEN Product_ID IS NULL THEN 1 ELSE 0 END) AS Null_Product_Id,
	SUM(CASE WHEN Order_Date IS NULL THEN 1 ELSE 0 END) AS Null_Order_Date,
	SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Null_Sales

from Superstore;

-- Check Duplicates ROW ID

Select Row_ID,count(*) As Duplicate_count
from Superstore
Group by Row_ID
having COUNT(*) > 1;

-- Check data range

SELECT 
    MIN(Order_Date) AS First_Order,
    MAX(Order_Date) AS Last_Order
FROM superstore;

-- Check Postal Code -- Bcoz It's some Postal Code Start with 0 (Example:01101) 

Select * from Superstore where Postal_Code Like '0%';

/*--------------------------------------------

2. Create NORMALISED TABLE (Order, OrderDetails, Product, Customer)

---------------------------------------------*/

select * from superstore;

-- 2.1 Create Table of Customers

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

-- 2.2 Create Table of Products

Create Table Products(
	Product_ID NVARCHAR(50) PRIMARY KEY,
	Product_Name NVARCHAR(255),
	Category NVARCHAR(50),
	Sub_Category NVARCHAR(50)	
);

-- 2.3 Create Table of Orders

Create Table Orders(
	Order_ID NVARCHAR(50) PRIMARY KEY,
	Order_Date DATE,
	Ship_Date DATE,
	Ship_Mode NVARCHAR(50),
	Customer_ID NVARCHAR(50),
	CONSTRAINT FK_Orders_Customers FOREIGN KEY (Customer_ID)
	REFERENCES Customers(Customer_ID)
);

-- 2.4 Create Table of Orders Details

Create Table OrderDetails(
	OrderDetails_ID INT IDENTITY(1,1) PRIMARY KEY,
	Order_ID NVARCHAR(50),
	Product_ID NVARCHAR(50),
	Sales DECIMAL(10,2),
	Quantity INT,
	Discount DECIMAL(5,2),
	Profit DECIMAL(10,2),

	CONSTRAINT Fk_OrderDetails_Orders FOREIGN KEY (Order_ID)
	REFERENCES Orders(Order_ID),

	CONSTRAINT Fk_OrderDetails_Products FOREIGN KEY (Product_ID)
	REFERENCES Products(Product_ID),
);

/*--------------------------------------------

3. Insert Data Into Normalized TABLE (Order, OrderDetails, Product, Customer)

---------------------------------------------*/

-- 3.1 Insert Unique Customers
INSERT INTO Customers (Customer_ID, Customer_Name, Segment, Country, City, State, Postal_Code, Region)
SELECT DISTINCT
    Customer_ID,
    Customer_Name,
    Segment,
    Country,
    City,
    State,
    Postal_Code,
    Region
FROM superstore
WHERE Customer_ID IS NOT NULL;


-- 3.2 Insert Unique Products
INSERT INTO Products (Product_ID, Product_Name, Category, Sub_Category)
SELECT DISTINCT
    Product_ID,
    Product_Name,
    Category,
    Sub_Category
FROM superstore
WHERE Product_ID IS NOT NULL;


-- 3.3 Insert Unique Orders
INSERT INTO Orders (Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID)
SELECT DISTINCT
    Order_ID,
    Order_Date,
    Ship_Date,
    Ship_Mode,
    Customer_ID
FROM superstore
WHERE Order_ID IS NOT NULL;


-- 3.4 Insert Order Details (all line items)
INSERT INTO OrderDetails (Order_ID, Product_ID, Sales, Quantity, Discount, Profit)
SELECT 
    Order_ID,
    Product_ID,
    Sales,
    Quantity,
    Discount,
    Profit
FROM superstore;

 

 select * from Customers