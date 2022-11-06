use sharkdb;

-- 1.
--  Write a function mostAttacks() that returns the township id of the township thay had the most number of attacks. 
-- The function accepts no arguments. If there are more than 1 town with the maximum value, return any town with the 
-- maximum value

DROP FUNCTION IF EXISTS mostAttacks;

DELIMITER // 
CREATE FUNCTION mostAttacks()
RETURNS INT
READS SQL DATA
BEGIN 

DECLARE townWithMostAttacks INT;

with countPerTId AS (select tid, count(tid) as noOfAttacks
from township  t
join attack a on a.location = t.tid
GROUP BY tid
ORDER BY noOfAttacks DESC)

SELECT MAX(tid)
INTO townWithMostAttacks
from countPerTId;

RETURN townWithMostAttacks; 

END //

Select mostAttacks();
Select mostAttacks();

-- 2. 
-- Write a procedure allReceivers(town, state) that accepts a town name and a state abbreviation and returns a 
-- result set of all receivers in that town. The result should contain all the fields in the receiver table as well 
-- as the provided town and state

DROP PROCEDURE IF EXISTS allReceivers;
DELIMITER // 
CREATE PROCEDURE allReceivers(town VARCHAR(64), state CHAR(2))
BEGIN 

select r.*, t.town, t.state
from receiver r 
join township t on t.tid = r.location
where t.town = town and t.state = state;

END //

CALL allReceivers('Hyannis', 'MA');
CALL allReceivers('Falmouth', 'MA');
CALL allReceivers('Chatham', 'MA');

-- 3.
-- Write a procedure named sharkLenGTE(length_p)  that accepts a length for a shark and  
-- returns a result set that contains the shark id, shark name, shark length, shark sex , and the number of 
-- detections for that shark for all sharks with a length greater than or equal to the passed length

DROP PROCEDURE IF EXISTS sharkLenGTE;
DELIMITER // 
CREATE PROCEDURE sharkLenGTE(length_p INT)
BEGIN 

select *
from shark s
where s.length >= length_p;

END //

CALL sharkLenGTE(8);
CALL sharkLenGTE(5);
CALL sharkLenGTE(12);

-- 4. 
-- Write a function named numSharkWithLen(length_p)  that accepts a shark length and returns the number of 
-- sharks with that length

DROP FUNCTION IF EXISTS numSharkWithLen;

DELIMITER // 
CREATE FUNCTION numSharkWithLen(length_p INT)
RETURNS INT
READS SQL DATA
BEGIN 

DECLARE numOfSharks INT;

select count(length)
into numOfSharks
from shark 
where length = length_p;

RETURN numOfSharks; 

END //

Select numSharkWithLen(8);
Select numSharkWithLen(3);
Select numSharkWithLen(16);

-- 5. 
-- Write a procedure  named sightingsByTown( ) that accepts no arguments  and returns a row for each township
-- tuple in the township table. The result contains the number of sightings per town, the town name and the state 
-- abbreviation. 

DROP PROCEDURE IF EXISTS sightingsByTown;
DELIMITER // 
CREATE PROCEDURE sightingsByTown()
BEGIN 

select t.town, t.state, sum(individual_sharks_detected) as numOfSightings
from township t
left join bayside_encounters be on be.location = t.tid
group by t.town, t.state;

END //

CALL sightingsByTown;
CALL sightingsByTown;


-- 6. 
-- Write a function named moreDetections(shark1,shark2). It accepts 2 shark names and returns 1 if shark1
-- has had more detections than shark2, 0 if they have had the same number of detections , and -1 if shark2 has
-- had more detections than shark1

DROP FUNCTION IF EXISTS moreDetections;

DELIMITER // 
CREATE FUNCTION moreDetections(shark1 VARCHAR(64), shark2 VARCHAR(64))
RETURNS INT
READS SQL DATA
BEGIN 

DECLARE shark1_result INT;
DECLARE shark2_result INT;

select detections
into shark1_result
from shark where name = shark1;

select detections
into shark2_result
from shark where name = shark2;

IF (shark1_result > shark2_result) THEN
	return 1;
ELSEIF (shark1_result < shark2_result) THEN
	return -1;
ELSE 
	return 0; 
END IF;

END //

select moreDetections('Amy', 'Alex');
select moreDetections('Bonnie', 'Cindy Lou');
select moreDetections('Gronk', 'Hammerhead');
select moreDetections('Heady Chomper', 'Hilary');
select moreDetections('test', 'test1');

-- 7. 
-- Create a procedure named createAttack( sname_p , vname_p , vage_p , fatal_p, attack_date,  activity_p,  
-- description_p ,town_p, state_p ) that inserts an attack into the database . Make sure you create the appropriate
-- tuples in the victim, shark and township table as well. Insert another attack into the attack table. 
-- victim name = “Ace Ventura”, age = 35, town = “Wellfleet”, state = “MA”,  shark_name = NULL, fatal = 0,
--  date = ‘2021-08-11’, description = “right foot”, activity = “surfing”


DROP PROCEDURE IF EXISTS createAttack;
DELIMITER // 
CREATE PROCEDURE createAttack(sname_p VARCHAR(64), vname_p VARCHAR(45), vage_p INT, fatal_p CHAR(1), attack_date DATE, 
activity_p VARCHAR(64), description_p VARCHAR(64), town_p VARCHAR(64), state_p CHAR(2))

BEGIN 

-- TODO

END //


CALL createAttack;

-- 8. 
-- Modify the township table to track the number of shark attacks for that town. Call the new field numAttacks.
-- Write a procedure named initialize_num_attack(townid) that initializes the field for a specific  township. 
-- Call the procedure for each town in the attack table

ALTER TABLE township 
ADD numAttacks INT; 

DROP PROCEDURE IF EXISTS initialize_num_attack;

DELIMITER // 
CREATE PROCEDURE initialize_num_attack(townId INT)

BEGIN 

DECLARE num_shark_attacks INT; 

select count(location)
into num_shark_attacks
from attack
where location = townId; 

update township
set numAttacks = num_shark_attacks
where tid = townId; 

END //

DROP PROCEDURE IF EXISTS call_each_row;

DELIMITER // 
CREATE PROCEDURE call_each_row()

BEGIN 

DECLARE row_not_found TINYINT DEFAULT FALSE;
DECLARE township_id INT; 

DECLARE township_cursor CURSOR FOR
SELECT tid FROM township;

DECLARE CONTINUE HANDLER FOR NOT FOUND 
SET row_not_found = TRUE;

OPEN township_cursor; 

WHILE row_not_found = FALSE DO
fetch township_cursor INTO township_id;
CALL initialize_num_attack(township_id);
END WHILE;

CLOSE township_cursor;

END //

CALL call_each_row();

-- 9. 
-- Write a trigger that updates township.numAttacks whenever an attack is added to the attack table.
-- Name the trigger attack_after_insert(). Insert an attack into the attack table to verify your trigger is working; 
-- victim name = “Jennifer Jones”, age = 25, town = “Truro”, state = “MA”,  sharkid = NULL, fatal = 0, 
-- date = ‘2021-11-11’, description = “left foot”, activity = “surfing”

DELIMITER // 

CREATE TRIGGER attack_after_insert 
AFTER INSERT ON attack
FOR EACH ROW 
BEGIN 
	CALL initialize_num_attack(NEW.location); 

END //

INSERT INTO victim
VALUES (9, 'Jennifer Jones', 32);

INSERT INTO attack 
VALUES (NULL, 9, 0, '2022-11-11', 'surfing', 'left foot', 10);


-- 10.
-- Write a trigger that updates township.numAttacks whenever an attack is deleted from the attack table. 
-- Call the trigger attack_after_delete().  Delete the  attack from the attack table to verify your trigger 
-- is working;  victim name = “Jennifer Jones”, age = 25, town = “Truro”, state = “MA”,  sharkid = NULL, fatal = 0, 
-- date = ‘2021-11-11’, description = “left foot”, activity = “surfing”

DELIMITER // 

CREATE TRIGGER attack_after_delete 
AFTER DELETE ON attack
FOR EACH ROW 
BEGIN 
	CALL initialize_num_attack(OLD.location); 

END //

DELETE FROM attack WHERE victim = 9;

-- 11. 
-- Create and execute a prepared statement from the SQL workbench that calls the function 
-- moreDetections(shark1, shark2). Use 2 user session variables to pass the two arguments to the function. 
-- Pass the values “Amy” and “Alex” as the shark variables

SET @shark1 = 'Amy';
SET @shark2 = 'Alex';

SET @s := "Select moreDetections(?, ?)";

PREPARE stmt1 FROM @s; 

EXECUTE stmt1 USING @shark1, @shark2; 

-- 12.
-- Create and execute a prepared statement from the SQL workbench that calls the function numSharkWithLen(length_p). 
-- Use a user session variable to pass the length to the function. Pass the value 14 as the length

SET @length = 14;

SET @s := "Select numSharkWithLen(?)";

PREPARE stmt1 FROM @s; 

EXECUTE stmt1 USING @length; 

