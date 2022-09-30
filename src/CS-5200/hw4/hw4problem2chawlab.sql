CREATE DATABASE IF NOT EXISTS RegionalSchool; 

CREATE TABLE `school`
(
	`schoolId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(60) NOT NULL,
	`Address` NVARCHAR(70),
    `town` NVARCHAR(40),
    `street` NVARCHAR(40),
    `zipcode` NVARCHAR(10),
    `Country` NVARCHAR(40),
	`Phone` NVARCHAR(24)
);

CREATE TABLE `pupil`
(
	`pupilId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `firstName` VARCHAR(40) NOT NULL, 
	`lastName` VARCHAR(40) NOT NULL, 
	`sex` VARCHAR(20) NOT NULL,
    `dob` DATETIME,
    `schoolId` INT NOT NULL,
    `subjectId` INT NOT NULL
);

CREATE TABLE `teacher`
(
	`teacherId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `noOfHours` INT NOT NULL, 
    `nin` INT NOT NULL, 
	`firstName` VARCHAR(40) NOT NULL, 
	`lastName` VARCHAR(40) NOT NULL, 
	`sex` VARCHAR(20) NOT NULL,
    `qualifications` VARCHAR(50),
    `managerRoleBeginDate` DATETIME, 
    `schoolId` INT NOT NULL
);

CREATE TABLE `subject`
(
	`subjectId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(50) NOT NULL, 
    `type` VARCHAR(50) NOT NULL, 
    `teacherId` INT NOT NULL
);

-- create foreign keys constraints 

ALTER TABLE `pupil` ADD CONSTRAINT `FK_schoolId` FOREIGN KEY (`schoolId`) 
		REFERENCES `school` (`schoolId`) ON DELETE NO ACTION ON UPDATE NO ACTION; 
        
ALTER TABLE `pupil` ADD CONSTRAINT `FK_subjectId` FOREIGN KEY (`subjectId`) 
		REFERENCES `subject` (`subjectId`) ON DELETE NO ACTION ON UPDATE NO ACTION; 

ALTER TABLE `teacher` ADD CONSTRAINT `FK_schoolId` FOREIGN KEY (`schoolId`) 
		REFERENCES `school` (`schoolId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `subject` ADD CONSTRAINT `FK_teacherId` FOREIGN KEY (`teacherId`) 
		REFERENCES `teacher` (`teacherId`) ON DELETE NO ACTION ON UPDATE NO ACTION;
        
