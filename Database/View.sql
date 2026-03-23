CREATE VIEW VW_PRODUCT_QUALITY_RESULTS
AS
SELECT
    qc.QualityCheckID,
    qc.CheckDate,
    qc.Result,
    p.ProductID,
    p.ProductName,
    p.Category,
    e.EmployeeID,
    e.Name + ' ' + e.Surname AS FullName,
    e.Position,
    m.MachineID,
    m.MachineName,
    m.Status AS MachineStatus
FROM QualityCheck qc
INNER JOIN Product p
    ON qc.ProductID = p.ProductID
INNER JOIN Employee e
    ON qc.CheckedByEmployeeID = e.EmployeeID
LEFT JOIN Machine m
    ON qc.MachineID = m.MachineID;
