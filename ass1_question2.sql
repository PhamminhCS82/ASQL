
CREATE TABLE Department (
	Department_Number INT IDENTITY(1,1) PRIMARY KEY,
	Department_Name VARCHAR(50)
)

CREATE TABLE Employee_Table (
	Employee_Number INT IDENTITY(1,1) PRIMARY KEY, 
	Employee_Name VARCHAR(50), 
	Department_Number INT
	FOREIGN KEY (Department_Number) REFERENCES Department (Department_Number)
)

CREATE TABLE Employee_Skill_Table (
	Employee_Number INT,
	Skill_Code VARCHAR(10),
	Date_Registered date,
	PRIMARY KEY (Employee_Number, Skill_Code),
	FOREIGN KEY (Employee_Number) REFERENCES Employee_Table (Employee_Number)
)

INSERT INTO Department(Department_Name)
VALUES ('Development'),
	('Human resource'),
	('Chairman')
	
INSERT INTO Employee_Table(Employee_Name, Department_Number)
VALUES ('Emp A3', 1),
	('Emp A1', 1),
	('Emp A2', 1),
	('Emp B', 1),
	('Emp C', 2),
	('Emp D', 3)

INSERT INTO Employee_Skill_Table(Employee_Number, Skill_Code, Date_Registered)
VALUES (1, 'C', '2021-04-12'),
	(2, 'Golang', '2022-06-20'),
	(4, 'C#', '2018-03-25')
--Use Join selection
SELECT et.Employee_Name
FROM dbo.Employee_Table et 
JOIN dbo.Employee_Skill_Table st
ON et.Employee_Number = st.Employee_Number 
AND st.Skill_Code = 'Java'
--Use Subquery
SELECT et.Employee_Name
FROM dbo.Employee_Table et
WHERE et.Employee_Number IN (
	SELECT st.Employee_Number
	FROM dbo.Employee_Skill_Table st
	WHERE st.Skill_Code = 'Java'
)

SELECT d.Department_Name, et.Employee_Number, et.Employee_Name
FROM dbo.Employee_Table et 
INNER JOIN dbo.Department d ON et.Department_Number = d.Department_Number
AND et.Department_Number IN(SELECT et.Department_Number
	FROM dbo.Employee_Table et
	GROUP BY et.Department_Number
	HAVING COUNT(et.Department_Number) >= 3
	)

SELECT et.Employee_Number, et.Employee_Name
FROM dbo.Employee_Table et
WHERE et.Employee_Number IN (
	SELECT st.Employee_Number
	FROM dbo.Employee_Skill_Table st
	GROUP BY st.Employee_Number
	HAVING COUNT (st.Employee_Number) >= 2
	)
GO
CREATE VIEW EmployeeHaveMultipleSkill AS (
SELECT et.Employee_Number, et.Employee_Name, d.Department_Name
FROM dbo.Employee_Table et
INNER JOIN dbo.Department d ON d.Department_Number = et.Department_Number
AND et.Employee_Number IN (
	SELECT st.Employee_Number
	FROM dbo.Employee_Skill_Table st
	GROUP BY st.Employee_Number
	HAVING COUNT(st.Employee_Number) >= 2
	)
)
GO