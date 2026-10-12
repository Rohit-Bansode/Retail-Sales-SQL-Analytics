
---------03_Import_data--------------------


-- Import Superstore.CSV using Import Flat File

	--- Step1 - Right-click database -> Tasks -> Import Flat File
	---	Step 2 - Select Superstore.csv
	--- Step 3 - Map Columns Carefully.

--- Check it's Import ---

Use RetailSalesAnalytics

SELECT * FROM superstore;

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS;
