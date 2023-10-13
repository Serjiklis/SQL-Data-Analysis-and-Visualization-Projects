-- Temp Tables

-- Create a temporary table
CREATE TEMPORARY TABLE temp_Employee (
    EmployeeID INT,
    JobTitle VARCHAR(100),
    Salary INT
);

INSERT INTO temp_Employee(EmployeeID, JobTitle,Salary)
VALUES
    (1001, 'Salesman', 45000),
    (1002, 'Receptionist', 36000),
    (1003, 'Salesman', 63000),
    (1004, 'Accountant', 47000),
    (1005, 'HR', 50000),
    (1006, 'Regional Manager', 65000),
    (1007, 'Supplier Relations', 41000),
    (1008, 'Salesman', 48000),
    (1009, 'Accountant', 42000);

SELECT *
FROM temp_Employee;


CREATE TEMPORARY TABLE temp_EmployeeDemografics (
     EmployeeID int,
     FirstName varchar(50),
     LastName varchar(50),
     Age int,
     Gender varchar(50)
);

INSERT INTO temp_EmployeeDemografics
SELECT *
FROM EmployeeDemographics;

SELECT *
FROM temp_EmployeeDemografics;

DROP TABLE IF EXISTS temp_Employee2;

CREATE TEMPORARY TABLE temp_Employee2 (
     JobTitle VARCHAR(50),
     EmploeesPerJob INT,
     AvgAge INT,
     AVGSalary INT
);

SELECT *
FROM temp_Employee2;


INSERT INTO temp_Employee2 (JobTitle, EmploeesPerJob,  AvgAge, AVGSalary)
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographics ED
JOIN EmployeeSalary ES ON ED.EmployeeID = ES.EmployeeID
GROUP BY JobTitle;

SELECT *
FROM temp_Employee2;




# DROP TABLE temp_EmployeeDemografics;
# DROP TABLE temp_Employee;
# DROP TABLE temp_Employee2;


