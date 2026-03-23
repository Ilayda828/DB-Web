DROP PROCEDURE IF EXISTS SP_DELETE_CUSTOMER;
GO

CREATE PROCEDURE SP_DELETE_CUSTOMER
    @CustomerID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- 1. Müşterinin varlığını kontrol edelim
    IF NOT EXISTS (SELECT 1 FROM Customer WHERE CustomerID = @CustomerID)
    BEGIN
        ;THROW 50020, 'Customer not found, deletion aborted!', 1;
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 2. ADIM: Önce en alttaki basamağı (Payment) silelim.
        -- Silinecek müşterinin InvoiceID'lerine bağlı olan ödemeleri temizliyoruz.
        DELETE FROM Payment
        WHERE InvoiceID IN (SELECT InvoiceID FROM Invoice WHERE CustomerID = @CustomerID);

        -- 3. ADIM: İkinci basamağı (Invoice) silelim.
        DELETE FROM Invoice
        WHERE CustomerID = @CustomerID;

        -- 4. ADIM: En son kök kaydı (Customer) silelim.
        DELETE FROM Customer 
        WHERE CustomerID = @CustomerID;

        COMMIT TRANSACTION;

        SELECT 1 AS ResultCode, 'Customer and all associated invoices/payments deleted successfully.' AS Message;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Hata mesajını fırlat
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO