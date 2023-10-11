-- Subqueries (in the Select, From, and Where Statement)

SELECT *
FROM SQLAnalysys.EmployeeSalary;

-- Subquery in Select

SELECT EmployeeID, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AllAvgSalary
FROM EmployeeSalary;

-- How to do it with Partition By

SELECT EmployeeID, Salary, AVG(Salary) over (partition by Salary) as AllAvgSalary
FROM EmployeeSalary;


-- Why Group By doesn't work

SELECT EmployeeID, Salary, AVG(Salary)  as AllAvgSalary
FROM EmployeeSalary
GROUP BY Salary, EmployeeID
ORDER BY 1,2;

-- Subquery in From

SELECT *
FROM (SELECT AVG(Salary) AS AllAvgSalary
      FROM EmployeeSalary) as subquery
GROUP BY 1;

-- Subquery in Where
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeID in (
    SELECT EmployeeID
    FROM EmployeeDemographics
    WHERE Age > 30);