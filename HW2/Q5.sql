-- Oracle Live SQL

-- Creating all required tables
-- DROP TABLE ProfessorCourse;
CREATE TABLE ProfessorCourse
(
ProfessorName VARCHAR2(50) NOT NULL,
ClassName VARCHAR2(50) NOT NULL,
PRIMARY KEY (ProfessorName, ClassName)
);

-- DROP TABLE Courses;
CREATE TABLE Courses
(
CourseName VARCHAR2(50) NOT NULL,
PRIMARY KEY (CourseName)
);

-- inserting professor courses data
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Aleph','MIDI controllers');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Aleph','Sound mixing');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Aleph','Synthesis algorithms');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Bit','EDM synthesis');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Bit','Electronic Music Fundamentals');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Bit','Sound mixing');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('CRC','EDM synthesis');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('CRC','Electronic Music Fundamentals');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Dat','MIDI controllers');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Dat','EDM synthesis');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Dat','Electronic Music Fundamentals');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Emscr','MIDI controllers');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Emscr','Synthesis algorithms');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Emscr','Electronic Music Fundamentals');
INSERT INTO ProfessorCourse(ProfessorName,ClassName) VALUES('Emscr','EDM synthesis');

-- inserting list of required courses
INSERT INTO Courses(CourseName) VALUES('Electronic Music Fundamentals');
INSERT INTO Courses(CourseName) VALUES('MIDI controllers');
INSERT INTO Courses(CourseName) VALUES('EDM synthesis');

-- querying required data
SELECT ProfessorName 
FROM ProfessorCourse INNER JOIN Courses ON ClassName=CourseName 
GROUP BY ProfessorName 
HAVING COUNT(*) = (SELECT COUNT(*) FROM Courses);

/*
Explanation: 

Initially we compute list of professors and the courses they teach 
(only the courses which are present in the Courses table (list of required courses)). 
Then we check if the number of courses taught by each professor is equal to the number of required courses,
this gives us the list of all professors who teach all required courses

This query is performing division operation
*/