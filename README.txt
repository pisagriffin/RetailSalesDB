PROJECT AUTHOR: Palmer King
-----------------------------------------------

This project aims to establish a database for a retail sales dataset containing
additional user demographic data. 
The dataset used contains 1000 entries.

The csv consists of the following columns:
Transaction ID
Date
Customer ID
Gender
Age
Product Category
Quantity
Price per Unit
Total Amount
-----------------------------------------------

Folder Navigation/Structure:

RetailSalesDB/
    backups/                        #backup files
            retailSalesDB_backup
            retailSalesDB_backup.sql
    README.txt
    retail_sales_dataset.csv
    sql/                            #all sql files
            dbCreation.sql
            dbIndexing.sql
            dbPopulation.sql
            dbQueries.sql
    
-----------------------------------------------

The database created has the following schema:

Customer(CustomerID, Gender, Age)
    Primary Key: CustomerID

Product(Category, PricePerUnit)
    Natural Key: Category, PricePerUnit

Transaction(TransactionID, CustomerID, TransDate)
    Primary Key: TransactionID

TransactionDetails(TransactionID, Category, PricePerUnit, Quantity, TotalAmt)
    Primary Key: TransactionID
    Foreign Keys:
        TransactionID references Transaction(TransactionID)
        Category, PricePerUnit references Product(Category, PricePerUnit)


This schema was developed under the assumption that because no ProductID is present,
every product within a specific category would have a unique price per unit. 
This assumption allows a combination of Category and PricePerUnit to function
as a ProductID.
-----------------------------------------------

EACH FILE IN SQL:

dbCreation:
Documents the creation of the retailSalesDB

dbIndexing:
Documents the creation of indexes for retailSalesDB

dbPopulation:
Documents the insertion of all entries in the CSV file to the database
NOTE: this was run from the terminal

dbQueries:
Documents sample queries and their results.
Queries answered in dbQueries.sql:
Total Sales per Product Category
Average Age of Customer per Category and # of Customers per category
3 Highest Paying Customers per Category in October, 2023
Most Popular Category per Age Group (by # of Transactions)
-----------------------------------------------

BACKUPS and RESTORE:
2 backup files are available:

1.
The backup of retailSalesDB is stored in the backup folder.
Created using pgAdmin’s backup tool.
Can restore the database from this backup using pgAdmin’s restore tool.
This backup is named: retailSalesDB_backup

2.
Secondary backup file created using pg_dump via terminal
command used: 
/Applications/Postgres.app/Contents/Versions/latest/bin/pg_dump -U postgres -d retailsalesdb -f ~/Desktop/RetailSalesDB/backups/retailSalesDB_backup.sql

This backup file is named retailSalesDB_backup.sql
To restore using this file, create a new database and in the terminal:
/Applications/Postgres.app/Contents/Versions/latest/bin/psql -U postgres -d retailsalesDB_restore -f ~/Desktop/RetailSalesDB/backups/retailSalesDB_backup.sql
