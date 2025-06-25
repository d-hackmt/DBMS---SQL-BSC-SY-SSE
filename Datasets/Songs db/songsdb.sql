-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: songsdb
-- ------------------------------------------------------
-- Server version	8.0.31

CREATE DATABASE IF NOT EXISTS songsdb;
USE songsdb;


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
-- Table structure for table `artists`
--

DROP TABLE IF EXISTS `artists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artists` (
  `artist_id` int unsigned NOT NULL,
  `name` varchar(45) NOT NULL,
  `birth_year` year DEFAULT NULL,
  PRIMARY KEY (`artist_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artists`
--

LOCK TABLES `artists` WRITE;
/*!40000 ALTER TABLE `artists` DISABLE KEYS */;
INSERT INTO `artists` VALUES (1,'The Weeknd',1975),(2,'Ed Sheeran',1967),(3,'Dua Lipa',1978),(4,'Imagine Dragons',1966),(5,'Bruno Mars',1986),(6,'Adele',1997),(7,'Taylor Swift',1991),(8,'Justin Bieber',1983),(9,'Sia',1977),(10,'The Kid LAROI',1986),(11,'Alan Walker',1990),(12,'Maroon 5',1971),(13,'Clean Bandit',1971),(14,'Shawn Mendes',1977),(15,'Arijit Singh',1998),(16,'Jubin Nautiyal',1970),(17,'Ranveer Singh',1967),(18,'Ankit Tiwari',1993),(19,'Sachet Tandon',1998),(20,'Dhvani Bhanushali',1967),(21,'Ali Sethi',1992),(22,'Vishal Mishra',1998),(23,'Atif Aslam',1970),(24,'Akhil Sachdeva',1976),(25,'B Praak',1992),(26,'Jasleen Royal',1994),(27,'AP Dhillon',1971),(28,'Sidhu Moosewala',1998),(29,'Guru Randhawa',1969),(30,'Diljit Dosanjh',1965),(31,'Jasmine Sandlas',1985),(32,'Badshah',1978),(33,'Honey Singh',1975),(34,'Drake',1998),(35,'Future',1979);
/*!40000 ALTER TABLE `artists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `financials`
--

DROP TABLE IF EXISTS `financials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `financials` (
  `song_id` int unsigned NOT NULL,
  `budget` decimal(10,3) DEFAULT NULL,
  `revenue` decimal(10,3) DEFAULT NULL,
  `unit` enum('Units','Thousands','Millions','Billions') DEFAULT NULL,
  `currency` char(3) DEFAULT NULL,
  PRIMARY KEY (`song_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `financials`
--

LOCK TABLES `financials` WRITE;
/*!40000 ALTER TABLE `financials` DISABLE KEYS */;
INSERT INTO `financials` VALUES (1,3.860,72.800,'Thousands','USD'),(2,3.860,23.120,'Thousands','USD'),(3,4.130,60.620,'Thousands','INR'),(4,4.450,20.630,'Millions','INR'),(5,2.610,80.270,'Millions','USD'),(6,3.690,44.160,'Millions','INR'),(7,1.960,52.360,'Millions','USD'),(8,2.640,84.820,'Millions','INR'),(9,3.370,26.770,'Thousands','INR'),(10,3.950,91.200,'Millions','INR'),(11,2.290,58.100,'Thousands','INR'),(12,0.580,60.130,'Millions','INR'),(13,2.590,58.740,'Thousands','INR'),(14,0.520,75.860,'Millions','INR'),(15,3.030,59.950,'Millions','USD'),(16,1.020,92.220,'Thousands','INR'),(17,2.270,11.460,'Millions','USD'),(18,2.430,48.670,'Thousands','USD'),(19,3.840,67.530,'Millions','USD'),(20,4.800,69.080,'Millions','USD'),(21,3.010,10.390,'Millions','USD'),(22,3.770,62.250,'Millions','USD'),(23,2.010,32.310,'Millions','INR'),(24,3.520,55.630,'Millions','INR'),(25,2.690,44.850,'Thousands','USD'),(26,1.310,22.070,'Thousands','INR'),(27,1.770,65.330,'Millions','USD'),(28,3.880,14.930,'Millions','USD'),(29,0.660,44.550,'Thousands','INR'),(30,3.820,17.000,'Thousands','INR'),(31,3.360,61.450,'Millions','USD'),(32,4.250,18.640,'Millions','USD'),(33,2.220,37.170,'Thousands','USD'),(34,1.870,15.800,'Millions','INR'),(35,1.620,32.760,'Thousands','USD'),(36,2.440,94.390,'Thousands','USD'),(37,1.910,94.600,'Millions','USD'),(38,1.160,49.050,'Thousands','INR'),(39,3.980,30.040,'Thousands','USD'),(40,2.350,25.620,'Thousands','INR'),(41,1.300,76.280,'Millions','USD'),(42,1.300,64.310,'Millions','INR'),(43,2.560,47.470,'Millions','INR'),(44,4.500,15.560,'Thousands','INR'),(45,1.330,13.110,'Millions','USD'),(46,3.820,68.390,'Thousands','USD'),(47,1.140,48.590,'Millions','USD'),(48,1.740,58.750,'Millions','USD'),(49,4.420,45.510,'Thousands','INR'),(50,3.380,32.200,'Thousands','INR'),(51,3.460,51.440,'Thousands','INR'),(52,2.340,36.530,'Thousands','USD'),(53,3.440,53.290,'Millions','INR'),(54,2.480,51.260,'Millions','INR'),(55,3.880,60.010,'Millions','INR'),(56,3.300,98.860,'Millions','INR'),(57,2.940,43.510,'Millions','USD'),(58,3.700,63.950,'Thousands','INR'),(59,0.930,38.890,'Thousands','USD'),(60,3.850,55.910,'Thousands','USD'),(62,2.390,84.880,'Thousands','USD'),(63,0.770,93.410,'Millions','USD'),(64,0.660,58.290,'Thousands','INR'),(65,3.480,58.420,'Thousands','USD'),(66,4.660,79.160,'Millions','INR'),(67,1.570,70.080,'Millions','INR'),(68,0.620,42.910,'Millions','USD'),(69,1.300,57.480,'Millions','INR'),(70,3.710,17.390,'Millions','INR'),(71,3.190,35.750,'Millions','INR'),(72,2.550,66.600,'Millions','INR'),(73,2.260,18.320,'Millions','USD'),(74,2.610,96.220,'Millions','INR'),(75,0.730,87.090,'Thousands','USD'),(76,4.910,94.180,'Thousands','INR'),(77,4.330,63.910,'Thousands','USD'),(78,1.110,63.230,'Millions','INR'),(79,2.780,79.550,'Thousands','USD'),(80,1.010,64.230,'Thousands','INR'),(84,0.570,91.140,'Millions','INR'),(86,4.780,65.320,'Thousands','INR'),(92,2.790,87.200,'Millions','INR');
/*!40000 ALTER TABLE `financials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `languages` (
  `language_id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`language_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `languages`
--

LOCK TABLES `languages` WRITE;
/*!40000 ALTER TABLE `languages` DISABLE KEYS */;
INSERT INTO `languages` VALUES (1,'English'),(2,'Hindi'),(3,'Punjabi');
/*!40000 ALTER TABLE `languages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `song_artist`
--

DROP TABLE IF EXISTS `song_artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `song_artist` (
  `song_id` int unsigned NOT NULL,
  `artist_id` int unsigned NOT NULL,
  PRIMARY KEY (`song_id`,`artist_id`),
  KEY `fk_song_artist_songs1_idx` (`song_id`),
  KEY `fk_song_artist_artists1_idx` (`artist_id`),
  CONSTRAINT `fk_song_artist_artists1` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_song_artist_songs1` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `song_artist`
--

LOCK TABLES `song_artist` WRITE;
/*!40000 ALTER TABLE `song_artist` DISABLE KEYS */;
INSERT INTO `song_artist` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,1),(11,2),(12,8),(13,10),(14,11),(15,11),(16,12),(17,12),(18,13),(19,2),(20,14),(21,15),(22,16),(23,15),(24,15),(25,15),(26,17),(27,18),(28,19),(29,20),(30,21),(31,15),(32,22),(33,15),(34,23),(35,24),(36,25),(37,26),(38,25),(39,15),(40,15),(41,27),(42,27),(43,28),(44,28),(45,29),(46,30),(47,29),(48,29),(49,31),(50,32),(51,33),(52,33),(53,33),(54,33),(55,33),(56,33),(57,33),(58,33),(59,33),(60,34),(61,34),(62,34),(63,34),(64,34),(65,35),(66,35),(67,35),(68,35),(69,35),(70,7),(71,7),(72,7),(73,7),(74,7),(75,15),(76,15),(77,15),(78,15),(79,1),(80,1),(81,1),(82,1);
/*!40000 ALTER TABLE `song_artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `songs`
--

DROP TABLE IF EXISTS `songs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `songs` (
  `song_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  `genre` varchar(45) DEFAULT NULL,
  `release_year` year DEFAULT NULL,
  `spotify_rating` decimal(3,1) DEFAULT NULL,
  `album` varchar(45) DEFAULT NULL,
  `language_id` tinyint unsigned NOT NULL,
  PRIMARY KEY (`song_id`),
  KEY `fk_songs_languages_idx` (`language_id`),
  CONSTRAINT `fk_songs_languages` FOREIGN KEY (`language_id`) REFERENCES `languages` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `songs`
--

LOCK TABLES `songs` WRITE;
/*!40000 ALTER TABLE `songs` DISABLE KEYS */;
INSERT INTO `songs` VALUES (1,'Blinding Lights','Pop',2009,9.6,'After Hours',1),(2,'Shape of You','Pop',2020,9.0,'Divide',1),(3,'Levitating','Pop',2016,9.3,'Future Nostalgia',1),(4,'Believer','Rock',2011,7.4,'Evolve',1),(5,'Uptown Funk','Funk',2012,7.3,'Evolve',1),(6,'Rolling in the Deep','Soul',2018,8.5,'21',1),(7,'Love Story','Country',2018,8.4,'Fearless',1),(8,'Peaches','R&B',2014,7.6,'Justice',1),(9,'Cheap Thrills','Pop',2005,7.0,'This Is Acting',1),(10,'Starboy','R&B',2020,9.5,'Starboy',1),(11,'Photograph','Pop',2008,8.8,'',1),(12,'Let Me Love You','Pop',2012,7.3,'Encore',1),(13,'Stay','Pop',2018,8.3,'Stay',1),(14,'Faded','EDM',2020,7.9,'Different World',1),(15,'On My Way','EDM',2017,9.8,'Single',1),(16,'Sugar','Pop',2018,7.4,'Sugar',1),(17,'Girls Like You','Pop',2017,7.7,'Red Pill Blues',1),(18,'Rockabye','Pop',2005,9.0,'Rockabye',1),(19,'Perfect','Pop',2018,9.7,'Divide',1),(20,'Senorita','Pop',2010,8.4,'Romance',1),(21,'Tum Hi Ho','Romantic',2014,7.5,'Aashiqui 2',2),(22,'Raataan Lambiyan','Romantic',2005,8.1,'Shershaah',2),(23,'Kesariya','Romantic',2007,9.7,'Brahmastra',2),(24,'Channa Mereya','Romantic',2008,9.1,'Ae Dil Hai Mushkil',2),(25,'Tujhe Kitna Chahne Lage','Romantic',2015,8.0,'Kabir Singh',2),(26,'Apna Time Aayega','Rap',2019,7.1,'Gully Boy',2),(27,'Galliyan','Romantic',2014,8.9,'Ek Villain',2),(28,'Bekhayali','Romantic',2017,9.3,'Kabir Singh',2),(29,'Vaaste','Pop',2018,9.1,'Vaaste',2),(30,'Pasoori','Fusion',2009,7.7,'Coke Studio',2),(31,'Pachtaoge','Romantic',2011,8.4,'Jaani Ve',2),(32,'Kaise Hua','Romantic',2013,8.1,'Kabir Singh',2),(33,'Shayad','Romantic',2018,9.8,'Love Aaj Kal',2),(34,'Dil Diyan Gallan','Romantic',2023,7.3,'Tiger Zinda Hai',2),(35,'Tera Ban Jaunga','Romantic',2012,8.4,'Kabir Singh',2),(36,'Ranjha','Romantic',2006,8.6,'Shershaah',2),(37,'Heeriye','Romantic',2008,7.2,'Heeriye',2),(38,'Mann Bharrya 2.0','Romantic',2013,8.4,'Shershaah',2),(39,'Zaalima','Romantic',2023,8.9,'Raees',2),(40,'Muskurane','Romantic',2007,8.1,'Citylights',2),(41,'Brown Munde','Punjabi Pop',2006,8.7,'Not By Chance',3),(42,'Excuses','Punjabi Pop',2014,7.7,'Excuses',3),(43,'Same Beef','Rap',2022,9.0,'Moosetape',3),(44,'So High','Rap',2012,9.7,'So High',3),(45,'Lahore','Punjabi Pop',2012,7.5,'Lahore',3),(46,'Do You Know','Romantic',2009,8.6,'Do You Know',3),(47,'Suit Suit','Punjabi Pop',2013,8.6,'Hindi Medium',3),(48,'High Rated Gabru','Punjabi Pop',2015,8.7,'Nawabzaade',3),(49,'Illegal Weapon','Punjabi Pop',2023,7.8,'Street Dancer 3D',3),(50,'She Move It Like','Hip-Hop',2013,8.1,'One',3),(51,'Brown Rang','Hip-Hop',2016,7.2,'',3),(52,'Dope Shope','Hip-Hop',2016,7.8,'International Villager',3),(53,'Angreji Beat','Hip-Hop',2016,8.8,'International Villager',3),(54,'Gabru','Hip-Hop',2016,7.5,'International Villager',3),(55,'High Heels','Hip-Hop',2016,9.2,'International Villager',3),(56,'Love Dose','Hip-Hop',2018,7.8,'Desi Kalakaar',2),(57,'Desi Kalakaar','Hip-Hop',2018,7.2,'Desi Kalakaar',2),(58,'Stardom','Hip-Hop',2018,8.0,'Desi Kalakaar',2),(59,'One Thousand Miles','Hip-Hop',2018,8.2,'Desi Kalakaar',2),(60,'Passionfruit','Hip-Hop',2019,8.8,'More Life',1),(61,'Portland','Hip-Hop',2019,6.9,'More Life',1),(62,'Fake Love','Hip-Hop',2019,7.6,'More Life',1),(63,'Free Smoke','Hip-Hop',2019,8.4,'More Life',1),(64,'Teenage Fever','Hip-Hop',2019,7.6,'More Life',1),(65,'Superhero','Trap',2025,7.4,'HEROES & VILLAINS',1),(66,'Too Many Nights','Trap',2025,8.7,'HEROES & VILLAINS',1),(67,'Metro Spider','Trap',2025,7.8,'HEROES & VILLAINS',1),(68,'Trance','Trap',2025,9.7,'HEROES & VILLAINS',1),(69,'Umbrella','Trap',2025,8.7,'HEROES & VILLAINS',1),(70,'Style','Pop',2023,7.9,'1989',1),(71,'Blank Space','Pop',2013,9.1,'1989',1),(72,'Shake It Off','Pop',2017,9.0,'1989',1),(73,'Out of the Woods','Pop',2015,8.9,'1989',1),(74,'Bad Blood','Pop',2015,9.5,'1989',1),(75,'Chahun Main Ya Naa','Romantic',2011,9.0,'Aashiqui 2',2),(76,'Bhula Dena','Romantic',2011,8.3,'Aashiqui 2',2),(77,'Hum Mar Jayenge','Romantic',2011,8.7,'Aashiqui 2',2),(78,'Milne Hai Mujhse Aayi','Romantic',2011,8.3,'Aashiqui 2',2),(79,'Save Your Tears','Pop',2019,9.3,'After Hours',1),(80,'In Your Eyes','Pop',2019,7.5,'After Hours',1),(81,'Faith','Pop',2019,7.5,'After Hours',1),(82,'Alone Again','Pop',2019,8.5,'After Hours',1);
/*!40000 ALTER TABLE `songs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-25 21:17:30
