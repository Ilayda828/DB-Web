DROP PROCEDURE IF EXISTS SP_ADD_PRODUCT;
GO --check

CREATE PROCEDURE SP_ADD_PRODUCT
    @ProductName NVARCHAR(100),
    @UnitPrice DECIMAL(12,2),
    @Category NVARCHAR(50),
    @Cost DECIMAL(12,2),
    @Stock INT = 0,
    @SupplierID INT = NULL,
    @MachineID INT -- MANDATORY (cannot be NULL)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Price and cost check
        IF @UnitPrice <= 0 OR @Cost <= 0
        BEGIN
            ;THROW 50001, 'Price and cost must be greater than 0.', 1;
        END
        
        -- MachineID must be mandatory and valid
        IF @MachineID IS NULL
        BEGIN
            ;THROW 50002, 'Machine ID is mandatory for every product.', 1;
        END
        
        IF NOT EXISTS (SELECT 1 FROM Machine WHERE MachineID = @MachineID)
        BEGIN
            ;THROW 50003, 'Invalid machine ID.', 1;
        END
        
        -- SupplierID check (if provided)
        IF @SupplierID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Supplier WHERE SupplierID = @SupplierID)
        BEGIN
            ;THROW 50004, 'Invalid supplier ID.', 1;
        END
        
        -- Insert product
        INSERT INTO Product(ProductName, UnitPrice, Category, Cost, Stock, SupplierID, MachineID, ManufacturedDate)
        VALUES(@ProductName, @UnitPrice, @Category, @Cost, @Stock, @SupplierID, @MachineID, GETDATE());
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;