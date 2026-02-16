--AUTHOR: Palmer King
--This is documentation for the creation of indexes for retailSalesDB

------------------------------------------------------------------

--Indexes for Transaction 
CREATE INDEX idx_trans_Customer ON Transaction(CustomerID);
CREATE INDEX idx_trans_Date ON Transaction(TransDate);

--Indexes for Transaction Details
CREATE INDEX idx_tdetails_transaction ON TransactionDetails(TransactionID);
CREATE INDEX idx_tdetails_category ON TransactionDetails(Category);