DROP PROCEDURE IF EXISTS SP_DELETE_CUSTOMER;
GO

CREATE PROCEDURE SP_DELETE_CUSTOMER
	@CustomerID INT
AS
BEGIN
	SET NOCOUNT ON;

	-- Müþterinin adýný deðiþkene alalým (Payee kontrolü için)
	DECLARE @TargetCustomerName NVARCHAR(200);

	SELECT @TargetCustomerName = Customer.Name
	FROM Customer
	WHERE CustomerID = @CustomerID;

	--Müþteri kontrol kýsmý
	IF @TargetCustomerName IS NULL
	BEGIN
		;THROW 50020, 'Customer not found, deletion aborted!', 1;
		RETURN
	END

	BEGIN TRY
		BEGIN TRANSACTION;

		DELETE FROM Invoice
		WHERE CustomerID = @CustomerID;	

		DELETE FROM Payment
		Where Payee = @TargetCustomerName

		DELETE FROM Customer 
		Where CustomerID = @CustomerID

		COMMIT TRANSACTION;

		SELECT 1 AS ResultCode, 'Customer and all associated records deleted successfully.' AS Message;

		
	END TRY
	BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        ;THROW; 
    END CATCH

END;
GO