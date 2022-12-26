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
SELECT DISTINCT ProfessorName FROM ProfessorCourse
WHERE ProfessorName not in ( 
SELECT ProfessorName FROM 
( 
    (SELECT ProfessorName, CourseName FROM (select CourseName from Courses) 
    cross join 
    (select distinct ProfessorName from ProfessorCourse))
    MINUS
    (SELECT ProfessorName, ClassName FROM ProfessorCourse)
) 
); 

/*
Explanation: 

We will compute all possible pairs of professros to required list of courses, then we will subtract this from
actual pair of professors to courses. This provides records with list of required courses which are not
taught by each professor, implying this list of professors who do not teach all required list of courses. Excluding these professors
from the complete list of professors produce list of professors who teach all required courses.

This query is performing division operation
*/