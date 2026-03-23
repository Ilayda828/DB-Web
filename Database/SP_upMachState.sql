DROP PROCEDURE IF EXISTS SP_UPDATE_MACHINE_STATUS;
GO --Check

CREATE PROCEDURE SP_UPDATE_MACHINE_STATUS
    @MachineID INT,
    @Status NVARCHAR(30),
    @UpdateMaintenanceDate BIT = 0
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ForceMaintenanceUpdate BIT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Machine existence check
        IF NOT EXISTS (SELECT 1 FROM Machine WHERE MachineID = @MachineID)
        BEGIN
            ;THROW 50005, 'Machine not found.', 1;
        END
        
        -- Status validity check
        IF @Status NOT IN ('Active', 'UnderMaintenance', 'Inactive')
        BEGIN
            ;   THROW 50006, 'Invalid status. (Must be Active, UnderMaintenance, or Inactive)', 1;
        END
        
        -- Force maintenance date update when status is 'UnderMaintenance'
        SET @ForceMaintenanceUpdate = CASE WHEN @Status = 'UnderMaintenance' THEN 1 ELSE @UpdateMaintenanceDate END;
        
        -- Update machine status
        UPDATE Machine
        SET Status = @Status,
            LastMaintenance = CASE WHEN @ForceMaintenanceUpdate = 1 THEN GETDATE() ELSE LastMaintenance END,
            NextMaintenance = CASE WHEN @ForceMaintenanceUpdate = 1 THEN DATEADD(MONTH, 3, GETDATE()) ELSE NextMaintenance END
        WHERE MachineID = @MachineID;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;