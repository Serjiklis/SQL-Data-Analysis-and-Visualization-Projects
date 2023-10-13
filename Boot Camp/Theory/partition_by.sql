-- Partition By

-- Calculate the total count of employees for each gender using window function
SELECT FirstName, LastName, Gender, Salary,
       COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
FROM EmployeeDemographics as dem
JOIN  EmployeeSalary as sel
    ON dem.EmployeeID = sel.EmployeeID;

-- Calculate the total count of employees for each combination of FirstName, LastName, Gender, and Salary
SELECT FirstName, LastName, Gender, Salary,
       COUNT(Gender)
FROM EmployeeDemographics as dem
         JOIN  EmployeeSalary as sel
               ON dem.EmployeeID = sel.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary;

-- Calculate the total count of employees for each gender
SELECT Gender,
       COUNT(Gender)
FROM EmployeeDemographics as dem
         JOIN  EmployeeSalary as sel
               ON dem.EmployeeID = sel.EmployeeID
GROUP BY Gender;