DROP PROCEDURE IF EXISTS SP_GET_CUSTOMER_BALANCE;
GO --Check

CREATE PROCEDURE SP_GET_CUSTOMER_BALANCE
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Customer check
        IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerID = @CustomerID)
        BEGIN
            THROW 50019, 'Customer not found.', 1;
        END
        
        -- CTE 1: Invoice summaries
        ;WITH InvoiceSummary AS (
            SELECT 
                i.CustomerID,
                COUNT(i.InvoiceID) AS TotalInvoiceCount,
                SUM(i.TotalAmount) AS TotalInvoiceAmount,
                SUM(i.TotalWithTax) AS TotalWithTax,
                AVG(i.TotalAmount) AS AverageInvoiceAmount,
                MAX(i.InvoiceDate) AS LastInvoiceDate
            FROM Invoice i
            WHERE i.CustomerID = @CustomerID
            GROUP BY i.CustomerID
        ),
        -- CTE 2: Payment summaries
        PaymentSummary AS (
            SELECT 
                i.CustomerID,
                COUNT(p.PaymentID) AS TotalPayments,
                SUM(p.PaymentAmount) AS TotalPaidAmount,
                MAX(p.PaymentDate) AS LastPaymentDate
            FROM Invoice i
            INNER JOIN Payment p ON i.InvoiceID = p.InvoiceID
            WHERE i.CustomerID = @CustomerID
            GROUP BY i.CustomerID
        )
        -- Final report
        SELECT 
            c.CustomerID,
            c.Name AS CustomerName,
            c.CustomerType,
            c.Email,
            ISNULL(inv.TotalInvoiceCount, 0) AS TotalInvoiceCount,
            ISNULL(inv.TotalInvoiceAmount, 0) AS TotalInvoiceAmount,
            ISNULL(inv.TotalWithTax, 0) AS TotalWithTax,
            ISNULL(inv.AverageInvoiceAmount, 0) AS AverageInvoiceAmount,
            ISNULL(pay.TotalPayments, 0) AS TotalPayments,
            ISNULL(pay.TotalPaidAmount, 0) AS TotalPaidAmount,
            ISNULL(inv.TotalWithTax, 0) - ISNULL(pay.TotalPaidAmount, 0) AS RemainingBalance,
            inv.LastInvoiceDate,
            pay.LastPaymentDate,
            CASE 
                WHEN ISNULL(inv.TotalWithTax, 0) - ISNULL(pay.TotalPaidAmount, 0) = 0 THEN 'No Debt'
                WHEN ISNULL(inv.TotalWithTax, 0) - ISNULL(pay.TotalPaidAmount, 0) > 0 THEN 'In Debt'
                ELSE 'Overpayment'
            END AS PaymentStatus
        FROM Customer c
        LEFT JOIN InvoiceSummary inv ON c.CustomerID = inv.CustomerID
        LEFT JOIN PaymentSummary pay ON c.CustomerID = pay.CustomerID
        WHERE c.CustomerID = @CustomerID;
        
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;