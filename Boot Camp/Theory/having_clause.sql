/*
In MySQL, we can use the `HAVING clause to filter the results of a query
(COUNT, `SUM, `AVG, etc.)HAVING clauseGROUP BY clause to

Here's theHAVING clause in

SELECT column1, aggregate_function(column2)
FROM table_name
GROUP BY column1
HAVING aggregate_function(column2) condition;

In this syntax:

- column1 is a column by which you are grouping the data.
- aggregate_function(column2) is an aggregate function applied to column2.
- table_name is the name of the table you are querying.
- condition is the condition that specifies which groups to include in the result set.
*/

SELECT JobTitle, COUNT(JobTitle)
FROM EmployeeDemographics
JOIN SQLAnalysys.EmployeeSalary ES on EmployeeDemographics.EmployeeID = ES.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle)  > 1;

SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
         JOIN SQLAnalysys.EmployeeSalary ES on EmployeeDemographics.EmployeeID = ES.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary)  > 45000
ORDER BY AVG(Salary)



