# DDL commands

create database if not exists cityhospitalDB;
use cityhospitalDB;
drop database cityhospitalDB; 
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(100) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    AdmissionDate DATE
);

desc patients;

ALTER TABLE Patients ADD DoctorAssigned VARCHAR(50);

ALTER TABLE Patients MODIFY PatientName VARCHAR(100);

ALTER TABLE Patients RENAME TO Patient_Info;

TRUNCATE TABLE Patient_Info;

desc Patient_Info;


## Constraints

# Primary key


CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    ISBN VARCHAR(20)
);

# Foreign key
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    );
    
    
INSERT INTO Orders (OrderID)
VALUES
(1),
(2),
(3),
(4),
(5);    

ALTER TABLE Books ADD CONSTRAINT UQ_ISBN UNIQUE (ISBN);

DELETE FROM Orders WHERE OrderID =3;

desc Orders;

TRUNCATE TABLE Orders;

desc Orders;


## Clauses and operators

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Dept VARCHAR(50),
    Course VARCHAR(50),
    StudentName VARCHAR(100) NOT NULL,
    GPA DECIMAL(3,2),
    EmailAddress VARCHAR(100)
);

INSERT INTO Students (StudentID, Dept, Course, StudentName, GPA, EmailAddress)
VALUES
(1, 'Computer Science', 'Database Systems', 'Alice Johnson', 3.75, 'alice.johnson@univ.edu'),
(2, 'Mathematics', 'Linear Algebra', 'Ravi Kumar', 3.40, NULL),
(3, 'Physics', 'Quantum Mechanics', 'Lakshmi Narayanan', 3.90, 'lakshmi.narayanan@univ.edu'),
(4, 'English', 'Literature Studies', 'Meena Subramanian', 3.25, NULL),
(5, 'Biology', 'Genetics', 'Arun Prakash', 3.60, 'arun.prakash@univ.edu');

desc Students;

select * from students;

SELECT DISTINCT Dept
FROM Students;

#Students with NULL emails

SELECT StudentID, StudentName
FROM Students
WHERE EmailAddress IS NULL;

# Students with NOT NULL emails

SELECT StudentID, StudentName, EmailAddress
FROM Students
WHERE EmailAddress IS NOT NULL;

SELECT StudentID, StudentName, GPA
FROM Students
WHERE GPA BETWEEN 3.50 AND 3.80;

## Sorting and aggregation

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2)
);

INSERT INTO Products (ProductID, ProductName, Price)
VALUES
(1, 'Laptop', 75000.00),
(2, 'Smartphone', 45000.00),
(3, 'Headphones', 3000.00),
(4, 'Smartwatch', 12000.00),
(5, 'Tablet', 25000.00);

select * from products;

select ProductID, ProductName, Price
from Products
order by Price DESC;
limit 3;

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Amount DECIMAL(10,2),
    SaleDate DATE
);

INSERT INTO Sales (SaleID, ProductID, Amount, SaleDate)
VALUES
(1, 1, 75000.00, '2026-01-10'),
(2, 2, 45000.00, '2026-01-12'),
(3, 3, 3000.00, '2026-01-15'),
(4, 4, 12000.00, '2026-01-20'),
(5, 5, 25000.00, '2026-01-25');

SELECT COUNT(*) AS TotalSales,
       SUM(Amount) AS TotalRevenue,
       AVG(Amount) AS AverageSale,
       MAX(Amount) AS HighestSale,
       MIN(Amount) AS LowestSale
FROM Sales;

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Dept VARCHAR(50)
);

INSERT INTO Employees (EmpID, EmpName, Dept)
VALUES
(1, 'Ravi Kumar', 'IT'),
(2, 'Lakshmi Narayanan', 'IT'),
(3, 'Meena Subramanian', 'HR'),
(4, 'Arun Prakash', 'HR'),
(5, 'Alice Johnson', 'Finance'),
(6, 'Bob Smith', 'Finance'),
(7, 'Charlie Brown', 'Finance'),
(8, 'Diana Prince', 'Finance'),
(9, 'Ethan Clark', 'Finance'),
(10, 'John Doe', 'Finance'),
(11, 'Jane Doe', 'Finance');

SELECT Dept, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY Dept
HAVING COUNT(*) > 10;

## Joins and Union
drop table students_1;
CREATE TABLE Students_1(StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    CourseID INT  
);

drop table Courses;
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100)
);

INSERT INTO Students_1 (StudentID, StudentName, CourseID)
VALUES
(1, 'Ravi Kumar', 101),
(2, 'Lakshmi Narayanan', 102),
(3, 'Meena Subramanian', 103),
(4, 'Arun Prakash', NULL),   -- no course
(5, 'Alice Johnson', 101);

INSERT INTO Courses (CourseID, CourseName)
VALUES
(101, 'Database Systems'),
(102, 'Linear Algebra'),
(103, 'Quantum Mechanics'),
(104, 'Literature Studies');

SELECT s.StudentID, s.StudentName, c.CourseName
FROM Students_1 s
INNER JOIN Courses c
ON s.CourseID = c.CourseID;

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT
);


INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID)
VALUES
(1, 1, 101),
(2, 2, 102),
(3, 3, 103);

SELECT s.StudentID, s.StudentName, e.CourseID
FROM Students_1 s
LEFT JOIN Enrollments e
ON s.StudentID = e.StudentID;

    
SELECT s.StudentID, s.StudentName, e.CourseID
FROM Students_1 s
RIGHT JOIN Enrollments e
ON s.StudentID = e.StudentID;


## Union and Union all

CREATE TABLE CurrentEmployees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100)
);


CREATE TABLE PastEmployees (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100)
);


INSERT INTO CurrentEmployees (EmpID, EmpName)
VALUES
(1, 'Ravi Kumar'),
(2, 'Alice Johnson'),
(3, 'Bob Smith');

INSERT INTO PastEmployees (EmpID, EmpName)
VALUES
(101, 'Alice Johnson'),  
(102, 'Charlie Brown'),
(103, 'Diana Prince');

-- UNION 
SELECT EmpName FROM CurrentEmployees
UNION
SELECT EmpName FROM PastEmployees;

-- UNION ALL 
SELECT EmpName FROM CurrentEmployees
UNION ALL
SELECT EmpName FROM PastEmployees;

## String Functions

CREATE TABLE Employees_1 (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    HireDate DATE
);

INSERT INTO Employees_1 (EmpID, FirstName, LastName, HireDate)
VALUES
(1, 'Ravi', 'Kumar', '2018-06-15'),
(2, 'Lakshmi', 'Narayanan', '2020-01-10'),
(3, 'Meena', 'Subramanian', '2015-09-05'),
(4, 'Arun', 'Prakash', '2012-03-20'),
(5, 'Karthik', 'Rajendran', '2021-11-01');

-- Upper
SELECT EmpID, UPPER(FirstName) AS UpperFirst, UPPER(LastName) AS UpperLast
FROM Employees_1;

-- Lower
SELECT EmpID, LOWER(FirstName) AS LowerFirst, LOWER(LastName) AS LowerLast
FROM Employees_1;

-- Substring (first 3 letters of FirstName)
SELECT EmpID, SUBSTRING(FirstName, 1, 3) AS ShortName
FROM Employees_1;

-- Concatenate FirstName + LastName
SELECT EmpID, CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees_1;


SELECT EmpID, FirstName, LastName,
       YEAR(NOW()) - YEAR(HireDate) AS TenureYears
FROM Employees_1;

# DATEDIFF
SELECT EmpID, FirstName, LastName,
       DATEDIFF(NOW(), HireDate) / 365 AS TenureYears
FROM Employees_1;

# User defined function(UDF)

DELIMITER //
CREATE FUNCTION GetFullName(FirstName VARCHAR(50), LastName VARCHAR(50))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN CONCAT(FirstName, ' ', LastName);
END //
DELIMITER ;

SELECT GetFullName(FirstName, LastName) AS FullName
FROM Employees_1;

## Procedures and Views

CREATE TABLE Employeess (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DeptID INT,
    HireDate DATE
);

INSERT INTO Employeess (EmpID, FirstName, LastName, DeptID, HireDate)
VALUES
(1, 'Ravi', 'Kumar', 10, '2018-06-15'),
(2, 'Lakshmi', 'Narayanan', 20, '2020-01-10'),
(3, 'Meena', 'Subramanian', 30, '2015-09-05'),
(4, 'Arun', 'Prakash', 20, '2012-03-20'),
(5, 'Karthik', 'Rajendran', 10, '2021-11-01');

CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50)
);

INSERT INTO Departments (DeptID, DeptName)
VALUES
(10, 'IT'),
(20, 'HR'),
(30, 'Finance');

CREATE TABLE Salary (
    SalaryID INT PRIMARY KEY,
    EmpID INT,
    SalaryAmount DECIMAL(10,2)
);

INSERT INTO Salary (SalaryID, EmpID, SalaryAmount)
VALUES
(1, 1, 55000.00),
(2, 2, 48000.00),
(3, 3, 62000.00),
(4, 4, 70000.00),
(5, 5, 45000.00);

DELIMITER //
CREATE PROCEDURE GetEmployeeByID(IN emp_id INT)
BEGIN
    SELECT EmpID, FirstName, LastName, DeptID, HireDate
    FROM Employeess
    WHERE EmpID = emp_id;
END //
DELIMITER ;

CREATE VIEW EmployeeDeptView AS
SELECT e.EmpID,
       CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
       d.DeptName
FROM Employeess e
JOIN Departments d
    ON e.DeptID = d.DeptID;


SELECT * FROM EmployeeDeptView;


# Complex view

CREATE VIEW EmployeeDetailsView AS
SELECT e.EmpID,
       CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
       d.DeptName,
       s.SalaryAmount,
       e.HireDate
FROM Employeess e
JOIN Departments d
    ON e.DeptID = d.DeptID
JOIN Salary s
    ON e.EmpID = s.EmpID;


SELECT * FROM EmployeeDetailsView;

## Triggers and Transaction

CREATE TABLE Orders_1 (
    OrderID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Quantity INT
);

INSERT INTO Orders_1 (OrderID, ProductName, Quantity)
VALUES
(1, 'Laptop', 2),
(2, 'Smartphone', 5),
(3, 'Headphones', 10),
(4, 'Smartwatch', 3),
(5, 'Tablet', 4);

CREATE TABLE Order_History (
    OrderID INT,
    ProductName VARCHAR(100),
    Quantity INT,
    DeletedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER //
CREATE TRIGGER LogOrderDeletion
AFTER DELETE ON Orders_1
FOR EACH ROW
BEGIN
    INSERT INTO Order_History (OrderID, ProductName, Quantity)
    VALUES (OLD.OrderID, OLD.ProductName, OLD.Quantity);
END //
DELIMITER ;


DELETE FROM Orders_1 WHERE OrderID = 3;

SELECT * FROM Order_History;

## TCL
START TRANSACTION;

-- Deduct from sender 
UPDATE Accounts
SET Balance = Balance - 5000
WHERE AccountID = 101;

-- Add to receiver account
UPDATE Accounts
SET Balance = Balance + 5000
WHERE AccountID = 202;

-- Set a savepoint
SAVEPOINT TransferStep;

-- If everything is fine, commit
COMMIT;

-- If something goes wrong, rollback to savepoint
-- ROLLBACK TO TransferStep;

-- Or rollback entire transaction
-- ROLLBACK;





