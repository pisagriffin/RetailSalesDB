--AUTHOR: Palmer King
--This is documentation for the insertion of data from the retail_sales_dataset into the retailsalesdb

------------------------------------------------------------------

--NOTE: These commands were run from the terminal, not vscode

--creating temp table 
CREATE TEMP TABLE stagingSales(
    TransactionID INT,
    TransDate DATE,
    CustomerID VARCHAR(10),
    Gender VARCHAR(10),
    Age INT,
    Category VARCHAR(50),
    Quantity INT,
    PricePerUnit DECIMAL(10,2),
    TotalAmt DECIMAL(10,2)
);

--loading CSV file into stagingSales
\copy stagingSales(TransactionID, TransDate, CustomerID, Gender, Age, Category, Quantity, PricePerUnit, TotalAmt) FROM '/Users/palmerking/Desktop/RetailSalesDB/retail_sales_dataset.csv' DELIMITER ',' CSV HEADER;

--simple check to ensure it was a success
SELECT * FROM stagingSales LIMIT 5;

--populate Customer
INSERT INTO Customer(CustomerID, Gender, Age)
SELECT DISTINCT CustomerID, Gender, Age
FROM stagingSales
ON CONFLICT (CustomerID) DO NOTHING;

--populate Product
INSERT INTO Product(Category, PricePerUnit)
SELECT DISTINCT Category, PricePerUnit
FROM stagingSales
ON CONFLICT (Category, PricePerUnit) DO NOTHING;

--populate Transaction
INSERT INTO Transaction(TransactionID, CustomerID, TransDate)
SELECT DISTINCT TransactionID, CustomerID, TransDate
FROM stagingSales
ON CONFLICT (TransactionID) DO NOTHING;

--populate TransactionDetails
INSERT INTO TransactionDetails(TransactionID, Category, PricePerUnit, Quantity, TotalAmt)
SELECT TransactionID, Category, PricePerUnit, Quantity, TotalAmt
FROM stagingSales;

--Verify
SELECT COUNT(*) FROM Customer;
SELECT COUNT(*) FROM Product;
SELECT COUNT(*) FROM Transaction;
SELECT COUNT(*) FROM TransactionDetails;

SELECT * FROM Customer LIMIT 5;
SELECT * FROM TransactionDetails LIMIT 5;
SELECT * FROM Transaction LIMIT 5;
SELECT * FROM Product LIMIT 5;



