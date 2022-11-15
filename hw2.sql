/*
    Homework 1-2
    [lij51]
    Due: 2-24-2019  11:59 pm
*/
--======================================================================== Q1
CREATE TABLE Employees(
	id			INT				PRIMERY KEY			IDENTITY,
	age			INT				NOT NULL,
	fName		VARCHAR(20)		DEFAULT '',
	lName		NVARCHAR(20)	NOT NULL,
	hired		DATE			NOT NULL,
	salary		FLOAT			DEFAULT '0.0'
)
--======================================================================== Q2
BULK INSERT Employees
FROM 'c:\temp\HW_01-2_NewEmployees'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	FIRSTROW = 2
)
--======================================================================== Q3
SELECT TOP 5 WITH TIES VendorName
FROM Vendors
ORDER BY VendorState DESC
--======================================================================== Q4
TRUNCATE TABLE Employees
--======================================================================== Q5
SELECT *
FROM Vendors
ORDER BY VendorName
LIMIT 10,10
--======================================================================== Q6
SELECT *
FROM GLAccounts, Vendors
WHERE GLAccounts.AccountNo = Vendors.DefaultAccountNo
--======================================================================== Q7
SELECT *
FROM GLAccounts
JOIN Vendors ON GLAccounts.AccountNo = Vendors.DefaultAccountNo
--======================================================================== Q8
SELECT i1.InvoiceID,
	   i1.InvoiceNumber,
	   i2.InvoiceLineItemDescription,
	   i2.AccountNo,
	   i2.InvoiceLineItemAmount,
	   [balance] = i1.InvoiceTotal - i1.PaymentTotal - i1.CreditTotal
FROM Invoices AS i1, 
	 InvoiceLineItems AS i2
WHERE i1.InvoiceID = i2.InvoiceID,
	  i1.isDeleted IS NOT 0
ORDER BY i1.InvoiceNumber
--======================================================================== Q9
SELECT v.VendorName,
	   [sum] = i.InvoiceTotal + i.PaymentTotal + (i.InvoiceTotal - i.PaymentTotal - i.CreditTotal),
	   Count(i.InvoiceID)
FROM Vendors AS v, 
	 Invoices AS i
WHERE i.VendorID = v.VendorID,
	  i.isDeleted IS NOT 0,
      Count(i.InvoiceID) > 5,
	  i.CreditTotal = 0
      