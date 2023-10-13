/*
Group By and Order By
*/

-- Query 1: Count the occurrences of each gender in the EmployeeDemographics table and display the result.
SELECT Gender, COUNT(*) AS GenderCount
FROM EmployeeDemographics
GROUP BY Gender;

-- Query 2: Same as Query 1 but repeats the same aggregation without any additional filtering.
SELECT Gender, COUNT(*) AS GenderCount
FROM EmployeeDemographics
GROUP BY Gender;

-- Query 3: Count the occurrences of each gender in the EmployeeDemographics table for employees over 30 years old.
SELECT Gender, COUNT(*) AS GenderCount
FROM EmployeeDemographics
WHERE Age > 30
GROUP BY Gender;

-- Query 4: Same as Query 3 but orders the results by Gender in ascending order.
SELECT Gender, COUNT(*) AS GenderCount
FROM EmployeeDemographics
WHERE Age > 30
GROUP BY Gender
ORDER BY Gender;

-- Query 5: Same as Query 4 but orders the results by Gender in descending order.
SELECT Gender, COUNT(*) AS GenderCount
FROM EmployeeDemographics
WHERE Age > 30
GROUP BY Gender
ORDER BY Gender DESC;

-- Query 6: Retrieve all records from the EmployeeDemographics table and order them by Age in ascending order.
SELECT *
FROM EmployeeDemographics
ORDER BY Age;

-- Query 7: Retrieve all records from the EmployeeDemographics table and order them by Age in descending order.
SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC;

-- Query 8: Retrieve all records from the EmployeeDemographics table and order them by Age in ascending order, then by Gender in descending order.
SELECT *
FROM EmployeeDemographics
ORDER BY Age, Gender DESC;

-- Query 9: Retrieve all records from the EmployeeDemographics table and order them by Age in descending order, then by Gender in descending order.
SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC, Gender DESC;

-- Query 10: Retrieve all records from the EmployeeDemographics table and order them by the 4th column (presumably an unnamed column) in descending order, and then by the 5th column (also unnamed) in descending order.
SELECT *
FROM EmployeeDemographics
ORDER BY 4 DESC, 5 DESC;
