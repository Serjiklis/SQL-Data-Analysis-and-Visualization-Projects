-- Stored Procedures

DELIMITER //
CREATE PROCEDURE Test()
BEGIN
    SELECT *
    FROM EmployeeDemographics;
END //
DELIMITER ;

CALL Test();

DELIMITER //
CREATE PROCEDURE Temp_Employee()
BEGIN
    DROP TABLE IF EXISTS temp_Employee2;
    CREATE TEMPORARY TABLE temp_Employee2 (
         JobTitle VARCHAR(50),
         EmploeesPerJob INT,
         AvgAge INT,
         AVGSalary INT
    );
    INSERT INTO temp_Employee2 (JobTitle, EmploeesPerJob,  AvgAge, AVGSalary)
    SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
    FROM EmployeeDemographics ED
             JOIN EmployeeSalary ES ON ED.EmployeeID = ES.EmployeeID
    GROUP BY JobTitle;

    SELECT *
    FROM temp_Employee2;
END //
DELIMITER ;




CALL Temp_Employee('Salesman');

