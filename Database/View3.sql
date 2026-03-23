CREATE VIEW VW_CUSTOMER_INVOICE_SUMMARY
AS
SELECT
    c.CustomerID,
    c.Name AS CustomerName,
    c.CustomerType,
    c.Email,
    c.PhoneNumber,
    COUNT(i.InvoiceID) AS InvoiceCount,
    SUM(i.TotalAmount) AS TotalInvoiceAmount,
    SUM(i.TotalWithTax) AS TotalInvoiceWithTax,
    AVG(i.TotalAmount) AS AverageInvoiceAmount,
    MAX(i.InvoiceDate) AS LastInvoiceDate,
    MIN(i.InvoiceDate) AS FirstInvoiceDate
FROM Customer c
LEFT JOIN Invoice i
    ON c.CustomerID = i.CustomerID
GROUP BY 
    c.CustomerID, 
    c.Name, 
    c.CustomerType, 
    c.Email, 
    c.PhoneNumber;
