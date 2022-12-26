-- Oracle Live SQL

-- Creating all required tables
-- DROP TABLE StudentGrades;
CREATE TABLE StudentGrades
(
SID INTEGER NOT NULL,
ClassName VARCHAR2(50) NOT NULL,
Grade VARCHAR2(1) NOT NULL,
PRIMARY KEY (SID, ClassName)
);

-- DROP TABLE ProfessorCourse;
CREATE TABLE ProfessorCourse
(
PID INTEGER NOT NULL,
ClassName VARCHAR2(50) NOT NULL,
PRIMARY KEY (PID, ClassName)
);

-- DROP TABLE HourlyRate;
CREATE TABLE HourlyRate
(
Type VARCHAR2(50) NOT NULL,
Rate DECIMAL(9,2) NOT NULL, 
PRIMARY KEY (Type)
);

-- inserting student courses data
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (123,'Synthesis algorithms','A');
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (123,'EDM synthesis','B');
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (123,'MIDI controllers','B');
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (662,'Sound mixing','B');
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (662,'EDM synthesis','A');
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (662,'Electronic Music Fundamentals','A');
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (662,'MIDI controllers','B');
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (345,'MIDI controllers','A');
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (345,'Electronic Music Fundamentals','B');
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (345,'EDM synthesis','A');
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (555,'EDM synthesis','B');
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (555,'Electronic Music Fundamentals','B');
INSERT INTO StudentGrades(SID,ClassName,Grade) VALUES (213,'Electronic Music Fundamentals','A');

-- inserting professor courses data
INSERT INTO ProfessorCourse(PID,ClassName) VALUES(101,'Synthesis algorithms');
INSERT INTO ProfessorCourse(PID,ClassName) VALUES(101,'EDM synthesis');
INSERT INTO ProfessorCourse(PID,ClassName) VALUES(102,'Synthesis algorithms');
INSERT INTO ProfessorCourse(PID,ClassName) VALUES(103,'MIDI controllers');
INSERT INTO ProfessorCourse(PID,ClassName) VALUES(104,'Electronic Music Fundamentals');

-- inserting hourly rate for teaching and supervising
INSERT INTO HourlyRate(Type,Rate) VALUES('Teaching',21);
INSERT INTO HourlyRate(Type,Rate) VALUES('Supervising',16.04);


-- querying required data
SELECT (Rate*totalCount*0.1) AS Bonus 
FROM 
HourlyRate,
(
	SELECT PC.PID,SUM(StudentCount) as totalCount
	FROM ProfessorCourse PC INNER JOIN (SELECT ClassName,COUNT(SID) as StudentCount FROM StudentGrades GROUP BY ClassName) CN ON PC.ClassName=CN.ClassName
	GROUP BY PC.PID
	ORDER BY SUM(StudentCount) DESC
	OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY
)
WHERE Type='Teaching';

/*
Explanation:

Firstly, we will compute number of students enrolled in each class. Then we will join this information with professors, to get 
number of students taught by ech professor of a aprticular class. Then we will group these records based on professor, to get
the aggregate of all students to whom professor teach (sum of total stuents for all courses a professor teach). We will consider
only 1 professor who teaches to maximum number of students. 
Later we use this maximum total number of students to compute the maximum bonus offered. 

*/