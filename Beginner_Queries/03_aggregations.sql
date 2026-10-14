
/*=======================================================
   03_Beginner_Queries / 03_aggregations.sql
   Practice: GROUP BY, HAVING, COUNT, SUM, AVG, MIN, MAX
=======================================================*/

USE RetailSalesAnalytics;

------------- 1. Total Sales and Profit -------------

SELECT 
	SUM(Sales) AS Total_Sales,
	SUM(Profit) AS Total_Profit,
	COUNT (*) AS Total_Orders_Lines
FROM OrderDetails;

-------------- 2. Sales by Category ------------------

SELECT
	p.Category,
	SUM(od.Sales) AS Total_Sales_by_Category,
	SUM(od.Profit) AS Total_Profit_by_Category,
	COUNT (*) AS Total_Orders_Lines
FROM
	orderdetails od INNER JOIN Products p
ON
	od.product_id = p.product_id

GROUP BY p.category
Order BY Total_Sales_by_Category DESC;

--------------- 3. Sales by Region --------------------

SELECT
	c.Region,
	SUM(od.Sales) AS Total_Sales_by_Region,
	SUM(od.Profit) AS Total_Profit_by_Region,
	Count(*) As Total_Order_Lines
FROM
	Orderdetails od
INNER JOIN orders o ON od.Order_ID = o.order_ID
INNER JOIN Customers c ON o.customer_id = c.customer_id

Group By c.Region
Order By Total_Sales_by_Region DESC;

------------- 4. Top 10 Customers by sales -------------

SELECT TOP 10
	c.Customer_Name,
	c.Region,
	SUM(od.Sales) AS Total_Sales,
	SUM(od.Profit) AS Total_Profit
FROM
	Orderdetails od
INNER JOIN orders o ON od.Order_ID = o.order_ID
INNER JOIN Customers c ON o.customer_id = c.customer_id

Group By c.Customer_Name,c.Region
Order By Total_Sales DESC;

--------------- 5. Average Order value by segment ----------------

SELECT 
	c.segment,
	COUNT(DISTINCT o.Order_ID) AS Total_Orders,
	SUM(od.Sales) AS Total_Sales,
	AVG(od.Sales) AS Avg_Sales
FROM
	Orderdetails od
INNER JOIN orders o ON od.Order_ID = o.order_ID
INNER JOIN Customers c ON o.customer_id = c.customer_id

Group By c.segment
Order By Total_Sales,Avg_Sales DESC;

----------- 6. Categories with profit less than 10000 (Having) ----------
	
SELECT 
	p.Category,
	SUM(od.profit) AS Total_Profit
FROM
	Orderdetails od
INNER JOIN products p ON od.Product_ID = p.Product_ID

Group By p.category
HAVING SUM(od.Profit) < 20000
Order By Total_Profit DESC;

