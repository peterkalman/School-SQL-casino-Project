CREATE DATABASE  IF NOT EXISTS `casinodbfinalfix` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `casinodbfinalfix`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: casinodbfinalfix
-- ------------------------------------------------------
-- Server version	5.6.35-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blackjack`
--

DROP TABLE IF EXISTS `blackjack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blackjack` (
  `idGame` int(11) NOT NULL,
  `turn` int(11) NOT NULL,
  `casinos_Hand` tinyint(1) NOT NULL,
  `moneyPlaced` float NOT NULL,
  `turnProcedure` int(11) NOT NULL,
  `Card` int(11) NOT NULL,
  PRIMARY KEY (`idGame`,`turn`),
  KEY `fk_Blackjack_Customer's Games1_idx` (`idGame`),
  KEY `fk_Blackjack_Blackjack turnProcedure1_idx` (`turnProcedure`),
  KEY `fk_Blackjack_Card1_idx` (`Card`),
  CONSTRAINT `fk_Blackjack_Blackjack turnProcedure1` FOREIGN KEY (`turnProcedure`) REFERENCES `blackjack_turn` (`idBlackjack_turnProcedure`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Blackjack_Card1` FOREIGN KEY (`Card`) REFERENCES `card` (`idCard`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Blackjack_Customer's Games1` FOREIGN KEY (`idGame`) REFERENCES `customers_games` (`idGame`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blackjack`
--

LOCK TABLES `blackjack` WRITE;
/*!40000 ALTER TABLE `blackjack` DISABLE KEYS */;
INSERT INTO `blackjack` VALUES (3,0,0,2000,1,5),(3,1,0,0,1,40),(3,2,1,0,1,26),(3,3,1,0,1,49),(3,4,0,0,1,30),(3,5,0,2000,3,49),(3,6,0,0,1,40),(4,0,0,500,1,5),(4,1,0,0,1,24),(4,2,1,0,1,26),(4,3,1,0,1,48);
/*!40000 ALTER TABLE `blackjack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blackjack_turn`
--

DROP TABLE IF EXISTS `blackjack_turn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blackjack_turn` (
  `idBlackjack_turnProcedure` int(11) NOT NULL AUTO_INCREMENT,
  `procedureName` varchar(45) NOT NULL,
  PRIMARY KEY (`idBlackjack_turnProcedure`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blackjack_turn`
--

LOCK TABLES `blackjack_turn` WRITE;
/*!40000 ALTER TABLE `blackjack_turn` DISABLE KEYS */;
INSERT INTO `blackjack_turn` VALUES (1,'Receive Card'),(2,'Stand'),(3,'Double Down'),(4,'Split');
/*!40000 ALTER TABLE `blackjack_turn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `card` (
  `idCard` int(11) NOT NULL,
  `CardType` varchar(45) NOT NULL,
  `CardPower` int(11) NOT NULL,
  PRIMARY KEY (`idCard`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
INSERT INTO `card` VALUES (1,'Hearts',1),(2,'Hearts',2),(3,'Hearts',3),(4,'Hearts',4),(5,'Hearts',5),(6,'Hearts',6),(7,'Hearts',7),(8,'Hearts',8),(9,'Hearts',9),(10,'Hearts',10),(11,'Hearts',10),(12,'Hearts',10),(13,'Hearts',10),(14,'Diamonds',1),(15,'Diamonds',2),(16,'Diamonds',3),(17,'Diamonds',4),(18,'Diamonds',5),(19,'Diamonds',6),(20,'Diamonds',7),(21,'Diamonds',8),(22,'Diamonds',9),(23,'Diamonds',10),(24,'Diamonds',10),(25,'Diamonds',10),(26,'Diamonds',10),(27,'Clubs',1),(28,'Clubs',2),(29,'Clubs',3),(30,'Clubs',4),(31,'Clubs',5),(32,'Clubs',6),(33,'Clubs',7),(34,'Clubs',8),(35,'Clubs',9),(36,'Clubs',10),(37,'Clubs',10),(38,'Clubs',10),(39,'Clubs',10),(40,'Spades',1),(41,'Spades',2),(42,'Spades',3),(43,'Spades',4),(44,'Spades',5),(45,'Spades',6),(46,'Spades',7),(47,'Spades',8),(48,'Spades',9),(49,'Spades',10),(50,'Spades',10),(51,'Spades',10),(52,'Spades',10);
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer's_games`
--

DROP TABLE IF EXISTS `customer's_games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer's_games` (
  `idGame` int(11) NOT NULL,
  `customerWon` tinyint(1) NOT NULL,
  `gameDate` datetime NOT NULL,
  `suspicious` tinyint(1) NOT NULL,
  `idWorkerDealer` int(11) NOT NULL,
  PRIMARY KEY (`idGame`),
  KEY `fk_Customer's Games_Workers1_idx` (`idWorkerDealer`),
  CONSTRAINT `fk_Customer's Games_Workers1` FOREIGN KEY (`idWorkerDealer`) REFERENCES `workers` (`idWorker`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer's_games`
--

LOCK TABLES `customer's_games` WRITE;
/*!40000 ALTER TABLE `customer's_games` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer's_games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_in_game`
--

DROP TABLE IF EXISTS `customer_in_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_in_game` (
  `idCustomer` int(11) NOT NULL,
  `idGame` int(11) NOT NULL,
  PRIMARY KEY (`idCustomer`,`idGame`),
  KEY `fk_Customer in game_Customers1_idx` (`idCustomer`),
  KEY `fk_Customer in game_Customer's Games1_idx` (`idGame`),
  CONSTRAINT `fk_Customer in game_Customer's Games1` FOREIGN KEY (`idGame`) REFERENCES `customers_games` (`idGame`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Customer in game_Customers1` FOREIGN KEY (`idCustomer`) REFERENCES `customers` (`idCustomer`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_in_game`
--

LOCK TABLES `customer_in_game` WRITE;
/*!40000 ALTER TABLE `customer_in_game` DISABLE KEYS */;
INSERT INTO `customer_in_game` VALUES (38,1),(50,2),(50,4),(55,2),(123,1),(123,3),(128,1);
/*!40000 ALTER TABLE `customer_in_game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `idCustomer` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `lastVisited` datetime DEFAULT NULL,
  `banned` tinyint(1) NOT NULL DEFAULT '0',
  `spendings` float NOT NULL DEFAULT '0',
  `debt` float DEFAULT '0',
  `limitDate` datetime DEFAULT NULL,
  PRIMARY KEY (`idCustomer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (38,'Kirill Rostopchin','2017-11-22 03:32:37',0,0,0,NULL),(50,'Mark Green','2016-05-05 00:10:18',0,0,0,NULL),(55,'Dave Blue','2016-05-05 00:10:28',0,0,0,NULL),(101,'Big B','2017-01-23 22:32:59',0,0,0,NULL),(123,'Peter Kalman','2017-11-22 03:32:17',0,0,0,NULL),(127,'Korel Kashri','2016-03-19 05:39:00',0,0,0,NULL),(128,'Sergey Vorfolomeyev','2017-11-22 03:32:27',0,0,0,NULL);
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers_games`
--

DROP TABLE IF EXISTS `customers_games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers_games` (
  `idGame` int(11) NOT NULL,
  `customerWon` tinyint(1) NOT NULL DEFAULT '0',
  `suspicious` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idGame`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers_games`
--

LOCK TABLES `customers_games` WRITE;
/*!40000 ALTER TABLE `customers_games` DISABLE KEYS */;
INSERT INTO `customers_games` VALUES (1,0,0),(2,0,0),(3,0,0),(4,0,0);
/*!40000 ALTER TABLE `customers_games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintance_expanses`
--

DROP TABLE IF EXISTS `maintance_expanses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maintance_expanses` (
  `idMaintanceExpanse` int(11) NOT NULL,
  `maintanceName` varchar(45) NOT NULL,
  `payment` float NOT NULL,
  PRIMARY KEY (`idMaintanceExpanse`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintance_expanses`
--

LOCK TABLES `maintance_expanses` WRITE;
/*!40000 ALTER TABLE `maintance_expanses` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintance_expanses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roulatte`
--

DROP TABLE IF EXISTS `roulatte`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roulatte` (
  `idGame` int(11) NOT NULL,
  `moneyPlaced` float NOT NULL,
  `ballGuess` int(11) NOT NULL,
  `ballResult` int(11) NOT NULL,
  PRIMARY KEY (`idGame`),
  KEY `fk_Roulatte_Customer's Games1_idx` (`idGame`),
  KEY `fk_Roulatte_RoulatteProcedure1_idx` (`ballResult`),
  KEY `fk_Roulatte_Roullate_Guessing_Options1_idx` (`ballGuess`),
  CONSTRAINT `fk_Roulatte_Customer's Games1` FOREIGN KEY (`idGame`) REFERENCES `customers_games` (`idGame`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Roulatte_RoulatteProcedure1` FOREIGN KEY (`ballResult`) REFERENCES `roulattebet` (`idRoulatteNum`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Roulatte_Roullate_Guessing_Options1` FOREIGN KEY (`ballGuess`) REFERENCES `roullate_guessing_options` (`guessingOption`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roulatte`
--

LOCK TABLES `roulatte` WRITE;
/*!40000 ALTER TABLE `roulatte` DISABLE KEYS */;
INSERT INTO `roulatte` VALUES (1,200,38,25),(2,1000,11,36);
/*!40000 ALTER TABLE `roulatte` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roulattebet`
--

DROP TABLE IF EXISTS `roulattebet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roulattebet` (
  `idRoulatteNum` int(11) NOT NULL,
  `is_red` tinyint(1) NOT NULL,
  PRIMARY KEY (`idRoulatteNum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roulattebet`
--

LOCK TABLES `roulattebet` WRITE;
/*!40000 ALTER TABLE `roulattebet` DISABLE KEYS */;
INSERT INTO `roulattebet` VALUES (0,0),(1,0),(2,1),(3,0),(4,1),(5,0),(6,1),(7,0),(8,0),(9,1),(10,0),(11,1),(12,0),(13,1),(14,0),(15,0),(16,1),(17,0),(18,1),(19,0),(20,1),(21,0),(22,0),(23,1),(24,0),(25,1),(26,0),(27,1),(28,0),(29,0),(30,1),(31,0),(32,1),(33,0),(34,1),(35,0),(36,0),(37,1);
/*!40000 ALTER TABLE `roulattebet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roullate_guessing_options`
--

DROP TABLE IF EXISTS `roullate_guessing_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roullate_guessing_options` (
  `guessingOption` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`guessingOption`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roullate_guessing_options`
--

LOCK TABLES `roullate_guessing_options` WRITE;
/*!40000 ALTER TABLE `roullate_guessing_options` DISABLE KEYS */;
INSERT INTO `roullate_guessing_options` VALUES (0,'Percise Guess'),(1,'Percise Guess'),(2,'Percise Guess'),(3,'Percise Guess'),(4,'Percise Guess'),(5,'Percise Guess'),(6,'Percise Guess'),(7,'Percise Guess'),(8,'Percise Guess'),(9,'Percise Guess'),(10,'Percise Guess'),(11,'Percise Guess'),(12,'Percise Guess'),(13,'Percise Guess'),(14,'Percise Guess'),(15,'Percise Guess'),(16,'Percise Guess'),(17,'Percise Guess'),(18,'Percise Guess'),(19,'Percise Guess'),(20,'Percise Guess'),(21,'Percise Guess'),(22,'Percise Guess'),(23,'Percise Guess'),(24,'Percise Guess'),(25,'Percise Guess'),(26,'Percise Guess'),(27,'Percise Guess'),(28,'Percise Guess'),(29,'Percise Guess'),(30,'Percise Guess'),(31,'Percise Guess'),(32,'Percise Guess'),(33,'Percise Guess'),(34,'Percise Guess'),(35,'Percise Guess'),(36,'Percise Guess'),(37,'Percise Guess'),(38,'Red Color'),(39,'Black Color'),(40,'Even'),(41,'Odd');
/*!40000 ALTER TABLE `roullate_guessing_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workers`
--

DROP TABLE IF EXISTS `workers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workers` (
  `idWorker` int(11) NOT NULL,
  `workerType` int(11) NOT NULL,
  `yearsOfExperience` int(11) NOT NULL DEFAULT '0',
  `hoursWorked` int(11) NOT NULL,
  `perHourPay` int(11) NOT NULL,
  PRIMARY KEY (`idWorker`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workers`
--

LOCK TABLES `workers` WRITE;
/*!40000 ALTER TABLE `workers` DISABLE KEYS */;
INSERT INTO `workers` VALUES (1,1,2,300,30),(2,2,10,1643,45),(3,1,5,800,35),(4,1,1,463,22),(10,2,1,90,29),(19,3,3,710,18);
/*!40000 ALTER TABLE `workers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workers_in_game`
--

DROP TABLE IF EXISTS `workers_in_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workers_in_game` (
  `idGame` int(11) NOT NULL,
  `idWorker` int(11) NOT NULL,
  PRIMARY KEY (`idGame`,`idWorker`),
  KEY `fk_Workers_in_Game_Customers_Games1_idx` (`idGame`),
  KEY `fk_Workers_in_Game_Workers1_idx` (`idWorker`),
  CONSTRAINT `fk_Workers_in_Game_Customers_Games1` FOREIGN KEY (`idGame`) REFERENCES `customers_games` (`idGame`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Workers_in_Game_Workers1` FOREIGN KEY (`idWorker`) REFERENCES `workers` (`idWorker`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workers_in_game`
--

LOCK TABLES `workers_in_game` WRITE;
/*!40000 ALTER TABLE `workers_in_game` DISABLE KEYS */;
INSERT INTO `workers_in_game` VALUES (1,1),(1,2),(1,19),(2,4),(2,10),(2,19),(3,2),(3,4),(4,2),(4,19);
/*!40000 ALTER TABLE `workers_in_game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `working_expanses`
--

DROP TABLE IF EXISTS `working_expanses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `working_expanses` (
  `idWorker` int(11) NOT NULL,
  `hoursWorked` int(11) NOT NULL DEFAULT '0',
  `perHourPay` int(11) NOT NULL,
  PRIMARY KEY (`idWorker`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `working_expanses`
--

LOCK TABLES `working_expanses` WRITE;
/*!40000 ALTER TABLE `working_expanses` DISABLE KEYS */;
/*!40000 ALTER TABLE `working_expanses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-04-23 14:44:36
