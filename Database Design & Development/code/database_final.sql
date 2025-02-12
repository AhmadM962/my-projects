-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: donortrackingsystem
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `communication_history`
--

DROP TABLE IF EXISTS `communication_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `communication_history` (
  `Communication_ID` int NOT NULL AUTO_INCREMENT,
  `Donor_ID` int DEFAULT NULL,
  `Event_ID` int DEFAULT NULL,
  `Type_of_Communication` varchar(50) NOT NULL,
  `Date` date NOT NULL,
  `Notes` varchar(255) DEFAULT NULL,
  `Follow_Up_Required` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Communication_ID`),
  KEY `FK_Communication_Donor` (`Donor_ID`),
  KEY `FK_Communication_Event` (`Event_ID`),
  CONSTRAINT `communication_history_ibfk_1` FOREIGN KEY (`Donor_ID`) REFERENCES `donor` (`Donor_ID`) ON DELETE SET NULL,
  CONSTRAINT `communication_history_ibfk_2` FOREIGN KEY (`Event_ID`) REFERENCES `event` (`Event_ID`) ON DELETE SET NULL,
  CONSTRAINT `FK_Communication_Donor` FOREIGN KEY (`Donor_ID`) REFERENCES `donor` (`Donor_ID`) ON DELETE SET NULL,
  CONSTRAINT `FK_Communication_Event` FOREIGN KEY (`Event_ID`) REFERENCES `event` (`Event_ID`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `communication_history`
--

LOCK TABLES `communication_history` WRITE;
/*!40000 ALTER TABLE `communication_history` DISABLE KEYS */;
INSERT INTO `communication_history` VALUES (1,1,1,'Email','2024-04-10','Sent invitation for Charity Gala',1),(2,2,2,'Phone Call','2024-04-15','Confirmed participation in Blood Donation Drive',0),(3,2,3,'Email','2024-04-18','Received follow-up for Education Awareness Seminar',1),(4,2,4,'SMS','2024-04-20','Sent reminder for Food Distribution Campaign',0),(5,3,3,'SMS','2024-04-18','Sent reminders for Education Awareness Seminar',1),(7,NULL,NULL,'Email','2025-05-10','Event invitation sent',1),(8,3,2,'Phone Call','2025-05-10','Follow-up on event participationn',0);
/*!40000 ALTER TABLE `communication_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `communicationlog`
--

DROP TABLE IF EXISTS `communicationlog`;
/*!50001 DROP VIEW IF EXISTS `communicationlog`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `communicationlog` AS SELECT 
 1 AS `Communication_ID`,
 1 AS `First_Name`,
 1 AS `Last_Name`,
 1 AS `Event_Name`,
 1 AS `Type_of_Communication`,
 1 AS `Date`,
 1 AS `Notes`,
 1 AS `Follow_Up_Required`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `donation`
--

DROP TABLE IF EXISTS `donation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donation` (
  `Donation_ID` int NOT NULL AUTO_INCREMENT,
  `Donor_ID` int DEFAULT NULL,
  `Date` date NOT NULL,
  `Amount` decimal(10,2) NOT NULL,
  `Donation_Type` varchar(50) NOT NULL,
  `Method_of_Payment` varchar(50) NOT NULL,
  PRIMARY KEY (`Donation_ID`),
  KEY `FK_Donation_Donor` (`Donor_ID`),
  CONSTRAINT `donation_ibfk_1` FOREIGN KEY (`Donor_ID`) REFERENCES `donor` (`Donor_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_Donation_Donor` FOREIGN KEY (`Donor_ID`) REFERENCES `donor` (`Donor_ID`) ON DELETE CASCADE,
  CONSTRAINT `donation_chk_1` CHECK ((`Amount` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donation`
--

LOCK TABLES `donation` WRITE;
/*!40000 ALTER TABLE `donation` DISABLE KEYS */;
INSERT INTO `donation` VALUES (1,1,'2024-05-15',500.00,'Money','Credit Card'),(2,1,'2024-06-01',300.00,'Clothes','N/A'),(3,1,'2024-07-10',250.00,'Books','N/A'),(4,2,'2024-06-22',300.00,'Blood','N/A'),(5,3,'2024-07-18',200.00,'Books','N/A'),(6,4,'2024-08-12',700.00,'Money','Bank Transfer'),(8,3,'2025-06-15',500.00,'Money','Credit Card'),(21,4,'2025-01-01',500.00,'Money','Credit Card');
/*!40000 ALTER TABLE `donation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donation_event`
--

DROP TABLE IF EXISTS `donation_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donation_event` (
  `Donation_ID` int NOT NULL,
  `Event_ID` int NOT NULL,
  `Purpose` varchar(255) NOT NULL,
  PRIMARY KEY (`Donation_ID`,`Event_ID`),
  KEY `FK_DonationEvent_Event` (`Event_ID`),
  CONSTRAINT `donation_event_ibfk_1` FOREIGN KEY (`Donation_ID`) REFERENCES `donation` (`Donation_ID`) ON DELETE CASCADE,
  CONSTRAINT `donation_event_ibfk_2` FOREIGN KEY (`Event_ID`) REFERENCES `event` (`Event_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_DonationEvent_Donation` FOREIGN KEY (`Donation_ID`) REFERENCES `donation` (`Donation_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_DonationEvent_Event` FOREIGN KEY (`Event_ID`) REFERENCES `event` (`Event_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donation_event`
--

LOCK TABLES `donation_event` WRITE;
/*!40000 ALTER TABLE `donation_event` DISABLE KEYS */;
INSERT INTO `donation_event` VALUES (1,1,'Funding the Charity Gala'),(1,2,'Helping Blood Donation Drive'),(2,2,'Supporting Blood Donation Drive'),(3,3,'Providing Educational Materials'),(4,4,'Funding Food Distribution'),(5,1,'Additional Event Expenses'),(5,4,'Food for Distribution');
/*!40000 ALTER TABLE `donation_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donor`
--

DROP TABLE IF EXISTS `donor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donor` (
  `Donor_ID` int NOT NULL AUTO_INCREMENT,
  `First_Name` varchar(50) NOT NULL,
  `Last_Name` varchar(50) NOT NULL,
  `Date_of_Birth` date NOT NULL,
  `Email_Address` varchar(100) NOT NULL,
  `Career_Details` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Donor_ID`),
  UNIQUE KEY `Email_Address` (`Email_Address`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donor`
--

LOCK TABLES `donor` WRITE;
/*!40000 ALTER TABLE `donor` DISABLE KEYS */;
INSERT INTO `donor` VALUES (1,'John','Doe','1985-06-15','johndoe@email.com','Software Engineer'),(2,'Jane','Smith','1990-03-22','janesmith@email.com','Doctor'),(3,'Robert','Brown','1978-12-10','robertbrown@email.com','Teacher'),(4,'Emily','Davis','1995-07-30','emilydavis@email.com','Marketing Manager'),(6,'ahmad','m','2005-12-10','a@a.com',''),(7,'John','Doe','1985-02-20','john.doe@example.com','Engineer'),(9,'Alice','Johnson','1985-06-15','alice@email.com','Software Engineer'),(12,'Test','User','1990-01-01','testuser@email.com','Engineer');
/*!40000 ALTER TABLE `donor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donor_event`
--

DROP TABLE IF EXISTS `donor_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donor_event` (
  `Donor_ID` int NOT NULL,
  `Event_ID` int NOT NULL,
  `Participation_Role` varchar(50) NOT NULL,
  PRIMARY KEY (`Donor_ID`,`Event_ID`),
  KEY `FK_DonorEvent_Event` (`Event_ID`),
  CONSTRAINT `donor_event_ibfk_1` FOREIGN KEY (`Donor_ID`) REFERENCES `donor` (`Donor_ID`) ON DELETE CASCADE,
  CONSTRAINT `donor_event_ibfk_2` FOREIGN KEY (`Event_ID`) REFERENCES `event` (`Event_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_DonorEvent_Donor` FOREIGN KEY (`Donor_ID`) REFERENCES `donor` (`Donor_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_DonorEvent_Event` FOREIGN KEY (`Event_ID`) REFERENCES `event` (`Event_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donor_event`
--

LOCK TABLES `donor_event` WRITE;
/*!40000 ALTER TABLE `donor_event` DISABLE KEYS */;
INSERT INTO `donor_event` VALUES (1,1,'Speaker'),(2,2,'Volunteer'),(2,3,'Guest'),(3,3,'Organizer'),(4,4,'Donor');
/*!40000 ALTER TABLE `donor_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donor_phone`
--

DROP TABLE IF EXISTS `donor_phone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donor_phone` (
  `Donor_ID` int NOT NULL,
  `Phone_Number` varchar(10) NOT NULL,
  PRIMARY KEY (`Donor_ID`,`Phone_Number`),
  CONSTRAINT `donor_phone_ibfk_1` FOREIGN KEY (`Donor_ID`) REFERENCES `donor` (`Donor_ID`) ON DELETE CASCADE,
  CONSTRAINT `FK_DonorPhone_Donor` FOREIGN KEY (`Donor_ID`) REFERENCES `donor` (`Donor_ID`) ON DELETE CASCADE,
  CONSTRAINT `donor_phone_chk_1` CHECK ((length(`Phone_Number`) = 10))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donor_phone`
--

LOCK TABLES `donor_phone` WRITE;
/*!40000 ALTER TABLE `donor_phone` DISABLE KEYS */;
INSERT INTO `donor_phone` VALUES (1,'0987654321'),(1,'1234567890'),(2,'2233445566'),(3,'3344556677'),(3,'7788990011'),(4,'4455667788');
/*!40000 ALTER TABLE `donor_phone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `donordonationsummary`
--

DROP TABLE IF EXISTS `donordonationsummary`;
/*!50001 DROP VIEW IF EXISTS `donordonationsummary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `donordonationsummary` AS SELECT 
 1 AS `Donor_ID`,
 1 AS `First_Name`,
 1 AS `Last_Name`,
 1 AS `Total_Donations`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `donorparticipation`
--

DROP TABLE IF EXISTS `donorparticipation`;
/*!50001 DROP VIEW IF EXISTS `donorparticipation`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `donorparticipation` AS SELECT 
 1 AS `Donor_ID`,
 1 AS `First_Name`,
 1 AS `Last_Name`,
 1 AS `Event_Name`,
 1 AS `Participation_Role`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `Event_ID` int NOT NULL AUTO_INCREMENT,
  `Event_Name` varchar(100) NOT NULL,
  `Event_Date` date NOT NULL,
  `Country` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Street_Name` varchar(100) DEFAULT NULL,
  `Building_Number` varchar(10) DEFAULT NULL,
  `Type` varchar(50) NOT NULL,
  PRIMARY KEY (`Event_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Charity Gala','2024-05-12','USA','New York','5th Avenue','100','Fundraising'),(2,'Blood Donation Drive','2024-06-20','UK','London','Main Street','20','Health'),(3,'Education Awareness Seminar','2024-07-15','Canada','Toronto','Queen Street','50','Education'),(4,'Food Distribution Campaign','2024-08-10','India','Mumbai','Central Road','30','Social Work');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `eventdonations`
--

DROP TABLE IF EXISTS `eventdonations`;
/*!50001 DROP VIEW IF EXISTS `eventdonations`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `eventdonations` AS SELECT 
 1 AS `Event_Name`,
 1 AS `Amount`,
 1 AS `Donation_Type`,
 1 AS `First_Name`,
 1 AS `Last_Name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `topdonors`
--

DROP TABLE IF EXISTS `topdonors`;
/*!50001 DROP VIEW IF EXISTS `topdonors`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `topdonors` AS SELECT 
 1 AS `Donor_ID`,
 1 AS `First_Name`,
 1 AS `Last_Name`,
 1 AS `Total_Donated`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'donortrackingsystem'
--
/*!50003 DROP PROCEDURE IF EXISTS `DeleteCommunication` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCommunication`(
    IN p_Communication_ID INT
)
BEGIN
    DELETE FROM Communication_History WHERE Communication_ID = p_Communication_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteDonation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDonation`(
    IN p_Donation_ID INT
)
BEGIN
    DELETE FROM Donation WHERE Donation_ID = p_Donation_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteDonor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteDonor`(
    IN p_Donor_ID INT
)
BEGIN
    DELETE FROM Donor WHERE Donor_ID = p_Donor_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DeleteEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteEvent`(
    IN p_Event_ID INT
)
BEGIN
    DELETE FROM Event WHERE Event_ID = p_Event_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertCommunication` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertCommunication`(
    IN p_Donor_ID INT,
    IN p_Event_ID INT,
    IN p_Type_of_Communication VARCHAR(50),
    IN p_Date DATE,
    IN p_Notes VARCHAR(255),
    IN p_Follow_Up_Required BOOLEAN
)
BEGIN
    INSERT INTO Communication_History (Donor_ID, Event_ID, Type_of_Communication, Date, Notes, Follow_Up_Required)
    VALUES (p_Donor_ID, p_Event_ID, p_Type_of_Communication, p_Date, p_Notes, p_Follow_Up_Required);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertDonation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDonation`(
    IN p_Donor_ID INT,
    IN p_Date DATE,
    IN p_Amount DECIMAL(10,2),
    IN p_Donation_Type VARCHAR(50),
    IN p_Method_of_Payment VARCHAR(50)
)
BEGIN
    INSERT INTO Donation (Donor_ID, Date, Amount, Donation_Type, Method_of_Payment)
    VALUES (p_Donor_ID, p_Date, p_Amount, p_Donation_Type, p_Method_of_Payment);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertDonor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertDonor`(
    IN p_First_Name VARCHAR(50),
    IN p_Last_Name VARCHAR(50),
    IN p_Date_of_Birth DATE,
    IN p_Email_Address VARCHAR(100),
    IN p_Career_Details VARCHAR(100)
)
BEGIN
    INSERT INTO Donor (First_Name, Last_Name, Date_of_Birth, Email_Address, Career_Details)
    VALUES (p_First_Name, p_Last_Name, p_Date_of_Birth, p_Email_Address, p_Career_Details);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertEvent`(
    IN p_Event_Name VARCHAR(100),
    IN p_Event_Date DATE,
    IN p_Country VARCHAR(50),
    IN p_City VARCHAR(50),
    IN p_Street_Name VARCHAR(100),
    IN p_Building_Number VARCHAR(10),
    IN p_Type VARCHAR(50)
)
BEGIN
    INSERT INTO Event (Event_Name, Event_Date, Country, City, Street_Name, Building_Number, Type)
    VALUES (p_Event_Name, p_Event_Date, p_Country, p_City, p_Street_Name, p_Building_Number, p_Type);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateDonation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDonation`(
    IN p_Donation_ID INT,
    IN p_Amount DECIMAL(10,2),
    IN p_Donation_Type VARCHAR(50),
    IN p_Method_of_Payment VARCHAR(50)
)
BEGIN
    UPDATE Donation
    SET Amount = p_Amount,
        Donation_Type = p_Donation_Type,
        Method_of_Payment = p_Method_of_Payment
    WHERE Donation_ID = p_Donation_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdateDonor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateDonor`(
    IN p_Donor_ID INT,
    IN p_First_Name VARCHAR(50),
    IN p_Last_Name VARCHAR(50),
    IN p_Email_Address VARCHAR(100),
    IN p_Career_Details VARCHAR(100)
)
BEGIN
    UPDATE Donor
    SET First_Name = p_First_Name,
        Last_Name = p_Last_Name,
        Email_Address = p_Email_Address,
        Career_Details = p_Career_Details
    WHERE Donor_ID = p_Donor_ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `communicationlog`
--

/*!50001 DROP VIEW IF EXISTS `communicationlog`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `communicationlog` AS select `ch`.`Communication_ID` AS `Communication_ID`,`d`.`First_Name` AS `First_Name`,`d`.`Last_Name` AS `Last_Name`,`e`.`Event_Name` AS `Event_Name`,`ch`.`Type_of_Communication` AS `Type_of_Communication`,`ch`.`Date` AS `Date`,`ch`.`Notes` AS `Notes`,`ch`.`Follow_Up_Required` AS `Follow_Up_Required` from ((`communication_history` `ch` join `donor` `d` on((`ch`.`Donor_ID` = `d`.`Donor_ID`))) join `event` `e` on((`ch`.`Event_ID` = `e`.`Event_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `donordonationsummary`
--

/*!50001 DROP VIEW IF EXISTS `donordonationsummary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `donordonationsummary` AS select `d`.`Donor_ID` AS `Donor_ID`,`d`.`First_Name` AS `First_Name`,`d`.`Last_Name` AS `Last_Name`,sum(`dn`.`Amount`) AS `Total_Donations` from (`donor` `d` join `donation` `dn` on((`d`.`Donor_ID` = `dn`.`Donor_ID`))) group by `d`.`Donor_ID`,`d`.`First_Name`,`d`.`Last_Name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `donorparticipation`
--

/*!50001 DROP VIEW IF EXISTS `donorparticipation`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `donorparticipation` AS select `de`.`Donor_ID` AS `Donor_ID`,`d`.`First_Name` AS `First_Name`,`d`.`Last_Name` AS `Last_Name`,`e`.`Event_Name` AS `Event_Name`,`de`.`Participation_Role` AS `Participation_Role` from ((`donor_event` `de` join `donor` `d` on((`de`.`Donor_ID` = `d`.`Donor_ID`))) join `event` `e` on((`de`.`Event_ID` = `e`.`Event_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `eventdonations`
--

/*!50001 DROP VIEW IF EXISTS `eventdonations`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `eventdonations` AS select `e`.`Event_Name` AS `Event_Name`,`dn`.`Amount` AS `Amount`,`dn`.`Donation_Type` AS `Donation_Type`,`d`.`First_Name` AS `First_Name`,`d`.`Last_Name` AS `Last_Name` from (((`donation` `dn` join `donation_event` `de` on((`dn`.`Donation_ID` = `de`.`Donation_ID`))) join `event` `e` on((`de`.`Event_ID` = `e`.`Event_ID`))) join `donor` `d` on((`dn`.`Donor_ID` = `d`.`Donor_ID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `topdonors`
--

/*!50001 DROP VIEW IF EXISTS `topdonors`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `topdonors` AS select `d`.`Donor_ID` AS `Donor_ID`,`d`.`First_Name` AS `First_Name`,`d`.`Last_Name` AS `Last_Name`,sum(`dn`.`Amount`) AS `Total_Donated` from (`donor` `d` join `donation` `dn` on((`d`.`Donor_ID` = `dn`.`Donor_ID`))) group by `d`.`Donor_ID`,`d`.`First_Name`,`d`.`Last_Name` order by `Total_Donated` desc limit 10 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-01-29 23:42:05
