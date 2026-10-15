
/*=======================================================
   04_Intermediate_Queries / 03_business_questions.sql
   Real Business Questions using Intermediate SQL
=======================================================*/

USE RetailSalesAnalytics;


------------1. Overall Business Performance ------------

SELECT 
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    COUNT(*) AS Total_Order_Lines,
    ROUND(SUM(od.Sales), 2) AS Total_Sales,
    ROUND(SUM(od.Profit), 2) AS Total_Profit,
    ROUND(SUM(od.Profit) * 100.0 / NULLIF(SUM(od.Sales), 0), 2) AS Profit_Margin_Percentage
FROM OrderDetails od
INNER JOIN Orders o ON od.Order_ID = o.Order_ID;


----------- 2. Top 5 Customer Region By Sales -----------

WITH RankedCustomers As(
	SELECT
		c.Customer_Name,
		c.Region,
		SUM(od.Sales) AS Total_Sales,
		ROW_NUMBER() OVER (PARTITION BY c.Region ORDER BY SUM(od.Sales) DESC ) AS rn
	FROM OrderDetails od
	INNER JOIN Orders o ON od.Order_ID = o.Order_ID
	INNER JOIN Customers c ON o.Customer_ID = c.Customer_ID
	GROUP BY c.Customer_Name,c.Region
)
SELECT * FROM RankedCustomers
WHERE rn <=5
ORDER BY Region,Total_Sales DESC;

------------ 2. Best Performing Sub-Category in each category -----------------

WITH SubCategorySales As(
	SELECT
		p.Category,
		p.Sub_Category,
		SUM(od.Sales) AS Total_Sales,
		Rank() OVER (PARTITION BY p.Category ORDER BY SUM(od.Sales) DESC ) AS Rank_In_Category
	FROM OrderDetails od
	INNER JOIN Products p ON od.Product_ID = p.Product_ID
	GROUP BY p.Category,p.Sub_Category
)
SELECT * FROM SubCategorySales
WHERE Rank_In_Category = 1;

--------------- 3. Month-over-Month Sales Growth % -----------------------

WITH MonthlySales AS (
	SELECT
		YEAR(o.order_date) AS Order_Year,
		MONTH(o.Order_Date) AS Order_Month,
		SUM(od.Sales) AS Monthly_Sales
	FROM OrderDetails od 
	INNER JOIN Orders o ON od.Order_ID = o.Order_ID
	GROUP BY YEAR(o.Order_Date),MONTH(o.Order_Date)
)
SELECT
	Order_Year,
	Order_Month,
	Monthly_Sales,
	LAG(Monthly_Sales) Over (ORDER BY Order_Year,Order_Month ) AS Prev_Month,
	ROUND(
		(Monthly_Sales - LAG(Monthly_Sales) Over (ORDER BY Order_Year,Order_Month))
		* 100.0 / NULLIF (LAG(Monthly_Sales) Over (ORDER BY Order_Year,Order_Month),0)
		,2) AS Growth_Percentage
FROM MonthlySales
Order By Order_Year,Order_Month;

-------------- 4. Customers who have not ordered in the last 1 year --------------
-- (Assuming latest date in data is around 2017)

SELECT
	c.Customer_ID,
	c.Customer_Name,
	c.Region,
	MAX(o.Order_Date) AS Last_Order_Date
FROM Orders o
INNER JOIN Customers c ON o.Customer_ID = c.Customer_ID
Group By c.Customer_ID,c.Customer_Name,c.Region
HAVING MAX(o.Order_Date) < '2017-01-01' OR MAX(o.Order_Date) IS NULL
ORDER BY Last_Order_Date


------------------ 5. Profitability by Segment and Category -------------------

SELECT
	c.segment,
	p.category,
	SUM(od.sales) AS Total_Sales,
	SUM(od.Profit) AS Total_Profit,
	ROUND (SUM(od.Profit) * 100.0 / NULLIF(SUM(od.sales),0),2) AS Profit_Margin_Percentage
FROM orderdetails od
	INNER JOIN orders o ON od.Order_Id = o.Order_ID
	INNER JOIN Customers c ON o.Customer_id = c.Customer_id
	INNER JOIN Products p ON od.Product_Id = p.Product_Id
GROUP BY c.segment,p.category
ORDER BY c.segment, Total_Profit DESC;
	

----------------- 6. Running total of profit by year ------------------------

SELECT
	YEAR(o.Order_Date) AS Order_Year,
	SUM(od.Profit) AS Total_Profit,
	SUM(SUM(od.Profit)) OVER (ORDER BY YEAR(o.Order_Date)) AS Running_Profit
FROM OrderDetails od
INNER JOIN orders o ON od.Order_Id = o.Order_Id
GROUP BY YEAR(o.Order_Date)
ORDER BY Order_Year;

