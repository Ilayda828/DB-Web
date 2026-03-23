CREATE VIEW VW_PAYMENT_STATUS
AS
SELECT
    c.CustomerID,
    c.Name AS CustomerName,
    c.CustomerType,
    i.InvoiceID,
    i.InvoiceDate,
    i.TotalAmount,
    i.TaxRate,
    i.TotalWithTax,
    ISNULL(SUM(p.PaymentAmount), 0) AS PaidAmount,
    i.TotalWithTax - ISNULL(SUM(p.PaymentAmount), 0) AS RemainingAmount,
    CASE 
        WHEN ISNULL(SUM(p.PaymentAmount), 0) = 0 THEN 'Unpaid'
        WHEN i.TotalWithTax - ISNULL(SUM(p.PaymentAmount), 0) = 0 THEN 'Paid'
        WHEN i.TotalWithTax - ISNULL(SUM(p.PaymentAmount), 0) > 0 THEN 'Partially Paid'
        ELSE 'Overpaid'
    END AS PaymentStatus,
    COUNT(p.PaymentID) AS PaymentCount,
    MAX(p.PaymentDate) AS LastPaymentDate
FROM Invoice i
INNER JOIN Customer c
    ON i.CustomerID = c.CustomerID
LEFT JOIN Payment p
    ON i.InvoiceID = p.InvoiceID
GROUP BY
    c.CustomerID,
    c.Name,
    c.CustomerType,
    i.InvoiceID,
    i.InvoiceDate,
    i.TotalAmount,
    i.TaxRate,
    i.TotalWithTax;