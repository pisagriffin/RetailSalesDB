
--AUTHOR: Palmer King
--This is documentation for the creation of the retailSalesDB

-- Connect to the 'retailSalesDB' database before creating tables
-- Example in psql: \c retailSalesDB

------------------------------------------------------------------


--Creating basic database for retail sales CSV
CREATE DATABASE retailSalesDB;

/*
Creating schema: Customer(CustomerID, Gender, Age)
Primary Key: CustomerID

Stores demographic information for each customer

Note: customerID in the csv is stored as: CUST001, so VARCHAR(10) is used
*/
CREATE TABLE Customer(
    CustomerID VARCHAR(10) PRIMARY KEY,
    Gender varchar(10),
    Age INT CHECK (age>=0)
);

/*
Creating schema: Product(Category, PricePerUnit)
Natural Key: Category, PricePerUnit

Stores product categories and prices

Note: Each product in a category is assumed to have a unique price per unit
*/
CREATE TABLE Product(
    Category varchar(50) NOT NULL,
    PricePerUnit DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (Category, PricePerUnit) 
);


/*
Creating schema: Transaction(TransactionID, CustomerID, Date)
Primary Key: TransactionID

Represents customer transactions
*/
CREATE TABLE Transaction(
    TransactionID INT PRIMARY KEY,
    CustomerID VARCHAR(10) NOT NULL, 
    TransDate DATE NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);

/*
Creating schema: TransactionDetails(TransactionID, Category, PricePerUnit, Quantity, TotalAmt)
Primary Key: TransactionID
Foreign Keys:
    TransactionID references Transaction(TransactionID)
    Category, PricePerUnit references Product(Category, PricePerUnit)

Stores information on each transaction
*/
CREATE TABLE TransactionDetails(
    TransactionID INT NOT NULL PRIMARY KEY,
    Category varchar(50) NOT NULL,
    PricePerUnit DECIMAL (10, 2) NOT NULL,
    Quantity INT NOT NULL CHECK(Quantity > 0),
    TotalAmt DECIMAL(10, 2) NOT NULL CHECK(TotalAmt > 0),
    FOREIGN KEY (TransactionID) REFERENCES Transaction(TransactionID) ON DELETE CASCADE,
    FOREIGN KEY (Category, PricePerUnit) REFERENCES Product(Category, PricePerUnit)
);


