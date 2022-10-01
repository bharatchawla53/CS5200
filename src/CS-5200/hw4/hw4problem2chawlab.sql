CREATE DATABASE IF NOT EXISTS RegionalSchool; 

use RegionalSchool; 

CREATE TABLE `school`
(
	`schoolId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(60) NOT NULL,
	`Address` VARCHAR(70),
    `town` VARCHAR(40),
    `street` VARCHAR(40),
    `zipcode` VARCHAR(10),
    `Country` VARCHAR(40),
	`Phone` VARCHAR(24)
);

CREATE TABLE `pupil`
(
	`pupilId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `firstName` VARCHAR(40) NOT NULL, 
	`lastName` VARCHAR(40) NOT NULL, 
	`sex` VARCHAR(20) NOT NULL,
    `dob` DATETIME,
    `schoolId` INT NOT NULL
);

CREATE TABLE `teacher`
(
	`teacherId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `nin` INT NOT NULL, 
	`firstName` VARCHAR(40) NOT NULL, 
	`lastName` VARCHAR(40) NOT NULL, 
	`sex` VARCHAR(20) NOT NULL,
    `qualifications` VARCHAR(50),
    `schoolId` INT NOT NULL
);

CREATE TABLE `subject`
(
	`subjectId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(50) NOT NULL, 
    `type` VARCHAR(50) NOT NULL
);

CREATE TABLE `teacherToSubject`
(
	`teacherId` INT NOT NULL, 
    `subjectId` INT NOT NULL,
    `noOfHours` INT NOT NULL,
    
	CONSTRAINT `PK_teacherToSubject` PRIMARY KEY  (`teacherId`, `subjectId`)
);

CREATE TABLE `pupilToSubject`
(
	`pupilId` INT NOT NULL, 
    `subjectId` INT NOT NULL,
    
	CONSTRAINT `PK_pupilToSubject` PRIMARY KEY  (`pupilId`, `subjectId`)
);

CREATE TABLE `schoolToTeacher`
(
	`schoolId` INT NOT NULL, 
    `teacherId` INT NOT NULL, 
    `beginToManageSchool` DATE NOT NULL, 
    
 	CONSTRAINT `PK_schoolToTeacher` PRIMARY KEY  (`schoolId`, `teacherId`)   
);

-- create foreign keys constraints 

ALTER TABLE `pupil` ADD CONSTRAINT `FK_pupilSchoolId` FOREIGN KEY (`schoolId`) 
		REFERENCES `school` (`schoolId`) ON DELETE NO ACTION ON UPDATE NO ACTION; 

ALTER TABLE `teacher` ADD CONSTRAINT `FK_teacherSchoolId` FOREIGN KEY (`schoolId`) 
		REFERENCES `school` (`schoolId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `teacherToSubject` ADD CONSTRAINT `FK_teacherToSubjectTeacherId` FOREIGN KEY (`teacherId`) 
		REFERENCES `teacher` (`teacherId`) ON DELETE NO ACTION ON UPDATE NO ACTION;
        
ALTER TABLE `teacherToSubject` ADD CONSTRAINT `FK_teacherToSubjectSubjectId` FOREIGN KEY (`subjectId`) 
		REFERENCES `subject` (`subjectId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `pupilToSubject` ADD CONSTRAINT `FK_pupilToSubjectPupilId` FOREIGN KEY (`pupilId`) 
		REFERENCES `pupil` (`pupilId`) ON DELETE NO ACTION ON UPDATE NO ACTION;
        
ALTER TABLE `pupilToSubject` ADD CONSTRAINT `FK_pupilToSubjectSubjectId` FOREIGN KEY (`subjectId`) 
		REFERENCES `subject` (`subjectId`) ON DELETE NO ACTION ON UPDATE NO ACTION;
        
ALTER TABLE `schoolToTeacher` ADD CONSTRAINT `FK_schoolToTeacherSchoolId` FOREIGN KEY (`schoolId`) 
		REFERENCES `school` (`schoolId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `schoolToTeacher` ADD CONSTRAINT `FK_schoolToTeacherTeacherIdId` FOREIGN KEY (`teacherId`) 
		REFERENCES `teacher` (`teacherId`) ON DELETE NO ACTION ON UPDATE NO ACTION;
