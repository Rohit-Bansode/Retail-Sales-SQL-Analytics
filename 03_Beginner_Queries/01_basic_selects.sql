

/*=======================================================
   03_Beginner_Queries / 01_basic_selects.sql
   Practice: SELECT, WHERE, ORDER BY, TOP, DISTINCT
=======================================================*/

Use RetailSalesAnalytics;

-------------- 1. View All customers ------------------

SELECT * FROM Customers;


-------------- 2. View Only Specific Column -----------

Select Customer_ID,Customer_Name,City,State,Region FROM Customers;


-------------- 3. Filters Customers from a specific region ------

SELECT Customer_Name,City,State,Region FROM Customers 
Where Region = 'EAST';

--------------- 4. Customers from California ---------------------

SELECT Customer_Name,City,State FROM Customers 
Where State = 'California';

---------------- 5. Top 10 Customers by name ---------------------

Select TOP 10 Customer_ID,Customer_Name,Segment,City,Region from Customers
Order BY Customer_Name;

---------------- 6. Distinct Segments ----------------------------

Select Distinct (Segment) As Unique_Segment from Customers;

---------------- 7. Distinct Categories --------------------------

Select DISTINCT Category As Unique_Category
FROM Products
Order BY Unique_Category;

---------------- 8. Products in Furniture Category ---------------

Select * from Products 
WHERE category = 'Furniture';

