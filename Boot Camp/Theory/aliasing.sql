/*
Aliasing
*/
-- Alias the FirstName column as Fname
SELECT FirstName AS Fname
FROM EmployeeDemographics;

-- Alias the FirstName column as Fname
SELECT FirstName Fname
FROM EmployeeDemographics;

-- Concatenate FirstName and LastName to create FullName
SELECT CONCAT(FirstName, ' ', LastName) AS FullName
FROM EmployeeDemographics;

-- Calculate the average age (AvgAge) of employees in the EmployeeDemographics table
SELECT AVG(Age) as AvgAge
FROM EmployeeDemographics;

-- Select the FirstName column from the EmployeeDemographics table and alias the table as TableName
SELECT TableName.FirstName
FROM EmployeeDemographics AS TableName;

