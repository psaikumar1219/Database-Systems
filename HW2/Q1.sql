-- Oracle Live SQL

-- creating table
-- DROP TABLE ProjectRoomBookings;
CREATE TABLE ProjectRoomBookings(
	roomNum INTEGER NOT NULL,
	startTime INTEGER NOT NULL,
	endTime INTEGER NOT NULL,
	groupName CHAR(10) NOT NULL,
	PRIMARY KEY (roomNum, startTime),
	CHECK (startTime BETWEEN 7 AND 18), -- check if start time is within the bounds
	CHECK (endTime BETWEEN 7 AND 18), -- check if endtime is within the bounds
	CHECK (endTime>startTime), -- check end time is after start time
	CHECK (MOD(endTime - startTime,3) = 0) -- check time slot is multiple of 3 hours
);


-- inserted
INSERT INTO ProjectRoomBookings(roomNum,startTime,endTime,groupName) VALUES(1,7,10,'G1'); 
-- violates endTime > startTime constraint
INSERT INTO ProjectRoomBookings(roomNum,startTime,endTime,groupName) VALUES(1,11,9,'G1');
-- violates startTime BETWEEN 7 AND 18 constraint
INSERT INTO ProjectRoomBookings(roomNum,startTime,endTime,groupName) VALUES(1,1,10,'G1'); 
-- violates endTime BETWEEN 7 AND 18 constraint
INSERT INTO ProjectRoomBookings(roomNum,startTime,endTime,groupName) VALUES(1,13,21,'G1'); 
-- violates time slot is multiple of 3 hours
INSERT INTO ProjectRoomBookings(roomNum,startTime,endTime,groupName) VALUES(1,14,15,'G1'); 
-- inserted
INSERT INTO ProjectRoomBookings(roomNum,startTime,endTime,groupName) VALUES(1,10,13,'G2'); 
-- inserted
INSERT INTO ProjectRoomBookings(roomNum,startTime,endTime,groupName) VALUES(2,8,11,'G3'); 
-- inserted
INSERT INTO ProjectRoomBookings(roomNum,startTime,endTime,groupName) VALUES(2,12,18,'G4'); 

-- displaying data
SELECT * FROM ProjectRoomBookings;

-- creating trigger before inserting record to check if inserted record is overlapping with existing ones
CREATE OR REPLACE TRIGGER check_overlapping_slots
BEFORE INSERT OR UPDATE ON ProjectRoomBookings
FOR EACH ROW
DECLARE
result INTEGER;
BEGIN
	select count(*) into result 
	from ProjectRoomBookings PB 
	where PB.roomNum=:new.roomNum AND 
	((PB.startTime<=:new.startTime AND PB.endTime>:new.startTime) OR (PB.startTime<:new.endTime AND PB.endTime>=:new.endTime));
	IF result > 0
	THEN
		raise_application_error(-20000, 'The slot is overlapping with a already existing slot. Please change timings and try again.');
	END IF;
END;
/

/*
Explanation:

Trigger is called before inserting a record to count the number of records the new inserting records share its time slot
with already exeisting slots. If the number of records is 0 then the record is inserted otherwise it exits and provides
error without inserting.

*/

-- violates overlapping constraint, throws erro, doesnt get inserted
INSERT INTO ProjectRoomBookings(roomNum,startTime,endTime,groupName) VALUES(1,12,15,'G6');
-- inserted
INSERT INTO ProjectRoomBookings(roomNum,startTime,endTime,groupName) VALUES(1,13,16,'G6');


-- displaying data
SELECT * FROM ProjectRoomBookings;
