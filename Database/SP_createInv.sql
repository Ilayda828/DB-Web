DROP PROCEDURE IF EXISTS SP_CREATE_INVOICE;
GO --Check

CREATE PROCEDURE SP_CREATE_INVOICE
    @CustomerID INT,
    @ProductID INT,
    @TotalAmount DECIMAL(12,2),
    @TaxRate DECIMAL(5,2) = 20.0,
    @TaxOfficeNumber NVARCHAR(50) = NULL,
    @InvoiceType NVARCHAR(30) = NULL,
    @InvoicingParty NVARCHAR(150),
    @InvoicedParty NVARCHAR(150),
    @NewInvoiceID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Customer check
        IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerID = @CustomerID)
        BEGIN
            ;THROW 50015, 'Customer not found.', 1;
        END
        
        -- Product check (MANDATORY)
        -- Fatura Kuralı: Her fatura tam olarak bir ürünle ilişkili olmalıdır.
        IF @ProductID IS NULL OR NOT EXISTS (SELECT 1 FROM Product WHERE ProductID = @ProductID)
        BEGIN
            ;THROW 50017, 'Product ID is mandatory and must be valid.', 1;
        END
        
        -- Amount check
        IF @TotalAmount <= 0
        BEGIN
            ;THROW 50018, 'Invoice amount must be greater than 0.', 1;
        END
        
        -- Create invoice
        INSERT INTO Invoice(InvoiceDate, CustomerID, ProductID, TotalAmount, TaxRate, TaxOfficeNumber, InvoiceType, InvoicingParty, InvoicedParty)
        VALUES(GETDATE(), @CustomerID, @ProductID, @TotalAmount, @TaxRate, @TaxOfficeNumber, @InvoiceType, @InvoicingParty, @InvoicedParty);
        
        SET @NewInvoiceID = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        -- Orijinal hatayı tekrar fırlat
        THROW;
    END CATCH
END;
GO