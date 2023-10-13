/*
In MySQL, we can use the UPDATE and DELETE statements to modify or remove data from your database.
*/

Insert into EmployeeDemographics(EmployeeID, FirstName, LastName, Age, Gender)
VALUES
    (1200, 'Mark', 'Visley', 42, 'male');

-- Update age for Philbin
UPDATE EmployeeDemographics
SET age = 41
WHERE LastName = 'Philbin';

-- Update EmployeeID for Visley
UPDATE EmployeeDemographics
SET EmployeeID = 1014
WHERE LastName = 'Visley';

-- Update age and gender for Holly Flax
UPDATE EmployeeDemographics
SET Age = 35, Gender = 'female'
WHERE EmployeeID = 1012;

-- Delete employee with EmployeeID 1014
DELETE  FROM EmployeeDemographics
WHERE EmployeeID = 1014;