

/*=======================================================
   03_Beginner_Queries / 02_joins.sql
   Practice: INNER JOIN, LEFT JOIN, Multi-table JOINs
=======================================================*/

Use RetailSalesAnalytics;

-------- 1. Simple Inner JOIN - Orders with Customer Name ------------

SELECT 
o.Order_ID,
o.Order_Date,
c.Customer_Name,
c.Segment,
c.Region
from Orders o 
INNER JOIN
Customers c ON 
o.Customer_ID = c.Customer_ID;


--------- 2. Order Details with Product Name ----------------------

SELECT
	od.Order_ID,
	p.Product_Name,
	p.Category,
	od.Quantity,
	od.Sales,
	od.Profit
From OrderDetails od
INNER JOIN
Products p ON
od.Product_ID = p.Product_ID;

----------- 3. Full Order Information (3 Tables) --------------------

Select 
	o.Order_ID,
	o.Order_Date,
	c.Customer_Name,
	c.City,
	c.Region,
	p.Product_Name,
	p.Category,
	od.Quantity,
	od.Sales,
	od.Profit
From
	Orderdetails od
	INNER JOIN orders o ON od.order_id = o.order_id
	INNER JOIN customers c ON o.customer_id = c.customer_id
	INNER JOIN products p ON od.product_id = p.product_id;

------------- 4. LEFT JOIN Example - Customers who may have orders ------------- 

SELECT
	c.Customer_ID,
	c.Customer_Name,
	c.City,
	c.Region,
	o.Order_ID,
	o.Order_Date
FROM
	Customers c LEFT JOIN Orders o
ON c.customer_id = o.customer_id
Order by c.Customer_Name;

------------- 5. Find Customer who never placed an order ----------------------

SELECT
	c.customer_ID,
	c.customer_Name,
	c.Region
From 
	Customers c LEFT JOIN orders o
ON c.customer_id = o.customer_id
Where o.order_id IS NULL;

