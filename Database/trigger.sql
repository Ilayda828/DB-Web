CREATE TRIGGER TR_QC_FAIL_UPDATE_MACHINE
ON QualityCheck
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- Update the status and maintenance dates of the machines 
        -- associated with the failed quality checks.
        UPDATE m
        SET 
            m.Status = 'UnderMaintenance',
            m.LastMaintenance = GETDATE(),
            m.NextMaintenance = DATEADD(MONTH, 3, GETDATE())
        FROM Machine m
        INNER JOIN INSERTED i
            ON m.MachineID = i.MachineID -- Joins Machine with the newly inserted failed checks
        WHERE i.Result = 'Fail'          -- Business Rule: Only trigger on failure
          AND i.MachineID IS NOT NULL;   -- Data Integrity: Ensures a valid MachineID is present
          
    END TRY
    BEGIN CATCH
        -- If an error occurs during the update (e.g., locking), rollback the original transaction.
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Throw the error back to the calling application/process.
        THROW;
    END CATCH
END;