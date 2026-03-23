-- ===================================================
-- SP_UPDATE_PRODUCT_STOCK Stored Procedure
-- Purpose: Update product stock quantity
-- ===================================================

USE DENE;
GO

-- Drop if exists
IF OBJECT_ID('dbo.SP_UPDATE_PRODUCT_STOCK', 'P') IS NOT NULL
    DROP PROCEDURE dbo.SP_UPDATE_PRODUCT_STOCK;
GO

-- Create stored procedure
CREATE PROCEDURE dbo.SP_UPDATE_PRODUCT_STOCK
    @ProductID INT,
    @NewStock INT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Validate product exists
    IF NOT EXISTS (SELECT 1 FROM dbo.Product WHERE ProductID = @ProductID)
    BEGIN
        ;THROW 50001, 'Product not found.', 1;
        RETURN;
    END
    
    -- Validate stock is not negative
    IF @NewStock < 0
    BEGIN
        ;THROW 50002, 'Stock cannot be negative.', 1;
        RETURN;
    END
    
    -- Update product stock
    UPDATE dbo.Product
    SET Stock = @NewStock
    WHERE ProductID = @ProductID;
    
    PRINT 'Product stock updated successfully.';
END;
GO

-- Test the stored procedure
PRINT '=== Testing SP_UPDATE_PRODUCT_STOCK ===';
EXEC dbo.SP_UPDATE_PRODUCT_STOCK @ProductID = 1, @NewStock = 100;
GO

PRINT '=== SP_UPDATE_PRODUCT_STOCK created successfully! ===';
GO
