CREATE DATABASE  IF NOT EXISTS `RegionalSchool` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `RegionalSchool`;
-- MySQL dump 10.13  Distrib 8.0.20, for macos10.15 (x86_64)
--
-- Host: localhost    Database: RegionalSchool
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `pupil`
--

DROP TABLE IF EXISTS `pupil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pupil` (
  `pupilId` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(40) NOT NULL,
  `lastName` varchar(40) NOT NULL,
  `sex` varchar(20) NOT NULL,
  `dob` datetime DEFAULT NULL,
  `schoolId` int NOT NULL,
  `subjectId` int NOT NULL,
  PRIMARY KEY (`pupilId`),
  KEY `FK_pupilSchoolId` (`schoolId`),
  CONSTRAINT `FK_pupilSchoolId` FOREIGN KEY (`schoolId`) REFERENCES `school` (`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pupil`
--

LOCK TABLES `pupil` WRITE;
/*!40000 ALTER TABLE `pupil` DISABLE KEYS */;
/*!40000 ALTER TABLE `pupil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pupilToSubject`
--

DROP TABLE IF EXISTS `pupilToSubject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pupilToSubject` (
  `pupilId` int NOT NULL,
  `subjectId` int NOT NULL,
  PRIMARY KEY (`pupilId`,`subjectId`),
  KEY `FK_pupilToSubjectSubjectId` (`subjectId`),
  CONSTRAINT `FK_pupilToSubjectPupilId` FOREIGN KEY (`pupilId`) REFERENCES `pupil` (`pupilId`),
  CONSTRAINT `FK_pupilToSubjectSubjectId` FOREIGN KEY (`subjectId`) REFERENCES `subject` (`subjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pupilToSubject`
--

LOCK TABLES `pupilToSubject` WRITE;
/*!40000 ALTER TABLE `pupilToSubject` DISABLE KEYS */;
/*!40000 ALTER TABLE `pupilToSubject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school`
--

DROP TABLE IF EXISTS `school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school` (
  `schoolId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `Address` varchar(70) DEFAULT NULL,
  `town` varchar(40) DEFAULT NULL,
  `street` varchar(40) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `Country` varchar(40) DEFAULT NULL,
  `Phone` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school`
--

LOCK TABLES `school` WRITE;
/*!40000 ALTER TABLE `school` DISABLE KEYS */;
/*!40000 ALTER TABLE `school` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schoolToTeacher`
--

DROP TABLE IF EXISTS `schoolToTeacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schoolToTeacher` (
  `schoolId` int NOT NULL,
  `teacherId` int NOT NULL,
  `beginToManageSchool` date NOT NULL,
  PRIMARY KEY (`schoolId`,`teacherId`),
  KEY `FK_schoolToTeacherTeacherIdId` (`teacherId`),
  CONSTRAINT `FK_schoolToTeacherSchoolId` FOREIGN KEY (`schoolId`) REFERENCES `school` (`schoolId`),
  CONSTRAINT `FK_schoolToTeacherTeacherIdId` FOREIGN KEY (`teacherId`) REFERENCES `teacher` (`teacherId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schoolToTeacher`
--

LOCK TABLES `schoolToTeacher` WRITE;
/*!40000 ALTER TABLE `schoolToTeacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `schoolToTeacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subject`
--

DROP TABLE IF EXISTS `subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subject` (
  `subjectId` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`subjectId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subject`
--

LOCK TABLES `subject` WRITE;
/*!40000 ALTER TABLE `subject` DISABLE KEYS */;
/*!40000 ALTER TABLE `subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `teacherId` int NOT NULL AUTO_INCREMENT,
  `nin` int NOT NULL,
  `firstName` varchar(40) NOT NULL,
  `lastName` varchar(40) NOT NULL,
  `sex` varchar(20) NOT NULL,
  `qualifications` varchar(50) DEFAULT NULL,
  `schoolId` int NOT NULL,
  PRIMARY KEY (`teacherId`),
  KEY `FK_teacherSchoolId` (`schoolId`),
  CONSTRAINT `FK_teacherSchoolId` FOREIGN KEY (`schoolId`) REFERENCES `school` (`schoolId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacherToSubject`
--

DROP TABLE IF EXISTS `teacherToSubject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacherToSubject` (
  `teacherId` int NOT NULL,
  `subjectId` int NOT NULL,
  `noOfHours` int NOT NULL,
  PRIMARY KEY (`teacherId`,`subjectId`),
  KEY `FK_teacherToSubjectSubjectId` (`subjectId`),
  CONSTRAINT `FK_teacherToSubjectSubjectId` FOREIGN KEY (`subjectId`) REFERENCES `subject` (`subjectId`),
  CONSTRAINT `FK_teacherToSubjectTeacherId` FOREIGN KEY (`teacherId`) REFERENCES `teacher` (`teacherId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacherToSubject`
--

LOCK TABLES `teacherToSubject` WRITE;
/*!40000 ALTER TABLE `teacherToSubject` DISABLE KEYS */;
/*!40000 ALTER TABLE `teacherToSubject` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-03 12:39:16
