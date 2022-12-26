-- Oracle Live SQL

-- creating table
-- DROP TABLE ProjectStatus;
CREATE TABLE ProjectStatus
(
PID VARCHAR(10) NOT NULL,
Step INTEGER NOT NULL,
Status VARCHAR2(1) NOT NULL,
PRIMARY KEY (PID, Step)
);

-- inserting data
INSERT INTO ProjectStatus(PID,Step,Status) VALUES('P100',0,'C');
INSERT INTO ProjectStatus(PID,Step,Status) VALUES('P100',1,'W');
INSERT INTO ProjectStatus(PID,Step,Status) VALUES('P100',2,'W');
INSERT INTO ProjectStatus(PID,Step,Status) VALUES('P201',0,'C');
INSERT INTO ProjectStatus(PID,Step,Status) VALUES('P201',1,'C');
INSERT INTO ProjectStatus(PID,Step,Status) VALUES('P333',0,'W');
INSERT INTO ProjectStatus(PID,Step,Status) VALUES('P333',1,'W');
INSERT INTO ProjectStatus(PID,Step,Status) VALUES('P333',2,'W');
INSERT INTO ProjectStatus(PID,Step,Status) VALUES('P333',3,'W');

-- querying required data
SELECT DISTINCT PSO.PID
FROM ProjectStatus PSO INNER JOIN (SELECT PID FROM ProjectStatus WHERE Step=0 AND Status='C') PS ON PSO.PID = PS.PID
WHERE 'W' = ALL(SELECT DISTINCT Status FROM ProjectStatus PSI WHERE PSI.PID=PSO.PID AND PSI.Step<>0)
GROUP BY PSO.PID;

/*
Explanation:

First compute the list of all projects whose 0th step is completed, we will join this with the complete project list and 
check if status of project for all steps except 0 is in waiting state, we will return the list of projects which 
satisfy this condtion. 

*/