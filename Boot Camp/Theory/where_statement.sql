/*
Where Statement
= , <>, <, >, And, Or, Like, Null, Not Null, In
*/

-- Select all records where the FirstName is 'Pam'
SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Pam';

-- Select all records where the FirstName is not 'Pam'
SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'Pam';

-- Select all records where the Age is greater than 31
SELECT *
FROM EmployeeDemographics
WHERE Age > 31;

-- Select all records where the Age is greater than or equal to 31
SELECT *
FROM EmployeeDemographics
WHERE Age >= 31;

-- Select all records where the Age is less than 31
SELECT *
FROM EmployeeDemographics
WHERE Age < 31;

-- Select all records where the Age is less than or equal to 31
SELECT *
FROM EmployeeDemographics
WHERE Age <= 31;

-- Select all records where the Age is less than 31 and the Gender is 'Male'
SELECT *
FROM EmployeeDemographics
WHERE Age < 31 AND Gender = 'Male';

-- Select all records where the LastName starts with 'S'
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%';

-- Select all records where the LastName contains 'S' anywhere in the name
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE '%S%';

-- Select all records where the LastName starts with 'H' and contains 'd' anywhere in the name
SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'H%d%';

-- Select all records where the LastName is null
SELECT *
FROM EmployeeDemographics
WHERE LastName IS NULL;

-- Select all records where the LastName is not null
SELECT *
FROM EmployeeDemographics
WHERE LastName IS NOT NULL;

-- Select all records where the FirstName is 'Tom', 'Pam', or 'Toby'
SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Tom', 'Pam', 'Toby');