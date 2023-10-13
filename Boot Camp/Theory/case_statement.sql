/*
A CASE statement in MySQL is used to perform conditional logic within a SQL query.
It allows you to execute different actions or return different values based on specified conditions.
The CASE statement can be used in both SELECT and UPDATE queries.
*/
SELECT
    JobTitle,
    salary,
    CASE
        WHEN salary >= 50000 THEN 'High'
        WHEN salary >= 40000 THEN 'Moderate'
        ELSE 'Low'
        END AS salary_category
FROM EmployeeSalary;

/*
CASE Statement:

The CASE statement is used to perform conditional logic within the query.
It begins with CASE and ends with END.
Inside the CASE statement, there are multiple WHEN clauses, each defining a condition to be evaluated.

WHEN Clauses:

Each WHEN clause specifies a condition to be checked against the salary column in the EmployeeSalary table.
If a condition is met, the corresponding result is returned.
In this query, there are three WHEN clauses with the following conditions:
    WHEN salary is greater than or equal to 50000, THEN it is categorized as 'High.'
    WHEN salary is greater than or equal to 40000, THEN it is categorized as 'Moderate.'
    Otherwise, ELSE it is categorized as 'Low.'
*/

SELECT
    EmployeeID,
    FirstName,
    Age
FROM EmployeeDemographics
WHERE CASE
          WHEN Age >= 32 THEN 1
          ELSE 0
          END = 1;
/*
WHERE Clause with CASE Statement:

WHERE CASE WHEN Age >= 32 THEN 1 ELSE 0 END = 1;
This is the WHERE clause of the query, and it includes a CASE statement to filter the rows based on a condition.

The CASE statement is evaluating the condition Age >= 32.
If an employee's age is greater than or equal to 32, it assigns the value 1; otherwise, it assigns 0.

The CASE statement effectively creates a new temporary column with values 1 or 0 for each row based on the condition.

The WHERE clause filters the rows where the result of the CASE statement is equal to 1.
This means it will only select rows where the employee's age is greater than or equal to 32.
*/

SELECT FirstName, LastName, Age,
CASE
    WHEN Age >30 THEN 'Old'
    ELSE 'Young'
END as AgeCategory
FROM EmployeeDemographics
WHERE Age is not null
ORDER BY Age;

SELECT FirstName, LastName, Age,
       CASE
           WHEN Age >30 THEN 'Old'
           WHEN Age BETWEEN 27 and 30 THEN 'Young'
           ELSE 'Baby'
           END as AgeCategory
FROM EmployeeDemographics
WHERE Age is not null
ORDER BY Age;

# Option 1
SELECT FirstName, LastName, Age,
       CASE
           WHEN Age >30 THEN 'Old'
           WHEN Age BETWEEN 27 and 30 THEN 'Young'
           WHEN Age = 38 THEN 'Palmer'
           ELSE 'Baby'
           END as AgeCategory
FROM EmployeeDemographics
WHERE Age is not null
ORDER BY Age;

# Option 2
SELECT
    FirstName,
    LastName,
    Age,
    CASE
        WHEN Age = 38 THEN 'Palmer'
        WHEN Age > 30 THEN 'Old'
        WHEN Age BETWEEN 27 AND 30 THEN 'Young'
        ELSE 'Baby'
    END AS AgeCategory
FROM EmployeeDemographics
WHERE Age IS NOT NULL
ORDER BY Age;

/*
In Option 1 (Original), the conditions are evaluated in the order they appear.
If an employee's age is greater than 30, it falls into the 'Old' category, and the subsequent conditions,
including WHEN Age = 38 THEN 'Palmer', are not checked.
This means that an employee aged 38 will be categorized as 'Old' instead of 'Palmer.'

In Option 2 (Modified), the conditions have been rearranged so that the condition for age 38 (WHEN Age = 38) is checked first.
If an employee's age is exactly 38, they will be categorized as 'Palmer'.
If that condition is not met, the query proceeds to evaluate the other conditions.
This ensures that age 38 is handled independently before the 'Old' category is assigned to older ages.
*/

SELECT FirstName,LastName, JobTitle, Salary,
CASE
    WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
    WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
    WHEN JobTitle = 'HR' THEN Salary + (Salary * .001)
    ELSE Salary + (Salary * 0.3)
END as SalaryAfterRaise
FROM EmployeeDemographics
JOIN EmployeeSalary
    ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
