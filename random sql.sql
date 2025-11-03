USE CorporateAnalytics;
-- Tabella dipendenti
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    HireDate DATE,
    Salary DECIMAL(10,2)
);

-- Tabella dipartimenti
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- Tabella performance annuali
CREATE TABLE PerformanceReviews (
    ReviewID INT PRIMARY KEY,
    EmployeeID INT,
    ReviewYear INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Bonus DECIMAL(10,2)
);
-- Crea il database se non esiste
CREATE DATABASE IF NOT EXISTS CorporateAnalytics;

-- Seleziona il database
USE CorporateAnalytics;
CREATE DATABASE IF NOT EXISTS CorporateAnalytics;
USE CorporateAnalytics;
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100) NOT NULL,
    Budget DECIMAL(12,2) NOT NULL
);
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    HireDate DATE NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    ManagerID INT,
    JobTitle VARCHAR(100),
    IsActive BOOLEAN DEFAULT TRUE,
    LastPromotionDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);
SHOW TABLES;
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
CREATE TABLE ProjectAssignments (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    ProjectID INT,
    Role VARCHAR(50),
    HoursWorked INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);
INSERT INTO Departments (DepartmentName, Budget)
VALUES 
('HR', 50000.00),
('IT', 120000.00),
('Finance', 80000.00);
INSERT INTO Employees (FirstName, LastName, DepartmentID, HireDate, Salary, ManagerID, JobTitle, LastPromotionDate)
VALUES 
('Alice', 'Rossi', 3, '2018-03-15', 55000, NULL, 'Finance Manager', '2022-01-10'),
('Marco', 'Bianchi', 3, '2019-07-01', 48000, 1, 'Analyst', '2023-06-01'),
('Laura', 'Verdi', 1, '2020-02-20', 47000, NULL, 'HR Manager', '2022-11-15'),
('Giulia', 'Neri', 1, '2021-05-10', 42000, 3, 'HR Assistant', '2023-03-01'),
('Luca', 'Ferrari', 2, '2017-09-01', 60000, NULL, 'IT Lead', '2021-12-01');
INSERT INTO PerformanceReviews (EmployeeID, ReviewYear, Rating, Bonus)
VALUES 
(2, 2023, 4, 1500),
(2, 2024, 5, 1800),
(4, 2023, 3, 1200),
(4, 2024, 4, 1300),
(5, 2023, 5, 2000),
(5, 2024, 5, 2200);
INSERT INTO Projects (ProjectName, DepartmentID, StartDate, EndDate)
VALUES 
('ERP Migration', 2, '2023-01-01', '2023-12-31'),
('HR Onboarding', 1, '2023-03-01', '2023-09-30'),
('Budget Optimization', 3, '2023-05-01', '2023-11-30');
INSERT INTO ProjectAssignments (EmployeeID, ProjectID, Role, HoursWorked)
VALUES 
(2, 3, 'Analyst', 120),
(4, 2, 'Coordinator', 100),
(5, 1, 'Lead Developer', 160),
(1, 3, 'Supervisor', 80),
(3, 2, 'HR Manager', 90);
WITH RecentPerformance AS (
    SELECT 
        EmployeeID,
        AVG(Rating) AS AvgRating,
        SUM(Bonus) AS TotalBonus
    FROM PerformanceReviews
    WHERE ReviewYear >= YEAR(CURDATE()) - 2
    GROUP BY EmployeeID
),
ProjectHours AS (
    SELECT 
        pa.EmployeeID,
        pa.ProjectID,
        SUM(pa.HoursWorked) AS TotalHours
    FROM ProjectAssignments pa
    JOIN Projects p ON pa.ProjectID = p.ProjectID
    WHERE p.EndDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    GROUP BY pa.EmployeeID, pa.ProjectID
),
DepartmentBudgetImpact AS (
    SELECT 
        d.DepartmentID,
        d.DepartmentName,
        d.Budget,
        SUM(e.Salary) AS TotalSalaries,
        ROUND(SUM(e.Salary) / d.Budget, 2) AS SalaryToBudgetRatio
    FROM Departments d
    JOIN Employees e ON d.DepartmentID = e.DepartmentID
    GROUP BY d.DepartmentID, d.DepartmentName, d.Budget
),
FinalReport AS (
    SELECT 
        e.EmployeeID,
        CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
        d.DepartmentName,
        dbi.SalaryToBudgetRatio,
        rp.AvgRating,
        rp.TotalBonus,
        ph.TotalHours,
        p.ProjectName,
        RANK() OVER (PARTITION BY p.ProjectID ORDER BY ph.TotalHours DESC) AS ProjectRank
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    JOIN DepartmentBudgetImpact dbi ON d.DepartmentID = dbi.DepartmentID
    JOIN RecentPerformance rp ON e.EmployeeID = rp.EmployeeID
    JOIN ProjectHours ph ON e.EmployeeID = ph.EmployeeID
    JOIN Projects p ON ph.ProjectID = p.ProjectID
    WHERE rp.AvgRating >= 4.0
      AND dbi.SalaryToBudgetRatio < 0.75
)
SELECT *
FROM FinalReport
WHERE ProjectRank <= 3
ORDER BY ProjectName, ProjectRank, AvgRating DESC;
CREATE OR REPLACE VIEW vw_TopProjectContributors AS
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    d.DepartmentName,
    ROUND(SUM(e.Salary) / d.Budget, 2) AS SalaryToBudgetRatio,
    AVG(pr.Rating) AS AvgRating,
    SUM(pr.Bonus) AS TotalBonus,
    SUM(pa.HoursWorked) AS TotalHours,
    MAX(p.ProjectName) AS ProjectName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN PerformanceReviews pr ON e.EmployeeID = pr.EmployeeID
JOIN ProjectAssignments pa ON e.EmployeeID = pa.EmployeeID
JOIN Projects p ON pa.ProjectID = p.ProjectID
WHERE pr.ReviewYear >= YEAR(CURDATE()) - 2
  AND p.EndDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY e.EmployeeID, FullName, d.DepartmentName, d.Budget
HAVING AvgRating >= 4.0
   AND SalaryToBudgetRatio < 0.75;
   CREATE OR REPLACE VIEW vw_EmployeePerformanceSummary AS
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    e.JobTitle,
    d.DepartmentName,
    d.Budget,
    ROUND(SUM(e.Salary) / d.Budget, 2) AS SalaryToBudgetRatio,
    
    -- Performance
    AVG(pr.Rating) AS AvgRating,
    SUM(pr.Bonus) AS TotalBonus,
    
    -- Progetti
    SUM(pa.HoursWorked) AS TotalHoursWorked,
    MAX(p.ProjectName) AS MostRecentProject,
    
    -- Stato
    e.IsActive,
    TIMESTAMPDIFF(YEAR, e.HireDate, CURDATE()) AS TenureYears,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, e.LastPromotionDate, CURDATE()) >= 3 THEN 'Eligible for Promotion'
        ELSE 'Recently Promoted'
    END AS PromotionStatus
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN PerformanceReviews pr ON e.EmployeeID = pr.EmployeeID AND pr.ReviewYear >= YEAR(CURDATE()) - 2
LEFT JOIN ProjectAssignments pa ON e.EmployeeID = pa.EmployeeID
LEFT JOIN Projects p ON pa.ProjectID = p.ProjectID AND p.EndDate >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY e.EmployeeID, FullName, e.JobTitle, d.DepartmentName, d.Budget, e.IsActive, e.HireDate, e.LastPromotionDate
HAVING AvgRating >= 3.5 AND SalaryToBudgetRatio < 0.75;
CREATE OR REPLACE VIEW vw_DepartmentSummary AS
SELECT 
    d.DepartmentID,
    d.DepartmentName,
    d.Budget,
    
    COUNT(DISTINCT e.EmployeeID) AS NumEmployees,
    ROUND(AVG(e.Salary), 2) AS AvgSalary,
    ROUND(SUM(e.Salary), 2) AS TotalSalaries,
    
    ROUND(SUM(pr.Bonus), 2) AS TotalBonus,
    ROUND(AVG(pr.Rating), 2) AS AvgRating,
    
    ROUND(SUM(pa.HoursWorked), 2) AS TotalHoursWorked,
    
    CASE 
        WHEN SUM(e.Salary) > d.Budget THEN 'Over Budget'
        WHEN SUM(e.Salary) / d.Budget > 0.75 THEN 'Near Saturation'
        ELSE 'Healthy'
    END AS BudgetStatus
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
LEFT JOIN PerformanceReviews pr ON e.EmployeeID = pr.EmployeeID AND pr.ReviewYear >= YEAR(CURDATE()) - 2
LEFT JOIN ProjectAssignments pa ON e.EmployeeID = pa.EmployeeID
GROUP BY d.DepartmentID, d.DepartmentName, d.Budget;
SELECT 
    d.DepartmentName,
    e.JobTitle,
    COUNT(e.EmployeeID) AS NumEmployees,
    ROUND(AVG(e.Salary), 2) AS AvgSalary,
    ROUND(SUM(pr.Bonus), 2) AS TotalBonus
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN PerformanceReviews pr ON e.EmployeeID = pr.EmployeeID
GROUP BY d.DepartmentName, e.JobTitle
ORDER BY d.DepartmentName, NumEmployees DESC;
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    e.JobTitle,
    e.HireDate,
    TIMESTAMPDIFF(YEAR, e.HireDate, CURDATE()) AS TenureYears,
    e.Salary,
    e.IsActive,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, e.LastPromotionDate, CURDATE()) >= 3 THEN 'Eligible for Promotion'
        ELSE 'Recently Promoted'
    END AS PromotionStatus,
    
    -- Dipartimento
    d.DepartmentName,
    d.Budget,
    ROUND(e.Salary / d.Budget, 2) AS SalaryToBudgetRatio,
    
    -- Performance
    pr.ReviewYear,
    pr.Rating,
    pr.Bonus,
    
    -- Progetti
    p.ProjectName,
    p.StartDate,
    p.EndDate,
    pa.Role,
    pa.HoursWorked
    
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN PerformanceReviews pr ON e.EmployeeID = pr.EmployeeID
LEFT JOIN ProjectAssignments pa ON e.EmployeeID = pa.EmployeeID
LEFT JOIN Projects p ON pa.ProjectID = p.ProjectID

ORDER BY e.EmployeeID, pr.ReviewYear, p.ProjectName;
CREATE OR REPLACE VIEW vw_FullEmployeeOverview AS
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    e.JobTitle,
    e.HireDate,
    TIMESTAMPDIFF(YEAR, e.HireDate, CURDATE()) AS TenureYears,
    e.Salary,
    e.IsActive,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, e.LastPromotionDate, CURDATE()) >= 3 THEN 'Eligible for Promotion'
        ELSE 'Recently Promoted'
    END AS PromotionStatus,

    -- Dipartimento
    d.DepartmentName,
    d.Budget,
    ROUND(e.Salary / d.Budget, 2) AS SalaryToBudgetRatio,

    -- Performance
    pr.ReviewYear,
    pr.Rating,
    pr.Bonus,

    -- Progetti
    p.ProjectName,
    p.StartDate AS ProjectStart,
    p.EndDate AS ProjectEnd,
    pa.Role AS ProjectRole,
    pa.HoursWorked AS ProjectHours

FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN PerformanceReviews pr ON e.EmployeeID = pr.EmployeeID
LEFT JOIN ProjectAssignments pa ON e.EmployeeID = pa.EmployeeID
LEFT JOIN Projects p ON pa.ProjectID = p.ProjectID;
SELECT * FROM vw_FullEmployeeOverview
WHERE IsActive = TRUE AND Rating >= 4;
SELECT ProjectName, SUM(ProjectHours) AS TotalHours
FROM vw_FullEmployeeOverview
GROUP BY ProjectName
ORDER BY TotalHours DESC;
SELECT * FROM vw_FullEmployeeOverview
WHERE SalaryToBudgetRatio > 0.75;
SELECT * FROM vw_FullEmployeeOverview
WHERE SalaryToBudgetRatio > 0.75;
ALTER TABLE Projects
ADD EstimatedRevenue DECIMAL(12,2);
UPDATE Projects
SET EstimatedRevenue = 
    CASE ProjectName
        WHEN 'ERP Migration' THEN 150000
        WHEN 'HR Onboarding' THEN 60000
        WHEN 'Budget Optimization' THEN 90000
        ELSE 50000
    END;
    CREATE OR REPLACE VIEW vw_ProjectOverview AS
SELECT 
    p.ProjectID,
    p.ProjectName,
    p.StartDate,
    p.EndDate,
    d.DepartmentName,
    p.EstimatedRevenue,
    COUNT(DISTINCT pa.EmployeeID) AS NumContributors,
    SUM(pa.HoursWorked) AS TotalHoursWorked,
    ROUND(p.EstimatedRevenue / NULLIF(SUM(pa.HoursWorked), 0), 2) AS RevenuePerHour
FROM Projects p
LEFT JOIN Departments d ON p.DepartmentID = d.DepartmentID
LEFT JOIN ProjectAssignments pa ON p.ProjectID = pa.ProjectID
GROUP BY p.ProjectID, p.ProjectName, p.StartDate, p.EndDate, d.DepartmentName, p.EstimatedRevenue;
SELECT * FROM vw_ProjectOverview
WHERE RevenuePerHour < 500;
SELECT * FROM vw_ProjectOverview
WHERE TotalHoursWorked > 100;
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    e.JobTitle,
    e.HireDate,
    TIMESTAMPDIFF(YEAR, e.HireDate, CURDATE()) AS TenureYears,
    e.Salary,
    e.IsActive,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, e.LastPromotionDate, CURDATE()) >= 3 THEN 'Eligible for Promotion'
        ELSE 'Recently Promoted'
    END AS PromotionStatus,

    -- Dipartimento
    d.DepartmentID,
    d.DepartmentName,
    d.Budget,
    ROUND(e.Salary / d.Budget, 2) AS SalaryToBudgetRatio,

    -- Performance
    pr.ReviewID,
    pr.ReviewYear,
    pr.Rating,
    pr.Bonus,

    -- Progetti
    p.ProjectID,
    p.ProjectName,
    p.StartDate AS ProjectStart,
    p.EndDate AS ProjectEnd,
    p.EstimatedRevenue,
    pa.AssignmentID,
    pa.Role AS ProjectRole,
    pa.HoursWorked AS ProjectHours,
    ROUND(p.EstimatedRevenue / NULLIF(pa.HoursWorked, 0), 2) AS RevenuePerHour

FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN PerformanceReviews pr ON e.EmployeeID = pr.EmployeeID
LEFT JOIN ProjectAssignments pa ON e.EmployeeID = pa.EmployeeID
LEFT JOIN Projects p ON pa.ProjectID = p.ProjectID

ORDER BY e.EmployeeID, pr.ReviewYear, p.ProjectName;
INSERT INTO Departments (DepartmentName, Budget)
VALUES 
('HR', 50000.00),
('IT', 120000.00),
('Finance', 80000.00);
INSERT INTO Employees (FirstName, LastName, DepartmentID, HireDate, Salary, ManagerID, JobTitle, IsActive, LastPromotionDate)
VALUES 
('Alice', 'Rossi', 3, '2018-03-15', 55000, NULL, 'Finance Manager', TRUE, '2022-01-10'),
('Marco', 'Bianchi', 3, '2019-07-01', 48000, 1, 'Analyst', TRUE, '2023-06-01'),
('Laura', 'Verdi', 1, '2020-02-20', 47000, NULL, 'HR Manager', TRUE, '2022-11-15'),
('Giulia', 'Neri', 1, '2021-05-10', 42000, 3, 'HR Assistant', TRUE, '2023-03-01'),
('Luca', 'Ferrari', 2, '2017-09-01', 60000, NULL, 'IT Lead', TRUE, '2021-12-01');
INSERT INTO Projects (ProjectName, DepartmentID, StartDate, EndDate, EstimatedRevenue)
VALUES 
('ERP Migration', 2, '2023-01-01', '2023-12-31', 150000),
('HR Onboarding', 1, '2023-03-01', '2023-09-30', 60000),
('Budget Optimization', 3, '2023-05-01', '2023-11-30', 90000),
('Cloud Integration', 2, '2024-01-15', '2024-08-15', 180000);
INSERT INTO ProjectAssignments (EmployeeID, ProjectID, Role, HoursWorked)
VALUES 
(2, 3, 'Analyst', 120),
(4, 2, 'Coordinator', 100),
(5, 1, 'Lead Developer', 160),
(1, 3, 'Supervisor', 80),
(3, 2, 'HR Manager', 90),
(5, 4, 'Cloud Architect', 140),
(2, 4, 'Integration Analyst', 100),
(1, 1, 'Finance Lead', 60);
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    e.JobTitle,
    e.HireDate,
    TIMESTAMPDIFF(YEAR, e.HireDate, CURDATE()) AS TenureYears,
    e.Salary,
    e.IsActive,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, e.LastPromotionDate, CURDATE()) >= 3 THEN 'Eligible for Promotion'
        ELSE 'Recently Promoted'
    END AS PromotionStatus,

    -- Dipartimento
    d.DepartmentID,
    d.DepartmentName,
    d.Budget,
    ROUND(e.Salary / d.Budget, 2) AS SalaryToBudgetRatio,

    -- Performance
    pr.ReviewID,
    pr.ReviewYear,
    pr.Rating,
    pr.Bonus,

    -- Progetti
    p.ProjectID,
    p.ProjectName,
    p.StartDate AS ProjectStart,
    p.EndDate AS ProjectEnd,
    p.EstimatedRevenue,
    pa.AssignmentID,
    pa.Role AS ProjectRole,
    pa.HoursWorked AS ProjectHours,
    ROUND(p.EstimatedRevenue / NULLIF(pa.HoursWorked, 0), 2) AS RevenuePerHour

FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID
LEFT JOIN PerformanceReviews pr ON e.EmployeeID = pr.EmployeeID
LEFT JOIN ProjectAssignments pa ON e.EmployeeID = pa.EmployeeID
LEFT JOIN Projects p ON pa.ProjectID = p.ProjectID

ORDER BY e.EmployeeID, pr.ReviewYear, p.ProjectName;