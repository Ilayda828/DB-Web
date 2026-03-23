DROP PROCEDURE IF EXISTS SP_PROCESS_QUALITY_CHECK;
GO --Check

CREATE PROCEDURE SP_PROCESS_QUALITY_CHECK
    @ProductID INT,
    @MachineID INT,
    @Result NVARCHAR(10),       -- 'Pass' veya 'Fail' olmalı
    @CheckedByEmployeeID INT,
    @NewQualityCheckID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Zorunlu alan kontrolü
    IF @ProductID IS NULL OR @MachineID IS NULL OR @Result IS NULL OR @CheckedByEmployeeID IS NULL
    BEGIN
        THROW 50020, 'All parameters (ProductID, MachineID, Result, CheckedByEmployeeID) are mandatory.', 1;
    END

    -- Result format kontrolü
    IF @Result NOT IN ('Pass', 'Fail')
    BEGIN
        THROW 50021, 'Result must be either ''Pass'' or ''Fail''.', 1;
    END

    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Varlık kontrolü
        IF NOT EXISTS (SELECT 1 FROM Product WHERE ProductID = @ProductID)
        BEGIN
            THROW 50022, 'Invalid ProductID. Product not found.', 1;
        END

        IF NOT EXISTS (SELECT 1 FROM Machine WHERE MachineID = @MachineID)
        BEGIN
            THROW 50023, 'Invalid MachineID. Machine not found.', 1;
        END

        IF NOT EXISTS (SELECT 1 FROM Employee WHERE EmployeeID = @CheckedByEmployeeID)
        BEGIN
            THROW 50024, 'Invalid EmployeeID. Employee not found.', 1;
        END
        
        -- 1. QualityCheck kaydını oluştur
        INSERT INTO QualityCheck (ProductID, MachineID, CheckDate, Result, CheckedByEmployeeID)
        VALUES (@ProductID, @MachineID, GETDATE(), @Result, @CheckedByEmployeeID);
        
        SET @NewQualityCheckID = SCOPE_IDENTITY();
        
        -- 2. Ürünün QualityStatus'ünü güncelle
        UPDATE Product
        SET QualityStatus = @Result
        WHERE ProductID = @ProductID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO