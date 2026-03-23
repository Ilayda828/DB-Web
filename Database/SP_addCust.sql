DROP PROCEDURE IF EXISTS SP_ADD_CUSTOMER;
GO -- Bu satýrlarý herhangi bi problem oluþumunu engellemek için koydum, tüm sp'lerde var

CREATE PROCEDURE SP_ADD_CUSTOMER
    @Name NVARCHAR(100),
    @Address NVARCHAR(255),
    @PhoneNumber NVARCHAR(20),
    @Email NVARCHAR(150),
    @CustomerType NVARCHAR(50),
    @NewCustomerID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Email uniqueness check
        IF EXISTS (SELECT 1 FROM Customer WHERE Email = @Email)
        BEGIN
            ROLLBACK TRANSACTION;
            RETURN -1; -- Email conflict
        END
        
        -- Insert customer
        INSERT INTO Customer(Name, Address, PhoneNumber, Email, CustomerType)
        VALUES(@Name, @Address, @PhoneNumber, @Email, @CustomerType);
        
        SET @NewCustomerID = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        RETURN 0; -- Success
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        RETURN -99; -- General error
    END CATCH
END;