DROP PROCEDURE IF EXISTS SP_RECORD_QUALITYCHECK;
GO --Check

CREATE PROCEDURE SP_RECORD_QUALITYCHECK
    @ProductID INT,
    @MachineID INT = NULL,
    @Result NVARCHAR(10),
    @CheckedByEmployeeID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Product check
        IF NOT EXISTS (SELECT 1 FROM Product WHERE ProductID = @ProductID)
        BEGIN
            ;THROW 50007, 'Product not found.', 1;
        END
        
        -- Employee check
        IF NOT EXISTS (SELECT 1 FROM Employee WHERE EmployeeID = @CheckedByEmployeeID)
        BEGIN
            ;THROW 50008, 'Employee not found.', 1;
        END
        
        -- Machine check (if provided)
        IF @MachineID IS NOT NULL AND NOT EXISTS (SELECT 1 FROM Machine WHERE MachineID = @MachineID)
        BEGIN
            ;THROW 50009, 'Invalid machine ID.', 1;
        END
        
        -- Result check
        IF @Result NOT IN ('Pass', 'Fail')
        BEGIN
            ;THROW 50010, 'Result must be Pass or Fail.', 1;
        END
        
        -- Record Quality Check
        INSERT INTO QualityCheck(ProductID, MachineID, CheckDate, Result, CheckedByEmployeeID)
        VALUES(@ProductID, @MachineID, GETDATE(), @Result, @CheckedByEmployeeID);
        
        -- IMPORTANT: Update QualityStatus in Product table
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