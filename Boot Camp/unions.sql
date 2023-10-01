/*
Description
The SQL UNION operator is used to combine the result sets of 2 or more SELECT statements.
It removes duplicate rows between the various SELECT statements.
Each SELECT statement within the UNION must have the same number of fields in the result sets with similar data types.
*/

# Preparation of tables

# Table 1 - EmployeeDemographics Insert:
INSERT INTO EmployeeDemographics (EmployeeID, FirstName, LastName, Age, Gender)
VALUES
    (1011, 'Ryan', 'Howard', 26, 'Male'),
    (1012, 'Holly', 'Flax', NULL, NULL),
    (1013, 'Darryl', 'Philbin', NULL, 'Male');

# Table 2 - WareHouseEmployeeDemographics Create Query:
Create Table WareHouseEmployeeDemographics
(EmployeeID int,
 FirstName varchar(50),
 LastName varchar(50),
 Age int,
 Gender varchar(50)
);

# Table 3 - WareHouseEmployeeDemographics Insert:
Insert into WareHouseEmployeeDemographics (EmployeeID, FirstName, LastName, Age, Gender)
VALUES
    (1013, 'Darryl', 'Philbin', NULL, 'Male'),
    (1050, 'Roy', 'Anderson', 31, 'Male'),
    (1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
    (1052, 'Val', 'Johnson', 31, 'Female');

/*
MySQL doesn't have a built-in FULL OUTER JOIN syntax like some other database management systems (e.g., SQL Server, PostgreSQL).
However, you can achieve a full outer join in MySQL by combining a LEFT JOIN and a RIGHT JOIN and then using the UNION operator.
Here's how you can do it:
*/

SELECT *
    FROM EmployeeDemographics
        LEFT JOIN WareHouseEmployeeDemographics
             on EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID
UNION

SELECT *
    FROM EmployeeDemographics
        RIGHT JOIN  WareHouseEmployeeDemographics
             on EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID;

/*
This query will return all rows from both EmployeeDemographics and WareHouseEmployeeDemographics, matching rows where the id values are equal
and including NULL values where there is no match in either table.
*/

SELECT *
FROM EmployeeDemographics

UNION

SELECT *
FROM WareHouseEmployeeDemographics;

SELECT *
FROM EmployeeDemographics

UNION ALL

SELECT *
FROM WareHouseEmployeeDemographics;

/*
What is the difference between UNION and UNION ALL?
UNION removes duplicate rows.
UNION ALL does not remove duplicate rows.
*/

SELECT EmployeeID, FirstName, Age
FROM EmployeeDemographics

UNION

SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary

/*
In this case, the query works because both SELECT statements retrieve data with the same number of columns
and matching data types.
This compatibility allows the UNION operator to seamlessly merge the results into a single result set.
*/