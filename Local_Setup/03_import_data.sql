
---------03_Import_data--------------------


-- Import Superstore.CSV using Import Flat File

	--- Step1 - Right-click database -> Tasks -> Import Flat File
	---	Step 2 - Select Superstore.csv
	--- Step 3 - Map Columns Carefully.

--- Check it's Import ---

Use RetailSalesAnalytics

SELECT * FROM superstore;

-- Give Informartion of Table Column

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS;

--Check Total Rows

SELECT COUNT(*) As TOTAL_ROWS FROM Superstore;

-- Check First 10 Rows

SELECT TOP 10 * FROM Superstore;

-- Check Column Data Types

SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'superstore';


