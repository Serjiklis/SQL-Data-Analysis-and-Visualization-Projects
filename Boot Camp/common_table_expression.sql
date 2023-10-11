/*
CTEs are a powerful tool for SQL developers to make queries more efficient and easier to understand.
They are also commonly used in recursive queries to traverse hierarchical data structures like organizational charts.

Here's a basic syntax for creating a CTE:

WITH cte_name (column1, column2, ...) AS (
    -- SQL query that defines the CTE
    SELECT ...
)
-- Main SQL query that references the CTE
SELECT ...
*/
WITH CTE_Employee as
    (
        SELECT FirstName, LastName, Gender,Salary,
               COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender,
               AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
        FROM EmployeeDemographics DM
        JOIN EmployeeSalary ES on DM.EmployeeID = ES.EmployeeID
        WHERE Salary > 45000
    )
SELECT *
FROM CTE_Employee;

WITH CTE_Employee as
         (
             SELECT FirstName, LastName, Gender,Salary,
                    COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender,
                    AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
             FROM EmployeeDemographics DM
                      JOIN EmployeeSalary ES on DM.EmployeeID = ES.EmployeeID
             WHERE Salary > 45000
         )
SELECT FirstName, AvgSalary
FROM CTE_Employee;