/*
    Homework 3
    [zhangc29]
    Due: 4-07-2019  11:59 pm
*/

--============================================= Q1 
select VendorID,PaymentSum=SUM(PaymentTotal)
From Invoices 
Group by VendorID
Go
--=============================================  Q2
SELECT Top(10) PaymentSum=SUM(e.PaymentTotal),i.VendorName
From Invoices as e JOIN Vendors  as i
on i.VendorID = e.VendorID
group by VendorName 
order by PaymentSum
--=============================================Q3
select i.VendorName,count (*) as InvoiceCount, invoiceSum =sum(e.InvoiceTotal)
From Invoices as e JOIN Vendors  as i
on i.VendorID = e.VendorID
GROUP BY VendorName
ORDER BY InvoiceCount DESC;
--============================================Q4
SELECT g.AccountDescription, COUNT(*) AS LineItemCount,SUM(InvoiceLineItemAmount) AS LineItemSum
FROM GLAccounts as g JOIN InvoiceLineItems as i
ON g.AccountNo = i.AccountNo
GROUP BY g.AccountDescription
HAVING COUNT(*) > 1
ORDER BY LineItemCount DESC;
--=============================================Q5
SELECT g.AccountDescription, COUNT(*) AS LineItemCount,
SUM(InvoiceLineItemAmount) AS LineItemSum
FROM GLAccounts as g JOIN InvoiceLineItems as i
ON g.AccountNo = i.AccountNo
JOIN Invoices as n
ON i.InvoiceID = n.InvoiceID
WHERE InvoiceDate BETWEEN '2015-12-01' AND '2016-02-29'
GROUP BY g.AccountDescription
HAVING COUNT(*) > 1
ORDER BY LineItemCount DESC;
--==============================================Q6
SELECT AccountNo, SUM(InvoiceLineItemAmount) AS LineItemSum
FROM InvoiceLineItems
GROUP BY AccountNo WITH ROLLUP;
--==============================================Q7
SELECT VendorName, AccountDescription, COUNT(*) AS LineItemCount, SUM(InvoiceLineItemAmount) AS LineItemSum
FROM Vendors as v JOIN Invoices as i
ON v.VendorID = i.VendorID
JOIN InvoiceLineItems as n
ON i.InvoiceID = n.InvoiceID
JOIN GLAccounts as g
ON n.AccountNo = g.AccountNo
GROUP BY VendorName, AccountDescription
ORDER BY VendorName, AccountDescription;
--=============================================Q8
SELECT VendorName,
COUNT(DISTINCT n.AccountNo) AS [# of Accounts]
FROM Vendors as v JOIN Invoices as i
ON v.VendorID = i.VendorID
JOIN InvoiceLineItems as n
ON i.InvoiceID = n.InvoiceID
GROUP BY VendorName
HAVING COUNT(DISTINCT InvoiceLineItems.AccountNo) > 1
ORDER BY VendorName;