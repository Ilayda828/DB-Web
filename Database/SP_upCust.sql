USE DENE; -- Veritabaný adý düzeltildi
GO

-- Varsa eski prosedürü siliyoruz
IF OBJECT_ID('[dbo].[SP_UPDATE_CUSTOMER]', 'P') IS NOT NULL
    DROP PROCEDURE [dbo].[SP_UPDATE_CUSTOMER];
GO

-- Prosedürü Identity hatasýný düzelterek yeniden oluþturuyoruz
CREATE PROCEDURE [dbo].[SP_UPDATE_CUSTOMER]
    @OldCustomerID INT,
    @NewCustomerID INT, -- Parametre yapýsýný bozmuyoruz (C# hata vermesin diye)
    @Name NVARCHAR(100),
    @Address NVARCHAR(255),
    @PhoneNumber NVARCHAR(20),
    @Email NVARCHAR(150),
    @CustomerType NVARCHAR(50),
    @TotalInvoices INT,
    @TotalSpent DECIMAL(18,2)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1. Ýsim Benzersizliði Kontrolü
        IF EXISTS (SELECT 1 FROM [dbo].[Customer] WHERE Name = @Name AND CustomerID <> @OldCustomerID)
        BEGIN
            ROLLBACK TRANSACTION;
            ;THROW 50002, 'A customer with this name already exists.', 1;
        END

        -- 2. Güncelleme Ýþlemi
        -- DÜZELTME BURADA: "CustomerID = @NewCustomerID" satýrýný kaldýrdýk.
        -- Identity kolonlar güncellenemez, sadece diðer bilgiler güncellenir.
        UPDATE [dbo].[Customer] 
        SET Name = @Name,
            Address = @Address,
            PhoneNumber = @PhoneNumber,
            Email = @Email,
            CustomerType = @CustomerType
        WHERE CustomerID = @OldCustomerID;

        COMMIT TRANSACTION;
        SELECT 1 AS ResultCode, 'Customer updated successfully.' AS Message;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO