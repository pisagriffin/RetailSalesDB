--AUTHOR: Palmer King
--This is documentation of sample queries and their results for retailSalesDB

------------------------------------------------------------------

--Total Sales per Product Category
SELECT Category, SUM(TotalAmt) AS TotalSales
FROM TransactionDetails
GROUP BY Category 
ORDER BY TotalSales DESC;

/*
RESULTS:
Electronics has a total of 156,905
Clothing has a total of 155,580
Beauty has a total of 143515
*/

--Average Age of Customer per Category and # of Customers per category
SELECT Category, 
    ROUND(AVG(c.Age)) as AvgAge,
    COUNT(DISTINCT c.CustomerID) as NumCustomers
FROM Customer c 
JOIN Transaction t ON c.CustomerID = t.CustomerID
JOIN TransactionDetails td ON td.TransactionID = t.TransactionID
GROUP BY Category 
ORDER BY AvgAge DESC;

/*
RESULTS:
Clothing has avg age of 42 with 351 distinct customers
Electronics has avg age of 42 with 342 distinct customers
Beauty has avg age of 40 with 307 distinct customers
*/

--3 Highest Paying Customers per Category in October, 2023
WITH CustomerTotals AS (
    SELECT td.Category,
           t.CustomerID,
           SUM(td.TotalAmt) AS Total,
           ROW_NUMBER() OVER (
               PARTITION BY td.Category
               ORDER BY SUM(td.TotalAmt) DESC
           ) AS rn
    FROM Transaction t
    JOIN TransactionDetails td ON td.TransactionID = t.TransactionID
    WHERE EXTRACT(YEAR FROM t.TransDate) = 2023
      AND EXTRACT(MONTH FROM t.TransDate) = 10
    GROUP BY td.Category, t.CustomerID
)
SELECT Category, CustomerID, Total
FROM CustomerTotals
WHERE rn <= 3
ORDER BY Category, Total DESC;

/*
RESULTS:
October 2023 top Customers:
Beauty: CUST503, $2000
        CUST869, $1500
        CUST677, $1500
Clothing:
        CUST735, $2000
        CUST342, $2000
        CUST124, $2000
Electronics:
        CUST089, $2000
        CUST109, $2000
        CUST634, $2000
*/

--Most Popular Category per Age Group (by # of Transactions)
WITH AgeGroupTotals AS(
    SELECT FLOOR(c.Age/10) * 10 AS ageGroup,
        td.Category,
        COUNT(*) AS TotalTransactions,
        ROW_NUMBER() OVER (
            PARTITION BY FLOOR(c.Age/10) * 10
            ORDER BY COUNT(*) DESC
        ) AS rn
    FROM Customer c
    JOIN Transaction t ON t.CustomerID = c.CustomerID
    JOIN TransactionDetails td ON td.TransactionID = t.TransactionID
    GROUP BY ageGroup, td.Category
)
SELECT Category, ageGroup, TotalTransactions
FROM AgeGroupTotals
WHERE rn = 1
ORDER BY AgeGroup, TotalTransactions ASC;

/*
Age group of 19 and below purchased Electronics the most, with total 16 transactions
20+ purchased Clothing the most with 75 total transactions
30+ purchased Electronics the most with 66 total transactions
40+ purchased Clothing the most with 86 total transactions
50+ purchased Electronics the most with 81 total transactions
60+ purchased Eelctronics the most with 43 total transactions
*/