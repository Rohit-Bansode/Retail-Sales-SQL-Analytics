
/*=======================================================
   04_Intermediate_Queries / 01_ctes.sql
   Practice: Common Table Expressions (CTEs)
=======================================================*/

USE RetailSalesAnalytics;

----------- 1. Simple CTE - TOP Customers by Sales ------------

WITH CustomerSales AS (
	SELECT
		c.Customer_ID,
		c.Customer_Name,
		c.City,
		SUM(od.Sales) AS Total_Sales_by_Customer
	FROM OrderDetails od
	INNER JOIN  Orders o  ON o.Order_ID = od.Order_ID
	INNER JOIN  Customers c ON o.Customer_ID = c.Customer_ID
	
	Group BY c.Customer_ID,c.Customer_Name,c.City
)
	SELECT TOP 10 *
	FROM CustomerSales
Order BY Total_Sales_by_Customer DESC;


------------- 2. Multiple CTEs - Sales by Category and Region -------------

WITH CategorySales AS (
	SELECT
		p.Category,
		SUM(od.Sales) AS Total_Sales_By_Category
	FROM OrderDetails od 
		INNER JOIN Products p ON p.Product_ID = od.Product_ID
	GROUP BY p.Category
),
RegionSales AS(
	SELECT 
		c.Region,
		SUM(od.Sales) AS Total_Sales_By_Region
	FROM OrderDetails od
		INNER JOIN orders o ON od.Order_ID = o.Order_ID
		INNER JOIN Customers c ON o.Customer_ID = c.Customer_ID
	GROUP BY c.Region
)
SELECT * FROM CategorySales
UNION ALL
SELECT * FROM RegionSales;


---------------- 3. CTE For Monthly Sales ------------------
 
WITH MonthlySales As (
	SELECT
		YEAR(o.Order_Date) AS Order_Year,
		MONTH(o.Order_Date) AS Order_Month,
		SUM(od.Sales) AS Total_Sales,
		SUM(od.Profit) AS Total_Profit

	FROM OrderDetails od 
		INNER JOIN Orders o ON o.Order_ID = od.Order_ID
	Group BY YEAR(o.Order_Date),MONTH(o.Order_Date)
)
SELECT * FROM MonthlySales
ORDER BY Order_Year,Order_Month DESC;

-------------- 4. CTE + Filtering high Value Customers ---------------

WITH HightValueCustomers AS(
	SELECT
		c.Customer_ID,
		c.Customer_Name,
		SUM(od.sales) AS Total_Sales
	FROM OrderDetails od
		INNER JOIN Orders o ON od.Order_ID = o.Order_ID
		INNER JOIN Customers c ON o.Customer_ID = c.Customer_ID
	GROUP BY c.Customer_ID, c.Customer_Name
	HAVING SUM(od.Sales) > 5000
)
SELECT * FROm HightValueCustomers
Order By Total_Sales DESC;

