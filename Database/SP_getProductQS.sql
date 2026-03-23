DROP PROCEDURE IF EXISTS SP_GET_PRODUCT_QUALITY_SUMMARY;
GO --Check

CREATE PROCEDURE SP_GET_PRODUCT_QUALITY_SUMMARY
    @CategoryFilter NVARCHAR(50) = NULL,
    @MinPassRate DECIMAL(5,2) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        -- CTE: Top 5 recent quality checks per product
        ;WITH RecentChecks AS (
            SELECT 
                qc.ProductID,
                qc.Result,
                qc.CheckDate,
                ROW_NUMBER() OVER (PARTITION BY qc.ProductID ORDER BY qc.CheckDate DESC) AS RowNum
            FROM QualityCheck qc
        ),
        -- CTE: Aggregate details of the top 5 records into a single string
        CheckDetails AS (
            SELECT 
                ProductID,
                STRING_AGG(
                    CAST(Result AS NVARCHAR(10)) + ' (' + CONVERT(NVARCHAR(10), CheckDate, 120) + ')', 
                    ', '
                ) WITHIN GROUP (ORDER BY CheckDate DESC) AS RecentChecksDetail
            FROM RecentChecks
            WHERE RowNum <= 5
            GROUP BY ProductID
        )
        -- Main report
        SELECT 
            p.ProductID,
            p.ProductName,
            p.Category,
            p.Stock,
            s.SupplierName,
            COUNT(qc.QualityCheckID) AS TotalChecks,
            SUM(CASE WHEN qc.Result = 'Pass' THEN 1 ELSE 0 END) AS PassCount,
            SUM(CASE WHEN qc.Result = 'Fail' THEN 1 ELSE 0 END) AS FailCount,
            CASE 
                WHEN COUNT(qc.QualityCheckID) > 0 
                THEN CAST(SUM(CASE WHEN qc.Result = 'Pass' THEN 1 ELSE 0 END) * 100.0 / COUNT(qc.QualityCheckID) AS DECIMAL(5,2))
                ELSE NULL 
            END AS PassRate,
            CASE 
                WHEN COUNT(qc.QualityCheckID) = 0 THEN 'Unchecked'
                WHEN CAST(SUM(CASE WHEN qc.Result = 'Pass' THEN 1 ELSE 0 END) * 100.0 / COUNT(qc.QualityCheckID) AS DECIMAL(5,2)) >= 95 THEN 'Excellent'
                WHEN CAST(SUM(CASE WHEN qc.Result = 'Pass' THEN 1 ELSE 0 END) * 100.0 / COUNT(qc.QualityCheckID) AS DECIMAL(5,2)) >= 85 THEN 'Good'
                WHEN CAST(SUM(CASE WHEN qc.Result = 'Pass' THEN 1 ELSE 0 END) * 100.0 / COUNT(qc.QualityCheckID) AS DECIMAL(5,2)) >= 70 THEN 'Medium'
                ELSE 'Low'
            END AS QualityGrade,
            MAX(qc.CheckDate) AS LastCheckDate,
            cd.RecentChecksDetail -- NEW COLUMN
        FROM Product p
        LEFT JOIN QualityCheck qc ON p.ProductID = qc.ProductID
        LEFT JOIN Supplier s ON p.SupplierID = s.SupplierID
        LEFT JOIN CheckDetails cd ON p.ProductID = cd.ProductID
        WHERE (@CategoryFilter IS NULL OR p.Category = @CategoryFilter)
        GROUP BY p.ProductID, p.ProductName, p.Category, p.Stock, s.SupplierName, cd.RecentChecksDetail
        HAVING (@MinPassRate IS NULL OR 
                 CAST(SUM(CASE WHEN qc.Result = 'Pass' THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(qc.QualityCheckID), 0) AS DECIMAL(5,2)) >= @MinPassRate)
        ORDER BY PassRate DESC;
        
    END TRY
    BEGIN CATCH
        THROW;
    END CATCH
END;