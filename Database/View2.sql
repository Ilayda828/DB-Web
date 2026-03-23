CREATE VIEW VW_PRODUCT_SUPPLIER
AS
SELECT
    p.ProductID,
    p.ProductName,
    p.Category,
    p.UnitPrice,
    p.Cost,
    p.Stock,
    p.ManufacturedDate,
    s.SupplierID,
    s.SupplierName,
    s.Country,
    s.Rating AS SupplierRating,
    s.ContactPerson,
    CASE 
        WHEN s.SupplierID IS NULL THEN 'No Supplier'
        ELSE 'Has Supplier'
    END AS SupplierStatus
FROM Product p
LEFT JOIN Supplier s
    ON p.SupplierID = s.SupplierID;