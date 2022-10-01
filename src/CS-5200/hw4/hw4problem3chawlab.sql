CREATE DATABASE IF NOT EXISTS BusyBee; 

use BusyBee; 

CREATE TABLE `client`
(
	`clientId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    `cleaningJobId` INT NOT NULL
);

CREATE TABLE `staff`
(
	`staffId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    `typeOfWorker` VARCHAR(50),
    `cleaningEquipmentId` INT,
    `cleaningJobId` INT,
    `cleaningGroupId` INT
);

CREATE TABLE `cleaningGroup`
(
	`cleaningGroupId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    `cleaningJobId` INT NOT NULL
);

CREATE TABLE `cleaningJob`
(
	`cleaningJobId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT
);

CREATE TABLE `cleaningEquipment`
(
	`cleaningEquipmentId` INT PRIMARY KEY NOT NULL AUTO_INCREMENT
);

CREATE TABLE `cleaningJobCleaningEquipment`
(
	`cleaningJobId` INT NOT NULL, 
    `cleaningEquipmentId` INT NOT NULL,
    
	CONSTRAINT `PK_cleaningJobCleaningEquipment` PRIMARY KEY  (`cleaningJobId`, `cleaningEquipmentId`)   
);

-- create foreign keys constraints 

ALTER TABLE `client` ADD CONSTRAINT `FK_clientCleaningJobId` FOREIGN KEY (`cleaningJobId`) 
		REFERENCES `cleaningJob` (`cleaningJobId`) ON DELETE NO ACTION ON UPDATE NO ACTION; 

ALTER TABLE `staff` ADD CONSTRAINT `FK_staffCleaningEquipmentId` FOREIGN KEY (`cleaningEquipmentId`) 
		REFERENCES `cleaningEquipment` (`cleaningEquipmentId`) ON DELETE NO ACTION ON UPDATE NO ACTION; 
        
ALTER TABLE `staff` ADD CONSTRAINT `FK_staffCleaningJobId` FOREIGN KEY (`cleaningJobId`) 
		REFERENCES `cleaningJob` (`cleaningJobId`) ON DELETE NO ACTION ON UPDATE NO ACTION; 
        
ALTER TABLE `staff` ADD CONSTRAINT `FK_staffCleaningGroupId` FOREIGN KEY (`cleaningGroupId`) 
		REFERENCES `cleaningGroup` (`cleaningGroupId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

ALTER TABLE `cleaningGroup` ADD CONSTRAINT `FK_cleaningGroupCleaningJobId` FOREIGN KEY (`cleaningJobId`) 
		REFERENCES `cleaningJob` (`cleaningJobId`) ON DELETE NO ACTION ON UPDATE NO ACTION; 
        
ALTER TABLE `cleaningJobCleaningEquipment` ADD CONSTRAINT `FK_cleaningJobCleaningEquipmentCleaningJobId` FOREIGN KEY (`cleaningJobId`) 
		REFERENCES `cleaningJob` (`cleaningJobId`) ON DELETE NO ACTION ON UPDATE NO ACTION; 
        
ALTER TABLE `cleaningJobCleaningEquipment` ADD CONSTRAINT `FK_cleaningJobCleaningEquipmentCleaningEquipmentId` FOREIGN KEY (`cleaningEquipmentId`) 
		REFERENCES `cleaningEquipment` (`cleaningEquipmentId`) ON DELETE NO ACTION ON UPDATE NO ACTION; 
        