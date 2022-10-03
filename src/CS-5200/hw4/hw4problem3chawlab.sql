CREATE DATABASE  IF NOT EXISTS `BusyBee` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `BusyBee`;
-- MySQL dump 10.13  Distrib 8.0.20, for macos10.15 (x86_64)
--
-- Host: localhost    Database: BusyBee
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
-- Table structure for table `cleaningEquipment`
--

DROP TABLE IF EXISTS `cleaningEquipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cleaningEquipment` (
  `cleaningEquipmentId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`cleaningEquipmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cleaningEquipment`
--

LOCK TABLES `cleaningEquipment` WRITE;
/*!40000 ALTER TABLE `cleaningEquipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `cleaningEquipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cleaningGroup`
--

DROP TABLE IF EXISTS `cleaningGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cleaningGroup` (
  `cleaningGroupId` int NOT NULL AUTO_INCREMENT,
  `cleaningJobId` int NOT NULL,
  PRIMARY KEY (`cleaningGroupId`),
  KEY `FK_cleaningGroupCleaningJobId` (`cleaningJobId`),
  CONSTRAINT `FK_cleaningGroupCleaningJobId` FOREIGN KEY (`cleaningJobId`) REFERENCES `cleaningJob` (`cleaningJobId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cleaningGroup`
--

LOCK TABLES `cleaningGroup` WRITE;
/*!40000 ALTER TABLE `cleaningGroup` DISABLE KEYS */;
/*!40000 ALTER TABLE `cleaningGroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cleaningJob`
--

DROP TABLE IF EXISTS `cleaningJob`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cleaningJob` (
  `cleaningJobId` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`cleaningJobId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cleaningJob`
--

LOCK TABLES `cleaningJob` WRITE;
/*!40000 ALTER TABLE `cleaningJob` DISABLE KEYS */;
/*!40000 ALTER TABLE `cleaningJob` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cleaningJobCleaningEquipment`
--

DROP TABLE IF EXISTS `cleaningJobCleaningEquipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cleaningJobCleaningEquipment` (
  `cleaningJobId` int NOT NULL,
  `cleaningEquipmentId` int NOT NULL,
  PRIMARY KEY (`cleaningJobId`,`cleaningEquipmentId`),
  KEY `FK_cleaningJobCleaningEquipmentCleaningEquipmentId` (`cleaningEquipmentId`),
  CONSTRAINT `FK_cleaningJobCleaningEquipmentCleaningEquipmentId` FOREIGN KEY (`cleaningEquipmentId`) REFERENCES `cleaningEquipment` (`cleaningEquipmentId`),
  CONSTRAINT `FK_cleaningJobCleaningEquipmentCleaningJobId` FOREIGN KEY (`cleaningJobId`) REFERENCES `cleaningJob` (`cleaningJobId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cleaningJobCleaningEquipment`
--

LOCK TABLES `cleaningJobCleaningEquipment` WRITE;
/*!40000 ALTER TABLE `cleaningJobCleaningEquipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `cleaningJobCleaningEquipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
  `clientId` int NOT NULL AUTO_INCREMENT,
  `cleaningJobId` int NOT NULL,
  PRIMARY KEY (`clientId`),
  KEY `FK_clientCleaningJobId` (`cleaningJobId`),
  CONSTRAINT `FK_clientCleaningJobId` FOREIGN KEY (`cleaningJobId`) REFERENCES `cleaningJob` (`cleaningJobId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `staff` (
  `staffId` int NOT NULL AUTO_INCREMENT,
  `typeOfWorker` varchar(50) DEFAULT NULL,
  `cleaningEquipmentId` int DEFAULT NULL,
  `cleaningJobId` int DEFAULT NULL,
  `cleaningGroupId` int DEFAULT NULL,
  PRIMARY KEY (`staffId`),
  KEY `FK_staffCleaningEquipmentId` (`cleaningEquipmentId`),
  KEY `FK_staffCleaningJobId` (`cleaningJobId`),
  KEY `FK_staffCleaningGroupId` (`cleaningGroupId`),
  CONSTRAINT `FK_staffCleaningEquipmentId` FOREIGN KEY (`cleaningEquipmentId`) REFERENCES `cleaningEquipment` (`cleaningEquipmentId`),
  CONSTRAINT `FK_staffCleaningGroupId` FOREIGN KEY (`cleaningGroupId`) REFERENCES `cleaningGroup` (`cleaningGroupId`),
  CONSTRAINT `FK_staffCleaningJobId` FOREIGN KEY (`cleaningJobId`) REFERENCES `cleaningJob` (`cleaningJobId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-03 12:39:50
