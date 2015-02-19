CREATE DATABASE  IF NOT EXISTS `frost` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `frost`;
-- MySQL dump 10.13  Distrib 5.5.40, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: frost
-- ------------------------------------------------------
-- Server version 5.5.40-0ubuntu0.14.04.1

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
-- Table structure for table `armies`
--

DROP TABLE IF EXISTS `armies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `armies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `races_id` int(11) NOT NULL,
  `colours_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_racetypes_races1_idx` (`races_id`),
  KEY `fk_armies_colours1_idx` (`colours_id`),
  CONSTRAINT `fk_armies_colours1` FOREIGN KEY (`colours_id`) REFERENCES `colours` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_racetypes_races1` FOREIGN KEY (`races_id`) REFERENCES `races` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `armies`
--

LOCK TABLES `armies` WRITE;
/*!40000 ALTER TABLE `armies` DISABLE KEYS */;
INSERT INTO `armies` VALUES (1,'Space marines',1,1,'2014-08-28 15:24:28','2014-08-28 15:24:28'),(2,'Blood Angels',1,2,'2014-09-02 16:23:41','2014-09-02 16:23:41');
/*!40000 ALTER TABLE `armies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `armycharacteristics`
--

DROP TABLE IF EXISTS `armycharacteristics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `armycharacteristics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `armycharacteristics`
--

LOCK TABLES `armycharacteristics` WRITE;
/*!40000 ALTER TABLE `armycharacteristics` DISABLE KEYS */;
/*!40000 ALTER TABLE `armycharacteristics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `armylists`
--

DROP TABLE IF EXISTS `armylists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `armylists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `descr` text NOT NULL,
  `point_limit` int(10) NOT NULL,
  `hide` tinyint(1) NOT NULL DEFAULT '0',
  `score` int(11) NOT NULL DEFAULT '1',
  `users_id` int(11) NOT NULL,
  `armies_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_armylists_users_idx` (`users_id`),
  KEY `fk_armylists_armies1_idx` (`armies_id`),
  CONSTRAINT `fk_armylists_armies1` FOREIGN KEY (`armies_id`) REFERENCES `armies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_armylists_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `armylists`
--

LOCK TABLES `armylists` WRITE;
/*!40000 ALTER TABLE `armylists` DISABLE KEYS */;
INSERT INTO `armylists` VALUES (1,'0368a531a179cee04b53b03610f09610d671850eb8e4901fc','My army','Something Something Something Something Something darkside',1500,0,2,1,1,'2014-09-01 11:34:11','2015-01-28 14:52:28'),(3,'568a551ffabcc63e440bf03c36de3827eac7b09dcc14a82cf','My Space marine army','A super cool Space marine army',1000,0,2,1,1,'2015-01-28 19:59:06','2015-01-28 19:59:06'),(4,'d1d8cbed6399f9133db2baf256b74c2ae853cd7bf8bd519ae','Blood Angel chapter','My blood angels',500,0,1,1,2,'2015-01-28 22:08:39','2015-01-28 22:08:39');
/*!40000 ALTER TABLE `armylists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `armyraces`
--

DROP TABLE IF EXISTS `armyraces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `armyraces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `armies_id` int(11) NOT NULL,
  `armycharacteristics_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_armyraces_armycharacteristics1_idx` (`armycharacteristics_id`),
  KEY `fk_armyraces_armies1_idx` (`armies_id`),
  CONSTRAINT `fk_armyraces_armies1` FOREIGN KEY (`armies_id`) REFERENCES `armies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_armyraces_armycharacteristics1` FOREIGN KEY (`armycharacteristics_id`) REFERENCES `armycharacteristics` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `armyraces`
--

LOCK TABLES `armyraces` WRITE;
/*!40000 ALTER TABLE `armyraces` DISABLE KEYS */;
/*!40000 ALTER TABLE `armyraces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `armysquads`
--

DROP TABLE IF EXISTS `armysquads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `armysquads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position` int(5) DEFAULT NULL,
  `squads_id` int(11) NOT NULL,
  `armylists_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_armysquads_squads1_idx` (`squads_id`),
  KEY `fk_armysquads_armylists1_idx` (`armylists_id`),
  CONSTRAINT `fk_armysquads_armylists1` FOREIGN KEY (`armylists_id`) REFERENCES `armylists` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_armysquads_squads1` FOREIGN KEY (`squads_id`) REFERENCES `squads` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `armysquads`
--

LOCK TABLES `armysquads` WRITE;
/*!40000 ALTER TABLE `armysquads` DISABLE KEYS */;
INSERT INTO `armysquads` VALUES (38,0,22,1,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(39,1,1,1,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(40,2,26,1,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(41,2,38,1,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(42,2,18,1,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(43,3,38,1,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(44,4,22,1,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(45,5,22,1,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(46,6,56,1,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(49,0,26,3,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(50,1,26,3,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(51,2,38,3,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(52,3,22,3,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(53,4,22,3,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(54,5,13,3,'2015-01-28 20:00:46','2015-01-28 20:00:46');
/*!40000 ALTER TABLE `armysquads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `armyunits`
--

DROP TABLE IF EXISTS `armyunits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `armyunits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `count` int(5) NOT NULL,
  `armysquads_id` int(11) NOT NULL,
  `units_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_armyunits_armysquads1_idx` (`armysquads_id`),
  KEY `fk_armyunits_units1_idx` (`units_id`),
  CONSTRAINT `fk_armyunits_armysquads1` FOREIGN KEY (`armysquads_id`) REFERENCES `armysquads` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_armyunits_units1` FOREIGN KEY (`units_id`) REFERENCES `units` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `armyunits`
--

LOCK TABLES `armyunits` WRITE;
/*!40000 ALTER TABLE `armyunits` DISABLE KEYS */;
INSERT INTO `armyunits` VALUES (57,9,38,21,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(58,1,38,22,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(59,1,39,1,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(60,1,40,25,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(61,4,41,21,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(62,1,41,22,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(63,1,42,17,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(64,4,43,21,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(65,1,43,22,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(66,4,44,21,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(67,1,44,22,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(68,4,45,21,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(69,1,45,22,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(70,1,46,51,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(73,1,49,25,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(74,1,50,25,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(75,4,51,21,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(76,1,51,22,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(77,4,52,21,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(78,1,52,22,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(79,4,53,21,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(80,1,53,22,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(81,1,54,9,'2015-01-28 20:00:46','2015-01-28 20:00:46');
/*!40000 ALTER TABLE `armyunits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `armywargears`
--

DROP TABLE IF EXISTS `armywargears`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `armywargears` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `armyunits_id` int(11) NOT NULL,
  `wargears_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_armywargear_armyunits1_idx` (`armyunits_id`),
  KEY `fk_armywargear_wargears1_idx` (`wargears_id`),
  CONSTRAINT `fk_armywargear_armyunits1` FOREIGN KEY (`armyunits_id`) REFERENCES `armyunits` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_armywargear_wargears1` FOREIGN KEY (`wargears_id`) REFERENCES `wargears` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `armywargears`
--

LOCK TABLES `armywargears` WRITE;
/*!40000 ALTER TABLE `armywargears` DISABLE KEYS */;
INSERT INTO `armywargears` VALUES (12,57,14,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(13,58,8,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(14,60,36,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(15,63,31,'2015-01-28 14:53:56','2015-01-28 14:53:56'),(17,76,26,'2015-01-28 20:00:46','2015-01-28 20:00:46'),(18,80,10,'2015-01-28 20:00:46','2015-01-28 20:00:46');
/*!40000 ALTER TABLE `armywargears` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colours`
--

DROP TABLE IF EXISTS `colours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `colours` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colours`
--

LOCK TABLES `colours` WRITE;
/*!40000 ALTER TABLE `colours` DISABLE KEYS */;
INSERT INTO `colours` VALUES (1,'Blue','2014-08-28 15:24:17','2014-08-28 15:24:17'),(2,'Red','2014-09-02 16:11:16','2014-09-02 16:11:16');
/*!40000 ALTER TABLE `colours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enhancements`
--

DROP TABLE IF EXISTS `enhancements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `enhancements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `effected_column` varchar(45) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enhancements`
--

LOCK TABLES `enhancements` WRITE;
/*!40000 ALTER TABLE `enhancements` DISABLE KEYS */;
INSERT INTO `enhancements` VALUES (1,'Weapon Skill','weapon_skill','2014-08-28 17:35:42','2014-08-28 17:35:42'),(2,'Ballistic skill','ballistic_skill','2014-08-28 17:35:47','2014-08-28 17:35:47'),(3,'Strength','strength','2014-08-28 17:35:52','2014-08-28 17:35:52'),(4,'Toughness','toughness','2014-08-28 17:36:07','2014-08-28 17:36:07'),(5,'Wounds','wounds','2014-08-28 17:36:16','2014-08-28 17:36:16'),(6,'Attacks','attacks','2014-08-28 17:36:30','2014-08-28 17:36:30'),(7,'Leadership','leadership','2014-08-28 17:36:40','2014-08-28 17:36:40'),(8,'Armour save','armour_save','2014-08-28 17:36:48','2014-08-28 17:36:48'),(9,'Invulnerable save','invulnerable_save','2014-08-28 17:37:05','2014-08-28 17:37:05'),(10,'Front armour','front_armour','2014-08-28 17:37:16','2014-08-28 17:37:16'),(11,'Side armour','side_armour','2014-08-28 17:37:29','2014-08-28 17:37:29'),(12,'rear_armour','Rear armour','2014-08-28 17:37:37','2014-08-28 17:37:37'),(13,'Hull hitpoints','hull_hitpoints','2014-08-28 17:37:55','2014-08-28 17:37:55'),(14,'Name','name','2014-08-28 17:38:07','2014-08-28 17:38:07');
/*!40000 ALTER TABLE `enhancements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `armies_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_groups_armies1_idx` (`armies_id`),
  CONSTRAINT `fk_groups_armies1` FOREIGN KEY (`armies_id`) REFERENCES `armies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1,'Ranged Weapons',1,'2014-08-28 15:48:59','2014-08-28 15:48:59'),(2,'Melee Weapons',1,'2014-08-28 15:49:06','2014-08-28 15:49:06'),(3,'Right hand Terminator Weapons',1,'2014-08-28 15:49:13','2014-08-28 16:54:37'),(4,'Heavy Weapons',1,'2014-08-28 15:49:20','2014-08-28 16:57:50'),(5,'Special Weapons',1,'2014-08-28 15:49:26','2014-08-28 15:49:26'),(6,'Special Issue Wargear',1,'2014-08-28 15:49:44','2014-08-28 15:49:44'),(7,'Chapter Relics',1,'2014-08-28 15:49:51','2014-08-28 15:49:51'),(8,'Space Marine Vehicle Equipment',1,'2014-08-28 15:50:00','2014-08-28 17:08:31'),(9,'Left hand Terminator Weapons',1,'2014-08-28 16:56:26','2014-08-28 16:56:26'),(10,'Marneus Calgar upgrades',1,'2014-08-28 17:57:39','2014-08-28 17:57:39'),(11,'Kor\'sarro Khan upgrade',1,'2014-08-29 10:03:16','2014-08-29 10:03:16'),(12,'Chapter Master upgrades',1,'2014-08-29 10:43:39','2014-08-29 10:45:29'),(13,'Honour guard upgrades',1,'2014-08-29 10:50:05','2014-08-29 10:50:05'),(14,'Chapter Champion upgrades',1,'2014-08-29 10:51:47','2014-08-29 10:51:47'),(15,'Captian upgrades',1,'2014-08-29 10:58:58','2014-08-29 10:58:58'),(16,'Command Squad Upgrades',1,'2014-08-29 11:07:16','2014-08-29 11:07:16'),(17,'Librarian upgrades',1,'2014-08-29 11:12:50','2014-08-29 11:12:50'),(18,'Librarian Terminator upgrades',1,'2014-08-29 11:16:59','2014-08-29 11:16:59'),(19,'Chaplain upgrades',1,'2014-08-29 11:26:53','2014-08-29 11:26:53'),(20,'Chaplain Terminator upgrades',1,'2014-08-29 11:28:03','2014-08-29 11:29:07'),(21,'Master of the Forge upgrades',1,'2014-08-29 11:33:04','2014-08-29 11:33:04'),(22,'Techmarine upgrades',1,'2014-08-29 11:38:32','2014-08-29 11:38:32'),(23,'Servitor upgrades',1,'2014-08-29 11:39:04','2014-08-29 11:39:04'),(24,'Tactical Sargeant upgrades',1,'2014-08-29 11:44:36','2014-08-29 11:44:36'),(25,'Scout upgrades',1,'2014-08-29 11:58:03','2014-08-29 11:58:03'),(26,'Scout sergeant upgrades',1,'2014-08-29 12:00:43','2014-08-29 12:02:03'),(27,'Crusader Initiate upgrades',1,'2014-08-29 12:11:40','2014-08-29 12:11:40'),(28,'Crusader Sword brother upgrades',1,'2014-08-29 12:13:08','2014-08-29 12:13:08'),(29,'Crusader Neophyte upgrades',1,'2014-08-29 12:14:05','2014-08-29 12:14:05'),(30,'Razorback upgrades',1,'2014-08-29 12:24:08','2014-08-29 12:24:08'),(31,'Drop Pod upgrades',1,'2014-08-29 12:29:40','2014-08-29 12:29:40'),(32,'Land Speeder Storm upgrades',1,'2014-08-29 12:30:59','2014-08-29 12:30:59'),(33,'Vanguard squad upgrades',1,'2014-08-29 12:40:47','2014-08-29 12:40:47'),(34,'Vanguard sergeant upgrades',1,'2014-08-29 12:43:07','2014-08-29 12:43:39'),(35,'Sternguard squad upgrades',1,'2014-08-29 12:48:01','2014-08-29 12:48:01'),(36,'Sternguard sargeant squad upgrades',1,'2014-08-29 12:49:14','2014-08-29 12:49:14'),(37,'Dreadnought Upgrades',1,'2014-08-29 12:58:05','2014-08-29 12:58:05'),(38,'Ironclad upgrades',1,'2014-08-29 14:06:36','2014-08-29 14:07:32'),(39,'Legion of the damned upgrades',1,'2014-08-29 14:13:09','2014-08-29 14:13:09'),(40,'Legion of the damned sargeant upgrades',1,'2014-08-29 14:13:52','2014-08-29 14:13:52'),(41,'Terminator upgrades',1,'2014-08-29 14:34:04','2014-08-29 14:34:04'),(42,'Terminator Assault upgrades',1,'2014-08-29 14:36:06','2014-08-29 14:36:06'),(43,'Centurion assault upgrades',1,'2014-08-29 14:45:00','2014-08-29 14:45:00'),(44,'Centurion assault sergeant upgrades',1,'2014-08-29 14:46:12','2014-08-29 14:46:12'),(45,'Assault upgrades',1,'2014-08-29 14:54:40','2014-08-29 14:54:40'),(46,'Assault Sergeant upgrades',1,'2014-08-29 14:55:58','2014-08-29 14:55:58'),(47,'Land Speeder upgrades',1,'2014-08-29 15:00:32','2014-08-29 15:00:32'),(48,'Stormtalon gunship upgrades',1,'2014-08-29 15:06:03','2014-08-29 15:06:03'),(49,'Bike upgrades',1,'2014-08-29 15:09:34','2014-08-29 15:11:13'),(50,'Bike Sergeant upgrades',1,'2014-08-29 15:12:22','2014-08-29 15:12:22'),(51,'Attack bike upgrades',1,'2014-08-29 15:16:58','2014-08-29 15:16:58'),(52,'Scout bike upgrades',1,'2014-08-29 15:20:17','2014-08-29 15:21:13'),(53,'Scout bike sergeant upgrades',1,'2014-08-29 15:21:52','2014-08-29 15:21:52'),(54,'Devastator sergeant upgrades',1,'2014-08-29 15:32:49','2014-08-29 15:32:49'),(55,'Centurion devastator upgrades',1,'2014-08-29 15:37:27','2014-08-29 15:37:27'),(56,'Centurion devastator sergeant upgrades',1,'2014-08-29 15:37:58','2014-08-29 15:42:31'),(57,'Predator upgrades',1,'2014-08-29 15:55:19','2014-08-29 15:55:19'),(58,'Vindicator upgrades',1,'2014-08-29 15:55:57','2014-08-29 15:55:57'),(59,'Land raider upgrades',1,'2014-08-29 16:04:48','2014-08-29 16:04:48'),(60,'Stormraven Gunship upgrades',1,'2014-08-29 16:15:08','2014-08-29 16:15:08'),(61,'Ranged weapons',2,'2015-02-04 14:35:54','2015-02-04 14:35:54'),(62,'Melee Weapons',2,'2015-02-04 14:38:22','2015-02-04 14:38:22'),(63,'Terminator Weapons (replace Storm bolter)',2,'2015-02-04 14:42:48','2015-02-04 14:42:48'),(64,'Terminator Weapons (replace Power weapon)',2,'2015-02-04 14:44:18','2015-02-04 14:44:18'),(65,'Heavy Weapons',2,'2015-02-04 14:46:06','2015-02-04 14:46:06'),(66,'Special Weapons',2,'2015-02-04 14:47:06','2015-02-04 14:47:06'),(67,'Special Issue Wargear',2,'2015-02-04 14:48:39','2015-02-04 14:48:39'),(68,'Vehicle Equipment',2,'2015-02-04 14:50:32','2015-02-04 14:50:32'),(69,'Dreadnought Weapons',2,'2015-02-04 14:52:00','2015-02-04 14:52:00'),(70,'Relics of Baal',2,'2015-02-04 14:53:33','2015-02-04 14:53:33'),(71,'Blood Angel Captain',2,'2015-02-04 15:12:55','2015-02-04 15:14:24'),(72,'Librarian upgrades',2,'2015-02-04 16:10:17','2015-02-04 16:10:17'),(73,'Librarian Dreadnought upgrades',2,'2015-02-06 13:45:16','2015-02-06 13:45:16'),(74,'Sanguinary Priest upgrades',2,'2015-02-06 14:15:38','2015-02-06 14:15:38'),(75,'Techmarine upgrades',2,'2015-02-06 14:31:40','2015-02-06 14:31:40'),(76,'Servitors upgrades',2,'2015-02-06 14:32:23','2015-02-06 14:32:23'),(77,'Chaplain upgrades',2,'2015-02-06 14:42:48','2015-02-06 14:42:48'),(78,'Tactical Sergeant upgrades',2,'2015-02-18 13:08:20','2015-02-18 13:08:20'),(79,'Scout upgrades',2,'2015-02-18 13:18:28','2015-02-18 13:18:28'),(80,'Scout Sergeant upgrades',2,'2015-02-18 13:19:47','2015-02-18 13:19:47'),(81,'Razorback upgrades',2,'2015-02-18 13:43:33','2015-02-18 13:43:33'),(82,'Drop pod upgrades',2,'2015-02-18 13:56:46','2015-02-18 13:56:46'),(83,'Land Speeder Heavy bolter upgrades',2,'2015-02-18 14:03:23','2015-02-18 14:03:23'),(84,'Land Speeder upgrades',2,'2015-02-18 14:03:59','2015-02-18 14:03:59'),(85,'Assault squad upgrades',2,'2015-02-18 14:08:04','2015-02-18 14:08:04'),(86,'Assault sergeant upgrades',2,'2015-02-18 14:10:14','2015-02-18 14:10:14'),(87,'Space Marine biker upgrades',2,'2015-02-18 14:21:19','2015-02-18 14:21:19'),(88,'Attack Bike upgrades',2,'2015-02-18 14:22:57','2015-02-18 14:22:57'),(89,'Biker sergeant upgrades',2,'2015-02-18 14:24:17','2015-02-18 14:24:17'),(90,'Attack bike squad upgrades',2,'2015-02-18 14:35:44','2015-02-18 14:35:44'),(91,'Scout biker upgrades',2,'2015-02-18 14:45:47','2015-02-18 14:45:47'),(92,'Scout Biker Sergeant upgrades',2,'2015-02-18 14:47:16','2015-02-18 14:47:16'),(93,'Stormraven assault cannon upgrade',2,'2015-02-19 12:27:06','2015-02-19 12:27:06'),(94,'Stormraven Heavy bolter upgrade',2,'2015-02-19 12:27:48','2015-02-19 12:27:48'),(95,'Stormraven upgrades',2,'2015-02-19 12:28:46','2015-02-19 12:28:46'),(96,'Devastator Sergeant upgrades',2,'2015-02-19 12:33:28','2015-02-19 12:33:28'),(97,'Baal Predator side sponsons upgrades',2,'2015-02-19 12:39:27','2015-02-19 12:39:27'),(98,'Baal Predator turret upgrades',2,'2015-02-19 12:40:03','2015-02-19 12:40:03'),(99,'Predator Turret upgrades',2,'2015-02-19 12:42:24','2015-02-19 12:42:24'),(100,'Predator Side sponsons upgrades',2,'2015-02-19 12:43:22','2015-02-19 12:43:22'),(101,'Predator upgrades',2,'2015-02-19 12:43:39','2015-02-19 12:43:39'),(102,'Vindicator upgrades',2,'2015-02-19 12:46:28','2015-02-19 12:46:28'),(103,'Whirlwind upgrades',2,'2015-02-19 12:48:09','2015-02-19 12:48:09'),(104,'Land raider upgrades',2,'2015-02-19 12:51:39','2015-02-19 12:51:39');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operations`
--

DROP TABLE IF EXISTS `operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `operation` varchar(4) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operations`
--

LOCK TABLES `operations` WRITE;
/*!40000 ALTER TABLE `operations` DISABLE KEYS */;
INSERT INTO `operations` VALUES (1,'Add','+','2014-08-28 17:38:57','2014-08-28 17:38:57'),(2,'Multiply','*','2014-08-28 17:39:22','2014-08-28 17:39:22'),(3,'Replace','=','2014-09-02 14:48:33','2014-09-02 14:48:33');
/*!40000 ALTER TABLE `operations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `psykers`
--

DROP TABLE IF EXISTS `psykers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `psykers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `armies_id` int(11) NOT NULL,
  `created` varchar(45) DEFAULT NULL,
  `modified` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wargears_armies1_idx` (`armies_id`),
  CONSTRAINT `fk_wargears_armies11` FOREIGN KEY (`armies_id`) REFERENCES `armies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `psykers`
--

LOCK TABLES `psykers` WRITE;
/*!40000 ALTER TABLE `psykers` DISABLE KEYS */;
INSERT INTO `psykers` VALUES (1,'Biomancy',1,'2014-08-28 15:51:55','2014-08-28 15:51:55'),(2,'Divination',1,'2014-08-28 15:52:01','2014-08-28 15:52:01'),(3,'Pyromancy',1,'2014-08-28 15:52:06','2014-08-28 15:52:06'),(4,'Telekinesis',1,'2014-08-28 15:52:13','2014-08-28 15:52:13'),(5,'Telepathy',1,'2014-08-28 15:52:19','2014-08-28 15:52:19'),(6,'Sanguinary',2,'2015-02-04 16:15:12','2015-02-04 16:15:12'),(7,'Daemonology',2,'2015-02-04 16:18:05','2015-02-04 16:18:05'),(8,'Sanguine Sword',2,'2015-02-06 13:52:23','2015-02-06 13:52:23');
/*!40000 ALTER TABLE `psykers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `races`
--

DROP TABLE IF EXISTS `races`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `races` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `icon` int(2) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `races`
--

LOCK TABLES `races` WRITE;
/*!40000 ALTER TABLE `races` DISABLE KEYS */;
INSERT INTO `races` VALUES (1,'Space marine',1,'2014-08-28 15:17:00','2014-09-01 15:52:27');
/*!40000 ALTER TABLE `races` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relics`
--

DROP TABLE IF EXISTS `relics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `armies_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_relics_armies1_idx` (`armies_id`),
  CONSTRAINT `fk_relics_armies1` FOREIGN KEY (`armies_id`) REFERENCES `armies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relics`
--

LOCK TABLES `relics` WRITE;
/*!40000 ALTER TABLE `relics` DISABLE KEYS */;
INSERT INTO `relics` VALUES (1,'The Primarch\'s Wrath',1,'2014-08-28 15:50:25','2014-08-28 15:50:25'),(2,'Teeth of Terra',1,'2014-08-28 15:50:32','2014-08-28 15:50:32'),(3,'The Shield Eternal',1,'2014-08-28 15:50:39','2014-08-28 15:50:39'),(4,'The Burning Blade',1,'2014-08-28 15:50:46','2014-08-28 15:50:46'),(5,'The Armour Indomitus',1,'2014-08-28 15:50:52','2014-08-28 15:50:52'),(6,'Gauntlets of Ultramar',1,'2014-08-29 09:35:17','2014-08-29 09:35:17'),(7,'Talassarian Tempest Blade',1,'2014-08-29 09:40:04','2014-08-29 09:40:04'),(8,'Mantle of the Suzerain',1,'2014-08-29 09:40:12','2014-08-29 09:40:12'),(9,'Hood of Hellfire',1,'2014-08-29 09:49:43','2014-08-29 09:49:43'),(10,'Rod of Tigurius',1,'2014-08-29 09:49:49','2014-08-29 09:49:49'),(11,'Infernus',1,'2014-08-29 09:55:42','2014-08-29 10:02:09'),(12,'Moonfang',1,'2014-08-29 10:02:26','2014-08-29 10:02:26'),(13,'Gauntlet of the Forge',1,'2014-08-29 10:10:55','2014-08-29 10:10:55'),(14,'Spear of Vulkan',1,'2014-08-29 10:11:07','2014-08-29 10:11:07'),(15,'Kesare\'s Mantle',1,'2014-08-29 10:11:16','2014-08-29 10:11:16'),(16,'The Raven\'s Talons',1,'2014-08-29 10:14:13','2014-08-29 10:14:13'),(17,'Dorn\'s Arrow',1,'2014-08-29 10:17:30','2014-08-29 10:17:30'),(18,'Fist of Dorn',1,'2014-08-29 10:17:46','2014-08-29 10:17:46'),(19,'Sword of the High Marshals',1,'2014-08-29 10:17:52','2014-08-29 10:17:52'),(20,'Armour of Faith',1,'2014-08-29 10:18:03','2014-08-29 10:18:03'),(21,'Black Sword',1,'2014-08-29 10:18:10','2014-08-29 10:18:10'),(22,'Quietus',1,'2014-08-29 12:04:47','2014-08-29 12:04:47'),(23,'Blood Song',2,'2015-02-06 13:32:07','2015-02-06 13:32:07'),(24,'The Executionerâ€™s Axe',2,'2015-02-06 14:12:15','2015-02-06 14:12:15'),(25,'Killing Strike',2,'2015-02-06 14:12:20','2015-02-06 14:12:20'),(26,'Heavenâ€™s Teeth',2,'2015-02-06 14:23:30','2015-02-06 14:23:30'),(27,'The Red Grail',2,'2015-02-06 14:23:34','2015-02-06 14:23:34'),(28,'The Axe Mortalis',2,'2015-02-19 12:58:01','2015-02-19 12:58:01'),(29,'The Death Mask of Sanguinius',2,'2015-02-19 12:58:17','2015-02-19 12:58:17'),(30,'Blood Reaver',2,'2015-02-19 13:03:13','2015-02-19 13:03:13');
/*!40000 ALTER TABLE `relics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `squads`
--

DROP TABLE IF EXISTS `squads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `squads` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `armies_id` int(11) NOT NULL,
  `types_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_squads_armies1_idx` (`armies_id`),
  KEY `fk_squads_types1_idx` (`types_id`),
  CONSTRAINT `fk_squads_armies1` FOREIGN KEY (`armies_id`) REFERENCES `armies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_squads_types1` FOREIGN KEY (`types_id`) REFERENCES `types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squads`
--

LOCK TABLES `squads` WRITE;
/*!40000 ALTER TABLE `squads` DISABLE KEYS */;
INSERT INTO `squads` VALUES (1,'Marneus Calgar',1,1,'2014-08-28 17:47:01','2014-08-28 17:53:13'),(2,'Captain Sicarius',1,1,'2014-08-29 09:43:13','2014-08-29 09:43:13'),(3,'Chief Librarian Tigurius',1,1,'2014-08-29 09:54:05','2014-08-29 09:54:05'),(4,'Chaplain Cassius',1,1,'2014-08-29 09:57:33','2014-08-29 09:57:33'),(5,'Kor\'sarro Khan',1,1,'2014-08-29 10:06:41','2014-08-29 10:06:41'),(6,'Vulkan He\'stan',1,1,'2014-08-29 10:12:21','2014-08-29 10:12:21'),(7,'Shadow Captain Shrike',1,1,'2014-08-29 10:15:12','2014-08-29 10:15:12'),(8,'Captain Lysander',1,1,'2014-08-29 10:24:33','2014-08-29 10:24:33'),(9,'Pedro Kantor',1,1,'2014-08-29 10:26:21','2014-08-29 10:26:21'),(10,'High Marshal Helbrecht',1,1,'2014-08-29 10:32:30','2014-08-29 10:32:30'),(11,'Chaplain Grimaldus',1,1,'2014-08-29 10:34:07','2014-08-29 10:35:56'),(12,'The Emperor\'s Champion',1,1,'2014-08-29 10:40:16','2014-08-29 10:40:49'),(13,'Chapter Master',1,1,'2014-08-29 10:42:41','2014-08-29 10:42:41'),(14,'Honour Guard',1,1,'2014-08-29 10:48:45','2014-08-29 10:52:58'),(15,'Captain',1,1,'2014-08-29 10:57:42','2014-08-29 10:57:42'),(16,'Terminator Captain',1,1,'2014-08-29 11:03:10','2014-08-29 11:03:10'),(17,'Command Squad',1,1,'2014-08-29 11:04:40','2014-08-29 11:10:22'),(18,'Librarian',1,1,'2014-08-29 11:13:46','2014-08-29 11:13:46'),(19,'Chaplain',1,1,'2014-08-29 11:25:20','2014-08-29 11:30:23'),(20,'Master of the Forge',1,1,'2014-08-29 11:33:56','2014-08-29 11:33:56'),(21,'Techmarine',1,1,'2014-08-29 11:37:35','2014-08-29 11:37:35'),(22,'Tactical squad',1,2,'2014-08-29 11:41:17','2014-08-29 11:42:47'),(23,'Scout squad',1,2,'2014-08-29 11:46:35','2014-08-29 11:56:42'),(24,'Sergeant Telion',1,2,'2014-08-29 12:06:03','2014-08-29 12:06:03'),(25,'Crusader Squad',1,2,'2014-08-29 12:15:27','2014-08-29 12:15:27'),(26,'Rhino',1,6,'2014-08-29 12:22:32','2014-08-29 12:22:32'),(27,'Razorback',1,6,'2014-08-29 12:27:19','2014-08-29 12:27:19'),(28,'Drop Pod',1,6,'2014-08-29 12:28:20','2014-08-29 12:28:20'),(29,'Land Speeder Storm',1,6,'2014-08-29 12:31:17','2014-08-29 12:31:17'),(30,'Vanguard veteran squad',1,3,'2014-08-29 12:42:11','2014-08-29 12:44:38'),(31,'Sternguard veteran squad',1,3,'2014-08-29 12:52:08','2014-08-29 12:52:08'),(32,'Dreadnought',1,3,'2014-08-29 14:05:36','2014-08-29 14:05:36'),(33,'Ironclad Dreadnought',1,3,'2014-08-29 14:09:43','2014-08-29 14:10:28'),(34,'Legion of the damned',1,3,'2014-08-29 14:15:37','2014-08-29 14:17:07'),(35,'Terminator squad',1,3,'2014-08-29 14:38:30','2014-08-29 14:38:30'),(36,'Terminator assault squad',1,3,'2014-08-29 14:41:13','2014-08-29 14:41:13'),(37,'Centurion assault squad',1,3,'2014-08-29 14:43:38','2014-08-29 14:47:10'),(38,'Assault squad',1,4,'2014-08-29 14:57:25','2014-08-29 14:57:25'),(39,'Land speeder Squadron',1,4,'2014-08-29 15:02:28','2014-08-29 15:02:28'),(40,'Stormtalon gunship',1,4,'2014-08-29 15:06:48','2014-08-29 15:06:48'),(41,'Bike squad',1,4,'2014-08-29 15:13:21','2014-08-29 15:13:21'),(42,'Attack bike squad',1,4,'2014-08-29 15:18:25','2014-08-29 15:18:25'),(43,'Scout bike squad',1,4,'2014-08-29 15:24:52','2014-08-29 15:24:52'),(44,'Devastator squad',1,5,'2014-08-29 15:33:43','2014-08-29 15:33:43'),(45,'Centurion devastator squad',1,5,'2014-08-29 15:39:16','2014-08-29 15:39:16'),(46,'Thunderfire cannon',1,5,'2014-08-29 15:50:27','2014-08-29 15:50:27'),(47,'Predator',1,5,'2014-08-29 15:56:45','2014-08-29 15:56:45'),(48,'Whirlwind',1,5,'2014-08-29 15:57:56','2014-08-29 15:58:47'),(49,'Vindicator',1,5,'2014-08-29 15:59:59','2014-08-29 15:59:59'),(50,'Hunter',1,5,'2014-08-29 16:00:50','2014-08-29 16:00:50'),(51,'Stalker',1,5,'2014-08-29 16:02:11','2014-08-29 16:02:11'),(52,'Land Raider',1,5,'2014-08-29 16:05:16','2014-08-29 16:05:16'),(53,'Land Raider Crusader',1,5,'2014-08-29 16:06:19','2014-08-29 16:06:19'),(54,'Land Raider Redeemer',1,5,'2014-08-29 16:08:24','2014-08-29 16:08:24'),(55,'Sergeant Chronus',1,5,'2014-08-29 16:10:29','2014-08-29 16:10:29'),(56,'Stormraven Gunship',1,5,'2014-08-29 16:12:31','2014-08-29 16:12:31'),(57,'Chapter Master',2,1,'2015-01-28 22:04:36','2015-01-28 22:04:36'),(58,'Librarian',2,1,'2015-02-04 16:02:37','2015-02-04 16:02:37'),(59,'Captain Tycho',2,1,'2015-02-06 13:30:02','2015-02-06 13:30:02'),(60,'Tycho of the Lost',2,1,'2015-02-06 13:37:19','2015-02-06 13:37:19'),(61,'Librarian Dreadnought',2,1,'2015-02-06 13:45:58','2015-02-06 13:45:58'),(62,'Mephiston',2,1,'2015-02-06 13:54:06','2015-02-06 13:54:06'),(63,'The Sanguinor',2,1,'2015-02-06 14:05:37','2015-02-06 14:05:37'),(64,'Astorath',2,1,'2015-02-06 14:10:39','2015-02-06 14:10:39'),(65,'Sanguinary Priest',2,1,'2015-02-06 14:17:42','2015-02-06 14:17:42'),(66,'Sanguinary Priest',2,1,'2015-02-06 14:19:01','2015-02-06 14:19:01'),(67,'Brother Corbulo',2,1,'2015-02-06 14:24:15','2015-02-06 14:24:15'),(68,'Techmarine',2,1,'2015-02-06 14:28:06','2015-02-06 14:28:06'),(69,'Chaplain',2,1,'2015-02-06 14:44:06','2015-02-06 14:44:06'),(70,'Tactical Squad',2,2,'2015-02-18 13:11:19','2015-02-18 13:11:19'),(71,'Scout Sergeant upgrades',2,2,'2015-02-18 13:23:35','2015-02-18 13:23:35'),(72,'Rhino',2,4,'2015-02-18 13:39:11','2015-02-18 13:39:11'),(73,'Razorback',2,4,'2015-02-18 13:41:48','2015-02-18 13:41:48'),(74,'Drop pod',2,4,'2015-02-18 13:55:54','2015-02-18 13:55:54'),(75,'Land Speeder Squadron',2,4,'2015-02-18 14:05:17','2015-02-18 14:05:17'),(76,'Assault squad',2,4,'2015-02-18 14:11:38','2015-02-18 14:11:38'),(77,'Bike squad',2,4,'2015-02-18 14:25:03','2015-02-18 14:25:03'),(78,'Attack Bike squad',2,4,'2015-02-18 14:36:25','2015-02-18 14:36:25'),(79,'Scout bike squad',2,4,'2015-02-18 14:48:19','2015-02-18 14:48:19'),(80,'Stormraven Gunship',2,5,'2015-02-19 12:29:33','2015-02-19 12:29:33'),(81,'Devastator Squad',2,5,'2015-02-19 12:34:29','2015-02-19 12:34:29'),(82,'Baal Predator',2,5,'2015-02-19 12:41:01','2015-02-19 12:41:01'),(83,'Predator',2,5,'2015-02-19 12:44:11','2015-02-19 12:44:11'),(84,'Vindicator',2,5,'2015-02-19 12:47:15','2015-02-19 12:47:15'),(85,'Whirlwind',2,5,'2015-02-19 12:48:46','2015-02-19 12:48:46'),(86,'Land Raider',2,5,'2015-02-19 12:52:04','2015-02-19 12:52:04'),(87,'Land raider crusader',2,5,'2015-02-19 12:53:26','2015-02-19 12:53:26'),(88,'Land Raider Redeemer',2,5,'2015-02-19 12:55:25','2015-02-19 12:55:25'),(89,'Commander Dante',2,7,'2015-02-19 13:00:53','2015-02-19 13:00:53'),(90,'Gabriel Seth',2,7,'2015-02-19 13:04:14','2015-02-19 13:04:14');
/*!40000 ALTER TABLE `squads` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `squadunits`
--

DROP TABLE IF EXISTS `squadunits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `squadunits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `min_count` int(4) DEFAULT NULL,
  `max_count` int(4) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `pts` int(4) DEFAULT NULL,
  `squads_id` int(11) NOT NULL,
  `units_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_squadunits_squads1_idx` (`squads_id`),
  KEY `fk_squadunits_units1_idx` (`units_id`),
  CONSTRAINT `fk_squadunits_squads1` FOREIGN KEY (`squads_id`) REFERENCES `squads` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_squadunits_units1` FOREIGN KEY (`units_id`) REFERENCES `units` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `squadunits`
--

LOCK TABLES `squadunits` WRITE;
/*!40000 ALTER TABLE `squadunits` DISABLE KEYS */;
INSERT INTO `squadunits` VALUES (1,1,1,'Marneus Calgar',275,1,1,'2014-08-28 17:53:13','2014-08-29 09:37:49'),(2,1,1,'Captain Sicarius',185,2,2,'2014-08-29 09:43:13','2014-08-29 09:44:13'),(3,1,1,'Chief Librarian Tigurius',165,3,3,'2014-08-29 09:54:05','2014-08-29 09:55:10'),(4,1,1,'Chaplain Cassius',130,4,4,'2014-08-29 09:57:33','2014-08-29 10:01:55'),(5,1,1,'Kor\'sarro Khan',125,5,2,'2014-08-29 10:06:41','2014-08-29 10:09:36'),(6,1,1,'Vulkan He\'stan',190,6,6,'2014-08-29 10:12:21','2014-08-29 10:13:24'),(7,1,1,'Shadow Captain Shrike',185,7,8,'2014-08-29 10:15:12','2014-08-29 10:17:03'),(8,1,1,'Captain Lysander',230,8,7,'2014-08-29 10:24:33','2014-08-29 10:25:23'),(9,1,1,'Pedro Kantor',185,9,9,'2014-08-29 10:26:21','2014-08-29 10:27:11'),(10,1,1,'High Marshal Helbrecht',180,10,1,'2014-08-29 10:32:30','2014-08-29 10:33:24'),(12,3,5,'Cenobyte Servitor',10,11,11,'2014-08-29 10:35:56','2014-08-29 10:37:12'),(13,1,1,'Chaplain Grimaldus',185,11,10,'2014-08-29 10:35:56','2014-08-29 10:39:51'),(14,1,1,'The Emperor\'s Champion',140,12,12,'2014-08-29 10:40:49','2014-08-29 10:41:34'),(15,1,1,'Chapter Master',130,13,9,'2014-08-29 10:42:41','2014-08-29 10:48:19'),(16,2,9,'Honour Guard',25,14,13,'2014-08-29 10:52:59','2014-08-29 10:53:57'),(17,1,1,'Chapter Champion',35,14,14,'2014-08-29 10:52:59','2014-08-29 10:54:53'),(18,1,1,'Captain',90,15,5,'2014-08-29 10:57:42','2014-08-29 11:02:43'),(19,1,1,'Terminator Captain',120,16,2,'2014-08-29 11:03:10','2014-08-29 11:04:10'),(20,5,5,'Veteran',20,17,15,'2014-08-29 11:10:22','2014-08-29 11:11:24'),(21,1,1,'Librarian',65,18,17,'2014-08-29 11:13:46','2014-08-29 11:21:59'),(22,1,1,'Chaplain',90,19,18,'2014-08-29 11:30:23','2014-08-29 11:31:29'),(23,1,1,'Master of the Forge',90,20,19,'2014-08-29 11:33:56','2014-08-29 11:35:53'),(24,1,5,'Servitor',10,21,11,'2014-08-29 11:37:35','2014-08-29 11:39:32'),(25,1,1,'Techmarine',50,21,20,'2014-08-29 11:37:35','2014-08-29 11:40:46'),(26,4,9,'Space marine',14,22,21,'2014-08-29 11:42:47','2014-08-29 11:43:58'),(27,1,1,'Space Marine Sgt',14,22,22,'2014-08-29 11:42:47','2014-08-29 11:45:41'),(28,4,9,'Scout',11,23,11,'2014-08-29 11:56:42','2014-08-29 12:03:36'),(29,1,1,'Scout Sergeant',11,23,23,'2014-08-29 11:56:42','2014-08-29 12:04:14'),(30,1,1,'Sergeant Telion',50,24,24,'2014-08-29 12:06:03','2014-08-29 12:07:53'),(31,5,10,'Initiate',14,25,21,'2014-08-29 12:15:27','2014-08-29 12:16:17'),(32,0,10,'Neophyte',10,25,23,'2014-08-29 12:15:27','2014-08-29 12:17:01'),(33,1,1,'Rhino',35,26,25,'2014-08-29 12:22:32','2014-08-29 12:23:37'),(34,1,1,'Razorback',55,27,25,'2014-08-29 12:27:20','2014-08-29 12:27:57'),(35,1,1,'Drop Pod',35,28,26,'2014-08-29 12:28:20','2014-08-29 12:30:25'),(36,1,1,'Land Speeder Storm',45,29,27,'2014-08-29 12:31:17','2014-08-29 12:32:12'),(38,4,9,'Veteran',19,30,15,'2014-08-29 12:44:38','2014-08-29 12:45:35'),(39,1,1,'Veteran Sergeant',19,30,28,'2014-08-29 12:44:38','2014-08-29 12:50:13'),(40,4,9,'Veteran',22,31,15,'2014-08-29 12:52:08','2014-08-29 12:54:33'),(41,1,1,'Veteran Sergeant',22,31,28,'2014-08-29 12:52:08','2014-08-29 12:54:47'),(42,1,1,'Dreadnought',100,32,29,'2014-08-29 14:05:36','2014-08-29 14:06:07'),(43,1,1,'Ironclad Dreadnought',135,33,30,'2014-08-29 14:10:28','2014-08-29 14:11:05'),(44,4,9,'Legionnaire',25,34,31,'2014-08-29 14:17:07','2014-08-29 14:20:05'),(45,1,1,'Legionnaire Sergeant',25,34,32,'2014-08-29 14:17:07','2014-08-29 14:20:14'),(46,4,9,'Terminator',40,35,33,'2014-08-29 14:38:30','2014-08-29 14:39:55'),(47,1,1,'Terminator Sergeant',40,35,34,'2014-08-29 14:38:30','2014-08-29 14:40:45'),(48,4,9,'Terminator',40,36,33,'2014-08-29 14:41:13','2014-08-29 14:41:54'),(49,1,1,'Terminator Sergeant',40,36,34,'2014-08-29 14:41:13','2014-08-29 14:42:27'),(50,2,5,'Centurion',60,37,35,'2014-08-29 14:47:10','2014-08-29 14:48:43'),(51,1,1,'Centurion Sergeant',70,37,36,'2014-08-29 14:47:10','2014-08-29 14:49:24'),(52,4,9,'Space Marine',17,38,21,'2014-08-29 14:57:25','2014-08-29 14:58:17'),(53,1,1,'Space Marine Sergeant',17,38,22,'2014-08-29 14:57:25','2014-08-29 15:09:58'),(54,1,3,'Land Speeder',50,39,37,'2014-08-29 15:02:29','2014-08-29 15:03:19'),(55,1,1,'Stormtalon Gunship',110,40,38,'2014-08-29 15:06:48','2014-08-29 15:08:51'),(56,2,7,'Space Marine Biker',21,41,39,'2014-08-29 15:13:21','2014-08-29 15:14:25'),(57,1,1,'Biker Sergeant',21,41,40,'2014-08-29 15:13:21','2014-08-29 15:16:31'),(58,1,3,'Attack bike',45,42,41,'2014-08-29 15:18:25','2014-08-29 15:19:35'),(59,2,9,'Scout Biker',18,43,42,'2014-08-29 15:24:52','2014-08-29 15:25:52'),(60,1,1,'Scout Biker Sergeant',18,43,43,'2014-08-29 15:24:52','2014-08-29 15:35:13'),(61,4,9,'Space Marine',14,44,21,'2014-08-29 15:33:43','2014-08-29 15:34:33'),(62,1,1,'Space Marine Sergeant',14,44,22,'2014-08-29 15:33:43','2014-08-29 15:36:32'),(63,2,5,'Centurion',60,45,35,'2014-08-29 15:39:16','2014-08-29 15:43:16'),(64,1,1,'Centurion Sergeant',70,45,36,'2014-08-29 15:39:16','2014-08-29 15:43:26'),(65,1,1,'Techmarine Gunner',50,46,45,'2014-08-29 15:50:28','2014-08-29 15:51:16'),(66,1,1,'Thunderfire Cannon',50,46,44,'2014-08-29 15:50:28','2014-08-29 15:52:02'),(67,1,1,'Predator',75,47,46,'2014-08-29 15:56:45','2014-08-29 15:59:24'),(68,1,1,'Whirlwind',65,48,48,'2014-08-29 15:58:47','2014-08-29 15:59:13'),(69,1,1,'Vindicator',125,49,46,'2014-08-29 15:59:59','2014-08-29 16:00:31'),(70,1,1,'Hunter',70,50,47,'2014-08-29 16:00:50','2014-08-29 16:01:40'),(71,1,1,'Stalker',75,51,47,'2014-08-29 16:02:11','2014-08-29 16:02:32'),(72,1,1,'Land Raider',250,52,49,'2014-08-29 16:05:16','2014-08-29 16:06:03'),(73,1,1,'Land Raider Crusader',250,53,49,'2014-08-29 16:06:20','2014-08-29 16:08:05'),(74,1,1,'Land Raider Redeemer',240,54,49,'2014-08-29 16:08:24','2014-08-29 16:09:11'),(75,1,1,'Sergeant Chronus',50,55,50,'2014-08-29 16:10:29','2014-08-29 16:11:03'),(76,1,1,'Stormraven Gunship',200,56,51,'2014-08-29 16:12:31','2014-08-29 16:20:08'),(77,1,1,'Captain',90,57,5,'2015-01-28 22:04:36','2015-02-04 15:49:48'),(78,1,1,'Librarian',65,58,17,'2015-02-04 16:02:37','2015-02-04 16:20:51'),(79,1,1,'Captain Tycho',130,59,2,'2015-02-06 13:30:02','2015-02-06 13:33:15'),(80,1,1,'Tycho of the Lost',145,60,52,'2015-02-06 13:37:19','2015-02-06 13:39:08'),(81,1,1,'Librarian Dreadnought',150,61,53,'2015-02-06 13:45:58','2015-02-06 13:47:44'),(82,1,1,'Mephiston',175,62,54,'2015-02-06 13:54:06','2015-02-06 14:02:23'),(83,1,1,'The Sanguinor',200,63,55,'2015-02-06 14:05:37','2015-02-06 14:06:56'),(84,1,1,'Astorath',165,64,56,'2015-02-06 14:10:39','2015-02-06 14:13:41'),(85,NULL,NULL,NULL,NULL,65,17,'2015-02-06 14:17:42','2015-02-06 14:17:42'),(86,1,1,'Sanguinary Priest',60,66,17,'2015-02-06 14:19:01','2015-02-06 14:20:18'),(87,1,1,'Brother Corbulo',120,67,57,'2015-02-06 14:24:15','2015-02-06 14:26:05'),(88,0,5,'Servitors',10,68,11,'2015-02-06 14:28:06','2015-02-06 14:35:23'),(89,1,1,'Techmarine',50,68,20,'2015-02-06 14:28:06','2015-02-06 14:39:44'),(90,1,1,'Chaplain',90,69,17,'2015-02-06 14:44:06','2015-02-06 14:45:20'),(91,4,9,'Space Marine',14,70,21,'2015-02-18 13:11:19','2015-02-18 13:12:49'),(92,1,1,'Space Marine Sergeant',14,70,22,'2015-02-18 13:11:19','2015-02-18 13:14:51'),(93,4,9,'Scout',11,71,23,'2015-02-18 13:23:35','2015-02-18 13:25:16'),(94,1,1,'Scout Sergeant',11,71,58,'2015-02-18 13:23:35','2015-02-18 13:26:53'),(95,1,1,'Rhino',45,72,59,'2015-02-18 13:39:11','2015-02-18 13:41:00'),(96,1,1,'Razorback',65,73,59,'2015-02-18 13:41:48','2015-02-18 13:47:21'),(97,1,1,'Drop pod',35,74,26,'2015-02-18 13:55:55','2015-02-18 13:58:06'),(98,1,3,'Land Speeder',50,75,37,'2015-02-18 14:05:17','2015-02-18 14:06:01'),(99,4,9,'Space Marine',17,76,21,'2015-02-18 14:11:38','2015-02-18 14:12:50'),(100,1,1,'Space Marine Sergeant',17,76,22,'2015-02-18 14:11:38','2015-02-18 14:14:25'),(101,2,7,'Space Marine Biker',21,77,39,'2015-02-18 14:25:03','2015-02-18 14:29:39'),(102,1,1,'Space marine Biker sergeant',21,77,40,'2015-02-18 14:25:03','2015-02-18 14:32:30'),(103,1,3,'Attack Bike',45,78,41,'2015-02-18 14:36:25','2015-02-18 14:37:31'),(104,2,9,'Scout Biker',18,79,42,'2015-02-18 14:48:19','2015-02-18 14:53:11'),(105,1,1,'Scout Biker Sergeant',18,79,43,'2015-02-18 14:48:19','2015-02-18 14:56:05'),(106,1,1,'Stormraven Gunship',200,80,51,'2015-02-19 12:29:33','2015-02-19 12:31:47'),(107,4,9,'Space Marine',14,81,21,'2015-02-19 12:34:29','2015-02-19 12:35:42'),(108,1,1,'Space Marine Sergeant',14,81,22,'2015-02-19 12:34:29','2015-02-19 12:36:33'),(109,1,1,'Baal Predator',115,82,60,'2015-02-19 12:41:01','2015-02-19 12:41:43'),(110,1,1,'Predator',75,83,46,'2015-02-19 12:44:11','2015-02-19 12:44:42'),(111,1,1,'Vindicator',120,84,46,'2015-02-19 12:47:15','2015-02-19 12:47:42'),(112,1,1,'Whirlwind',65,85,46,'2015-02-19 12:48:46','2015-02-19 12:49:17'),(113,1,1,'Land Raider',250,86,49,'2015-02-19 12:52:04','2015-02-19 12:52:48'),(114,1,1,'Land Raider Crusader',250,87,49,'2015-02-19 12:53:26','2015-02-19 12:54:22'),(115,1,1,'Land Raider Redeemer',240,88,49,'2015-02-19 12:55:25','2015-02-19 12:56:38'),(116,1,1,'Commander Dante',220,89,61,'2015-02-19 13:00:53','2015-02-19 13:02:04'),(117,1,1,'Gabriel Seth',155,90,9,'2015-02-19 13:04:14','2015-02-19 13:05:27');
/*!40000 ALTER TABLE `squadunits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transports`
--

DROP TABLE IF EXISTS `transports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `armies_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_transports_armies1_idx` (`armies_id`),
  CONSTRAINT `fk_transports_armies1` FOREIGN KEY (`armies_id`) REFERENCES `armies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transports`
--

LOCK TABLES `transports` WRITE;
/*!40000 ALTER TABLE `transports` DISABLE KEYS */;
INSERT INTO `transports` VALUES (1,'Ten models',1,'2014-08-29 12:21:15','2014-08-29 12:21:15'),(2,'Six models',1,'2014-08-29 12:21:25','2014-08-29 12:21:25'),(3,'One Dreadnought',1,'2014-08-29 12:21:38','2014-08-29 12:29:13'),(4,'One Thunderfire Cannon and Techmarine Gunner',1,'2014-08-29 12:21:53','2014-08-29 12:21:53'),(5,'Five Scouts',1,'2014-08-29 12:22:00','2014-08-29 12:22:00'),(6,'Sixteen models',1,'2014-08-29 16:07:35','2014-08-29 16:07:35'),(7,'Twelve models',1,'2014-08-29 16:07:44','2014-08-29 16:07:44'),(8,'Twelve models and/or one Dreadnought ',1,'2014-08-29 16:19:49','2014-08-29 16:19:49');
/*!40000 ALTER TABLE `transports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `types`
--

DROP TABLE IF EXISTS `types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `types`
--

LOCK TABLES `types` WRITE;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` VALUES (1,'HQ','2014-08-28 17:33:25','2014-08-28 17:33:25'),(2,'Troops','2014-08-28 17:33:29','2014-08-28 17:33:29'),(3,'Elites','2014-08-28 17:33:35','2014-08-28 17:33:35'),(4,'Fast_Attack','2014-08-28 17:33:41','2014-09-01 14:55:48'),(5,'Heavy_support','2014-08-28 17:33:45','2014-09-01 14:48:32'),(6,'Dedicated_transports','2014-08-28 17:33:49','2014-09-01 14:48:38'),(7,'Lords_of_War','2015-02-18 14:56:56','2015-02-18 14:56:56');
/*!40000 ALTER TABLE `types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitcharacteristics`
--

DROP TABLE IF EXISTS `unitcharacteristics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitcharacteristics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `armies_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_unitcharacteristics_armies1_idx` (`armies_id`),
  CONSTRAINT `fk_unitcharacteristics_armies1` FOREIGN KEY (`armies_id`) REFERENCES `armies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitcharacteristics`
--

LOCK TABLES `unitcharacteristics` WRITE;
/*!40000 ALTER TABLE `unitcharacteristics` DISABLE KEYS */;
INSERT INTO `unitcharacteristics` VALUES (1,'Aid Unlooked For',1,'2014-08-28 17:23:41','2014-08-28 17:23:41'),(2,'And they shall know no fear',1,'2014-08-28 17:27:44','2014-08-28 17:27:44'),(3,'Assault Vehicle',1,'2014-08-28 17:27:48','2014-08-28 17:27:48'),(4,'Battle-forged Heroes',1,'2014-08-28 17:27:52','2014-08-28 17:27:52'),(5,'Blessing of the Omnissiah',1,'2014-08-28 17:27:56','2014-08-28 17:27:56'),(6,'Bolster Defences',1,'2014-08-28 17:28:02','2014-08-28 17:28:02'),(7,'Champion of Humanity',1,'2014-08-28 17:28:07','2014-08-28 17:28:07'),(8,'Chapter tactics',1,'2014-08-28 17:28:12','2014-08-28 17:28:12'),(9,'Combat squads',1,'2014-08-28 17:28:16','2014-08-28 17:28:16'),(10,'Crusade of Wrath',1,'2014-08-28 17:28:22','2014-08-28 17:28:22'),(11,'Decimator Protocols',1,'2014-08-28 17:28:26','2014-08-28 17:28:26'),(12,'Deep Strike',1,'2014-08-28 17:28:30','2014-08-28 17:28:30'),(13,'Drop Pod Assault',1,'2014-08-28 17:28:33','2014-08-28 17:28:33'),(14,'Escort Craft',1,'2014-08-28 17:28:38','2014-08-28 17:28:38'),(15,'Eternal Warrior',1,'2014-08-28 17:28:42','2014-08-28 17:28:42'),(16,'Fear',1,'2014-08-28 17:28:48','2014-08-28 17:28:48'),(17,'Fearless',1,'2014-08-28 17:28:52','2014-08-28 17:28:52'),(18,'Feel No Pain',1,'2014-08-28 17:28:56','2014-08-28 17:28:56'),(20,'Flaming Projectiles',1,'2014-08-28 17:29:05','2014-08-28 17:29:05'),(21,'Furious Charge',1,'2014-08-28 17:29:10','2014-08-28 17:29:10'),(22,'Gift of Prescience',1,'2014-08-28 17:29:15','2014-08-28 17:29:15'),(23,'God of War',1,'2014-08-28 17:29:18','2014-08-28 17:29:18'),(24,'Heroic Intervention',1,'2014-08-28 17:29:27','2014-08-28 17:29:27'),(25,'Hold the Line',1,'2014-08-28 17:29:32','2014-08-28 17:29:32'),(26,'Honour or Death (Chapter Champion only)',1,'2014-08-28 17:29:37','2014-08-28 17:29:37'),(27,'Icon of Obstinacy',1,'2014-08-28 17:29:48','2014-08-28 17:29:48'),(28,'Immobile',1,'2014-08-28 17:29:53','2014-08-28 17:29:53'),(29,'Independent character',1,'2014-08-28 17:29:57','2014-08-28 17:29:57'),(30,'Inertial Guidance System',1,'2014-08-28 17:30:03','2014-08-28 17:30:03'),(31,'Infiltrate',1,'2014-08-28 17:30:08','2014-08-28 17:30:08'),(32,'Iron Resolve',1,'2014-08-28 17:30:12','2014-08-28 17:30:12'),(33,'Master of the Hunt',1,'2014-08-28 17:30:27','2014-08-28 17:30:27'),(34,'Master Psyker',1,'2014-08-28 17:30:31','2014-08-28 17:30:31'),(35,'Mindlock',1,'2014-08-28 17:30:35','2014-08-28 17:30:35'),(36,'Move Through Cover',1,'2014-08-28 17:30:41','2014-08-28 17:30:41'),(37,'Oath of Rynn',1,'2014-08-28 17:30:53','2014-08-28 17:30:53'),(39,'Orbital Bombardment',1,'2014-08-28 17:31:02','2014-08-28 17:31:02'),(40,'Psyker (Mastery Level 2)',1,'2014-08-28 17:31:06','2014-08-28 17:31:06'),(41,'Power of the Machine Spirit',1,'2014-08-28 17:31:11','2014-08-28 17:31:11'),(42,'Preferred Enemy (Tyranids)',1,'2014-08-28 17:31:15','2014-08-28 17:31:15'),(43,'Psyker (Mastery Level 1)',1,'2014-08-28 17:31:19','2014-08-28 17:31:19'),(44,'Psyker (Mastery Level 3)',1,'2014-08-28 17:31:23','2014-08-28 17:31:23'),(45,'Relics of Helsreach',1,'2014-08-28 17:31:29','2014-08-28 17:31:29'),(47,'Repair',1,'2014-08-28 17:31:40','2014-08-28 17:31:40'),(48,'Rites of Battle',1,'2014-08-28 17:31:44','2014-08-28 17:31:44'),(49,'Rites of War',1,'2014-08-28 17:31:48','2014-08-28 17:31:48'),(50,'Scout',1,'2014-08-28 17:31:55','2014-08-28 17:31:55'),(51,'See, But Remain Unseen',1,'2014-08-28 17:32:00','2014-08-28 17:32:00'),(53,'Sixteen models',1,'2014-08-28 17:32:08','2014-08-28 17:32:08'),(54,'Skies of Fury',1,'2014-08-28 17:32:12','2014-08-28 17:32:12'),(55,'Slayer of Champions',1,'2014-08-28 17:32:16','2014-08-28 17:32:16'),(57,'The Angel of Death',1,'2014-08-28 17:32:26','2014-08-28 17:32:26'),(58,'The Forgefather',1,'2014-08-28 17:32:30','2014-08-28 17:32:30'),(59,'The Imperium\'s Sword',1,'2014-08-28 17:32:33','2014-08-28 17:32:33'),(60,'Ultramarines Tank Commander',1,'2014-08-28 17:32:40','2014-08-28 17:32:40'),(61,'Unmatched Zeal',1,'2014-08-28 17:32:44','2014-08-28 17:32:44'),(62,'Unyielding Spectres',1,'2014-08-28 17:32:48','2014-08-28 17:32:48'),(63,'Venerable (Venerable Dreadnought only)',1,'2014-08-28 17:32:53','2014-08-28 17:32:53'),(64,'Very Bulky',1,'2014-08-28 17:32:58','2014-08-28 17:32:58'),(65,'Zealot',1,'2014-08-28 17:33:12','2014-08-28 17:33:12'),(66,'Titanic Might',1,'2014-08-28 18:00:13','2014-08-28 18:00:13'),(67,'Surprise Attack',1,'2014-08-29 09:41:06','2014-08-29 09:41:06'),(68,'It Will Not Die',1,'2014-08-29 10:38:40','2014-08-29 10:38:40'),(69,'Eye of Vengeance',1,'2014-08-29 12:04:58','2014-08-29 12:04:58'),(70,'Stealth',1,'2014-08-29 12:05:06','2014-08-29 12:05:06'),(71,'Voice of Experience',1,'2014-08-29 12:05:12','2014-08-29 12:05:12'),(72,'Acute Senses',1,'2014-08-29 12:07:28','2014-08-29 12:07:28'),(73,'Slow and Purposeful',1,'2014-08-29 14:18:24','2014-08-29 14:18:24'),(74,'Strafing Run',1,'2014-08-29 15:08:32','2014-08-29 15:08:32'),(75,'Hatred (Orks)',2,'2015-02-06 13:27:33','2015-02-06 13:27:33'),(76,'Rage',2,'2015-02-06 13:35:33','2015-02-06 13:35:33'),(77,'Relentless',2,'2015-02-06 13:35:39','2015-02-06 13:35:39'),(78,'Psychic Pilot (Mastery Level 1)',2,'2015-02-06 13:43:58','2015-02-06 13:43:58'),(79,'Fleet',2,'2015-02-06 13:49:26','2015-02-06 13:49:26'),(80,'Transfixing Gaze',2,'2015-02-06 13:50:09','2015-02-06 13:50:09'),(81,'Aura of Fervour',2,'2015-02-06 14:04:58','2015-02-06 14:04:58'),(82,'Avenging Angel',2,'2015-02-06 14:05:03','2015-02-06 14:05:03'),(83,'Liturgies of Blood',2,'2015-02-06 14:11:52','2015-02-06 14:11:52'),(84,'Far-Seeing Eye',2,'2015-02-06 14:23:06','2015-02-06 14:23:06'),(85,'Fire Points',2,'2015-02-18 13:36:51','2015-02-18 13:36:51'),(86,'Access Points',2,'2015-02-18 13:36:56','2015-02-18 13:36:56'),(87,'Hit & Run',2,'2015-02-19 13:00:08','2015-02-19 13:00:08'),(88,'Tactical Precision',2,'2015-02-19 13:00:21','2015-02-19 13:00:21'),(89,'Whirlwind of Gore',2,'2015-02-19 13:02:38','2015-02-19 13:02:38');
/*!40000 ALTER TABLE `unitcharacteristics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitgroups`
--

DROP TABLE IF EXISTS `unitgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `min_count` int(4) DEFAULT NULL,
  `max_count` int(4) DEFAULT NULL,
  `squadunits_id` int(11) NOT NULL,
  `groups_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_unitgroups_squadunits1_idx` (`squadunits_id`),
  KEY `fk_unitgroups_groups1_idx` (`groups_id`),
  CONSTRAINT `fk_unitgroups_groups1` FOREIGN KEY (`groups_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_unitgroups_squadunits1` FOREIGN KEY (`squadunits_id`) REFERENCES `squadunits` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=247 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitgroups`
--

LOCK TABLES `unitgroups` WRITE;
/*!40000 ALTER TABLE `unitgroups` DISABLE KEYS */;
INSERT INTO `unitgroups` VALUES (1,0,0,1,10,'2014-08-29 09:37:50','2014-08-29 09:37:55'),(2,0,0,5,11,'2014-08-29 10:09:37','2014-08-29 10:09:41'),(3,0,0,15,12,'2014-08-29 10:48:19','2014-08-29 10:48:24'),(4,NULL,NULL,15,7,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(5,NULL,NULL,15,9,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(6,NULL,NULL,15,2,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(7,NULL,NULL,15,1,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(8,NULL,NULL,15,3,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(9,NULL,NULL,15,6,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(10,NULL,NULL,16,13,'2014-08-29 10:53:57','2014-08-29 10:53:57'),(11,NULL,NULL,17,14,'2014-08-29 10:54:53','2014-08-29 10:54:53'),(12,NULL,NULL,18,15,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(13,NULL,NULL,18,7,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(14,NULL,NULL,18,2,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(15,NULL,NULL,18,1,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(16,NULL,NULL,18,6,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(17,NULL,NULL,19,7,'2014-08-29 11:04:10','2014-08-29 11:04:10'),(18,NULL,NULL,19,9,'2014-08-29 11:04:10','2014-08-29 11:04:10'),(19,NULL,NULL,19,3,'2014-08-29 11:04:10','2014-08-29 11:04:10'),(20,NULL,NULL,19,6,'2014-08-29 11:04:10','2014-08-29 11:04:10'),(21,NULL,NULL,20,16,'2014-08-29 11:11:24','2014-08-29 11:11:24'),(22,NULL,NULL,20,2,'2014-08-29 11:11:24','2014-08-29 11:11:24'),(23,NULL,NULL,20,1,'2014-08-29 11:11:24','2014-08-29 11:11:24'),(40,NULL,NULL,21,7,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(41,NULL,NULL,21,18,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(42,NULL,NULL,21,17,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(43,NULL,NULL,21,1,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(44,NULL,NULL,21,6,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(45,NULL,NULL,22,20,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(46,NULL,NULL,22,19,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(47,NULL,NULL,22,7,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(48,NULL,NULL,22,1,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(49,NULL,NULL,22,6,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(55,NULL,NULL,23,7,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(56,NULL,NULL,23,21,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(57,NULL,NULL,23,2,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(58,NULL,NULL,23,1,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(59,NULL,NULL,23,6,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(60,NULL,NULL,24,23,'2014-08-29 11:39:32','2014-08-29 11:39:32'),(61,NULL,NULL,25,2,'2014-08-29 11:40:47','2014-08-29 11:40:47'),(62,NULL,NULL,25,1,'2014-08-29 11:40:47','2014-08-29 11:40:47'),(63,NULL,NULL,25,6,'2014-08-29 11:40:47','2014-08-29 11:40:47'),(64,NULL,NULL,25,22,'2014-08-29 11:40:47','2014-08-29 11:40:47'),(65,NULL,NULL,26,4,'2014-08-29 11:43:58','2014-08-29 11:43:58'),(66,NULL,NULL,26,5,'2014-08-29 11:43:58','2014-08-29 11:43:58'),(67,NULL,NULL,27,2,'2014-08-29 11:45:41','2014-08-29 11:45:41'),(68,NULL,NULL,27,1,'2014-08-29 11:45:41','2014-08-29 11:45:41'),(69,NULL,NULL,27,24,'2014-08-29 11:45:41','2014-08-29 11:45:41'),(70,NULL,NULL,28,25,'2014-08-29 12:03:36','2014-08-29 12:03:36'),(71,NULL,NULL,29,26,'2014-08-29 12:04:14','2014-08-29 12:04:14'),(72,NULL,NULL,31,27,'2014-08-29 12:16:17','2014-08-29 12:16:17'),(73,NULL,NULL,31,28,'2014-08-29 12:16:17','2014-08-29 12:16:17'),(74,NULL,NULL,32,29,'2014-08-29 12:17:01','2014-08-29 12:17:01'),(76,NULL,NULL,33,8,'2014-08-29 12:23:37','2014-08-29 12:23:37'),(77,NULL,NULL,34,30,'2014-08-29 12:27:57','2014-08-29 12:27:57'),(78,NULL,NULL,35,31,'2014-08-29 12:30:25','2014-08-29 12:30:25'),(80,NULL,NULL,36,32,'2014-08-29 12:32:13','2014-08-29 12:32:13'),(81,NULL,NULL,38,2,'2014-08-29 12:45:36','2014-08-29 12:45:36'),(82,NULL,NULL,38,33,'2014-08-29 12:45:36','2014-08-29 12:45:36'),(84,NULL,NULL,39,2,'2014-08-29 12:50:14','2014-08-29 12:50:14'),(85,NULL,NULL,39,34,'2014-08-29 12:50:14','2014-08-29 12:50:14'),(89,NULL,NULL,40,4,'2014-08-29 12:54:33','2014-08-29 12:54:33'),(90,NULL,NULL,40,5,'2014-08-29 12:54:33','2014-08-29 12:54:33'),(91,NULL,NULL,40,35,'2014-08-29 12:54:33','2014-08-29 12:54:33'),(92,NULL,NULL,41,4,'2014-08-29 12:54:47','2014-08-29 12:54:47'),(93,NULL,NULL,41,1,'2014-08-29 12:54:47','2014-08-29 12:54:47'),(94,NULL,NULL,41,36,'2014-08-29 12:54:47','2014-08-29 12:54:47'),(95,NULL,NULL,42,37,'2014-08-29 14:06:07','2014-08-29 14:06:07'),(96,NULL,NULL,43,38,'2014-08-29 14:11:05','2014-08-29 14:11:05'),(100,NULL,NULL,44,4,'2014-08-29 14:20:06','2014-08-29 14:20:06'),(101,NULL,NULL,44,39,'2014-08-29 14:20:06','2014-08-29 14:20:06'),(102,NULL,NULL,45,40,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(103,NULL,NULL,45,1,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(106,NULL,NULL,46,41,'2014-08-29 14:39:55','2014-08-29 14:39:55'),(107,NULL,NULL,47,41,'2014-08-29 14:40:45','2014-08-29 14:40:45'),(108,NULL,NULL,48,42,'2014-08-29 14:41:54','2014-08-29 14:41:54'),(109,NULL,NULL,49,42,'2014-08-29 14:42:27','2014-08-29 14:42:27'),(111,NULL,NULL,50,43,'2014-08-29 14:48:44','2014-08-29 14:48:44'),(112,NULL,NULL,51,44,'2014-08-29 14:49:24','2014-08-29 14:49:24'),(113,NULL,NULL,52,45,'2014-08-29 14:58:17','2014-08-29 14:58:17'),(115,NULL,NULL,54,47,'2014-08-29 15:03:19','2014-08-29 15:03:19'),(117,NULL,NULL,55,48,'2014-08-29 15:08:51','2014-08-29 15:08:51'),(118,NULL,NULL,53,46,'2014-08-29 15:09:58','2014-08-29 15:09:58'),(119,NULL,NULL,53,2,'2014-08-29 15:09:58','2014-08-29 15:09:58'),(120,NULL,NULL,56,49,'2014-08-29 15:14:25','2014-08-29 15:14:25'),(121,NULL,NULL,56,5,'2014-08-29 15:14:25','2014-08-29 15:14:25'),(122,NULL,NULL,57,50,'2014-08-29 15:16:31','2014-08-29 15:16:31'),(123,NULL,NULL,57,2,'2014-08-29 15:16:31','2014-08-29 15:16:31'),(124,NULL,NULL,57,1,'2014-08-29 15:16:31','2014-08-29 15:16:31'),(125,NULL,NULL,58,51,'2014-08-29 15:19:36','2014-08-29 15:19:36'),(126,NULL,NULL,59,52,'2014-08-29 15:25:52','2014-08-29 15:25:52'),(128,NULL,NULL,61,4,'2014-08-29 15:34:33','2014-08-29 15:34:33'),(129,NULL,NULL,60,2,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(130,NULL,NULL,60,1,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(131,NULL,NULL,60,53,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(132,NULL,NULL,62,54,'2014-08-29 15:36:32','2014-08-29 15:36:32'),(133,NULL,NULL,62,2,'2014-08-29 15:36:32','2014-08-29 15:36:32'),(134,NULL,NULL,62,1,'2014-08-29 15:36:32','2014-08-29 15:36:32'),(136,NULL,NULL,63,55,'2014-08-29 15:43:16','2014-08-29 15:43:16'),(137,NULL,NULL,64,56,'2014-08-29 15:43:27','2014-08-29 15:43:27'),(140,NULL,NULL,68,8,'2014-08-29 15:59:13','2014-08-29 15:59:13'),(141,NULL,NULL,67,57,'2014-08-29 15:59:24','2014-08-29 15:59:24'),(142,NULL,NULL,67,8,'2014-08-29 15:59:24','2014-08-29 15:59:24'),(143,NULL,NULL,69,8,'2014-08-29 16:00:31','2014-08-29 16:00:31'),(144,NULL,NULL,69,58,'2014-08-29 16:00:31','2014-08-29 16:00:31'),(146,NULL,NULL,70,8,'2014-08-29 16:01:40','2014-08-29 16:01:40'),(147,NULL,NULL,71,8,'2014-08-29 16:02:32','2014-08-29 16:02:32'),(148,NULL,NULL,72,59,'2014-08-29 16:06:03','2014-08-29 16:06:03'),(149,NULL,NULL,72,8,'2014-08-29 16:06:03','2014-08-29 16:06:03'),(152,NULL,NULL,73,59,'2014-08-29 16:08:05','2014-08-29 16:08:05'),(153,NULL,NULL,73,8,'2014-08-29 16:08:05','2014-08-29 16:08:05'),(154,NULL,NULL,74,59,'2014-08-29 16:09:11','2014-08-29 16:09:11'),(155,NULL,NULL,74,8,'2014-08-29 16:09:11','2014-08-29 16:09:11'),(157,NULL,NULL,76,60,'2014-08-29 16:20:08','2014-08-29 16:20:08'),(159,0,0,77,71,'2015-02-04 15:49:48','2015-02-04 15:53:54'),(161,0,0,77,62,'2015-02-04 15:49:48','2015-02-04 15:55:44'),(162,0,0,77,61,'2015-02-04 15:49:48','2015-02-04 15:55:48'),(163,0,0,77,70,'2015-02-04 15:49:48','2015-02-04 15:55:52'),(164,0,0,77,67,'2015-02-04 15:49:48','2015-02-04 15:55:55'),(165,0,0,78,69,'2015-02-04 16:20:51','2015-02-04 16:20:58'),(166,0,0,78,72,'2015-02-04 16:20:51','2015-02-04 16:21:01'),(167,0,0,78,62,'2015-02-04 16:20:51','2015-02-04 16:21:04'),(168,0,0,78,61,'2015-02-04 16:20:51','2015-02-04 16:21:08'),(169,0,0,78,70,'2015-02-04 16:20:51','2015-02-04 16:21:11'),(170,0,0,78,67,'2015-02-04 16:20:51','2015-02-04 16:21:14'),(171,0,0,81,73,'2015-02-06 13:47:44','2015-02-06 13:47:52'),(172,0,0,86,62,'2015-02-06 14:20:18','2015-02-06 14:20:27'),(173,0,0,86,61,'2015-02-06 14:20:18','2015-02-06 14:20:34'),(174,0,0,86,70,'2015-02-06 14:20:18','2015-02-06 14:20:36'),(175,0,0,86,74,'2015-02-06 14:20:18','2015-02-06 14:20:40'),(176,0,0,86,67,'2015-02-06 14:20:18','2015-02-06 14:20:43'),(177,0,0,88,76,'2015-02-06 14:35:23','2015-02-06 14:35:30'),(178,0,0,89,62,'2015-02-06 14:39:44','2015-02-06 14:39:51'),(179,0,0,89,61,'2015-02-06 14:39:44','2015-02-06 14:39:55'),(180,0,0,89,67,'2015-02-06 14:39:44','2015-02-06 14:39:59'),(181,0,0,89,75,'2015-02-06 14:39:44','2015-02-06 14:40:02'),(182,0,0,90,77,'2015-02-06 14:45:20','2015-02-06 14:45:24'),(183,0,0,90,61,'2015-02-06 14:45:20','2015-02-06 14:45:27'),(184,0,0,90,70,'2015-02-06 14:45:20','2015-02-06 14:45:30'),(185,0,0,90,67,'2015-02-06 14:45:20','2015-02-06 14:45:34'),(186,0,0,91,65,'2015-02-18 13:12:49','2015-02-18 13:12:55'),(187,0,0,91,66,'2015-02-18 13:12:49','2015-02-18 13:13:01'),(188,0,0,92,62,'2015-02-18 13:14:51','2015-02-18 13:14:55'),(189,0,0,92,61,'2015-02-18 13:14:51','2015-02-18 13:15:01'),(190,0,0,92,78,'2015-02-18 13:14:51','2015-02-18 13:15:07'),(191,0,0,93,79,'2015-02-18 13:25:16','2015-02-18 13:25:20'),(192,0,0,94,62,'2015-02-18 13:26:53','2015-02-18 13:26:59'),(193,0,0,94,61,'2015-02-18 13:26:53','2015-02-18 13:27:02'),(194,0,0,94,80,'2015-02-18 13:26:53','2015-02-18 13:27:06'),(195,0,0,95,68,'2015-02-18 13:41:00','2015-02-18 13:41:07'),(196,0,0,96,81,'2015-02-18 13:47:21','2015-02-18 13:47:26'),(197,0,0,96,68,'2015-02-18 13:47:21','2015-02-18 13:47:29'),(198,0,0,97,82,'2015-02-18 13:58:06','2015-02-18 13:58:10'),(199,0,0,98,83,'2015-02-18 14:06:01','2015-02-18 14:06:13'),(200,0,0,98,84,'2015-02-18 14:06:01','2015-02-18 14:06:16'),(201,0,0,99,85,'2015-02-18 14:12:50','2015-02-18 14:12:54'),(202,0,0,100,86,'2015-02-18 14:14:25','2015-02-18 14:14:29'),(203,0,0,100,62,'2015-02-18 14:14:25','2015-02-18 14:14:32'),(204,0,0,100,61,'2015-02-18 14:14:25','2015-02-18 14:14:39'),(211,0,0,101,88,'2015-02-18 14:29:39','2015-02-18 14:29:44'),(212,0,0,101,87,'2015-02-18 14:29:39','2015-02-18 14:29:47'),(213,0,0,101,66,'2015-02-18 14:29:39','2015-02-18 14:29:50'),(214,0,0,102,89,'2015-02-18 14:32:30','2015-02-18 14:32:34'),(215,0,0,102,62,'2015-02-18 14:32:30','2015-02-18 14:32:38'),(216,0,0,102,61,'2015-02-18 14:32:30','2015-02-18 14:32:43'),(217,0,0,102,87,'2015-02-18 14:32:30','2015-02-18 14:32:47'),(218,0,0,103,90,'2015-02-18 14:37:31','2015-02-18 14:37:35'),(219,0,0,104,91,'2015-02-18 14:53:11','2015-02-18 14:53:19'),(220,0,0,105,62,'2015-02-18 14:56:05','2015-02-18 14:56:10'),(221,0,0,105,61,'2015-02-18 14:56:05','2015-02-18 14:56:14'),(222,0,0,105,80,'2015-02-18 14:56:05','2015-02-18 14:56:19'),(223,0,0,106,93,'2015-02-19 12:31:47','2015-02-19 12:31:51'),(224,0,0,106,94,'2015-02-19 12:31:47','2015-02-19 12:31:54'),(225,0,0,106,95,'2015-02-19 12:31:47','2015-02-19 12:31:57'),(226,0,0,107,65,'2015-02-19 12:35:42','2015-02-19 12:35:45'),(227,0,0,108,96,'2015-02-19 12:36:33','2015-02-19 12:36:37'),(228,0,0,108,62,'2015-02-19 12:36:33','2015-02-19 12:36:41'),(229,0,0,108,61,'2015-02-19 12:36:33','2015-02-19 12:36:44'),(230,0,0,109,97,'2015-02-19 12:41:43','2015-02-19 12:41:47'),(231,0,0,109,98,'2015-02-19 12:41:43','2015-02-19 12:41:51'),(232,0,0,109,68,'2015-02-19 12:41:43','2015-02-19 12:41:54'),(233,0,0,110,100,'2015-02-19 12:44:42','2015-02-19 12:45:46'),(234,0,0,110,99,'2015-02-19 12:44:42','2015-02-19 12:45:48'),(235,0,0,110,101,'2015-02-19 12:44:42','2015-02-19 12:45:51'),(236,0,0,110,68,'2015-02-19 12:44:42','2015-02-19 12:45:54'),(237,0,0,111,68,'2015-02-19 12:47:42','2015-02-19 12:47:46'),(238,0,0,111,102,'2015-02-19 12:47:42','2015-02-19 12:47:49'),(239,0,0,112,68,'2015-02-19 12:49:17','2015-02-19 12:49:23'),(240,0,0,112,103,'2015-02-19 12:49:17','2015-02-19 12:49:26'),(241,0,0,113,104,'2015-02-19 12:52:48','2015-02-19 12:52:51'),(242,0,0,114,104,'2015-02-19 12:54:22','2015-02-19 12:54:26'),(243,0,0,115,104,'2015-02-19 12:56:38','2015-02-19 12:56:41'),(244,0,0,115,68,'2015-02-19 12:56:38','2015-02-19 12:56:44'),(245,0,0,113,68,'2015-02-19 13:12:40','2015-02-19 13:12:40'),(246,0,0,114,68,'2015-02-19 13:12:40','2015-02-19 13:12:40');
/*!40000 ALTER TABLE `unitgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitpsykers`
--

DROP TABLE IF EXISTS `unitpsykers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitpsykers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `psykers_id` int(11) NOT NULL,
  `squadunits_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_unitpsyker_psykers1_idx` (`psykers_id`),
  KEY `fk_unitpsyker_squadunits1_idx` (`squadunits_id`),
  CONSTRAINT `fk_unitpsyker_psykers1` FOREIGN KEY (`psykers_id`) REFERENCES `psykers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_unitpsyker_squadunits1` FOREIGN KEY (`squadunits_id`) REFERENCES `squadunits` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitpsykers`
--

LOCK TABLES `unitpsykers` WRITE;
/*!40000 ALTER TABLE `unitpsykers` DISABLE KEYS */;
INSERT INTO `unitpsykers` VALUES (1,1,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(2,2,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(3,3,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(4,4,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(5,5,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(18,1,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(19,3,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(20,4,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(21,5,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(22,1,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(23,7,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(24,2,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(25,3,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(26,6,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(27,1,81,'2015-02-06 13:47:44','2015-02-06 13:47:44'),(28,7,81,'2015-02-06 13:47:44','2015-02-06 13:47:44'),(29,2,81,'2015-02-06 13:47:44','2015-02-06 13:47:44'),(30,3,81,'2015-02-06 13:47:44','2015-02-06 13:47:44'),(31,6,81,'2015-02-06 13:47:44','2015-02-06 13:47:44'),(32,1,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(33,7,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(34,2,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(35,3,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(36,6,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(37,8,82,'2015-02-06 14:02:23','2015-02-06 14:02:23');
/*!40000 ALTER TABLE `unitpsykers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitqualities`
--

DROP TABLE IF EXISTS `unitqualities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitqualities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `unitcharacteristics_id` int(11) NOT NULL,
  `squadunits_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_squadquality_squadcharacteristics1_idx` (`unitcharacteristics_id`),
  KEY `fk_unitqualities_squadunits1_idx` (`squadunits_id`),
  CONSTRAINT `fk_squadquality_squadcharacteristics1` FOREIGN KEY (`unitcharacteristics_id`) REFERENCES `unitcharacteristics` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_unitqualities_squadunits1` FOREIGN KEY (`squadunits_id`) REFERENCES `squadunits` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=499 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitqualities`
--

LOCK TABLES `unitqualities` WRITE;
/*!40000 ALTER TABLE `unitqualities` DISABLE KEYS */;
INSERT INTO `unitqualities` VALUES (1,2,1,'2014-08-29 09:37:50','2014-08-29 09:37:50'),(2,8,1,'2014-08-29 09:37:50','2014-08-29 09:37:50'),(3,15,1,'2014-08-29 09:37:50','2014-08-29 09:37:50'),(4,23,1,'2014-08-29 09:37:50','2014-08-29 09:37:50'),(5,29,1,'2014-08-29 09:37:50','2014-08-29 09:37:50'),(6,66,1,'2014-08-29 09:37:50','2014-08-29 09:37:50'),(7,2,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(8,4,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(9,8,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(10,29,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(11,48,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(12,67,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(13,2,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(14,8,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(15,22,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(16,29,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(17,34,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(18,44,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(24,8,4,'2014-08-29 10:01:55','2014-08-29 10:01:55'),(25,18,4,'2014-08-29 10:01:55','2014-08-29 10:01:55'),(26,29,4,'2014-08-29 10:01:55','2014-08-29 10:01:55'),(27,42,4,'2014-08-29 10:01:55','2014-08-29 10:01:55'),(28,65,4,'2014-08-29 10:01:55','2014-08-29 10:01:55'),(29,2,5,'2014-08-29 10:09:37','2014-08-29 10:09:37'),(30,8,5,'2014-08-29 10:09:37','2014-08-29 10:09:37'),(31,21,5,'2014-08-29 10:09:37','2014-08-29 10:09:37'),(32,29,5,'2014-08-29 10:09:37','2014-08-29 10:09:37'),(33,33,5,'2014-08-29 10:09:37','2014-08-29 10:09:37'),(34,2,6,'2014-08-29 10:13:24','2014-08-29 10:13:24'),(35,8,6,'2014-08-29 10:13:24','2014-08-29 10:13:24'),(36,29,6,'2014-08-29 10:13:24','2014-08-29 10:13:24'),(37,58,6,'2014-08-29 10:13:24','2014-08-29 10:13:24'),(38,2,7,'2014-08-29 10:17:03','2014-08-29 10:17:03'),(39,8,7,'2014-08-29 10:17:03','2014-08-29 10:17:03'),(40,29,7,'2014-08-29 10:17:03','2014-08-29 10:17:03'),(41,51,7,'2014-08-29 10:17:03','2014-08-29 10:17:03'),(42,2,8,'2014-08-29 10:25:24','2014-08-29 10:25:24'),(43,8,8,'2014-08-29 10:25:24','2014-08-29 10:25:24'),(44,15,8,'2014-08-29 10:25:24','2014-08-29 10:25:24'),(45,27,8,'2014-08-29 10:25:24','2014-08-29 10:25:24'),(46,29,8,'2014-08-29 10:25:24','2014-08-29 10:25:24'),(47,2,9,'2014-08-29 10:27:11','2014-08-29 10:27:11'),(48,8,9,'2014-08-29 10:27:11','2014-08-29 10:27:11'),(49,25,9,'2014-08-29 10:27:11','2014-08-29 10:27:11'),(50,29,9,'2014-08-29 10:27:11','2014-08-29 10:27:11'),(51,37,9,'2014-08-29 10:27:11','2014-08-29 10:27:11'),(52,39,9,'2014-08-29 10:27:11','2014-08-29 10:27:11'),(53,2,10,'2014-08-29 10:33:24','2014-08-29 10:33:24'),(54,8,10,'2014-08-29 10:33:24','2014-08-29 10:33:24'),(55,10,10,'2014-08-29 10:33:24','2014-08-29 10:33:24'),(56,29,10,'2014-08-29 10:33:24','2014-08-29 10:33:24'),(57,45,12,'2014-08-29 10:37:12','2014-08-29 10:37:12'),(62,8,13,'2014-08-29 10:39:52','2014-08-29 10:39:52'),(63,29,13,'2014-08-29 10:39:52','2014-08-29 10:39:52'),(64,68,13,'2014-08-29 10:39:52','2014-08-29 10:39:52'),(65,61,13,'2014-08-29 10:39:52','2014-08-29 10:39:52'),(66,65,13,'2014-08-29 10:39:52','2014-08-29 10:39:52'),(67,8,14,'2014-08-29 10:41:34','2014-08-29 10:41:34'),(68,17,14,'2014-08-29 10:41:34','2014-08-29 10:41:34'),(69,29,14,'2014-08-29 10:41:34','2014-08-29 10:41:34'),(70,55,14,'2014-08-29 10:41:34','2014-08-29 10:41:34'),(71,2,15,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(72,8,15,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(73,29,15,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(74,39,15,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(75,2,16,'2014-08-29 10:53:57','2014-08-29 10:53:57'),(76,8,16,'2014-08-29 10:53:57','2014-08-29 10:53:57'),(77,2,17,'2014-08-29 10:54:53','2014-08-29 10:54:53'),(78,8,17,'2014-08-29 10:54:53','2014-08-29 10:54:53'),(79,26,17,'2014-08-29 10:54:53','2014-08-29 10:54:53'),(83,2,18,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(84,8,18,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(85,29,18,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(86,2,19,'2014-08-29 11:04:10','2014-08-29 11:04:10'),(87,8,19,'2014-08-29 11:04:10','2014-08-29 11:04:10'),(88,29,19,'2014-08-29 11:04:10','2014-08-29 11:04:10'),(89,2,20,'2014-08-29 11:11:24','2014-08-29 11:11:24'),(90,8,20,'2014-08-29 11:11:24','2014-08-29 11:11:24'),(91,26,20,'2014-08-29 11:11:24','2014-08-29 11:11:24'),(104,2,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(105,8,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(106,29,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(107,43,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(108,8,22,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(109,29,22,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(110,65,22,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(116,2,23,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(117,5,23,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(118,6,23,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(119,8,23,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(120,29,23,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(122,35,24,'2014-08-29 11:39:32','2014-08-29 11:39:32'),(123,2,25,'2014-08-29 11:40:46','2014-08-29 11:40:46'),(124,5,25,'2014-08-29 11:40:46','2014-08-29 11:40:46'),(125,6,25,'2014-08-29 11:40:46','2014-08-29 11:40:46'),(126,8,25,'2014-08-29 11:40:46','2014-08-29 11:40:46'),(127,29,25,'2014-08-29 11:40:46','2014-08-29 11:40:46'),(128,2,26,'2014-08-29 11:43:58','2014-08-29 11:43:58'),(129,8,26,'2014-08-29 11:43:58','2014-08-29 11:43:58'),(130,9,26,'2014-08-29 11:43:58','2014-08-29 11:43:58'),(131,2,27,'2014-08-29 11:45:41','2014-08-29 11:45:41'),(132,8,27,'2014-08-29 11:45:41','2014-08-29 11:45:41'),(133,9,27,'2014-08-29 11:45:41','2014-08-29 11:45:41'),(134,2,28,'2014-08-29 12:03:36','2014-08-29 12:03:36'),(135,8,28,'2014-08-29 12:03:36','2014-08-29 12:03:36'),(136,9,28,'2014-08-29 12:03:36','2014-08-29 12:03:36'),(137,31,28,'2014-08-29 12:03:36','2014-08-29 12:03:36'),(138,36,28,'2014-08-29 12:03:36','2014-08-29 12:03:36'),(139,50,28,'2014-08-29 12:03:36','2014-08-29 12:03:36'),(149,72,30,'2014-08-29 12:07:54','2014-08-29 12:07:54'),(150,2,30,'2014-08-29 12:07:54','2014-08-29 12:07:54'),(151,8,30,'2014-08-29 12:07:54','2014-08-29 12:07:54'),(152,9,30,'2014-08-29 12:07:54','2014-08-29 12:07:54'),(153,69,30,'2014-08-29 12:07:54','2014-08-29 12:07:54'),(154,31,30,'2014-08-29 12:07:54','2014-08-29 12:07:54'),(155,36,30,'2014-08-29 12:07:54','2014-08-29 12:07:54'),(156,50,30,'2014-08-29 12:07:54','2014-08-29 12:07:54'),(157,70,30,'2014-08-29 12:07:54','2014-08-29 12:07:54'),(158,71,30,'2014-08-29 12:07:54','2014-08-29 12:07:54'),(159,2,31,'2014-08-29 12:16:17','2014-08-29 12:16:17'),(160,8,31,'2014-08-29 12:16:17','2014-08-29 12:16:17'),(161,2,32,'2014-08-29 12:17:01','2014-08-29 12:17:01'),(162,8,32,'2014-08-29 12:17:01','2014-08-29 12:17:01'),(164,47,33,'2014-08-29 12:23:37','2014-08-29 12:23:37'),(168,13,35,'2014-08-29 12:30:25','2014-08-29 12:30:25'),(169,28,35,'2014-08-29 12:30:25','2014-08-29 12:30:25'),(170,30,35,'2014-08-29 12:30:25','2014-08-29 12:30:25'),(173,12,36,'2014-08-29 12:32:13','2014-08-29 12:32:13'),(174,50,36,'2014-08-29 12:32:13','2014-08-29 12:32:13'),(175,2,38,'2014-08-29 12:45:35','2014-08-29 12:45:35'),(176,8,38,'2014-08-29 12:45:35','2014-08-29 12:45:35'),(177,9,38,'2014-08-29 12:45:35','2014-08-29 12:45:35'),(178,24,38,'2014-08-29 12:45:35','2014-08-29 12:45:35'),(183,2,39,'2014-08-29 12:50:13','2014-08-29 12:50:13'),(184,8,39,'2014-08-29 12:50:13','2014-08-29 12:50:13'),(185,9,39,'2014-08-29 12:50:13','2014-08-29 12:50:13'),(186,24,39,'2014-08-29 12:50:13','2014-08-29 12:50:13'),(196,2,40,'2014-08-29 12:54:33','2014-08-29 12:54:33'),(197,8,40,'2014-08-29 12:54:33','2014-08-29 12:54:33'),(198,9,40,'2014-08-29 12:54:33','2014-08-29 12:54:33'),(199,2,41,'2014-08-29 12:54:47','2014-08-29 12:54:47'),(200,8,41,'2014-08-29 12:54:47','2014-08-29 12:54:47'),(201,9,41,'2014-08-29 12:54:47','2014-08-29 12:54:47'),(202,63,42,'2014-08-29 14:06:07','2014-08-29 14:06:07'),(203,36,43,'2014-08-29 14:11:05','2014-08-29 14:11:05'),(221,1,44,'2014-08-29 14:20:06','2014-08-29 14:20:06'),(222,16,44,'2014-08-29 14:20:06','2014-08-29 14:20:06'),(223,17,44,'2014-08-29 14:20:06','2014-08-29 14:20:06'),(224,20,44,'2014-08-29 14:20:06','2014-08-29 14:20:06'),(225,73,44,'2014-08-29 14:20:06','2014-08-29 14:20:06'),(226,62,44,'2014-08-29 14:20:06','2014-08-29 14:20:06'),(227,1,45,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(228,16,45,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(229,17,45,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(230,20,45,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(231,73,45,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(232,62,45,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(239,2,46,'2014-08-29 14:39:55','2014-08-29 14:39:55'),(240,8,46,'2014-08-29 14:39:55','2014-08-29 14:39:55'),(241,9,46,'2014-08-29 14:39:55','2014-08-29 14:39:55'),(242,2,47,'2014-08-29 14:40:45','2014-08-29 14:40:45'),(243,8,47,'2014-08-29 14:40:45','2014-08-29 14:40:45'),(244,9,47,'2014-08-29 14:40:45','2014-08-29 14:40:45'),(245,2,48,'2014-08-29 14:41:54','2014-08-29 14:41:54'),(246,8,48,'2014-08-29 14:41:54','2014-08-29 14:41:54'),(247,9,48,'2014-08-29 14:41:54','2014-08-29 14:41:54'),(248,2,49,'2014-08-29 14:42:27','2014-08-29 14:42:27'),(249,8,49,'2014-08-29 14:42:27','2014-08-29 14:42:27'),(250,9,49,'2014-08-29 14:42:27','2014-08-29 14:42:27'),(257,2,50,'2014-08-29 14:48:44','2014-08-29 14:48:44'),(258,8,50,'2014-08-29 14:48:44','2014-08-29 14:48:44'),(259,11,50,'2014-08-29 14:48:44','2014-08-29 14:48:44'),(260,36,50,'2014-08-29 14:48:44','2014-08-29 14:48:44'),(261,73,50,'2014-08-29 14:48:44','2014-08-29 14:48:44'),(262,64,50,'2014-08-29 14:48:44','2014-08-29 14:48:44'),(263,2,51,'2014-08-29 14:49:24','2014-08-29 14:49:24'),(264,8,51,'2014-08-29 14:49:24','2014-08-29 14:49:24'),(265,11,51,'2014-08-29 14:49:24','2014-08-29 14:49:24'),(266,36,51,'2014-08-29 14:49:24','2014-08-29 14:49:24'),(267,73,51,'2014-08-29 14:49:24','2014-08-29 14:49:24'),(268,64,51,'2014-08-29 14:49:24','2014-08-29 14:49:24'),(269,2,52,'2014-08-29 14:58:17','2014-08-29 14:58:17'),(270,8,52,'2014-08-29 14:58:17','2014-08-29 14:58:17'),(271,9,52,'2014-08-29 14:58:17','2014-08-29 14:58:17'),(275,12,54,'2014-08-29 15:03:19','2014-08-29 15:03:19'),(277,14,55,'2014-08-29 15:08:51','2014-08-29 15:08:51'),(278,74,55,'2014-08-29 15:08:51','2014-08-29 15:08:51'),(279,2,53,'2014-08-29 15:09:58','2014-08-29 15:09:58'),(280,8,53,'2014-08-29 15:09:58','2014-08-29 15:09:58'),(281,9,53,'2014-08-29 15:09:58','2014-08-29 15:09:58'),(282,2,56,'2014-08-29 15:14:25','2014-08-29 15:14:25'),(283,8,56,'2014-08-29 15:14:25','2014-08-29 15:14:25'),(284,9,56,'2014-08-29 15:14:25','2014-08-29 15:14:25'),(285,2,57,'2014-08-29 15:16:31','2014-08-29 15:16:31'),(286,8,57,'2014-08-29 15:16:31','2014-08-29 15:16:31'),(287,9,57,'2014-08-29 15:16:31','2014-08-29 15:16:31'),(288,2,58,'2014-08-29 15:19:35','2014-08-29 15:19:35'),(289,8,58,'2014-08-29 15:19:35','2014-08-29 15:19:35'),(290,2,59,'2014-08-29 15:25:52','2014-08-29 15:25:52'),(291,8,59,'2014-08-29 15:25:52','2014-08-29 15:25:52'),(292,9,59,'2014-08-29 15:25:52','2014-08-29 15:25:52'),(293,31,59,'2014-08-29 15:25:52','2014-08-29 15:25:52'),(294,50,59,'2014-08-29 15:25:52','2014-08-29 15:25:52'),(300,2,61,'2014-08-29 15:34:33','2014-08-29 15:34:33'),(301,8,61,'2014-08-29 15:34:33','2014-08-29 15:34:33'),(302,9,61,'2014-08-29 15:34:33','2014-08-29 15:34:33'),(303,2,60,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(304,8,60,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(305,9,60,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(306,31,60,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(307,50,60,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(308,2,62,'2014-08-29 15:36:32','2014-08-29 15:36:32'),(309,8,62,'2014-08-29 15:36:32','2014-08-29 15:36:32'),(310,9,62,'2014-08-29 15:36:32','2014-08-29 15:36:32'),(321,2,63,'2014-08-29 15:43:16','2014-08-29 15:43:16'),(322,8,63,'2014-08-29 15:43:16','2014-08-29 15:43:16'),(323,11,63,'2014-08-29 15:43:16','2014-08-29 15:43:16'),(324,73,63,'2014-08-29 15:43:16','2014-08-29 15:43:16'),(325,64,63,'2014-08-29 15:43:16','2014-08-29 15:43:16'),(326,2,64,'2014-08-29 15:43:27','2014-08-29 15:43:27'),(327,8,64,'2014-08-29 15:43:27','2014-08-29 15:43:27'),(328,11,64,'2014-08-29 15:43:27','2014-08-29 15:43:27'),(329,73,64,'2014-08-29 15:43:27','2014-08-29 15:43:27'),(330,64,64,'2014-08-29 15:43:27','2014-08-29 15:43:27'),(331,2,65,'2014-08-29 15:51:16','2014-08-29 15:51:16'),(332,5,65,'2014-08-29 15:51:16','2014-08-29 15:51:16'),(333,6,65,'2014-08-29 15:51:16','2014-08-29 15:51:16'),(334,8,65,'2014-08-29 15:51:16','2014-08-29 15:51:16'),(335,3,72,'2014-08-29 16:06:03','2014-08-29 16:06:03'),(336,41,72,'2014-08-29 16:06:03','2014-08-29 16:06:03'),(339,3,73,'2014-08-29 16:08:05','2014-08-29 16:08:05'),(340,41,73,'2014-08-29 16:08:05','2014-08-29 16:08:05'),(341,3,74,'2014-08-29 16:09:11','2014-08-29 16:09:11'),(342,41,74,'2014-08-29 16:09:11','2014-08-29 16:09:11'),(343,60,75,'2014-08-29 16:11:03','2014-08-29 16:11:03'),(350,3,76,'2014-08-29 16:20:08','2014-08-29 16:20:08'),(351,41,76,'2014-08-29 16:20:08','2014-08-29 16:20:08'),(352,54,76,'2014-08-29 16:20:08','2014-08-29 16:20:08'),(362,2,77,'2015-02-04 15:49:48','2015-02-04 15:49:48'),(363,4,77,'2015-02-04 15:49:48','2015-02-04 15:49:48'),(364,21,77,'2015-02-04 15:49:48','2015-02-04 15:49:48'),(365,29,77,'2015-02-04 15:49:48','2015-02-04 15:49:48'),(366,2,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(367,21,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(368,29,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(369,43,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(370,2,79,'2015-02-06 13:33:15','2015-02-06 13:33:15'),(371,21,79,'2015-02-06 13:33:15','2015-02-06 13:33:15'),(372,75,79,'2015-02-06 13:33:15','2015-02-06 13:33:15'),(373,29,79,'2015-02-06 13:33:15','2015-02-06 13:33:15'),(374,17,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(375,18,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(376,21,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(377,75,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(378,29,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(379,76,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(380,77,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(381,21,81,'2015-02-06 13:47:44','2015-02-06 13:47:44'),(382,78,81,'2015-02-06 13:47:44','2015-02-06 13:47:44'),(383,2,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(384,79,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(385,21,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(386,29,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(387,44,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(388,80,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(389,81,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(390,82,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(391,15,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(392,16,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(393,21,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(394,21,84,'2015-02-06 14:13:41','2015-02-06 14:13:41'),(395,29,84,'2015-02-06 14:13:41','2015-02-06 14:13:41'),(396,65,84,'2015-02-06 14:13:41','2015-02-06 14:13:41'),(397,2,86,'2015-02-06 14:20:18','2015-02-06 14:20:18'),(398,21,86,'2015-02-06 14:20:18','2015-02-06 14:20:18'),(399,29,86,'2015-02-06 14:20:18','2015-02-06 14:20:18'),(400,2,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(401,81,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(402,84,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(403,21,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(404,29,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(405,35,88,'2015-02-06 14:35:23','2015-02-06 14:35:23'),(406,2,89,'2015-02-06 14:39:44','2015-02-06 14:39:44'),(407,5,89,'2015-02-06 14:39:44','2015-02-06 14:39:44'),(408,6,89,'2015-02-06 14:39:44','2015-02-06 14:39:44'),(409,21,89,'2015-02-06 14:39:44','2015-02-06 14:39:44'),(410,29,89,'2015-02-06 14:39:44','2015-02-06 14:39:44'),(411,21,90,'2015-02-06 14:45:20','2015-02-06 14:45:20'),(412,29,90,'2015-02-06 14:45:20','2015-02-06 14:45:20'),(413,65,90,'2015-02-06 14:45:20','2015-02-06 14:45:20'),(414,2,91,'2015-02-18 13:12:49','2015-02-18 13:12:49'),(415,9,91,'2015-02-18 13:12:49','2015-02-18 13:12:49'),(416,21,91,'2015-02-18 13:12:49','2015-02-18 13:12:49'),(417,2,92,'2015-02-18 13:14:51','2015-02-18 13:14:51'),(418,9,92,'2015-02-18 13:14:51','2015-02-18 13:14:51'),(419,21,92,'2015-02-18 13:14:51','2015-02-18 13:14:51'),(420,2,93,'2015-02-18 13:25:16','2015-02-18 13:25:16'),(421,9,93,'2015-02-18 13:25:16','2015-02-18 13:25:16'),(422,21,93,'2015-02-18 13:25:16','2015-02-18 13:25:16'),(423,31,93,'2015-02-18 13:25:16','2015-02-18 13:25:16'),(424,36,93,'2015-02-18 13:25:16','2015-02-18 13:25:16'),(425,50,93,'2015-02-18 13:25:16','2015-02-18 13:25:16'),(426,2,94,'2015-02-18 13:26:53','2015-02-18 13:26:53'),(427,9,94,'2015-02-18 13:26:53','2015-02-18 13:26:53'),(428,21,94,'2015-02-18 13:26:53','2015-02-18 13:26:53'),(429,31,94,'2015-02-18 13:26:53','2015-02-18 13:26:53'),(430,36,94,'2015-02-18 13:26:53','2015-02-18 13:26:53'),(431,50,94,'2015-02-18 13:26:53','2015-02-18 13:26:53'),(432,86,95,'2015-02-18 13:41:00','2015-02-18 13:41:00'),(433,85,95,'2015-02-18 13:41:00','2015-02-18 13:41:00'),(434,47,95,'2015-02-18 13:41:00','2015-02-18 13:41:00'),(435,86,96,'2015-02-18 13:47:21','2015-02-18 13:47:21'),(436,85,96,'2015-02-18 13:47:21','2015-02-18 13:47:21'),(437,13,97,'2015-02-18 13:58:06','2015-02-18 13:58:06'),(438,28,97,'2015-02-18 13:58:06','2015-02-18 13:58:06'),(439,30,97,'2015-02-18 13:58:06','2015-02-18 13:58:06'),(440,12,98,'2015-02-18 14:06:01','2015-02-18 14:06:01'),(441,2,99,'2015-02-18 14:12:50','2015-02-18 14:12:50'),(442,9,99,'2015-02-18 14:12:50','2015-02-18 14:12:50'),(443,21,99,'2015-02-18 14:12:50','2015-02-18 14:12:50'),(444,2,100,'2015-02-18 14:14:25','2015-02-18 14:14:25'),(445,9,100,'2015-02-18 14:14:25','2015-02-18 14:14:25'),(446,21,100,'2015-02-18 14:14:25','2015-02-18 14:14:25'),(450,2,101,'2015-02-18 14:29:39','2015-02-18 14:29:39'),(451,9,101,'2015-02-18 14:29:39','2015-02-18 14:29:39'),(452,21,101,'2015-02-18 14:29:39','2015-02-18 14:29:39'),(453,2,102,'2015-02-18 14:32:30','2015-02-18 14:32:30'),(454,9,102,'2015-02-18 14:32:30','2015-02-18 14:32:30'),(455,21,102,'2015-02-18 14:32:30','2015-02-18 14:32:30'),(456,2,103,'2015-02-18 14:37:31','2015-02-18 14:37:31'),(457,21,103,'2015-02-18 14:37:31','2015-02-18 14:37:31'),(458,2,104,'2015-02-18 14:53:11','2015-02-18 14:53:11'),(459,9,104,'2015-02-18 14:53:11','2015-02-18 14:53:11'),(460,21,104,'2015-02-18 14:53:11','2015-02-18 14:53:11'),(461,31,104,'2015-02-18 14:53:11','2015-02-18 14:53:11'),(462,50,104,'2015-02-18 14:53:11','2015-02-18 14:53:11'),(463,2,105,'2015-02-18 14:56:05','2015-02-18 14:56:05'),(464,9,105,'2015-02-18 14:56:05','2015-02-18 14:56:05'),(465,21,105,'2015-02-18 14:56:05','2015-02-18 14:56:05'),(466,31,105,'2015-02-18 14:56:05','2015-02-18 14:56:05'),(467,50,105,'2015-02-18 14:56:05','2015-02-18 14:56:05'),(468,86,106,'2015-02-19 12:31:47','2015-02-19 12:31:47'),(469,3,106,'2015-02-19 12:31:47','2015-02-19 12:31:47'),(470,41,106,'2015-02-19 12:31:47','2015-02-19 12:31:47'),(471,54,106,'2015-02-19 12:31:47','2015-02-19 12:31:47'),(472,2,107,'2015-02-19 12:35:42','2015-02-19 12:35:42'),(473,9,107,'2015-02-19 12:35:42','2015-02-19 12:35:42'),(474,21,107,'2015-02-19 12:35:42','2015-02-19 12:35:42'),(475,2,108,'2015-02-19 12:36:33','2015-02-19 12:36:33'),(476,9,108,'2015-02-19 12:36:33','2015-02-19 12:36:33'),(477,21,108,'2015-02-19 12:36:33','2015-02-19 12:36:33'),(478,86,113,'2015-02-19 12:52:48','2015-02-19 12:52:48'),(479,3,113,'2015-02-19 12:52:48','2015-02-19 12:52:48'),(480,41,113,'2015-02-19 12:52:48','2015-02-19 12:52:48'),(481,86,114,'2015-02-19 12:54:22','2015-02-19 12:54:22'),(482,3,114,'2015-02-19 12:54:22','2015-02-19 12:54:22'),(483,41,114,'2015-02-19 12:54:22','2015-02-19 12:54:22'),(484,86,115,'2015-02-19 12:56:38','2015-02-19 12:56:38'),(485,3,115,'2015-02-19 12:56:38','2015-02-19 12:56:38'),(486,41,115,'2015-02-19 12:56:38','2015-02-19 12:56:38'),(487,2,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(488,15,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(489,21,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(490,87,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(491,29,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(492,88,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(493,3,117,'2015-02-19 13:05:27','2015-02-19 13:05:27'),(494,17,117,'2015-02-19 13:05:27','2015-02-19 13:05:27'),(495,21,117,'2015-02-19 13:05:27','2015-02-19 13:05:27'),(496,29,117,'2015-02-19 13:05:27','2015-02-19 13:05:27'),(497,76,117,'2015-02-19 13:05:27','2015-02-19 13:05:27'),(498,89,117,'2015-02-19 13:05:27','2015-02-19 13:05:27');
/*!40000 ALTER TABLE `unitqualities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitrelics`
--

DROP TABLE IF EXISTS `unitrelics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitrelics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `relics_id` int(11) NOT NULL,
  `squadunits_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_unitrelics_relics1_idx` (`relics_id`),
  KEY `fk_unitrelics_squadunits1_idx` (`squadunits_id`),
  CONSTRAINT `fk_unitrelics_relics1` FOREIGN KEY (`relics_id`) REFERENCES `relics` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_unitrelics_squadunits1` FOREIGN KEY (`squadunits_id`) REFERENCES `squadunits` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitrelics`
--

LOCK TABLES `unitrelics` WRITE;
/*!40000 ALTER TABLE `unitrelics` DISABLE KEYS */;
INSERT INTO `unitrelics` VALUES (1,6,1,'2014-08-29 09:37:50','2014-08-29 09:37:50'),(2,8,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(3,7,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(4,9,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(5,10,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(7,12,5,'2014-08-29 10:09:37','2014-08-29 10:09:37'),(8,13,6,'2014-08-29 10:13:24','2014-08-29 10:13:24'),(9,15,6,'2014-08-29 10:13:24','2014-08-29 10:13:24'),(10,14,6,'2014-08-29 10:13:24','2014-08-29 10:13:24'),(11,16,7,'2014-08-29 10:17:03','2014-08-29 10:17:03'),(12,18,8,'2014-08-29 10:25:24','2014-08-29 10:25:24'),(13,17,9,'2014-08-29 10:27:11','2014-08-29 10:27:11'),(14,19,10,'2014-08-29 10:33:24','2014-08-29 10:33:24'),(15,20,14,'2014-08-29 10:41:34','2014-08-29 10:41:34'),(16,21,14,'2014-08-29 10:41:34','2014-08-29 10:41:34'),(18,22,30,'2014-08-29 12:07:54','2014-08-29 12:07:54'),(19,23,79,'2015-02-06 13:33:15','2015-02-06 13:33:15'),(20,23,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(21,25,84,'2015-02-06 14:13:41','2015-02-06 14:13:41'),(22,24,84,'2015-02-06 14:13:41','2015-02-06 14:13:41'),(23,26,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(24,27,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(25,28,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(26,29,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(27,30,117,'2015-02-19 13:05:27','2015-02-19 13:05:27');
/*!40000 ALTER TABLE `unitrelics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `weapon_skill` int(4) NOT NULL,
  `ballistic_skill` int(4) NOT NULL,
  `strength` int(4) NOT NULL,
  `toughness` int(4) NOT NULL,
  `initiative` int(4) NOT NULL,
  `wounds` int(4) NOT NULL,
  `attacks` int(4) NOT NULL,
  `leadership` int(4) NOT NULL,
  `armour_save` int(4) NOT NULL,
  `invulnerable_save` int(4) NOT NULL,
  `front_armour` int(4) NOT NULL,
  `side_armour` int(4) NOT NULL,
  `rear_armour` int(4) NOT NULL,
  `hull_hitpoints` int(4) NOT NULL,
  `unittypes_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_units_unitTypes1_idx` (`unittypes_id`),
  CONSTRAINT `fk_units_unitTypes1` FOREIGN KEY (`unittypes_id`) REFERENCES `unittypes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units`
--

LOCK TABLES `units` WRITE;
/*!40000 ALTER TABLE `units` DISABLE KEYS */;
INSERT INTO `units` VALUES (1,6,5,4,4,5,4,4,10,2,4,0,0,0,0,2,'2014-08-28 17:49:07','2014-08-28 17:49:07'),(2,6,5,4,4,5,3,3,10,2,4,0,0,0,0,2,'2014-08-29 09:42:53','2014-08-29 09:42:53'),(3,5,4,4,4,4,3,2,10,3,0,0,0,0,0,2,'2014-08-29 09:53:51','2014-08-29 09:53:51'),(4,5,4,4,6,4,2,2,10,3,4,0,0,0,0,2,'2014-08-29 09:57:00','2014-08-29 09:57:00'),(5,6,5,4,4,5,3,3,10,3,4,0,0,0,0,2,'2014-08-29 10:05:35','2014-08-29 10:05:35'),(6,6,5,4,4,5,3,3,10,2,0,0,0,0,0,2,'2014-08-29 10:11:58','2014-08-29 10:11:58'),(7,6,5,4,4,5,4,3,10,2,4,0,0,0,0,2,'2014-08-29 10:20:31','2014-08-29 10:20:31'),(8,6,5,4,4,5,3,3,10,3,4,0,0,0,0,14,'2014-08-29 10:21:24','2014-08-29 10:21:24'),(9,6,5,4,4,5,4,4,10,3,4,0,0,0,0,2,'2014-08-29 10:25:58','2014-08-29 10:25:58'),(10,5,4,4,4,4,3,3,10,3,4,0,0,0,0,2,'2014-08-29 10:34:32','2014-08-29 10:34:32'),(11,3,3,3,3,3,1,1,8,4,0,0,0,0,0,1,'2014-08-29 10:35:44','2014-08-29 10:35:44'),(12,6,4,4,4,5,2,2,10,2,0,0,0,0,0,2,'2014-08-29 10:40:39','2014-08-29 10:40:39'),(13,4,4,4,4,4,1,2,10,2,0,0,0,0,0,1,'2014-08-29 10:49:10','2014-08-29 10:49:10'),(14,5,4,4,4,4,1,3,10,2,0,0,0,0,0,2,'2014-08-29 10:49:31','2014-08-29 10:49:31'),(15,4,4,4,4,4,1,2,9,3,0,0,0,0,0,1,'2014-08-29 11:05:02','2014-08-29 11:05:02'),(16,5,4,4,4,4,1,2,9,3,0,0,0,0,0,2,'2014-08-29 11:05:27','2014-08-29 11:05:27'),(17,5,4,4,4,4,2,2,10,3,0,0,0,0,0,2,'2014-08-29 11:12:18','2014-08-29 11:12:18'),(18,5,4,4,4,4,2,2,10,3,4,0,0,0,0,2,'2014-08-29 11:25:37','2014-08-29 11:25:37'),(19,4,5,4,4,4,2,2,10,2,0,0,0,0,0,2,'2014-08-29 11:32:31','2014-08-29 11:32:31'),(20,4,4,4,4,4,1,1,8,2,0,0,0,0,0,2,'2014-08-29 11:36:24','2014-08-29 11:36:24'),(21,4,4,4,4,4,1,1,8,3,0,0,0,0,0,1,'2014-08-29 11:41:51','2014-08-29 11:41:51'),(22,4,4,4,4,4,1,1,8,3,0,0,0,0,0,2,'2014-08-29 11:42:26','2014-08-29 11:42:26'),(23,3,3,4,4,4,1,1,8,4,0,0,0,0,0,1,'2014-08-29 11:47:01','2014-08-29 11:47:01'),(24,5,6,4,4,4,1,2,9,4,0,0,0,0,0,2,'2014-08-29 12:05:32','2014-08-29 12:05:32'),(25,0,4,0,0,0,0,0,0,0,0,11,11,10,3,4,'2014-08-29 12:20:01','2014-08-29 12:20:01'),(26,0,4,0,0,0,0,0,0,0,0,12,12,12,3,8,'2014-08-29 12:20:41','2014-08-29 12:20:41'),(27,0,3,0,0,0,0,0,0,0,0,10,10,10,2,3,'2014-08-29 12:21:03','2014-08-29 12:21:03'),(28,4,4,4,4,4,1,2,9,3,0,0,0,0,0,2,'2014-08-29 12:42:39','2014-08-29 12:42:39'),(29,4,4,6,0,4,0,2,0,0,0,12,12,10,3,12,'2014-08-29 12:55:24','2014-08-29 12:55:24'),(30,4,4,6,0,4,0,2,0,0,0,13,13,10,3,12,'2014-08-29 14:10:16','2014-08-29 14:10:16'),(31,4,4,4,4,4,1,2,10,3,3,0,0,0,0,1,'2014-08-29 14:16:25','2014-08-29 14:16:25'),(32,5,4,4,4,4,1,2,10,3,3,0,0,0,0,2,'2014-08-29 14:16:47','2014-08-29 14:16:47'),(33,4,4,4,4,4,1,2,9,2,5,0,0,0,0,1,'2014-08-29 14:37:34','2014-08-29 14:37:34'),(34,4,4,4,4,4,1,2,9,2,5,0,0,0,0,2,'2014-08-29 14:37:48','2014-08-29 14:37:48'),(35,4,4,5,5,4,2,1,8,2,0,0,0,0,0,1,'2014-08-29 14:44:07','2014-08-29 14:44:07'),(36,4,4,5,5,4,2,2,9,2,0,0,0,0,0,2,'2014-08-29 14:44:24','2014-08-29 14:44:24'),(37,0,4,0,0,0,0,0,0,0,0,10,10,10,2,5,'2014-08-29 15:02:06','2014-08-29 15:02:06'),(38,0,4,0,0,0,0,0,0,0,0,11,11,11,2,6,'2014-08-29 15:03:47','2014-08-29 15:03:47'),(39,4,4,4,5,4,1,1,8,3,0,0,0,0,0,10,'2014-08-29 15:12:48','2014-08-29 15:12:48'),(40,4,4,4,5,4,1,1,8,3,0,0,0,0,0,11,'2014-08-29 15:13:05','2014-08-29 15:13:05'),(41,4,4,4,5,4,2,2,8,3,0,0,0,0,0,10,'2014-08-29 15:17:57','2014-08-29 15:17:57'),(42,3,3,4,5,4,1,1,8,4,0,0,0,0,0,10,'2014-08-29 15:23:15','2014-08-29 15:24:00'),(43,4,4,4,5,4,1,1,8,4,0,0,0,0,0,11,'2014-08-29 15:24:33','2014-08-29 15:24:33'),(44,0,0,0,7,0,2,0,0,3,0,0,0,0,0,9,'2014-08-29 15:49:42','2014-08-29 15:49:42'),(45,4,4,4,4,4,1,1,8,2,0,0,0,0,0,9,'2014-08-29 15:49:58','2014-08-29 15:49:58'),(46,0,4,0,0,0,0,0,0,0,0,13,11,10,3,15,'2014-08-29 15:52:56','2014-08-29 15:53:30'),(47,0,4,0,0,0,0,0,0,0,0,12,12,10,3,15,'2014-08-29 15:54:32','2014-08-29 15:54:32'),(48,0,4,0,0,0,0,0,0,0,0,11,11,10,3,15,'2014-08-29 15:58:12','2014-08-29 15:58:12'),(49,0,4,0,0,0,0,0,0,0,0,14,14,14,4,4,'2014-08-29 16:04:21','2014-08-29 16:04:21'),(50,4,5,4,4,4,1,2,9,3,0,0,0,0,0,2,'2014-08-29 16:10:05','2014-08-29 16:10:05'),(51,0,4,0,0,0,0,0,0,0,0,12,12,12,3,7,'2014-08-29 16:12:10','2014-08-29 16:12:10'),(52,6,5,4,4,5,3,4,10,2,0,0,0,0,0,2,'2015-02-06 13:36:41','2015-02-06 13:36:41'),(53,5,4,6,0,0,0,0,0,0,0,13,12,10,3,16,'2015-02-06 13:43:02','2015-02-06 13:43:02'),(54,6,5,5,5,5,3,4,10,2,0,0,0,0,0,2,'2015-02-06 13:53:15','2015-02-06 13:53:15'),(55,8,5,5,4,6,3,4,10,2,4,0,0,0,0,14,'2015-02-06 14:03:03','2015-02-06 14:03:03'),(56,6,5,4,4,5,3,3,10,2,0,0,0,0,0,14,'2015-02-06 14:08:11','2015-02-06 14:08:11'),(57,5,5,4,4,5,3,3,10,3,0,0,0,0,0,2,'2015-02-06 14:22:28','2015-02-06 14:22:28'),(58,4,4,4,4,4,1,1,8,4,0,0,0,0,0,2,'2015-02-18 13:23:00','2015-02-18 13:23:00'),(59,0,4,0,0,0,0,0,0,0,0,11,11,10,3,17,'2015-02-18 13:38:42','2015-02-18 13:38:42'),(60,0,4,0,0,0,0,0,0,0,0,13,11,10,3,18,'2015-02-19 12:40:38','2015-02-19 12:40:38'),(61,6,5,4,4,6,4,4,10,2,4,0,0,0,0,14,'2015-02-19 12:57:34','2015-02-19 12:57:34');
/*!40000 ALTER TABLE `units` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unittransports`
--

DROP TABLE IF EXISTS `unittransports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unittransports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transports_id` int(11) NOT NULL,
  `squadunits_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_unittransports_transports1_idx` (`transports_id`),
  KEY `fk_unittransports_squadunits1_idx` (`squadunits_id`),
  CONSTRAINT `fk_unittransports_squadunits1` FOREIGN KEY (`squadunits_id`) REFERENCES `squadunits` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_unittransports_transports1` FOREIGN KEY (`transports_id`) REFERENCES `transports` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unittransports`
--

LOCK TABLES `unittransports` WRITE;
/*!40000 ALTER TABLE `unittransports` DISABLE KEYS */;
INSERT INTO `unittransports` VALUES (2,1,33,'2014-08-29 12:23:37','2014-08-29 12:23:37'),(3,2,34,'2014-08-29 12:27:57','2014-08-29 12:27:57'),(6,3,35,'2014-08-29 12:30:25','2014-08-29 12:30:25'),(7,4,35,'2014-08-29 12:30:25','2014-08-29 12:30:25'),(8,1,35,'2014-08-29 12:30:25','2014-08-29 12:30:25'),(10,5,36,'2014-08-29 12:32:13','2014-08-29 12:32:13'),(11,1,72,'2014-08-29 16:06:03','2014-08-29 16:06:03'),(12,6,73,'2014-08-29 16:08:05','2014-08-29 16:08:05'),(13,7,74,'2014-08-29 16:09:11','2014-08-29 16:09:11'),(14,8,76,'2014-08-29 16:20:08','2014-08-29 16:20:08'),(15,1,95,'2015-02-18 13:41:00','2015-02-18 13:41:00'),(16,2,96,'2015-02-18 13:47:21','2015-02-18 13:47:21'),(17,8,97,'2015-02-18 13:58:06','2015-02-18 13:58:06'),(18,8,106,'2015-02-19 12:31:47','2015-02-19 12:31:47');
/*!40000 ALTER TABLE `unittransports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unittypes`
--

DROP TABLE IF EXISTS `unittypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unittypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unittypes`
--

LOCK TABLES `unittypes` WRITE;
/*!40000 ALTER TABLE `unittypes` DISABLE KEYS */;
INSERT INTO `unittypes` VALUES (1,'Infantry','2014-08-28 17:34:01','2014-08-28 17:34:01'),(2,'Infantry (Character)','2014-08-28 17:34:04','2014-08-28 17:34:04'),(3,'Vehicle (Fast, Open-topped, Skimmer, Transport)','2014-08-28 17:34:09','2014-08-28 17:34:09'),(4,'Vehicle (Tank, Transport)','2014-08-28 17:34:12','2014-08-28 17:34:12'),(5,'Vehicle (Fast, Skimmer)','2014-08-28 17:34:15','2014-08-28 17:34:15'),(6,'Vehicle (Flyer, Hover)','2014-08-28 17:34:19','2014-08-28 17:34:19'),(7,'Vehicle (Flyer, Hover, Transport)','2014-08-28 17:34:24','2014-08-28 17:34:24'),(8,'Vehicle (Open-topped, Transport)','2014-08-28 17:34:27','2014-08-28 17:34:27'),(9,'Artillery','2014-08-28 17:34:37','2014-08-28 17:34:37'),(10,'Bike','2014-08-28 17:34:42','2014-08-28 17:34:42'),(11,'Bike (Character)','2014-08-28 17:34:45','2014-08-28 17:34:45'),(12,'Vehicle (Walker)','2014-08-28 17:34:53','2014-08-29 12:55:43'),(13,'Jump Infantry','2014-08-28 17:35:07','2014-08-28 17:35:07'),(14,'Jump Infantry (Character)','2014-08-28 17:35:10','2014-08-28 17:35:10'),(15,'Vehicle (Tank)','2014-08-29 15:53:16','2014-08-29 15:53:16'),(16,'Vehicle (Walker, Character)','2015-02-06 13:42:30','2015-02-06 13:42:30'),(17,'Vehicle (Tank, Fast, Transport)','2015-02-18 13:31:17','2015-02-18 13:31:17'),(18,'Vehicle (Tank, Fast)','2015-02-19 12:38:42','2015-02-19 12:38:42');
/*!40000 ALTER TABLE `unittypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitupgrades`
--

DROP TABLE IF EXISTS `unitupgrades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitupgrades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enhancements_id` int(11) NOT NULL,
  `operations_id` int(11) NOT NULL,
  `factor` varchar(50) NOT NULL,
  `wargears_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_unitupgrade_wargears1_idx` (`wargears_id`),
  KEY `fk_unitupgrade_enhancements1_idx` (`enhancements_id`),
  KEY `fk_unitupgrades_operations1_idx` (`operations_id`),
  CONSTRAINT `fk_unitupgrades_operations1` FOREIGN KEY (`operations_id`) REFERENCES `operations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_unitupgrade_enhancements1` FOREIGN KEY (`enhancements_id`) REFERENCES `enhancements` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_unitupgrade_wargears1` FOREIGN KEY (`wargears_id`) REFERENCES `wargears` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitupgrades`
--

LOCK TABLES `unitupgrades` WRITE;
/*!40000 ALTER TABLE `unitupgrades` DISABLE KEYS */;
INSERT INTO `unitupgrades` VALUES (1,3,2,'2',10,'2014-09-02 14:49:38','2014-09-02 14:49:38'),(2,3,2,'2',11,'2014-09-02 14:52:18','2014-09-02 14:52:18'),(3,3,2,'2',13,'2014-09-02 14:53:46','2014-09-02 14:53:46'),(4,9,1,'3',12,'2014-09-02 14:54:59','2014-09-02 14:54:59'),(5,4,1,'1',30,'2014-09-02 14:56:45','2014-09-02 14:56:45'),(6,9,3,'4',61,'2014-09-02 15:06:33','2014-09-02 15:06:33'),(7,14,3,'Veteran Sergeant',77,'2014-09-02 15:10:08','2014-09-02 15:10:08'),(8,3,1,'1',94,'2014-09-02 15:11:19','2014-09-02 15:11:19'),(9,3,1,'1',138,'2014-09-02 15:12:40','2014-09-02 15:12:40'),(10,3,1,'2',139,'2014-09-02 15:13:06','2014-09-02 15:13:06'),(11,3,2,'2',140,'2014-09-02 15:13:44','2014-09-02 15:13:44'),(12,3,1,'2',141,'2014-09-02 15:14:11','2014-09-02 15:14:11'),(13,9,3,'4',80,'2014-09-02 15:17:57','2014-09-02 15:17:57'),(14,9,3,'6',121,'2014-09-02 15:27:51','2014-09-02 15:27:51');
/*!40000 ALTER TABLE `unitupgrades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitwargears`
--

DROP TABLE IF EXISTS `unitwargears`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitwargears` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wargears_id` int(11) NOT NULL,
  `squadunits_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_unitwargear_wargear1_idx` (`wargears_id`),
  KEY `fk_unitwargears_squadunits1_idx` (`squadunits_id`),
  CONSTRAINT `fk_unitwargears_squadunits1` FOREIGN KEY (`squadunits_id`) REFERENCES `squadunits` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_unitwargear_wargear1` FOREIGN KEY (`wargears_id`) REFERENCES `wargears` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=666 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitwargears`
--

LOCK TABLES `unitwargears` WRITE;
/*!40000 ALTER TABLE `unitwargears` DISABLE KEYS */;
INSERT INTO `unitwargears` VALUES (1,42,1,'2014-08-29 09:37:49','2014-08-29 09:37:49'),(2,54,1,'2014-08-29 09:37:49','2014-08-29 09:37:49'),(3,61,1,'2014-08-29 09:37:49','2014-08-29 09:37:49'),(4,65,1,'2014-08-29 09:37:49','2014-08-29 09:37:49'),(5,69,1,'2014-08-29 09:37:49','2014-08-29 09:37:49'),(6,54,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(7,61,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(8,65,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(9,7,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(10,44,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(11,54,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(12,65,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(13,70,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(18,44,4,'2014-08-29 10:01:55','2014-08-29 10:01:55'),(19,79,4,'2014-08-29 10:01:55','2014-08-29 10:01:55'),(20,54,4,'2014-08-29 10:01:55','2014-08-29 10:01:55'),(21,65,4,'2014-08-29 10:01:55','2014-08-29 10:01:55'),(22,70,4,'2014-08-29 10:01:55','2014-08-29 10:01:55'),(23,80,4,'2014-08-29 10:01:55','2014-08-29 10:01:55'),(24,44,5,'2014-08-29 10:09:37','2014-08-29 10:09:37'),(25,54,5,'2014-08-29 10:09:37','2014-08-29 10:09:37'),(26,61,5,'2014-08-29 10:09:37','2014-08-29 10:09:37'),(27,65,5,'2014-08-29 10:09:37','2014-08-29 10:09:37'),(28,70,5,'2014-08-29 10:09:37','2014-08-29 10:09:37'),(29,42,6,'2014-08-29 10:13:24','2014-08-29 10:13:24'),(30,44,6,'2014-08-29 10:13:24','2014-08-29 10:13:24'),(31,54,6,'2014-08-29 10:13:24','2014-08-29 10:13:24'),(32,65,6,'2014-08-29 10:13:24','2014-08-29 10:13:24'),(33,44,7,'2014-08-29 10:17:03','2014-08-29 10:17:03'),(34,54,7,'2014-08-29 10:17:03','2014-08-29 10:17:03'),(35,61,7,'2014-08-29 10:17:03','2014-08-29 10:17:03'),(36,29,7,'2014-08-29 10:17:03','2014-08-29 10:17:03'),(37,65,7,'2014-08-29 10:17:03','2014-08-29 10:17:03'),(38,70,7,'2014-08-29 10:17:03','2014-08-29 10:17:03'),(39,61,8,'2014-08-29 10:25:24','2014-08-29 10:25:24'),(40,12,8,'2014-08-29 10:25:24','2014-08-29 10:25:24'),(41,76,8,'2014-08-29 10:25:24','2014-08-29 10:25:24'),(42,54,9,'2014-08-29 10:27:11','2014-08-29 10:27:11'),(43,61,9,'2014-08-29 10:27:11','2014-08-29 10:27:11'),(44,70,9,'2014-08-29 10:27:11','2014-08-29 10:27:11'),(45,10,9,'2014-08-29 10:27:11','2014-08-29 10:27:11'),(46,42,10,'2014-08-29 10:33:24','2014-08-29 10:33:24'),(47,4,10,'2014-08-29 10:33:24','2014-08-29 10:33:24'),(48,54,10,'2014-08-29 10:33:24','2014-08-29 10:33:24'),(49,61,10,'2014-08-29 10:33:24','2014-08-29 10:33:24'),(50,65,10,'2014-08-29 10:33:24','2014-08-29 10:33:24'),(56,79,13,'2014-08-29 10:39:52','2014-08-29 10:39:52'),(57,54,13,'2014-08-29 10:39:52','2014-08-29 10:39:52'),(58,65,13,'2014-08-29 10:39:52','2014-08-29 10:39:52'),(59,82,13,'2014-08-29 10:39:52','2014-08-29 10:39:52'),(60,70,13,'2014-08-29 10:39:52','2014-08-29 10:39:52'),(61,80,13,'2014-08-29 10:39:52','2014-08-29 10:39:52'),(62,44,14,'2014-08-29 10:41:34','2014-08-29 10:41:34'),(63,54,14,'2014-08-29 10:41:34','2014-08-29 10:41:34'),(64,65,14,'2014-08-29 10:41:34','2014-08-29 10:41:34'),(65,44,15,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(66,83,15,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(67,54,15,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(68,61,15,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(69,65,15,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(70,70,15,'2014-08-29 10:48:19','2014-08-29 10:48:19'),(71,42,16,'2014-08-29 10:53:57','2014-08-29 10:53:57'),(72,44,16,'2014-08-29 10:53:57','2014-08-29 10:53:57'),(73,45,16,'2014-08-29 10:53:57','2014-08-29 10:53:57'),(74,54,16,'2014-08-29 10:53:57','2014-08-29 10:53:57'),(75,65,16,'2014-08-29 10:53:57','2014-08-29 10:53:57'),(76,8,16,'2014-08-29 10:53:57','2014-08-29 10:53:57'),(77,42,17,'2014-08-29 10:54:53','2014-08-29 10:54:53'),(78,44,17,'2014-08-29 10:54:53','2014-08-29 10:54:53'),(79,45,17,'2014-08-29 10:54:53','2014-08-29 10:54:53'),(80,54,17,'2014-08-29 10:54:53','2014-08-29 10:54:53'),(81,65,17,'2014-08-29 10:54:53','2014-08-29 10:54:53'),(82,69,17,'2014-08-29 10:54:53','2014-08-29 10:54:53'),(89,44,18,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(90,83,18,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(91,54,18,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(92,61,18,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(93,65,18,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(94,70,18,'2014-08-29 11:02:43','2014-08-29 11:02:43'),(95,61,19,'2014-08-29 11:04:10','2014-08-29 11:04:10'),(96,69,19,'2014-08-29 11:04:10','2014-08-29 11:04:10'),(97,1,19,'2014-08-29 11:04:10','2014-08-29 11:04:10'),(98,76,19,'2014-08-29 11:04:10','2014-08-29 11:04:10'),(99,44,20,'2014-08-29 11:11:24','2014-08-29 11:11:24'),(100,83,20,'2014-08-29 11:11:24','2014-08-29 11:11:24'),(101,54,20,'2014-08-29 11:11:24','2014-08-29 11:11:24'),(102,65,20,'2014-08-29 11:11:24','2014-08-29 11:11:24'),(103,70,20,'2014-08-29 11:11:24','2014-08-29 11:11:24'),(120,44,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(121,90,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(122,54,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(123,65,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(124,70,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(125,91,21,'2014-08-29 11:21:59','2014-08-29 11:21:59'),(126,44,22,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(127,79,22,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(128,54,22,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(129,65,22,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(130,70,22,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(131,80,22,'2014-08-29 11:31:30','2014-08-29 11:31:30'),(137,42,23,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(138,44,23,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(139,45,23,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(140,54,23,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(141,65,23,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(142,95,23,'2014-08-29 11:35:53','2014-08-29 11:35:53'),(144,96,24,'2014-08-29 11:39:32','2014-08-29 11:39:32'),(145,42,25,'2014-08-29 11:40:46','2014-08-29 11:40:46'),(146,44,25,'2014-08-29 11:40:46','2014-08-29 11:40:46'),(147,45,25,'2014-08-29 11:40:46','2014-08-29 11:40:46'),(148,54,25,'2014-08-29 11:40:46','2014-08-29 11:40:46'),(149,65,25,'2014-08-29 11:40:46','2014-08-29 11:40:46'),(150,96,25,'2014-08-29 11:40:46','2014-08-29 11:40:46'),(151,44,26,'2014-08-29 11:43:58','2014-08-29 11:43:58'),(152,45,26,'2014-08-29 11:43:58','2014-08-29 11:43:58'),(153,54,26,'2014-08-29 11:43:58','2014-08-29 11:43:58'),(154,65,26,'2014-08-29 11:43:58','2014-08-29 11:43:58'),(155,70,26,'2014-08-29 11:43:58','2014-08-29 11:43:58'),(156,44,27,'2014-08-29 11:45:41','2014-08-29 11:45:41'),(157,45,27,'2014-08-29 11:45:41','2014-08-29 11:45:41'),(158,54,27,'2014-08-29 11:45:41','2014-08-29 11:45:41'),(159,65,27,'2014-08-29 11:45:41','2014-08-29 11:45:41'),(160,70,27,'2014-08-29 11:45:41','2014-08-29 11:45:41'),(161,44,28,'2014-08-29 12:03:36','2014-08-29 12:03:36'),(162,45,28,'2014-08-29 12:03:36','2014-08-29 12:03:36'),(163,54,28,'2014-08-29 12:03:36','2014-08-29 12:03:36'),(164,65,28,'2014-08-29 12:03:36','2014-08-29 12:03:36'),(165,73,28,'2014-08-29 12:03:36','2014-08-29 12:03:36'),(166,44,29,'2014-08-29 12:04:14','2014-08-29 12:04:14'),(167,45,29,'2014-08-29 12:04:14','2014-08-29 12:04:14'),(168,54,29,'2014-08-29 12:04:14','2014-08-29 12:04:14'),(169,65,29,'2014-08-29 12:04:14','2014-08-29 12:04:14'),(170,73,29,'2014-08-29 12:04:14','2014-08-29 12:04:14'),(176,44,30,'2014-08-29 12:07:53','2014-08-29 12:07:53'),(177,99,30,'2014-08-29 12:07:53','2014-08-29 12:07:53'),(178,54,30,'2014-08-29 12:07:53','2014-08-29 12:07:53'),(179,65,30,'2014-08-29 12:07:53','2014-08-29 12:07:53'),(180,73,30,'2014-08-29 12:07:53','2014-08-29 12:07:53'),(181,44,31,'2014-08-29 12:16:17','2014-08-29 12:16:17'),(182,45,31,'2014-08-29 12:16:17','2014-08-29 12:16:17'),(183,54,31,'2014-08-29 12:16:17','2014-08-29 12:16:17'),(184,65,31,'2014-08-29 12:16:17','2014-08-29 12:16:17'),(185,70,31,'2014-08-29 12:16:17','2014-08-29 12:16:17'),(186,44,32,'2014-08-29 12:17:01','2014-08-29 12:17:01'),(187,45,32,'2014-08-29 12:17:01','2014-08-29 12:17:01'),(188,54,32,'2014-08-29 12:17:01','2014-08-29 12:17:01'),(189,65,32,'2014-08-29 12:17:01','2014-08-29 12:17:01'),(190,73,32,'2014-08-29 12:17:01','2014-08-29 12:17:01'),(193,72,33,'2014-08-29 12:23:37','2014-08-29 12:23:37'),(194,102,33,'2014-08-29 12:23:37','2014-08-29 12:23:37'),(195,1,33,'2014-08-29 12:23:37','2014-08-29 12:23:37'),(196,72,34,'2014-08-29 12:27:57','2014-08-29 12:27:57'),(197,102,34,'2014-08-29 12:27:57','2014-08-29 12:27:57'),(198,106,34,'2014-08-29 12:27:57','2014-08-29 12:27:57'),(200,1,35,'2014-08-29 12:30:25','2014-08-29 12:30:25'),(203,110,36,'2014-08-29 12:32:13','2014-08-29 12:32:13'),(204,14,36,'2014-08-29 12:32:13','2014-08-29 12:32:13'),(205,63,36,'2014-08-29 12:32:13','2014-08-29 12:32:13'),(206,44,38,'2014-08-29 12:45:35','2014-08-29 12:45:35'),(207,83,38,'2014-08-29 12:45:35','2014-08-29 12:45:35'),(208,54,38,'2014-08-29 12:45:35','2014-08-29 12:45:35'),(209,65,38,'2014-08-29 12:45:35','2014-08-29 12:45:35'),(210,70,38,'2014-08-29 12:45:35','2014-08-29 12:45:35'),(216,44,39,'2014-08-29 12:50:13','2014-08-29 12:50:13'),(217,83,39,'2014-08-29 12:50:13','2014-08-29 12:50:13'),(218,54,39,'2014-08-29 12:50:13','2014-08-29 12:50:13'),(219,65,39,'2014-08-29 12:50:13','2014-08-29 12:50:13'),(220,70,39,'2014-08-29 12:50:13','2014-08-29 12:50:13'),(238,44,40,'2014-08-29 12:54:33','2014-08-29 12:54:33'),(239,45,40,'2014-08-29 12:54:33','2014-08-29 12:54:33'),(240,54,40,'2014-08-29 12:54:33','2014-08-29 12:54:33'),(241,65,40,'2014-08-29 12:54:33','2014-08-29 12:54:33'),(242,70,40,'2014-08-29 12:54:33','2014-08-29 12:54:33'),(243,111,40,'2014-08-29 12:54:33','2014-08-29 12:54:33'),(244,44,41,'2014-08-29 12:54:47','2014-08-29 12:54:47'),(245,45,41,'2014-08-29 12:54:47','2014-08-29 12:54:47'),(246,54,41,'2014-08-29 12:54:47','2014-08-29 12:54:47'),(247,65,41,'2014-08-29 12:54:47','2014-08-29 12:54:47'),(248,70,41,'2014-08-29 12:54:47','2014-08-29 12:54:47'),(249,111,41,'2014-08-29 12:54:47','2014-08-29 12:54:47'),(250,16,42,'2014-08-29 14:06:07','2014-08-29 14:06:07'),(251,112,42,'2014-08-29 14:06:07','2014-08-29 14:06:07'),(252,72,42,'2014-08-29 14:06:07','2014-08-29 14:06:07'),(253,102,42,'2014-08-29 14:06:07','2014-08-29 14:06:07'),(254,38,43,'2014-08-29 14:11:05','2014-08-29 14:11:05'),(255,112,43,'2014-08-29 14:11:05','2014-08-29 14:11:05'),(256,72,43,'2014-08-29 14:11:05','2014-08-29 14:11:05'),(257,75,43,'2014-08-29 14:11:05','2014-08-29 14:11:05'),(258,102,43,'2014-08-29 14:11:05','2014-08-29 14:11:05'),(274,44,44,'2014-08-29 14:20:05','2014-08-29 14:20:05'),(275,45,44,'2014-08-29 14:20:05','2014-08-29 14:20:05'),(276,54,44,'2014-08-29 14:20:05','2014-08-29 14:20:05'),(277,65,44,'2014-08-29 14:20:05','2014-08-29 14:20:05'),(278,70,44,'2014-08-29 14:20:05','2014-08-29 14:20:05'),(279,44,45,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(280,45,45,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(281,54,45,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(282,65,45,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(283,70,45,'2014-08-29 14:20:14','2014-08-29 14:20:14'),(291,10,46,'2014-08-29 14:39:55','2014-08-29 14:39:55'),(292,1,46,'2014-08-29 14:39:55','2014-08-29 14:39:55'),(293,76,46,'2014-08-29 14:39:55','2014-08-29 14:39:55'),(294,69,47,'2014-08-29 14:40:45','2014-08-29 14:40:45'),(295,1,47,'2014-08-29 14:40:45','2014-08-29 14:40:45'),(296,76,47,'2014-08-29 14:40:45','2014-08-29 14:40:45'),(297,9,48,'2014-08-29 14:41:54','2014-08-29 14:41:54'),(298,76,48,'2014-08-29 14:41:54','2014-08-29 14:41:54'),(299,9,49,'2014-08-29 14:42:27','2014-08-29 14:42:27'),(300,76,49,'2014-08-29 14:42:27','2014-08-29 14:42:27'),(303,62,50,'2014-08-29 14:48:44','2014-08-29 14:48:44'),(304,120,50,'2014-08-29 14:48:44','2014-08-29 14:48:44'),(305,108,50,'2014-08-29 14:48:44','2014-08-29 14:48:44'),(306,62,51,'2014-08-29 14:49:24','2014-08-29 14:49:24'),(307,120,51,'2014-08-29 14:49:24','2014-08-29 14:49:24'),(308,108,51,'2014-08-29 14:49:24','2014-08-29 14:49:24'),(309,44,52,'2014-08-29 14:58:17','2014-08-29 14:58:17'),(310,83,52,'2014-08-29 14:58:17','2014-08-29 14:58:17'),(311,54,52,'2014-08-29 14:58:17','2014-08-29 14:58:17'),(312,29,52,'2014-08-29 14:58:17','2014-08-29 14:58:17'),(313,65,52,'2014-08-29 14:58:17','2014-08-29 14:58:17'),(314,70,52,'2014-08-29 14:58:17','2014-08-29 14:58:17'),(321,14,54,'2014-08-29 15:03:19','2014-08-29 15:03:19'),(324,125,55,'2014-08-29 15:08:51','2014-08-29 15:08:51'),(325,104,55,'2014-08-29 15:08:51','2014-08-29 15:08:51'),(326,106,55,'2014-08-29 15:08:51','2014-08-29 15:08:51'),(327,44,53,'2014-08-29 15:09:58','2014-08-29 15:09:58'),(328,83,53,'2014-08-29 15:09:58','2014-08-29 15:09:58'),(329,54,53,'2014-08-29 15:09:58','2014-08-29 15:09:58'),(330,29,53,'2014-08-29 15:09:58','2014-08-29 15:09:58'),(331,65,53,'2014-08-29 15:09:58','2014-08-29 15:09:58'),(332,70,53,'2014-08-29 15:09:58','2014-08-29 15:09:58'),(333,44,56,'2014-08-29 15:14:25','2014-08-29 15:14:25'),(334,54,56,'2014-08-29 15:14:25','2014-08-29 15:14:25'),(335,57,56,'2014-08-29 15:14:25','2014-08-29 15:14:25'),(336,65,56,'2014-08-29 15:14:25','2014-08-29 15:14:25'),(337,70,56,'2014-08-29 15:14:25','2014-08-29 15:14:25'),(338,30,56,'2014-08-29 15:14:25','2014-08-29 15:14:25'),(339,44,57,'2014-08-29 15:16:31','2014-08-29 15:16:31'),(340,54,57,'2014-08-29 15:16:31','2014-08-29 15:16:31'),(341,65,57,'2014-08-29 15:16:31','2014-08-29 15:16:31'),(342,70,57,'2014-08-29 15:16:31','2014-08-29 15:16:31'),(343,30,57,'2014-08-29 15:16:31','2014-08-29 15:16:31'),(344,44,58,'2014-08-29 15:19:35','2014-08-29 15:19:35'),(345,54,58,'2014-08-29 15:19:35','2014-08-29 15:19:35'),(346,14,58,'2014-08-29 15:19:35','2014-08-29 15:19:35'),(347,65,58,'2014-08-29 15:19:35','2014-08-29 15:19:35'),(348,70,58,'2014-08-29 15:19:35','2014-08-29 15:19:35'),(349,30,58,'2014-08-29 15:19:35','2014-08-29 15:19:35'),(350,44,59,'2014-08-29 15:25:52','2014-08-29 15:25:52'),(351,54,59,'2014-08-29 15:25:52','2014-08-29 15:25:52'),(352,65,59,'2014-08-29 15:25:52','2014-08-29 15:25:52'),(353,73,59,'2014-08-29 15:25:52','2014-08-29 15:25:52'),(354,97,59,'2014-08-29 15:25:52','2014-08-29 15:25:52'),(355,30,59,'2014-08-29 15:25:52','2014-08-29 15:25:52'),(362,45,61,'2014-08-29 15:34:33','2014-08-29 15:34:33'),(363,54,61,'2014-08-29 15:34:33','2014-08-29 15:34:33'),(364,65,61,'2014-08-29 15:34:33','2014-08-29 15:34:33'),(365,70,61,'2014-08-29 15:34:33','2014-08-29 15:34:33'),(366,44,60,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(367,54,60,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(368,65,60,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(369,73,60,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(370,97,60,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(371,30,60,'2014-08-29 15:35:13','2014-08-29 15:35:13'),(372,44,62,'2014-08-29 15:36:32','2014-08-29 15:36:32'),(373,45,62,'2014-08-29 15:36:32','2014-08-29 15:36:32'),(374,54,62,'2014-08-29 15:36:32','2014-08-29 15:36:32'),(375,65,62,'2014-08-29 15:36:32','2014-08-29 15:36:32'),(376,70,62,'2014-08-29 15:36:32','2014-08-29 15:36:32'),(377,130,62,'2014-08-29 15:36:32','2014-08-29 15:36:32'),(382,116,63,'2014-08-29 15:43:16','2014-08-29 15:43:16'),(383,106,63,'2014-08-29 15:43:16','2014-08-29 15:43:16'),(384,116,64,'2014-08-29 15:43:27','2014-08-29 15:43:27'),(385,106,64,'2014-08-29 15:43:27','2014-08-29 15:43:27'),(386,42,65,'2014-08-29 15:51:16','2014-08-29 15:51:16'),(387,44,65,'2014-08-29 15:51:16','2014-08-29 15:51:16'),(388,54,65,'2014-08-29 15:51:16','2014-08-29 15:51:16'),(389,65,65,'2014-08-29 15:51:16','2014-08-29 15:51:16'),(390,95,65,'2014-08-29 15:51:16','2014-08-29 15:51:16'),(391,131,66,'2014-08-29 15:52:02','2014-08-29 15:52:02'),(397,72,68,'2014-08-29 15:59:13','2014-08-29 15:59:13'),(398,102,68,'2014-08-29 15:59:13','2014-08-29 15:59:13'),(399,78,68,'2014-08-29 15:59:13','2014-08-29 15:59:13'),(400,133,67,'2014-08-29 15:59:24','2014-08-29 15:59:24'),(401,72,67,'2014-08-29 15:59:24','2014-08-29 15:59:24'),(402,102,67,'2014-08-29 15:59:24','2014-08-29 15:59:24'),(403,49,69,'2014-08-29 16:00:31','2014-08-29 16:00:31'),(404,72,69,'2014-08-29 16:00:31','2014-08-29 16:00:31'),(405,102,69,'2014-08-29 16:00:31','2014-08-29 16:00:31'),(406,1,69,'2014-08-29 16:00:31','2014-08-29 16:00:31'),(409,72,70,'2014-08-29 16:01:40','2014-08-29 16:01:40'),(410,134,70,'2014-08-29 16:01:40','2014-08-29 16:01:40'),(411,102,70,'2014-08-29 16:01:40','2014-08-29 16:01:40'),(412,60,71,'2014-08-29 16:02:32','2014-08-29 16:02:32'),(413,72,71,'2014-08-29 16:02:32','2014-08-29 16:02:32'),(414,102,71,'2014-08-29 16:02:32','2014-08-29 16:02:32'),(415,72,72,'2014-08-29 16:06:03','2014-08-29 16:06:03'),(416,102,72,'2014-08-29 16:06:03','2014-08-29 16:06:03'),(417,106,72,'2014-08-29 16:06:03','2014-08-29 16:06:03'),(418,105,72,'2014-08-29 16:06:03','2014-08-29 16:06:03'),(424,53,73,'2014-08-29 16:08:05','2014-08-29 16:08:05'),(425,116,73,'2014-08-29 16:08:05','2014-08-29 16:08:05'),(426,72,73,'2014-08-29 16:08:05','2014-08-29 16:08:05'),(427,102,73,'2014-08-29 16:08:05','2014-08-29 16:08:05'),(428,104,73,'2014-08-29 16:08:05','2014-08-29 16:08:05'),(429,52,74,'2014-08-29 16:09:11','2014-08-29 16:09:11'),(430,53,74,'2014-08-29 16:09:11','2014-08-29 16:09:11'),(431,72,74,'2014-08-29 16:09:11','2014-08-29 16:09:11'),(432,102,74,'2014-08-29 16:09:11','2014-08-29 16:09:11'),(433,104,74,'2014-08-29 16:09:11','2014-08-29 16:09:11'),(434,44,75,'2014-08-29 16:11:03','2014-08-29 16:11:03'),(435,54,75,'2014-08-29 16:11:03','2014-08-29 16:11:03'),(436,65,75,'2014-08-29 16:11:03','2014-08-29 16:11:03'),(437,70,75,'2014-08-29 16:11:03','2014-08-29 16:11:03'),(438,96,75,'2014-08-29 16:11:03','2014-08-29 16:11:03'),(446,125,76,'2014-08-29 16:20:08','2014-08-29 16:20:08'),(447,137,76,'2014-08-29 16:20:08','2014-08-29 16:20:08'),(448,104,76,'2014-08-29 16:20:08','2014-08-29 16:20:08'),(449,106,76,'2014-08-29 16:20:08','2014-08-29 16:20:08'),(466,44,77,'2015-02-04 15:49:48','2015-02-04 15:49:48'),(467,83,77,'2015-02-04 15:49:48','2015-02-04 15:49:48'),(468,54,77,'2015-02-04 15:49:48','2015-02-04 15:49:48'),(469,61,77,'2015-02-04 15:49:48','2015-02-04 15:49:48'),(470,65,77,'2015-02-04 15:49:48','2015-02-04 15:49:48'),(471,70,77,'2015-02-04 15:49:48','2015-02-04 15:49:48'),(472,44,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(473,90,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(474,54,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(475,65,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(476,70,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(477,91,78,'2015-02-04 16:20:51','2015-02-04 16:20:51'),(478,42,79,'2015-02-06 13:33:15','2015-02-06 13:33:15'),(479,44,79,'2015-02-06 13:33:15','2015-02-06 13:33:15'),(480,27,79,'2015-02-06 13:33:15','2015-02-06 13:33:15'),(481,54,79,'2015-02-06 13:33:15','2015-02-06 13:33:15'),(482,61,79,'2015-02-06 13:33:15','2015-02-06 13:33:15'),(483,65,79,'2015-02-06 13:33:15','2015-02-06 13:33:15'),(484,42,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(485,44,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(486,27,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(487,54,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(488,61,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(489,65,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(490,152,81,'2015-02-06 13:47:44','2015-02-06 13:47:44'),(491,112,81,'2015-02-06 13:47:44','2015-02-06 13:47:44'),(492,91,81,'2015-02-06 13:47:44','2015-02-06 13:47:44'),(493,72,81,'2015-02-06 13:47:44','2015-02-06 13:47:44'),(494,102,81,'2015-02-06 13:47:44','2015-02-06 13:47:44'),(495,42,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(496,154,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(497,54,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(498,65,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(499,7,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(500,91,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(501,42,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(502,156,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(503,155,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(504,54,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(505,61,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(506,29,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(507,65,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(508,42,84,'2015-02-06 14:13:41','2015-02-06 14:13:41'),(509,44,84,'2015-02-06 14:13:41','2015-02-06 14:13:41'),(510,54,84,'2015-02-06 14:13:41','2015-02-06 14:13:41'),(511,29,84,'2015-02-06 14:13:41','2015-02-06 14:13:41'),(512,65,84,'2015-02-06 14:13:41','2015-02-06 14:13:41'),(513,80,84,'2015-02-06 14:13:41','2015-02-06 14:13:41'),(514,157,86,'2015-02-06 14:20:18','2015-02-06 14:20:18'),(515,83,86,'2015-02-06 14:20:18','2015-02-06 14:20:18'),(516,54,86,'2015-02-06 14:20:18','2015-02-06 14:20:18'),(517,65,86,'2015-02-06 14:20:18','2015-02-06 14:20:18'),(518,158,86,'2015-02-06 14:20:18','2015-02-06 14:20:18'),(519,70,86,'2015-02-06 14:20:18','2015-02-06 14:20:18'),(520,44,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(521,54,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(522,65,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(523,158,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(524,70,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(525,96,88,'2015-02-06 14:35:23','2015-02-06 14:35:23'),(526,42,89,'2015-02-06 14:39:44','2015-02-06 14:39:44'),(527,44,89,'2015-02-06 14:39:44','2015-02-06 14:39:44'),(528,45,89,'2015-02-06 14:39:44','2015-02-06 14:39:44'),(529,54,89,'2015-02-06 14:39:44','2015-02-06 14:39:44'),(530,65,89,'2015-02-06 14:39:44','2015-02-06 14:39:44'),(531,96,89,'2015-02-06 14:39:44','2015-02-06 14:39:44'),(532,44,90,'2015-02-06 14:45:20','2015-02-06 14:45:20'),(533,79,90,'2015-02-06 14:45:20','2015-02-06 14:45:20'),(534,54,90,'2015-02-06 14:45:20','2015-02-06 14:45:20'),(535,65,90,'2015-02-06 14:45:20','2015-02-06 14:45:20'),(536,70,90,'2015-02-06 14:45:20','2015-02-06 14:45:20'),(537,80,90,'2015-02-06 14:45:20','2015-02-06 14:45:20'),(538,44,91,'2015-02-18 13:12:49','2015-02-18 13:12:49'),(539,45,91,'2015-02-18 13:12:49','2015-02-18 13:12:49'),(540,54,91,'2015-02-18 13:12:49','2015-02-18 13:12:49'),(541,65,91,'2015-02-18 13:12:49','2015-02-18 13:12:49'),(542,70,91,'2015-02-18 13:12:49','2015-02-18 13:12:49'),(543,44,92,'2015-02-18 13:14:51','2015-02-18 13:14:51'),(544,45,92,'2015-02-18 13:14:51','2015-02-18 13:14:51'),(545,54,92,'2015-02-18 13:14:51','2015-02-18 13:14:51'),(546,65,92,'2015-02-18 13:14:51','2015-02-18 13:14:51'),(547,70,92,'2015-02-18 13:14:51','2015-02-18 13:14:51'),(548,44,93,'2015-02-18 13:25:16','2015-02-18 13:25:16'),(549,45,93,'2015-02-18 13:25:16','2015-02-18 13:25:16'),(550,54,93,'2015-02-18 13:25:16','2015-02-18 13:25:16'),(551,65,93,'2015-02-18 13:25:16','2015-02-18 13:25:16'),(552,73,93,'2015-02-18 13:25:16','2015-02-18 13:25:16'),(553,44,94,'2015-02-18 13:26:53','2015-02-18 13:26:53'),(554,45,94,'2015-02-18 13:26:53','2015-02-18 13:26:53'),(555,54,94,'2015-02-18 13:26:53','2015-02-18 13:26:53'),(556,65,94,'2015-02-18 13:26:53','2015-02-18 13:26:53'),(557,73,94,'2015-02-18 13:26:53','2015-02-18 13:26:53'),(558,159,95,'2015-02-18 13:41:00','2015-02-18 13:41:00'),(559,72,95,'2015-02-18 13:41:00','2015-02-18 13:41:00'),(560,102,95,'2015-02-18 13:41:00','2015-02-18 13:41:00'),(561,1,95,'2015-02-18 13:41:00','2015-02-18 13:41:00'),(562,159,96,'2015-02-18 13:47:21','2015-02-18 13:47:21'),(563,72,96,'2015-02-18 13:47:21','2015-02-18 13:47:21'),(564,102,96,'2015-02-18 13:47:21','2015-02-18 13:47:21'),(565,106,96,'2015-02-18 13:47:21','2015-02-18 13:47:21'),(566,1,97,'2015-02-18 13:58:06','2015-02-18 13:58:06'),(567,14,98,'2015-02-18 14:06:01','2015-02-18 14:06:01'),(568,44,99,'2015-02-18 14:12:50','2015-02-18 14:12:50'),(569,83,99,'2015-02-18 14:12:50','2015-02-18 14:12:50'),(570,54,99,'2015-02-18 14:12:50','2015-02-18 14:12:50'),(571,29,99,'2015-02-18 14:12:50','2015-02-18 14:12:50'),(572,65,99,'2015-02-18 14:12:50','2015-02-18 14:12:50'),(573,70,99,'2015-02-18 14:12:50','2015-02-18 14:12:50'),(574,44,100,'2015-02-18 14:14:25','2015-02-18 14:14:25'),(575,83,100,'2015-02-18 14:14:25','2015-02-18 14:14:25'),(576,54,100,'2015-02-18 14:14:25','2015-02-18 14:14:25'),(577,29,100,'2015-02-18 14:14:25','2015-02-18 14:14:25'),(578,65,100,'2015-02-18 14:14:25','2015-02-18 14:14:25'),(579,70,100,'2015-02-18 14:14:25','2015-02-18 14:14:25'),(585,44,101,'2015-02-18 14:29:39','2015-02-18 14:29:39'),(586,54,101,'2015-02-18 14:29:39','2015-02-18 14:29:39'),(587,65,101,'2015-02-18 14:29:39','2015-02-18 14:29:39'),(588,70,101,'2015-02-18 14:29:39','2015-02-18 14:29:39'),(589,30,101,'2015-02-18 14:29:39','2015-02-18 14:29:39'),(590,44,102,'2015-02-18 14:32:30','2015-02-18 14:32:30'),(591,54,102,'2015-02-18 14:32:30','2015-02-18 14:32:30'),(592,65,102,'2015-02-18 14:32:30','2015-02-18 14:32:30'),(593,70,102,'2015-02-18 14:32:30','2015-02-18 14:32:30'),(594,30,102,'2015-02-18 14:32:30','2015-02-18 14:32:30'),(595,44,103,'2015-02-18 14:37:31','2015-02-18 14:37:31'),(596,54,103,'2015-02-18 14:37:31','2015-02-18 14:37:31'),(597,14,103,'2015-02-18 14:37:31','2015-02-18 14:37:31'),(598,65,103,'2015-02-18 14:37:31','2015-02-18 14:37:31'),(599,70,103,'2015-02-18 14:37:31','2015-02-18 14:37:31'),(600,30,103,'2015-02-18 14:37:31','2015-02-18 14:37:31'),(601,44,104,'2015-02-18 14:53:11','2015-02-18 14:53:11'),(602,54,104,'2015-02-18 14:53:11','2015-02-18 14:53:11'),(603,65,104,'2015-02-18 14:53:11','2015-02-18 14:53:11'),(604,73,104,'2015-02-18 14:53:11','2015-02-18 14:53:11'),(605,97,104,'2015-02-18 14:53:11','2015-02-18 14:53:11'),(606,30,104,'2015-02-18 14:53:11','2015-02-18 14:53:11'),(607,44,105,'2015-02-18 14:56:05','2015-02-18 14:56:05'),(608,54,105,'2015-02-18 14:56:05','2015-02-18 14:56:05'),(609,65,105,'2015-02-18 14:56:05','2015-02-18 14:56:05'),(610,73,105,'2015-02-18 14:56:05','2015-02-18 14:56:05'),(611,97,105,'2015-02-18 14:56:05','2015-02-18 14:56:05'),(612,30,105,'2015-02-18 14:56:05','2015-02-18 14:56:05'),(613,125,106,'2015-02-19 12:31:47','2015-02-19 12:31:47'),(614,137,106,'2015-02-19 12:31:47','2015-02-19 12:31:47'),(615,104,106,'2015-02-19 12:31:47','2015-02-19 12:31:47'),(616,106,106,'2015-02-19 12:31:47','2015-02-19 12:31:47'),(617,44,107,'2015-02-19 12:35:42','2015-02-19 12:35:42'),(618,45,107,'2015-02-19 12:35:42','2015-02-19 12:35:42'),(619,54,107,'2015-02-19 12:35:42','2015-02-19 12:35:42'),(620,65,107,'2015-02-19 12:35:42','2015-02-19 12:35:42'),(621,70,107,'2015-02-19 12:35:42','2015-02-19 12:35:42'),(622,44,108,'2015-02-19 12:36:33','2015-02-19 12:36:33'),(623,45,108,'2015-02-19 12:36:33','2015-02-19 12:36:33'),(624,54,108,'2015-02-19 12:36:33','2015-02-19 12:36:33'),(625,65,108,'2015-02-19 12:36:33','2015-02-19 12:36:33'),(626,70,108,'2015-02-19 12:36:33','2015-02-19 12:36:33'),(627,130,108,'2015-02-19 12:36:33','2015-02-19 12:36:33'),(628,159,109,'2015-02-19 12:41:43','2015-02-19 12:41:43'),(629,72,109,'2015-02-19 12:41:43','2015-02-19 12:41:43'),(630,102,109,'2015-02-19 12:41:43','2015-02-19 12:41:43'),(631,104,109,'2015-02-19 12:41:43','2015-02-19 12:41:43'),(632,133,110,'2015-02-19 12:44:42','2015-02-19 12:44:42'),(633,72,110,'2015-02-19 12:44:42','2015-02-19 12:44:42'),(634,102,110,'2015-02-19 12:44:42','2015-02-19 12:44:42'),(635,49,111,'2015-02-19 12:47:42','2015-02-19 12:47:42'),(636,72,111,'2015-02-19 12:47:42','2015-02-19 12:47:42'),(637,102,111,'2015-02-19 12:47:42','2015-02-19 12:47:42'),(638,72,112,'2015-02-19 12:49:17','2015-02-19 12:49:17'),(639,102,112,'2015-02-19 12:49:17','2015-02-19 12:49:17'),(640,78,112,'2015-02-19 12:49:17','2015-02-19 12:49:17'),(641,72,113,'2015-02-19 12:52:48','2015-02-19 12:52:48'),(642,102,113,'2015-02-19 12:52:48','2015-02-19 12:52:48'),(643,106,113,'2015-02-19 12:52:48','2015-02-19 12:52:48'),(644,105,113,'2015-02-19 12:52:48','2015-02-19 12:52:48'),(645,54,114,'2015-02-19 12:54:22','2015-02-19 12:54:22'),(646,116,114,'2015-02-19 12:54:22','2015-02-19 12:54:22'),(647,72,114,'2015-02-19 12:54:22','2015-02-19 12:54:22'),(648,102,114,'2015-02-19 12:54:22','2015-02-19 12:54:22'),(649,104,114,'2015-02-19 12:54:22','2015-02-19 12:54:22'),(650,52,115,'2015-02-19 12:56:38','2015-02-19 12:56:38'),(651,53,115,'2015-02-19 12:56:38','2015-02-19 12:56:38'),(652,72,115,'2015-02-19 12:56:38','2015-02-19 12:56:38'),(653,102,115,'2015-02-19 12:56:38','2015-02-19 12:56:38'),(654,107,115,'2015-02-19 12:56:38','2015-02-19 12:56:38'),(655,42,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(656,54,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(657,142,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(658,61,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(659,29,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(660,65,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(661,44,117,'2015-02-19 13:05:27','2015-02-19 13:05:27'),(662,54,117,'2015-02-19 13:05:27','2015-02-19 13:05:27'),(663,61,117,'2015-02-19 13:05:27','2015-02-19 13:05:27'),(664,65,117,'2015-02-19 13:05:27','2015-02-19 13:05:27'),(665,70,117,'2015-02-19 13:05:27','2015-02-19 13:05:27');
/*!40000 ALTER TABLE `unitwargears` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitwarlords`
--

DROP TABLE IF EXISTS `unitwarlords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unitwarlords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `warlords_id` int(11) NOT NULL,
  `squadunits_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_unitwarlords_warlords1_idx` (`warlords_id`),
  KEY `fk_unitwarlords_squadunits1_idx` (`squadunits_id`),
  CONSTRAINT `fk_unitwarlords_squadunits1` FOREIGN KEY (`squadunits_id`) REFERENCES `squadunits` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_unitwarlords_warlords1` FOREIGN KEY (`warlords_id`) REFERENCES `warlords` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitwarlords`
--

LOCK TABLES `unitwarlords` WRITE;
/*!40000 ALTER TABLE `unitwarlords` DISABLE KEYS */;
INSERT INTO `unitwarlords` VALUES (1,1,2,'2014-08-29 09:44:13','2014-08-29 09:44:13'),(2,2,3,'2014-08-29 09:55:10','2014-08-29 09:55:10'),(4,3,4,'2014-08-29 10:01:55','2014-08-29 10:01:55'),(5,4,5,'2014-08-29 10:09:37','2014-08-29 10:09:37'),(6,5,6,'2014-08-29 10:13:24','2014-08-29 10:13:24'),(7,3,7,'2014-08-29 10:17:03','2014-08-29 10:17:03'),(8,4,8,'2014-08-29 10:25:24','2014-08-29 10:25:24'),(9,5,9,'2014-08-29 10:27:11','2014-08-29 10:27:11'),(10,1,10,'2014-08-29 10:33:24','2014-08-29 10:33:24'),(12,6,13,'2014-08-29 10:39:52','2014-08-29 10:39:52'),(13,7,79,'2015-02-06 13:33:15','2015-02-06 13:33:15'),(14,7,80,'2015-02-06 13:39:08','2015-02-06 13:39:08'),(15,8,82,'2015-02-06 14:02:23','2015-02-06 14:02:23'),(16,9,83,'2015-02-06 14:06:56','2015-02-06 14:06:56'),(17,8,84,'2015-02-06 14:13:41','2015-02-06 14:13:41'),(18,10,87,'2015-02-06 14:26:05','2015-02-06 14:26:05'),(19,11,116,'2015-02-19 13:02:04','2015-02-19 13:02:04'),(20,7,117,'2015-02-19 13:05:27','2015-02-19 13:05:27');
/*!40000 ALTER TABLE `unitwarlords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `social_id` bigint(25) DEFAULT NULL,
  `social_access_token` varchar(255) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified` tinyint(1) DEFAULT '0',
  `last_login` datetime DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT '0',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'chrissheppard',NULL,NULL,'4c1eae03df941842','ad462c3e84992a2fc88ac37e0dbe9bbd0280fd56','chrissheppard@rehabstudio.com',1,'2015-02-19 12:24:31',1,'2014-08-28 15:21:25','2015-02-19 12:24:31');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votes`
--

DROP TABLE IF EXISTS `votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `armylists_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `vote` varchar(4) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_votes_armylists1_idx` (`armylists_id`),
  KEY `fk_votes_users1_idx` (`users_id`),
  CONSTRAINT `fk_votes_armylists1` FOREIGN KEY (`armylists_id`) REFERENCES `armylists` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_votes_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votes`
--

LOCK TABLES `votes` WRITE;
/*!40000 ALTER TABLE `votes` DISABLE KEYS */;
INSERT INTO `votes` VALUES (1,1,1,'up','2015-01-28 21:01:30','2015-01-28 21:01:30'),(4,3,1,'up','2015-01-28 21:37:24','2015-01-28 21:37:24');
/*!40000 ALTER TABLE `votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wargeargroups`
--

DROP TABLE IF EXISTS `wargeargroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wargeargroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pts` int(4) DEFAULT NULL,
  `groups_id` int(11) NOT NULL,
  `wargears_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wargeargroups_groups1_idx` (`groups_id`),
  KEY `fk_wargeargroups_wargears1_idx` (`wargears_id`),
  CONSTRAINT `fk_wargeargroups_groups1` FOREIGN KEY (`groups_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_wargeargroups_wargears1` FOREIGN KEY (`wargears_id`) REFERENCES `wargears` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=442 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wargeargroups`
--

LOCK TABLES `wargeargroups` WRITE;
/*!40000 ALTER TABLE `wargeargroups` DISABLE KEYS */;
INSERT INTO `wargeargroups` VALUES (1,5,1,1,'2014-08-28 15:55:23','2014-08-28 15:56:25'),(2,10,1,2,'2014-08-28 15:55:34','2014-08-28 15:56:28'),(3,10,1,3,'2014-08-28 15:55:45','2014-08-28 15:56:31'),(4,10,1,4,'2014-08-28 15:55:54','2014-08-28 15:56:34'),(5,10,1,5,'2014-08-28 15:56:03','2014-08-28 15:56:37'),(6,15,1,6,'2014-08-28 15:56:13','2014-08-28 15:56:45'),(7,15,1,7,'2014-08-28 15:56:20','2014-08-28 15:56:48'),(8,15,2,8,'2014-08-28 15:57:05','2014-08-28 15:57:40'),(9,15,2,9,'2014-08-28 15:57:15','2014-08-28 15:57:45'),(10,25,2,10,'2014-08-28 15:57:22','2014-08-28 15:57:50'),(11,30,2,11,'2014-08-28 15:57:33','2014-08-28 15:57:54'),(32,6,3,2,'2014-08-28 16:54:37','2014-08-28 16:54:44'),(33,6,3,4,'2014-08-28 16:54:37','2014-08-28 16:54:47'),(34,6,3,5,'2014-08-28 16:54:37','2014-08-28 16:54:50'),(35,10,3,9,'2014-08-28 16:54:37','2014-08-28 16:54:57'),(36,25,3,11,'2014-08-28 16:54:37','2014-08-28 16:55:01'),(37,15,9,13,'2014-08-28 16:56:26','2014-08-28 16:56:36'),(38,5,9,9,'2014-08-28 16:56:26','2014-08-28 16:56:42'),(39,10,9,10,'2014-08-28 16:56:26','2014-08-28 16:56:48'),(40,5,9,12,'2014-08-28 16:56:26','2014-08-28 16:56:54'),(41,15,9,11,'2014-08-28 16:56:26','2014-08-28 16:56:58'),(42,10,4,14,'2014-08-28 16:58:06','2014-08-28 17:03:28'),(43,10,4,15,'2014-08-28 16:58:18','2014-08-28 17:03:32'),(44,10,4,16,'2014-08-28 16:58:29','2014-08-28 17:03:37'),(45,15,4,17,'2014-08-28 16:58:38','2014-08-28 17:03:43'),(46,25,4,18,'2014-08-28 16:58:47','2014-08-28 17:03:46'),(47,15,4,19,'2014-08-28 16:58:55','2014-08-28 17:03:52'),(48,20,4,20,'2014-08-28 16:59:01','2014-08-28 17:03:55'),(49,5,5,21,'2014-08-28 17:04:20','2014-08-28 17:04:57'),(50,10,5,22,'2014-08-28 17:04:37','2014-08-28 17:05:01'),(51,15,5,23,'2014-08-28 17:04:46','2014-08-28 17:05:05'),(52,15,5,24,'2014-08-28 17:04:53','2014-08-28 17:05:08'),(53,5,6,25,'2014-08-28 17:05:25','2014-08-28 17:06:07'),(54,5,6,26,'2014-08-28 17:05:34','2014-08-28 17:06:10'),(55,10,6,27,'2014-08-28 17:05:45','2014-08-28 17:06:15'),(56,10,6,28,'2014-08-28 17:05:51','2014-08-28 17:06:18'),(57,15,6,29,'2014-08-28 17:05:57','2014-08-28 17:06:21'),(58,20,6,30,'2014-08-28 17:06:03','2014-08-28 17:06:25'),(59,20,7,31,'2014-08-28 17:06:40','2014-08-28 17:07:32'),(60,35,7,32,'2014-08-28 17:06:49','2014-08-28 17:07:35'),(61,50,7,33,'2014-08-28 17:06:56','2014-08-28 17:07:39'),(62,55,7,34,'2014-08-28 17:07:18','2014-08-28 17:07:42'),(63,60,7,35,'2014-08-28 17:07:25','2014-08-28 17:07:45'),(67,5,8,36,'2014-08-28 17:08:31','2014-08-28 17:08:37'),(68,10,8,38,'2014-08-28 17:08:31','2014-08-28 17:08:39'),(69,10,8,37,'2014-08-28 17:08:31','2014-08-28 17:08:42'),(70,5,8,1,'2014-08-28 17:08:31','2014-08-28 17:08:44'),(71,10,10,40,'2014-08-28 17:57:39','2014-08-28 17:57:45'),(72,25,11,81,'2014-08-29 10:03:26','2014-08-29 10:03:30'),(82,20,12,42,'2014-08-29 10:45:29','2014-08-29 10:45:36'),(83,0,12,45,'2014-08-29 10:45:29','2014-08-29 10:45:40'),(84,25,12,71,'2014-08-29 10:45:29','2014-08-29 10:45:43'),(85,15,12,12,'2014-08-29 10:45:29','2014-08-29 10:45:47'),(86,40,12,76,'2014-08-29 10:45:29','2014-08-29 10:45:50'),(87,10,13,71,'2014-08-29 10:50:05','2014-08-29 10:51:12'),(88,25,13,84,'2014-08-29 10:50:55','2014-08-29 10:51:16'),(89,65,13,85,'2014-08-29 10:51:04','2014-08-29 10:51:21'),(90,15,14,11,'2014-08-29 10:51:47','2014-08-29 10:52:11'),(91,0,14,86,'2014-08-29 10:52:00','2014-08-29 10:52:13'),(92,20,15,42,'2014-08-29 10:58:58','2014-08-29 10:59:08'),(93,0,15,45,'2014-08-29 10:58:58','2014-08-29 10:59:13'),(94,25,15,71,'2014-08-29 10:58:58','2014-08-29 10:59:19'),(95,15,15,12,'2014-08-29 10:58:58','2014-08-29 10:59:27'),(96,0,16,45,'2014-08-29 11:07:16','2014-08-29 11:08:15'),(97,5,16,26,'2014-08-29 11:07:16','2014-08-29 11:08:18'),(98,35,16,30,'2014-08-29 11:07:16','2014-08-29 11:08:25'),(99,65,16,85,'2014-08-29 11:07:16','2014-08-29 11:08:37'),(100,10,16,12,'2014-08-29 11:07:16','2014-08-29 11:09:00'),(101,15,16,87,'2014-08-29 11:07:44','2014-08-29 11:09:08'),(102,15,16,88,'2014-08-29 11:08:11','2014-08-29 11:09:16'),(103,15,16,89,'2014-08-29 11:08:48','2014-08-29 11:09:20'),(104,0,17,45,'2014-08-29 11:12:50','2014-08-29 11:12:54'),(107,10,18,2,'2014-08-29 11:16:59','2014-08-29 11:17:05'),(108,10,18,4,'2014-08-29 11:16:59','2014-08-29 11:17:09'),(109,10,18,5,'2014-08-29 11:16:59','2014-08-29 11:17:12'),(110,5,18,1,'2014-08-29 11:16:59','2014-08-29 11:17:16'),(111,10,18,12,'2014-08-29 11:16:59','2014-08-29 11:17:20'),(112,25,17,92,'2014-08-29 11:20:38','2014-08-29 11:20:42'),(113,30,18,76,'2014-08-29 11:21:33','2014-08-29 11:21:33'),(114,0,19,45,'2014-08-29 11:26:53','2014-08-29 11:26:57'),(115,25,19,10,'2014-08-29 11:26:53','2014-08-29 11:27:01'),(124,6,20,2,'2014-08-29 11:29:07','2014-08-29 11:29:19'),(125,6,20,4,'2014-08-29 11:29:07','2014-08-29 11:29:22'),(126,6,20,5,'2014-08-29 11:29:07','2014-08-29 11:29:25'),(127,0,20,1,'2014-08-29 11:29:07','2014-08-29 11:29:27'),(128,30,20,76,'2014-08-29 11:29:07','2014-08-29 11:29:32'),(129,20,21,93,'2014-08-29 11:33:13','2014-08-29 11:33:25'),(130,15,21,94,'2014-08-29 11:33:21','2014-08-29 11:33:29'),(131,15,22,94,'2014-08-29 11:38:32','2014-08-29 11:38:37'),(132,25,22,95,'2014-08-29 11:38:32','2014-08-29 11:38:41'),(133,10,23,14,'2014-08-29 11:39:04','2014-08-29 11:39:10'),(134,10,23,16,'2014-08-29 11:39:04','2014-08-29 11:39:13'),(135,20,23,19,'2014-08-29 11:39:04','2014-08-29 11:39:16'),(136,0,24,83,'2014-08-29 11:44:36','2014-08-29 11:44:41'),(137,5,24,26,'2014-08-29 11:44:36','2014-08-29 11:44:44'),(138,10,24,28,'2014-08-29 11:44:36','2014-08-29 11:44:47'),(139,10,24,77,'2014-08-29 11:44:36','2014-08-29 11:44:50'),(140,0,25,86,'2014-08-29 11:58:04','2014-08-29 11:58:41'),(141,8,25,14,'2014-08-29 11:58:04','2014-08-29 11:58:47'),(142,13,25,58,'2014-08-29 11:58:04','2014-08-29 11:58:51'),(143,15,25,17,'2014-08-29 11:58:04','2014-08-29 11:59:01'),(144,25,25,18,'2014-08-29 11:58:04','2014-08-29 11:59:06'),(145,0,25,97,'2014-08-29 11:58:12','2014-08-29 11:59:15'),(146,1,25,98,'2014-08-29 11:58:23','2014-08-29 11:59:19'),(147,2,25,99,'2014-08-29 11:58:34','2014-08-29 11:59:25'),(151,2,26,99,'2014-08-29 12:02:03','2014-08-29 12:02:07'),(152,0,26,86,'2014-08-29 12:02:03','2014-08-29 12:02:10'),(153,5,26,26,'2014-08-29 12:02:03','2014-08-29 12:02:14'),(154,0,26,97,'2014-08-29 12:02:03','2014-08-29 12:02:17'),(155,1,26,98,'2014-08-29 12:02:03','2014-08-29 12:02:20'),(156,10,26,28,'2014-08-29 12:02:03','2014-08-29 12:02:28'),(157,10,26,100,'2014-08-29 12:02:03','2014-08-29 12:02:33'),(158,0,27,83,'2014-08-29 12:11:40','2014-08-29 12:11:49'),(159,25,27,10,'2014-08-29 12:11:40','2014-08-29 12:12:04'),(160,15,27,8,'2014-08-29 12:11:40','2014-08-29 12:12:00'),(161,0,28,83,'2014-08-29 12:13:08','2014-08-29 12:13:11'),(162,5,28,26,'2014-08-29 12:13:08','2014-08-29 12:13:15'),(163,10,28,101,'2014-08-29 12:13:22','2014-08-29 12:13:27'),(164,0,29,86,'2014-08-29 12:14:05','2014-08-29 12:14:09'),(165,0,29,97,'2014-08-29 12:14:05','2014-08-29 12:14:12'),(166,20,30,66,'2014-08-29 12:24:08','2014-08-29 12:25:04'),(167,0,30,103,'2014-08-29 12:24:24','2014-08-29 12:25:09'),(168,20,30,104,'2014-08-29 12:24:46','2014-08-29 12:25:13'),(169,20,30,105,'2014-08-29 12:24:59','2014-08-29 12:25:16'),(170,15,31,48,'2014-08-29 12:29:40','2014-08-29 12:29:53'),(171,10,31,109,'2014-08-29 12:29:50','2014-08-29 12:29:55'),(172,NULL,32,43,'2014-08-29 12:30:59','2014-08-29 12:30:59'),(173,NULL,32,15,'2014-08-29 12:30:59','2014-08-29 12:30:59'),(174,NULL,32,16,'2014-08-29 12:30:59','2014-08-29 12:30:59'),(175,15,33,6,'2014-08-29 12:40:47','2014-08-29 12:40:52'),(176,3,33,29,'2014-08-29 12:40:47','2014-08-29 12:40:58'),(177,5,33,26,'2014-08-29 12:40:47','2014-08-29 12:41:02'),(178,15,33,7,'2014-08-29 12:40:47','2014-08-29 12:41:05'),(179,10,33,12,'2014-08-29 12:40:47','2014-08-29 12:41:10'),(181,15,34,6,'2014-08-29 12:43:39','2014-08-29 12:43:43'),(182,3,34,29,'2014-08-29 12:43:39','2014-08-29 12:43:57'),(183,5,34,26,'2014-08-29 12:43:39','2014-08-29 12:44:03'),(184,15,34,7,'2014-08-29 12:43:39','2014-08-29 12:44:06'),(185,25,34,71,'2014-08-29 12:43:39','2014-08-29 12:44:12'),(186,10,34,12,'2014-08-29 12:43:39','2014-08-29 12:44:16'),(187,10,35,2,'2014-08-29 12:48:01','2014-08-29 12:48:07'),(188,10,35,3,'2014-08-29 12:48:01','2014-08-29 12:48:10'),(189,10,35,4,'2014-08-29 12:48:01','2014-08-29 12:48:12'),(190,10,35,5,'2014-08-29 12:48:01','2014-08-29 12:48:14'),(191,5,35,1,'2014-08-29 12:48:01','2014-08-29 12:48:17'),(192,0,36,83,'2014-08-29 12:49:15','2014-08-29 12:49:19'),(193,10,36,2,'2014-08-29 12:49:15','2014-08-29 12:49:22'),(194,10,36,3,'2014-08-29 12:49:15','2014-08-29 12:49:24'),(195,10,36,4,'2014-08-29 12:49:15','2014-08-29 12:49:27'),(196,10,36,5,'2014-08-29 12:49:15','2014-08-29 12:49:29'),(197,15,36,6,'2014-08-29 12:49:15','2014-08-29 12:49:37'),(198,15,36,9,'2014-08-29 12:49:15','2014-08-29 12:49:40'),(199,5,36,26,'2014-08-29 12:49:15','2014-08-29 12:49:43'),(200,15,36,7,'2014-08-29 12:49:15','2014-08-29 12:49:45'),(201,25,36,10,'2014-08-29 12:49:15','2014-08-29 12:49:48'),(202,15,36,8,'2014-08-29 12:49:15','2014-08-29 12:49:50'),(203,5,36,1,'2014-08-29 12:49:15','2014-08-29 12:49:54'),(204,20,37,43,'2014-08-29 12:58:05','2014-08-29 12:58:23'),(205,10,37,38,'2014-08-29 12:58:05','2014-08-29 12:58:31'),(206,10,37,15,'2014-08-29 12:58:05','2014-08-29 12:58:40'),(207,10,37,17,'2014-08-29 12:58:05','2014-08-29 12:58:44'),(208,10,37,19,'2014-08-29 12:58:05','2014-08-29 12:58:48'),(209,5,37,107,'2014-08-29 12:58:05','2014-08-29 12:59:07'),(210,5,37,106,'2014-08-29 12:58:05','2014-08-29 12:59:12'),(211,5,37,103,'2014-08-29 12:58:05','2014-08-29 12:59:19'),(212,25,37,105,'2014-08-29 12:58:05','2014-08-29 12:59:24'),(213,25,37,113,'2014-08-29 12:58:16','2014-08-29 12:59:29'),(214,0,38,13,'2014-08-29 14:07:32','2014-08-29 14:08:47'),(215,10,38,62,'2014-08-29 14:07:32','2014-08-29 14:08:54'),(216,10,38,114,'2014-08-29 14:08:04','2014-08-29 14:09:00'),(217,0,38,115,'2014-08-29 14:08:26','2014-08-29 14:09:03'),(218,0,38,116,'2014-08-29 14:08:38','2014-08-29 14:09:06'),(219,5,39,21,'2014-08-29 14:13:09','2014-08-29 14:13:16'),(220,10,39,22,'2014-08-29 14:13:09','2014-08-29 14:13:19'),(221,15,39,24,'2014-08-29 14:13:09','2014-08-29 14:13:22'),(222,0,40,83,'2014-08-29 14:13:52','2014-08-29 14:13:57'),(223,25,40,10,'2014-08-29 14:13:52','2014-08-29 14:14:01'),(224,15,40,8,'2014-08-29 14:13:52','2014-08-29 14:14:03'),(225,20,41,43,'2014-08-29 14:34:05','2014-08-29 14:34:21'),(226,5,41,13,'2014-08-29 14:34:05','2014-08-29 14:34:26'),(227,10,41,114,'2014-08-29 14:34:05','2014-08-29 14:34:31'),(228,25,41,117,'2014-08-29 14:34:14','2014-08-29 14:34:35'),(229,5,42,118,'2014-08-29 14:36:12','2014-08-29 14:36:18'),(230,0,43,116,'2014-08-29 14:45:00','2014-08-29 14:45:39'),(231,5,43,119,'2014-08-29 14:45:29','2014-08-29 14:45:43'),(232,0,44,116,'2014-08-29 14:46:12','2014-08-29 14:46:16'),(233,10,44,68,'2014-08-29 14:46:12','2014-08-29 14:46:19'),(234,5,44,119,'2014-08-29 14:46:12','2014-08-29 14:46:22'),(235,5,45,21,'2014-08-29 14:54:40','2014-08-29 14:54:45'),(236,15,45,7,'2014-08-29 14:54:40','2014-08-29 14:54:49'),(237,15,46,6,'2014-08-29 14:55:58','2014-08-29 14:56:08'),(238,5,46,26,'2014-08-29 14:55:58','2014-08-29 14:56:11'),(239,15,46,7,'2014-08-29 14:55:58','2014-08-29 14:56:13'),(240,10,46,77,'2014-08-29 14:55:58','2014-08-29 14:56:17'),(241,5,46,121,'2014-08-29 14:56:04','2014-08-29 14:56:21'),(242,30,47,43,'2014-08-29 15:00:32','2014-08-29 15:00:57'),(243,10,47,14,'2014-08-29 15:00:32','2014-08-29 15:01:03'),(244,10,47,15,'2014-08-29 15:00:32','2014-08-29 15:01:07'),(245,0,47,59,'2014-08-29 15:00:32','2014-08-29 15:01:13'),(246,20,47,16,'2014-08-29 15:00:32','2014-08-29 15:01:19'),(247,10,47,122,'2014-08-29 15:00:43','2014-08-29 15:01:23'),(248,25,47,123,'2014-08-29 15:00:52','2014-08-29 15:01:27'),(249,30,48,105,'2014-08-29 15:06:03','2014-08-29 15:06:17'),(250,35,48,123,'2014-08-29 15:06:03','2014-08-29 15:06:20'),(251,15,48,124,'2014-08-29 15:06:12','2014-08-29 15:06:24'),(252,45,49,126,'2014-08-29 15:11:13','2014-08-29 15:11:26'),(253,55,49,127,'2014-08-29 15:11:46','2014-08-29 15:11:49'),(254,5,50,26,'2014-08-29 15:12:22','2014-08-29 15:12:25'),(255,10,50,77,'2014-08-29 15:12:22','2014-08-29 15:12:29'),(256,10,51,16,'2014-08-29 15:16:58','2014-08-29 15:17:04'),(258,5,52,128,'2014-08-29 15:21:14','2014-08-29 15:21:17'),(259,20,52,129,'2014-08-29 15:21:14','2014-08-29 15:21:20'),(260,20,53,129,'2014-08-29 15:21:53','2014-08-29 15:22:10'),(261,10,53,109,'2014-08-29 15:21:53','2014-08-29 15:22:14'),(262,5,53,26,'2014-08-29 15:21:53','2014-08-29 15:22:18'),(263,10,53,74,'2014-08-29 15:21:53','2014-08-29 15:22:21'),(264,0,54,83,'2014-08-29 15:32:49','2014-08-29 15:32:52'),(265,5,54,26,'2014-08-29 15:32:49','2014-08-29 15:32:55'),(266,10,54,77,'2014-08-29 15:32:49','2014-08-29 15:32:57'),(267,20,55,56,'2014-08-29 15:37:27','2014-08-29 15:37:36'),(268,10,55,17,'2014-08-29 15:37:27','2014-08-29 15:37:40'),(269,20,55,105,'2014-08-29 15:37:27','2014-08-29 15:37:43'),(271,20,56,56,'2014-08-29 15:42:31','2014-08-29 15:42:35'),(272,10,56,17,'2014-08-29 15:42:31','2014-08-29 15:42:37'),(273,10,56,68,'2014-08-29 15:42:31','2014-08-29 15:42:41'),(274,20,56,105,'2014-08-29 15:42:31','2014-08-29 15:42:43'),(275,20,57,14,'2014-08-29 15:55:19','2014-08-29 15:55:26'),(276,40,57,20,'2014-08-29 15:55:19','2014-08-29 15:55:29'),(277,25,57,105,'2014-08-29 15:55:19','2014-08-29 15:55:32'),(278,10,58,132,'2014-08-29 15:56:12','2014-08-29 15:56:17'),(279,10,59,16,'2014-08-29 16:04:48','2014-08-29 16:04:51'),(280,5,60,38,'2014-08-29 16:15:08','2014-08-29 16:15:35'),(281,10,60,109,'2014-08-29 16:15:08','2014-08-29 16:15:40'),(282,1,60,72,'2014-08-29 16:15:08','2014-08-29 16:15:43'),(283,0,60,105,'2014-08-29 16:15:08','2014-08-29 16:15:47'),(284,25,60,123,'2014-08-29 16:15:08','2014-08-29 16:15:53'),(285,0,60,135,'2014-08-29 16:15:16','2014-08-29 16:15:56'),(286,0,60,136,'2014-08-29 16:15:24','2014-08-29 16:16:08'),(287,30,60,116,'2014-08-29 16:17:48','2014-08-29 16:17:48'),(288,10,61,2,'2015-02-04 14:35:54','2015-02-04 14:36:20'),(289,10,61,3,'2015-02-04 14:35:54','2015-02-04 14:36:07'),(290,10,61,4,'2015-02-04 14:35:54','2015-02-04 14:36:10'),(291,10,61,5,'2015-02-04 14:35:54','2015-02-04 14:36:12'),(292,15,61,6,'2015-02-04 14:35:54','2015-02-04 14:36:25'),(293,10,61,143,'2015-02-04 14:35:54','2015-02-04 14:36:31'),(294,15,61,142,'2015-02-04 14:35:54','2015-02-04 14:36:35'),(295,15,61,7,'2015-02-04 14:35:54','2015-02-04 14:36:38'),(296,5,61,1,'2015-02-04 14:35:54','2015-02-04 14:36:42'),(297,0,62,83,'2015-02-04 14:38:22','2015-02-04 14:38:26'),(298,15,62,9,'2015-02-04 14:38:22','2015-02-04 14:38:31'),(299,25,62,10,'2015-02-04 14:38:22','2015-02-04 14:38:34'),(300,15,62,8,'2015-02-04 14:38:22','2015-02-04 14:38:38'),(301,30,62,11,'2015-02-04 14:38:22','2015-02-04 14:38:42'),(302,5,63,2,'2015-02-04 14:42:48','2015-02-04 14:42:52'),(303,5,63,4,'2015-02-04 14:42:48','2015-02-04 14:42:54'),(304,5,63,5,'2015-02-04 14:42:48','2015-02-04 14:42:59'),(305,10,63,9,'2015-02-04 14:42:48','2015-02-04 14:43:01'),(306,25,63,11,'2015-02-04 14:42:48','2015-02-04 14:43:04'),(307,15,64,13,'2015-02-04 14:44:18','2015-02-04 14:44:23'),(308,5,64,9,'2015-02-04 14:44:18','2015-02-04 14:44:28'),(309,10,64,10,'2015-02-04 14:44:18','2015-02-04 14:44:33'),(310,5,64,12,'2015-02-04 14:44:18','2015-02-04 14:44:52'),(311,15,64,11,'2015-02-04 14:44:18','2015-02-04 14:44:58'),(312,10,65,14,'2015-02-04 14:46:06','2015-02-04 14:46:12'),(313,10,65,15,'2015-02-04 14:46:06','2015-02-04 14:46:17'),(314,20,65,20,'2015-02-04 14:46:06','2015-02-04 14:46:26'),(315,15,65,17,'2015-02-04 14:46:06','2015-02-04 14:46:31'),(316,25,65,18,'2015-02-04 14:46:06','2015-02-04 14:46:33'),(317,10,65,16,'2015-02-04 14:46:06','2015-02-04 14:46:21'),(318,15,65,19,'2015-02-04 14:46:06','2015-02-04 14:46:37'),(319,5,66,21,'2015-02-04 14:47:06','2015-02-04 14:47:11'),(320,15,66,23,'2015-02-04 14:47:06','2015-02-04 14:47:22'),(321,10,66,22,'2015-02-04 14:47:06','2015-02-04 14:47:25'),(322,15,66,24,'2015-02-04 14:47:06','2015-02-04 14:47:29'),(323,5,67,25,'2015-02-04 14:48:39','2015-02-04 14:49:12'),(324,10,67,27,'2015-02-04 14:48:39','2015-02-04 14:49:17'),(325,15,67,29,'2015-02-04 14:48:39','2015-02-04 14:49:21'),(326,5,67,26,'2015-02-04 14:48:39','2015-02-04 14:49:25'),(327,20,67,30,'2015-02-04 14:48:39','2015-02-04 14:49:30'),(328,10,67,28,'2015-02-04 14:48:39','2015-02-04 14:49:44'),(329,5,68,36,'2015-02-04 14:50:32','2015-02-04 14:50:39'),(330,10,68,38,'2015-02-04 14:50:32','2015-02-04 14:50:43'),(331,10,68,37,'2015-02-04 14:50:32','2015-02-04 14:50:46'),(332,5,68,1,'2015-02-04 14:50:32','2015-02-04 14:50:51'),(333,20,69,43,'2015-02-04 14:52:00','2015-02-04 14:52:04'),(334,10,69,19,'2015-02-04 14:52:00','2015-02-04 14:52:07'),(335,5,69,107,'2015-02-04 14:52:00','2015-02-04 14:52:11'),(336,5,69,106,'2015-02-04 14:52:00','2015-02-04 14:52:14'),(337,5,69,103,'2015-02-04 14:52:00','2015-02-04 14:52:18'),(338,25,69,105,'2015-02-04 14:52:00','2015-02-04 14:52:20'),(339,25,70,147,'2015-02-04 14:53:33','2015-02-04 14:53:37'),(340,25,70,148,'2015-02-04 14:53:33','2015-02-04 14:53:40'),(341,10,70,144,'2015-02-04 14:53:33','2015-02-04 14:53:44'),(342,15,70,145,'2015-02-04 14:53:33','2015-02-04 14:53:49'),(343,20,70,146,'2015-02-04 14:53:33','2015-02-04 14:53:58'),(349,20,71,42,'2015-02-04 15:14:24','2015-02-04 15:51:22'),(350,0,71,45,'2015-02-04 15:14:24','2015-02-04 15:51:25'),(351,25,71,71,'2015-02-04 15:14:24','2015-02-04 15:51:28'),(352,15,71,12,'2015-02-04 15:14:24','2015-02-04 15:51:32'),(353,30,71,76,'2015-02-04 15:14:24','2015-02-04 15:52:29'),(354,0,72,45,'2015-02-04 16:10:18','2015-02-04 16:10:21'),(355,10,72,150,'2015-02-04 16:10:18','2015-02-04 16:10:23'),(356,25,72,92,'2015-02-04 16:10:18','2015-02-04 16:10:27'),(357,25,72,76,'2015-02-04 16:10:18','2015-02-04 16:10:31'),(358,10,73,15,'2015-02-06 13:45:16','2015-02-06 13:45:20'),(359,10,73,22,'2015-02-06 13:45:16','2015-02-06 13:45:23'),(360,25,73,153,'2015-02-06 13:45:16','2015-02-06 13:45:30'),(361,1,74,44,'2015-02-06 14:15:38','2015-02-06 14:15:45'),(362,0,75,29,'2015-02-06 14:31:41','2015-02-06 14:31:45'),(363,15,75,94,'2015-02-06 14:31:41','2015-02-06 14:31:48'),(364,25,75,95,'2015-02-06 14:31:41','2015-02-06 14:31:52'),(365,10,76,14,'2015-02-06 14:32:23','2015-02-06 14:32:30'),(366,10,76,16,'2015-02-06 14:32:23','2015-02-06 14:32:34'),(367,20,76,19,'2015-02-06 14:32:23','2015-02-06 14:32:37'),(368,0,77,45,'2015-02-06 14:42:48','2015-02-06 14:42:51'),(369,5,77,2,'2015-02-06 14:42:48','2015-02-06 14:42:56'),(370,5,77,4,'2015-02-06 14:42:48','2015-02-06 14:43:01'),(371,5,77,5,'2015-02-06 14:42:48','2015-02-06 14:43:03'),(372,25,77,10,'2015-02-06 14:42:48','2015-02-06 14:43:06'),(373,30,77,76,'2015-02-06 14:42:48','2015-02-06 14:43:10'),(374,5,78,26,'2015-02-18 13:08:20','2015-02-18 13:08:26'),(375,10,78,28,'2015-02-18 13:08:20','2015-02-18 13:08:29'),(376,10,78,77,'2015-02-18 13:08:20','2015-02-18 13:08:33'),(377,0,79,86,'2015-02-18 13:18:28','2015-02-18 13:18:32'),(378,8,79,14,'2015-02-18 13:18:28','2015-02-18 13:18:36'),(379,13,79,58,'2015-02-18 13:18:28','2015-02-18 13:18:42'),(380,15,79,17,'2015-02-18 13:18:28','2015-02-18 13:18:46'),(381,25,79,18,'2015-02-18 13:18:28','2015-02-18 13:18:49'),(382,0,79,97,'2015-02-18 13:18:28','2015-02-18 13:18:52'),(383,1,79,98,'2015-02-18 13:18:28','2015-02-18 13:18:55'),(384,5,80,26,'2015-02-18 13:19:47','2015-02-18 13:19:53'),(385,10,80,28,'2015-02-18 13:19:47','2015-02-18 13:19:56'),(386,10,80,100,'2015-02-18 13:19:47','2015-02-18 13:20:03'),(387,20,81,66,'2015-02-18 13:43:33','2015-02-18 13:43:38'),(388,20,81,104,'2015-02-18 13:43:33','2015-02-18 13:44:19'),(389,0,81,103,'2015-02-18 13:43:33','2015-02-18 13:44:22'),(390,20,81,105,'2015-02-18 13:43:33','2015-02-18 13:44:24'),(391,15,82,48,'2015-02-18 13:56:46','2015-02-18 13:56:50'),(392,10,82,109,'2015-02-18 13:56:46','2015-02-18 13:56:53'),(393,0,83,15,'2015-02-18 14:03:23','2015-02-18 14:03:27'),(394,10,83,16,'2015-02-18 14:03:23','2015-02-18 14:03:31'),(395,30,84,43,'2015-02-18 14:03:59','2015-02-18 14:04:09'),(396,10,84,14,'2015-02-18 14:03:59','2015-02-18 14:04:13'),(397,10,84,15,'2015-02-18 14:03:59','2015-02-18 14:04:16'),(398,20,84,16,'2015-02-18 14:03:59','2015-02-18 14:04:22'),(399,25,84,123,'2015-02-18 14:03:59','2015-02-18 14:04:25'),(400,5,85,21,'2015-02-18 14:08:04','2015-02-18 14:08:10'),(401,10,85,143,'2015-02-18 14:08:04','2015-02-18 14:08:16'),(402,15,85,142,'2015-02-18 14:08:04','2015-02-18 14:08:19'),(403,10,85,22,'2015-02-18 14:08:04','2015-02-18 14:08:22'),(404,15,85,24,'2015-02-18 14:08:04','2015-02-18 14:08:27'),(405,15,85,7,'2015-02-18 14:08:04','2015-02-18 14:08:29'),(406,5,86,121,'2015-02-18 14:10:15','2015-02-18 14:10:19'),(407,5,86,26,'2015-02-18 14:10:15','2015-02-18 14:10:21'),(408,10,86,77,'2015-02-18 14:10:15','2015-02-18 14:10:25'),(409,0,87,83,'2015-02-18 14:21:19','2015-02-18 14:21:25'),(410,45,88,126,'2015-02-18 14:22:57','2015-02-18 14:23:03'),(411,55,88,127,'2015-02-18 14:22:57','2015-02-18 14:23:05'),(412,10,89,46,'2015-02-18 14:24:18','2015-02-18 14:24:26'),(413,5,89,26,'2015-02-18 14:24:18','2015-02-18 14:24:29'),(414,10,90,16,'2015-02-18 14:35:44','2015-02-18 14:35:47'),(415,5,91,128,'2015-02-18 14:45:47','2015-02-18 14:45:54'),(416,20,91,129,'2015-02-18 14:45:47','2015-02-18 14:45:56'),(417,10,92,109,'2015-02-18 14:47:16','2015-02-18 14:47:20'),(418,5,92,26,'2015-02-18 14:47:16','2015-02-18 14:47:23'),(419,10,92,74,'2015-02-18 14:47:16','2015-02-18 14:47:27'),(420,0,93,105,'2015-02-19 12:27:06','2015-02-19 12:27:10'),(421,0,93,135,'2015-02-19 12:27:06','2015-02-19 12:27:13'),(422,0,94,136,'2015-02-19 12:27:48','2015-02-19 12:27:52'),(423,25,94,123,'2015-02-19 12:27:48','2015-02-19 12:27:54'),(424,5,95,38,'2015-02-19 12:28:46','2015-02-19 12:28:51'),(425,30,95,116,'2015-02-19 12:28:46','2015-02-19 12:28:56'),(426,10,95,109,'2015-02-19 12:28:46','2015-02-19 12:29:00'),(427,5,95,72,'2015-02-19 12:28:46','2015-02-19 12:29:03'),(428,0,96,83,'2015-02-19 12:33:28','2015-02-19 12:33:31'),(429,5,96,26,'2015-02-19 12:33:28','2015-02-19 12:33:34'),(430,10,96,77,'2015-02-19 12:33:28','2015-02-19 12:33:37'),(431,20,97,14,'2015-02-19 12:39:27','2015-02-19 12:39:34'),(432,20,97,15,'2015-02-19 12:39:27','2015-02-19 12:39:36'),(433,0,98,52,'2015-02-19 12:40:03','2015-02-19 12:42:44'),(434,25,99,105,'2015-02-19 12:42:25','2015-02-19 12:42:27'),(435,20,100,14,'2015-02-19 12:43:22','2015-02-19 12:43:26'),(436,40,100,20,'2015-02-19 12:43:22','2015-02-19 12:43:28'),(437,10,101,159,'2015-02-19 12:43:39','2015-02-19 12:43:42'),(438,10,102,159,'2015-02-19 12:46:28','2015-02-19 12:46:32'),(439,10,102,132,'2015-02-19 12:46:28','2015-02-19 12:46:34'),(440,0,103,159,'2015-02-19 12:48:09','2015-02-19 12:48:12'),(441,10,104,16,'2015-02-19 12:51:39','2015-02-19 12:51:43');
/*!40000 ALTER TABLE `wargeargroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wargears`
--

DROP TABLE IF EXISTS `wargears`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wargears` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `created` varchar(45) DEFAULT NULL,
  `modified` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wargears`
--

LOCK TABLES `wargears` WRITE;
/*!40000 ALTER TABLE `wargears` DISABLE KEYS */;
INSERT INTO `wargears` VALUES (1,'Storm bolter','2014-08-28 15:55:23','2014-08-28 15:55:23'),(2,'Combi-flamer','2014-08-28 15:55:34','2014-08-28 15:55:34'),(3,'Combi-grav','2014-08-28 15:55:45','2014-08-28 15:55:45'),(4,'Combi-melta','2014-08-28 15:55:54','2014-08-28 15:55:54'),(5,'Combi-plasma','2014-08-28 15:56:03','2014-08-28 15:56:03'),(6,'Grav-pistol','2014-08-28 15:56:13','2014-08-28 15:56:13'),(7,'Plasma pistol','2014-08-28 15:56:20','2014-08-28 15:56:20'),(8,'Power weapon','2014-08-28 15:57:04','2014-08-28 15:57:04'),(9,'Lightning claw(s)','2014-08-28 15:57:15','2014-08-28 15:57:15'),(10,'Power fist','2014-08-28 15:57:22','2014-08-28 15:57:22'),(11,'Thunder hammer','2014-08-28 15:57:33','2014-08-28 15:57:33'),(12,'Storm shield','2014-08-28 15:58:12','2014-08-28 15:58:12'),(13,'Chainfist','2014-08-28 15:58:19','2014-08-28 15:58:19'),(14,'Heavy bolter','2014-08-28 16:58:06','2014-08-28 16:58:06'),(15,'Heavy flamer','2014-08-28 16:58:18','2014-08-28 16:58:18'),(16,'Multi-melta','2014-08-28 16:58:29','2014-08-28 16:58:29'),(17,'Missile launcher','2014-08-28 16:58:38','2014-08-28 16:58:38'),(18,'Missile launcher (Flakk)','2014-08-28 16:58:47','2014-08-28 16:58:47'),(19,'Plasma cannon','2014-08-28 16:58:55','2014-08-28 16:58:55'),(20,'Lascannon','2014-08-28 16:59:01','2014-08-28 16:59:01'),(21,'Flamer','2014-08-28 17:04:20','2014-08-28 17:04:20'),(22,'Meltagun','2014-08-28 17:04:37','2014-08-28 17:04:37'),(23,'Grav-gun','2014-08-28 17:04:46','2014-08-28 17:04:46'),(24,'Plasma gun','2014-08-28 17:04:53','2014-08-28 17:04:53'),(25,'Auspex','2014-08-28 17:05:25','2014-08-28 17:05:25'),(26,'Melta bombs','2014-08-28 17:05:33','2014-08-28 17:05:33'),(27,'Digital weapons','2014-08-28 17:05:44','2014-08-28 17:05:44'),(28,'Teleport homer','2014-08-28 17:05:51','2014-08-28 17:05:51'),(29,'Jump pack','2014-08-28 17:05:57','2014-08-28 17:05:57'),(30,'Space Marine bike(s)','2014-08-28 17:06:03','2014-08-28 17:06:03'),(31,'The Primarch\'s Wrath','2014-08-28 17:06:40','2014-08-28 17:06:40'),(32,'Teeth of Terra','2014-08-28 17:06:49','2014-08-28 17:06:49'),(33,'The Shield Eternal','2014-08-28 17:06:56','2014-08-28 17:06:56'),(34,'The Burning Blade','2014-08-28 17:07:18','2014-08-28 17:07:18'),(35,'The Armour Indomitus','2014-08-28 17:07:25','2014-08-28 17:07:25'),(36,'Dozer blade','2014-08-28 17:07:59','2014-08-28 17:07:59'),(37,'Hunter-killer missile','2014-08-28 17:08:16','2014-08-28 17:08:16'),(38,'Extra Armour','2014-08-28 17:08:23','2014-08-28 17:08:23'),(39,'Apothecary','2014-08-28 17:09:01','2014-08-28 17:09:01'),(40,'Armour of Antilochus','2014-08-28 17:09:07','2014-08-28 17:09:07'),(41,'Armour of Faith','2014-08-28 17:09:17','2014-08-28 17:09:17'),(42,'Artificer armour ','2014-08-28 17:09:32','2014-08-28 17:09:32'),(43,'Assault cannon','2014-08-28 17:09:37','2014-08-28 17:09:37'),(44,'Bolt pistol','2014-08-28 17:09:44','2014-08-28 17:09:44'),(45,'Boltgun','2014-08-28 17:09:48','2014-08-29 10:44:56'),(46,'Biker Veteran Sergeant','2014-08-28 17:09:53','2014-08-28 17:09:53'),(47,'Black Sword','2014-08-28 17:09:59','2014-08-28 17:09:59'),(48,'Deathwind launcher','2014-08-28 17:10:23','2014-08-28 17:10:23'),(49,'Demolisher cannon','2014-08-28 17:10:29','2014-08-28 17:10:29'),(50,'Dorn\'s Arrow','2014-08-28 17:10:34','2014-08-28 17:10:34'),(51,'Fist of Dorn','2014-08-28 17:11:06','2014-08-28 17:11:06'),(52,'Flamestorm cannons','2014-08-28 17:11:12','2014-08-28 17:11:12'),(53,'Frag assault launchers','2014-08-28 17:11:17','2014-08-28 17:11:17'),(54,'Frag grenades','2014-08-28 17:11:21','2014-08-28 17:11:21'),(55,'Gauntlet of the Forge','2014-08-28 17:11:28','2014-08-28 17:11:28'),(56,'Grav-cannon and grav-amp','2014-08-28 17:11:35','2014-08-28 17:11:35'),(57,'Heavy bolter (Attack Bike only)','2014-08-28 17:11:48','2014-08-28 17:11:48'),(58,'Heavy bolter with hellfire shells','2014-08-28 17:11:54','2014-08-28 17:11:54'),(59,'Heavy flamer (replace Heavy bolter)','2014-08-28 17:12:03','2014-08-28 17:12:03'),(60,'Icarus stormcannon array','2014-08-28 17:12:25','2014-08-28 17:12:25'),(61,'Iron halo','2014-08-28 17:12:30','2014-08-28 17:12:30'),(62,'Ironclad assault launchers','2014-08-28 17:12:34','2014-08-28 17:12:34'),(63,'Jamming beacon ','2014-08-28 17:12:43','2014-08-28 17:12:43'),(64,'Kesare\'s Mantle','2014-08-28 17:12:53','2014-08-28 17:12:53'),(65,'Krak grenades','2014-08-28 17:12:57','2014-08-28 17:12:57'),(66,'Lascannon and twin-linked plasma gun','2014-08-28 17:13:05','2014-08-28 17:13:05'),(67,'Mantle of the Suzerain','2014-08-28 17:13:22','2014-08-28 17:13:22'),(68,'Omniscope','2014-08-28 17:13:33','2014-08-28 17:13:33'),(69,'Power sword','2014-08-28 17:13:43','2014-08-28 17:58:38'),(70,'Power armour','2014-08-28 17:13:57','2014-08-28 17:13:57'),(71,'Relic blade','2014-08-28 17:14:05','2014-08-28 17:14:05'),(72,'Searchlight','2014-08-28 17:14:13','2014-08-28 17:14:13'),(73,'Scout armour','2014-08-28 17:14:20','2014-08-28 17:14:20'),(74,'Scout bike veteran sergeant','2014-08-28 17:14:26','2014-08-28 17:14:26'),(75,'Seismic hammer with built-in meltagun','2014-08-28 17:14:32','2014-08-28 17:14:32'),(76,'Terminator armour','2014-08-28 17:14:46','2014-08-28 17:14:46'),(77,'Veteran Sergeant','2014-08-28 17:14:59','2014-08-28 17:14:59'),(78,'Whirlwind multiple missile launcher','2014-08-28 17:15:23','2014-08-28 17:15:23'),(79,'Crozius arcanum','2014-08-29 10:01:00','2014-08-29 10:01:00'),(80,'Rosarius','2014-08-29 10:01:07','2014-08-29 10:01:07'),(81,'Moondrakkan','2014-08-29 10:03:26','2014-08-29 10:03:26'),(82,'Master-crafted plasma pistol','2014-08-29 10:39:28','2014-08-29 10:39:28'),(83,'Chainsword','2014-08-29 10:46:53','2014-08-29 10:46:53'),(84,'Chapter banner','2014-08-29 10:50:55','2014-08-29 10:50:55'),(85,'Standard of the Emperor Ascendant','2014-08-29 10:51:04','2014-08-29 10:51:04'),(86,'Close combat weapon','2014-08-29 10:52:00','2014-08-29 10:52:00'),(87,'Company Champion','2014-08-29 11:07:44','2014-08-29 11:07:44'),(88,'Apothecary (with Narthecium)','2014-08-29 11:08:11','2014-08-29 11:08:11'),(89,'Company standard','2014-08-29 11:08:48','2014-08-29 11:08:48'),(90,'Force weapon','2014-08-29 11:15:37','2014-08-29 11:15:37'),(91,'Psychic hood','2014-08-29 11:15:42','2014-08-29 11:15:42'),(92,'Psyker (Mastery Level 2)','2014-08-29 11:20:38','2014-08-29 11:20:38'),(93,'Conversion beamer','2014-08-29 11:33:13','2014-08-29 11:33:13'),(94,'Power axe','2014-08-29 11:33:21','2014-08-29 11:33:21'),(95,'Servo-harness','2014-08-29 11:34:35','2014-08-29 11:34:35'),(96,'Servo-arm','2014-08-29 11:34:49','2014-08-29 11:34:49'),(97,'Shotgun','2014-08-29 11:58:12','2014-08-29 11:58:12'),(98,'Sniper rifle','2014-08-29 11:58:23','2014-08-29 11:58:23'),(99,'Camo cloaks','2014-08-29 11:58:34','2014-08-29 11:58:34'),(100,'Veteran Scout sergeant','2014-08-29 12:00:59','2014-08-29 12:00:59'),(101,'Sword Brother','2014-08-29 12:13:22','2014-08-29 12:13:22'),(102,'Smoke launchers','2014-08-29 12:23:25','2014-08-29 12:23:25'),(103,'Twin-linked heavy flamer','2014-08-29 12:24:24','2014-08-29 12:24:24'),(104,'Twin-linked Assault cannon','2014-08-29 12:24:46','2014-08-29 12:24:46'),(105,'Twin-linked Lascannon','2014-08-29 12:24:59','2014-08-29 12:24:59'),(106,'Twin-linked heavy bolter','2014-08-29 12:25:31','2014-08-29 12:25:31'),(107,'Twin-linked Autocannon','2014-08-29 12:25:40','2014-08-29 12:25:40'),(108,'Twin-linked flamer','2014-08-29 12:25:51','2014-08-29 12:25:51'),(109,'Locator beacon','2014-08-29 12:29:50','2014-08-29 12:29:50'),(110,'Cerberus launcher','2014-08-29 12:32:06','2014-08-29 12:32:06'),(111,'Special issue ammunition','2014-08-29 12:53:11','2014-08-29 12:53:11'),(112,'Power fist with built-in storm bolter','2014-08-29 12:56:29','2014-08-29 12:56:29'),(113,'Venerable Dreadnought','2014-08-29 12:58:16','2014-08-29 12:58:16'),(114,'Heavy flamer (replace Storm bolter)','2014-08-29 14:08:03','2014-08-29 14:08:03'),(115,'Heavy flamer (replace melta gun)','2014-08-29 14:08:26','2014-08-29 14:08:26'),(116,'Hurricane bolter ','2014-08-29 14:08:38','2014-08-29 14:08:38'),(117,'Cyclone missile launcher','2014-08-29 14:34:14','2014-08-29 14:34:14'),(118,'Thunder hammer and Storm shield','2014-08-29 14:36:12','2014-08-29 14:36:12'),(119,'Twin-linked meltagun','2014-08-29 14:45:29','2014-08-29 14:45:29'),(120,'Siege drills','2014-08-29 14:48:31','2014-08-29 14:48:31'),(121,'Combat shield','2014-08-29 14:56:04','2014-08-29 14:56:04'),(122,'Multi-melta (replaces Heavy bolter)','2014-08-29 15:00:43','2014-08-29 15:00:43'),(123,'Typhoon missile launcher','2014-08-29 15:00:52','2014-08-29 15:00:52'),(124,'Skyhammer missile launcher','2014-08-29 15:06:12','2014-08-29 15:06:12'),(125,'Ceramite plating','2014-08-29 15:08:19','2014-08-29 15:08:19'),(126,'Attack bike','2014-08-29 15:10:11','2014-08-29 15:10:11'),(127,'Attack bike with Multi-melta','2014-08-29 15:11:45','2014-08-29 15:11:45'),(128,'Astartes grenade launcher','2014-08-29 15:20:22','2014-08-29 15:20:22'),(129,'Cluster mines','2014-08-29 15:21:04','2014-08-29 15:21:04'),(130,'Signum (Sergeant/Veteran Sergeant only)','2014-08-29 15:34:51','2014-08-29 15:34:51'),(131,'Thunderfire cannon','2014-08-29 15:51:46','2014-08-29 15:51:46'),(132,'Siege shield','2014-08-29 15:56:12','2014-08-29 15:56:12'),(133,'Autocannon','2014-08-29 15:57:25','2014-08-29 15:57:25'),(134,'Skyspear missile launcher','2014-08-29 16:01:23','2014-08-29 16:01:23'),(135,'Twin-linked plasma cannon','2014-08-29 16:15:16','2014-08-29 16:15:16'),(136,'Twin-linked multi-melta','2014-08-29 16:15:24','2014-08-29 16:15:24'),(137,'Stormstrike missiles ','2014-08-29 16:18:25','2014-08-29 16:18:25'),(138,'Force axe','2014-09-02 15:12:27','2014-09-02 15:12:27'),(139,'Force stave','2014-09-02 15:12:56','2014-09-02 15:12:56'),(140,'Eviscerator','2014-09-02 15:13:32','2014-09-02 15:13:32'),(141,'Heavy chainsword','2014-09-02 15:13:59','2014-09-02 15:13:59'),(142,'Inferno Pistol','2015-02-04 14:32:47','2015-02-04 14:32:47'),(143,'Hand Flamer','2015-02-04 14:35:00','2015-02-04 14:35:00'),(144,'The Crown Angelic','2015-02-04 14:52:34','2015-02-04 14:52:34'),(145,'The Veritas Vitae','2015-02-04 14:52:40','2015-02-04 14:52:40'),(146,'Valourâ€™s Edge','2015-02-04 14:52:46','2015-02-04 14:52:46'),(147,'Fury of Baal','2015-02-04 14:52:53','2015-02-04 14:52:53'),(148,'The Angelâ€™s Wing','2015-02-04 14:52:57','2015-02-04 14:52:57'),(149,'Sanguinary','2015-02-04 16:05:22','2015-02-04 16:05:22'),(150,'Gallianâ€™s Staff','2015-02-04 16:07:30','2015-02-04 16:07:30'),(151,'Blood Song','2015-02-06 13:27:58','2015-02-06 13:27:58'),(152,'Furioso force halberd','2015-02-06 13:43:35','2015-02-06 13:43:35'),(153,'Psychic Pilot (Mastery Level 2)','2015-02-06 13:44:35','2015-02-06 13:44:35'),(154,'Force sword','2015-02-06 13:54:57','2015-02-06 13:55:06'),(155,'Encarmine sword','2015-02-06 14:03:35','2015-02-06 14:03:35'),(156,'Death mask','2015-02-06 14:03:45','2015-02-06 14:03:45'),(157,'Blood chalice','2015-02-06 14:17:05','2015-02-06 14:17:05'),(158,'Narthecium','2015-02-06 14:18:35','2015-02-06 14:18:35'),(159,'Overcharged engines','2015-02-18 13:29:16','2015-02-18 13:29:16');
/*!40000 ALTER TABLE `wargears` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warlords`
--

DROP TABLE IF EXISTS `warlords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warlords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `armies_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_warlords_armies1_idx` (`armies_id`),
  CONSTRAINT `fk_warlords_armies1` FOREIGN KEY (`armies_id`) REFERENCES `armies` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warlords`
--

LOCK TABLES `warlords` WRITE;
/*!40000 ALTER TABLE `warlords` DISABLE KEYS */;
INSERT INTO `warlords` VALUES (1,'The Imperium\'s Sword',1,'2014-08-29 09:40:32','2014-08-29 09:40:32'),(2,'Storm of Fire',1,'2014-08-29 09:50:05','2014-08-29 09:50:05'),(3,'The Angel of Death',1,'2014-08-29 09:55:29','2014-08-29 09:55:29'),(4,'Champion of Humanity',1,'2014-08-29 10:02:39','2014-08-29 10:02:39'),(5,'Iron Resolve',1,'2014-08-29 10:11:27','2014-08-29 10:11:27'),(6,'Rites of War',1,'2014-08-29 10:18:32','2014-08-29 10:18:32'),(7,'Red Rampage',2,'2015-02-06 13:26:54','2015-02-06 13:26:54'),(8,'Soulwarden',2,'2015-02-06 13:49:04','2015-02-06 13:49:04'),(9,'Heroic Bearing',2,'2015-02-06 14:03:56','2015-02-06 14:03:56'),(10,'Speed of the Primarch',2,'2015-02-06 14:22:48','2015-02-06 14:22:48'),(11,'Descent of Angels',2,'2015-02-19 12:59:26','2015-02-19 12:59:26');
/*!40000 ALTER TABLE `warlords` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-02-19 13:13:29
