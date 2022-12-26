-- Oracle Live SQL

-- creating table
-- DROP TABLE StudentGrades;
CREATE TABLE StudentGrades
(
SID INTEGER NOT NULL,
ClassName VARCHAR2(50) NOT NULL,
Grade VARCHAR2(1) NOT NULL,
PRIMARY KEY (SID, ClassName)
);

-- inserting data
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

-- querying required data
SELECT ClassName,COUNT(SID) FROM StudentGrades GROUP BY ClassName ORDER BY COUNT(SID) DESC, ClassName DESC;

/*
Explanation:

We will group all the records based on ClassNames and compute sum of students who belong to correspnding 
Class, this will produce list of Classes with number of students enrolled. Then we will order the data in 
decreasing order of number of students enrolled.

*/