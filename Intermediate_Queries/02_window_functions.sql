
/*=======================================================
   04_Intermediate_Queries / 02_window_functions.sql
   Practice: ROW_NUMBER, RANK, DENSE_RANK, LAG, LEAD, 
             SUM/AVG OVER, NTILE
=======================================================*/

USE RetailSalesAnalytics;

---------- 1. ROW_NUMBER - Rank Customers by Total Sales -------------

    SELECT 
        c.Customer_Name,
        c.Region,
        SUM(od.Sales) AS Total_Sales,
        ROW_NUMBER() OVER (Order by SUM(od.Sales) DESC) As Sales_
    FROM OrderDetails od
        INNER JOIN Orders o ON od.Order_ID = o.Order_ID
        INNER JOIN Customers c ON o.Customer_ID = c.Customer_ID
        GROUP BY c.Customer_Name, c.Region;


------------- 2. RANK Vs DENSE_RANK - TOP Products by Sales in each Category --------------

SELECT
    p.Product_Name,
    p.Category,
    SUM(od.Sales) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(od.Sales) DESC) AS Rank_In_Category,
    DENSE_RANK() OVER (PARTITION BY p.Category ORDER BY SUM(od.Sales) DESC) AS Dense_Rank_In_Category
FROM OrderDetails od
      INNER JOIN Products p ON od.Product_ID = p.Product_ID
GROUP BY p.Product_Name, p.Category;


----------------- 3. Running Total of Sales by Month ---------------------------

WITH MonthlySales As (
    SELECT
        YEAR(o.order_date) AS Order_Year,
        MONTH(o.order_date) AS Order_Month,
        SUM(od.Sales) AS Monthly_Sales
    FROM OrderDetails od 
    INNER JOIN Orders o ON od.Order_ID = o.Order_ID
    GROUP BY YEAR(o.Order_Date),MONTH(o.Order_Date)
)
SELECT
    Order_Year,
    Order_Month,
    Monthly_Sales,
    SUM(Monthly_Sales) OVER (Order By Order_Year,Order_Month) As Running_Total
FROM MonthlySales
ORDER BY Order_Year,Order_Month;

------------------------- 4. LAG & LEAD - Month Over Month Growth --------------------

WITH MonthlySales As (
    SELECT
        YEAR(o.order_date) AS Order_Year,
        MONTH(o.order_date) AS Order_Month,
        SUM(od.Sales) AS Monthly_Sales
    FROM OrderDetails od 
    INNER JOIN Orders o ON od.Order_ID = o.Order_ID
    GROUP BY YEAR(o.Order_Date),MONTH(o.Order_Date)
)
SELECT
    Order_Year,
    Order_Month,
    Monthly_Sales,
    LAG(Monthly_Sales) OVER (Order BY Order_Year,Order_Month) As Previous_Monthly_Sales,
    Monthly_Sales - LAG(Monthly_Sales) OVER (ORDER BY Order_Year,Order_Month) As MoM_Changes 
FROM MonthlySales
ORDER BY Order_Year,Order_Month;


-------------------- 5. NTILE - Customer Segmentation (4 Groups) --------------------------

 WITH CustomerSales AS(
 SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Region,
    SUM(od.Sales) AS Total_Sales
FROM Orderdetails od
    INNER JOIN Orders o ON od.Order_ID = o.Order_ID
    INNER JOIN Customers c ON o.Customer_ID = c.Customer_ID
    GROUP BY c.Customer_ID, c.Customer_Name, c.Region
)
SELECT
    Customer_Name,
    Region,
    Total_Sales,
    NTILE(4) OVER (ORDER BY Total_Sales DESC) As Customer_Segment
FROM CustomerSales
ORDER BY Total_Sales DESC;


--------------- 6. Average Sales by Region Using Window Function -------------------

SELECT
    c.Customer_Name,
    c.Region,
    SUM(od.Sales) AS Customer_Sales,
    AVG(SUM(od.Sales)) OVER (PARTITION BY c.Region) AS Avg_Sales_by_Region
FROM OrderDetails od
INNER JOIN Orders o ON od.Order_ID = o.Order_ID
INNER JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name,c.Region;
