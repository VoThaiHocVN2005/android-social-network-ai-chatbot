-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: id18420043_sharepixel
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `chat_messages`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chat_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role` enum('user','model') NOT NULL,
  `message_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_chat_messages_user_id_id` (`user_id`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_messages`
--

LOCK TABLES `chat_messages` WRITE;
/*!40000 ALTER TABLE `chat_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `story_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `profile_image` text NOT NULL,
  `comment_text` text NOT NULL,
  `time` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (16,13,12,'john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','Beautiful ✨','Sat Mar 12 17:00:43 GMT+05:30 2022'),(17,21,11,'selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','cute ❤','Sat Mar 12 23:01:45 GMT+05:30 2022'),(18,21,11,'selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg',':) ','Sun Mar 13 10:48:40 GMT+05:30 2022'),(19,22,11,'selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','hi','Sun Mar 13 10:50:21 GMT+05:30 2022'),(20,22,11,'selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','cool','Sun Mar 13 16:16:02 GMT+05:30 2022'),(21,24,12,'john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','Carry on :) ','Sun Mar 13 16:18:39 GMT+05:30 2022'),(22,28,12,'john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','nice','Mon Mar 14 11:19:18 GMT+05:30 2022'),(23,29,11,'selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','beautiful✨✨✨','Mon Mar 14 12:29:08 GMT+05:30 2022'),(24,13,13,'suzan','https://sharepixel.000webhostapp.com/users_images/2022-04-16 12:02:30.908.jpg','nice :) ','Mon Mar 14 12:41:56 GMT+05:30 2022'),(25,35,12,'john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','cool','Fri Apr 01 16:08:55 GMT+05:30 2022'),(26,37,18,'albert_newton','https://sharepixel.000webhostapp.com/users_images/2022-04-03 18:19:48.275.jpg','awesome!','Sun Apr 03 18:20:22 GMT+05:30 2022'),(27,38,17,'issac_einstein','https://sharepixel.000webhostapp.com/users_images/2022-04-16 11:59:23.787.jpg','Jai Shree Ram!!','Sun Apr 03 18:21:36 GMT+05:30 2022'),(28,39,11,'selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','Enjoy ヾ(＾-＾)ノ','Mon Apr 04 08:23:18 GMT+05:30 2022'),(29,34,13,'suzan','https://sharepixel.000webhostapp.com/users_images/2022-04-16 12:02:30.908.jpg','nice','Mon Apr 11 18:47:40 GMT+05:30 2022'),(30,20,12,'john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','nice','Mon Apr 11 20:44:22 GMT+05:30 2022'),(31,40,12,'john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','Enjoy (〃＾▽＾〃)','Mon Apr 11 21:59:57 GMT+05:30 2022'),(32,40,11,'selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','Cooollll','Mon Apr 11 22:00:40 GMT+05:30 2022'),(33,42,12,'john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','Woahh','Sat Apr 16 12:04:43 GMT+05:30 2022'),(34,35,13,'suzan','https://sharepixel.000webhostapp.com/users_images/2022-04-16 12:02:30.908.jpg','great','Sat Apr 16 12:05:10 GMT+05:30 2022'),(35,44,11,'selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','not good pic','Sat Apr 16 20:23:56 GMT+05:30 2022'),(36,45,12,'john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','Beautiful✨','Sat Apr 16 23:52:27 GMT+05:30 2022'),(37,45,13,'suzan','https://sharepixel.000webhostapp.com/users_images/2022-04-16 12:02:30.908.jpg','wow *(^o^)/*','Sat Apr 16 23:53:41 GMT+05:30 2022'),(38,45,23,'charlie9','https://sharepixel.000webhostapp.com/users_images/2022-04-22 01:57:29.733.jpg','wow','Sun Apr 17 08:16:54 GMT+05:30 2022'),(39,45,25,'james','https://sharepixel.000webhostapp.com/users_images/2022-04-17 08:41:56.722.jpg','wowe','Sun Apr 17 08:35:23 GMT+05:30 2022');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `following`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `following` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `other_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `following`
--

LOCK TABLES `following` WRITE;
/*!40000 ALTER TABLE `following` DISABLE KEYS */;
INSERT INTO `following` VALUES (13,12,11),(14,11,12),(15,11,13),(17,13,11),(18,14,11),(19,15,14),(20,11,16),(21,18,17),(22,17,18),(23,12,18),(24,12,13),(25,19,12),(26,19,16),(27,19,15),(28,19,15),(29,19,11),(30,19,13),(31,19,15),(32,13,14),(33,20,11),(34,21,11),(35,22,11),(36,23,11),(37,23,13),(38,24,11),(39,25,11),(40,25,13);
/*!40000 ALTER TABLE `following` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_name` text NOT NULL,
  `image_url` text NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (23,'#flower #beauty #nature','https://sharepixel.000webhostapp.com/story_images/2022-03-12 16:59:17.375.jpg',11),(30,'#food','https://sharepixel.000webhostapp.com/story_images/2022-03-12 22:54:49.251.jpg',11),(31,'#cute #doggo','https://sharepixel.000webhostapp.com/story_images/2022-03-12 22:59:36.586.jpg',12),(32,'#work','https://sharepixel.000webhostapp.com/story_images/2022-03-12 23:47:53.062.jpg',12),(33,'My garden ','https://sharepixel.000webhostapp.com/story_images/2022-03-13 10:51:50.164.jpg',11),(34,'#working on major project','https://sharepixel.000webhostapp.com/story_images/2022-03-13 16:16:58.308.jpg',11),(35,'#muskmelon #texture','https://sharepixel.000webhostapp.com/story_images/2022-03-13 16:32:29.328.jpg',12),(36,'#how insta started','https://sharepixel.000webhostapp.com/story_images/2022-03-13 17:39:19.526.jpg',13),(38,'back to terna ','https://sharepixel.000webhostapp.com/story_images/2022-03-14 11:18:06.324.jpg',11),(39,'#scenery ','https://sharepixel.000webhostapp.com/story_images/2022-03-14 12:27:18.559.jpg',13),(40,'test ','https://sharepixel.000webhostapp.com/story_images/2022-03-14 12:32:09.519.jpg',12),(41,'#bts #army','https://sharepixel.000webhostapp.com/story_images/2022-03-14 12:48:21.078.jpg',14),(42,'prac','https://sharepixel.000webhostapp.com/story_images/2022-03-14 12:55:27.153.jpg',15),(43,'#nature','https://sharepixel.000webhostapp.com/story_images/2022-03-15 22:11:51.413.jpg',12),(44,'#pattern','https://sharepixel.000webhostapp.com/story_images/2022-03-24 19:41:53.846.jpg',11),(45,'back to college','https://sharepixel.000webhostapp.com/story_images/2022-03-31 11:37:10.301.jpg',11),(46,'Volleyball','https://sharepixel.000webhostapp.com/story_images/2022-03-31 12:33:13.915.jpg',12),(47,'sky ','https://sharepixel.000webhostapp.com/story_images/2022-04-03 18:09:57.773.jpg',17),(48,'Jai Shree Ram!','https://sharepixel.000webhostapp.com/story_images/2022-04-03 18:19:20.905.jpg',18),(49,'#fest ٩( ᐛ )و','https://sharepixel.000webhostapp.com/story_images/2022-04-04 08:19:04.924.jpg',13),(50,'#Fest','https://sharepixel.000webhostapp.com/story_images/2022-04-04 21:54:53.556.jpg',13),(51,'Quote','https://sharepixel.000webhostapp.com/story_images/2022-04-11 18:49:10.372.jpg',13),(52,'#Dhol ','https://sharepixel.000webhostapp.com/story_images/2022-04-11 22:03:54.793.jpg',13),(53,'#Cultural Fest','https://sharepixel.000webhostapp.com/story_images/2022-04-11 22:38:09.543.jpg',13),(54,'#cat','https://sharepixel.000webhostapp.com/story_images/2022-04-12 13:30:11.113.jpg',13),(55,'#painting ','https://sharepixel.000webhostapp.com/story_images/2022-04-16 21:16:44.616.jpg',11),(56,'#nature','https://sharepixel.000webhostapp.com/story_images/2022-04-17 08:39:11.99.jpg',25),(57,'#pic','https://sharepixel.000webhostapp.com/story_images/2022-04-17 08:40:15.523.jpg',25),(58,'#crush','https://sharepixel.000webhostapp.com/story_images/2022-04-17 18:16:16.113.jpg',12),(59,'xyZ','https://sharepixel.000webhostapp.com/story_images/2022-04-21 12:28:14.765.jpg',19),(60,'xyZ','https://sharepixel.000webhostapp.com/story_images/2022-04-21 12:28:14.765.jpg',19),(61,'coding','https://sharepixel.000webhostapp.com/story_images/2022-04-22 01:56:34.438.jpg',23);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `story_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_likes_user_story` (`user_id`,`story_id`),
  KEY `idx_likes_story_id` (`story_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (22,11,21),(23,11,22),(27,11,26),(40,11,39),(43,11,40),(57,11,42),(21,12,13),(24,12,23),(25,12,24),(26,12,28),(41,12,38),(44,12,40),(50,12,45),(30,13,13),(31,13,23),(32,13,28),(42,13,34),(51,13,45),(35,14,23),(34,14,24),(33,14,28),(36,15,31),(39,17,38),(38,18,37),(49,19,39),(48,19,40),(47,19,42),(46,19,43),(45,19,44),(52,20,45),(53,21,45),(54,23,45),(55,24,45),(56,25,45);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `story_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_reports_user_story` (`user_id`,`story_id`),
  KEY `idx_reports_story_id` (`story_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (18,11,41),(20,11,43),(21,11,44),(25,11,48),(2,12,13),(23,12,35),(19,12,41),(22,12,44),(24,25,44);
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stories`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `num_of_likes` int(11) NOT NULL DEFAULT 0,
  `image_url` text NOT NULL,
  `title` varchar(100) NOT NULL,
  `time` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `profile_image` text NOT NULL,
  `image_name` varchar(50) NOT NULL,
  `num_of_reports` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stories`
--

LOCK TABLES `stories` WRITE;
/*!40000 ALTER TABLE `stories` DISABLE KEYS */;
INSERT INTO `stories` VALUES (20,11,0,'https://sharepixel.000webhostapp.com/story_images/2022-03-12 22:54:49.251.jpg','#food','Sat Mar 12 22:54:49 GMT+05:30 2022','selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','2022-03-12 22:54:49.251',0),(21,12,1,'https://sharepixel.000webhostapp.com/story_images/2022-03-12 22:59:36.586.jpg','#cute #doggo','Sat Mar 12 22:59:36 GMT+05:30 2022','john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','2022-03-12 22:59:36.586',0),(22,12,1,'https://sharepixel.000webhostapp.com/story_images/2022-03-12 23:47:53.062.jpg','#work','Sat Mar 12 23:47:53 GMT+05:30 2022','john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','2022-03-12 23:47:53.062',0),(23,11,3,'https://sharepixel.000webhostapp.com/story_images/2022-03-13 10:51:50.164.jpg','My garden ','Sun Mar 13 10:51:50 GMT+05:30 2022','selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','2022-03-13 10:51:50.164',0),(24,11,2,'https://sharepixel.000webhostapp.com/story_images/2022-03-13 16:16:58.308.jpg','#working on major project','Sun Mar 13 16:16:58 GMT+05:30 2022','selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','2022-03-13 16:16:58.308',0),(25,12,0,'https://sharepixel.000webhostapp.com/story_images/2022-03-13 16:32:29.328.jpg','#muskmelon #texture','Sun Mar 13 16:32:29 GMT+05:30 2022','john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','2022-03-13 16:32:29.328',0),(26,13,1,'https://sharepixel.000webhostapp.com/story_images/2022-03-13 17:39:19.526.jpg','#how insta started','Sun Mar 13 17:39:19 GMT+05:30 2022','suzan','https://sharepixel.000webhostapp.com/users_images/2022-04-16 12:02:30.908.jpg','2022-03-13 17:39:19.526',0),(28,11,3,'https://sharepixel.000webhostapp.com/story_images/2022-03-14 11:18:06.324.jpg','back to terna ','Mon Mar 14 11:18:06 GMT+05:30 2022','selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','2022-03-14 11:18:06.324',0),(29,13,0,'https://sharepixel.000webhostapp.com/story_images/2022-03-14 12:27:18.559.jpg','#scenery ','Mon Mar 14 12:27:18 GMT+05:30 2022','suzan','https://sharepixel.000webhostapp.com/users_images/2022-04-16 12:02:30.908.jpg','2022-03-14 12:27:18.559',0),(30,12,0,'https://sharepixel.000webhostapp.com/story_images/2022-03-14 12:32:09.519.jpg','test ','Mon Mar 14 12:32:09 GMT+05:30 2022','john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','2022-03-14 12:32:09.519',0),(31,14,1,'https://sharepixel.000webhostapp.com/story_images/2022-03-14 12:48:21.078.jpg','#bts #army','Mon Mar 14 12:48:21 GMT+05:30 2022','annnuu136','http://mifo.000webhostapp.com/users_images/default_image.jpg','2022-03-14 12:48:21.078',0),(32,15,0,'https://sharepixel.000webhostapp.com/story_images/2022-03-14 12:55:27.153.jpg','prac','Mon Mar 14 12:55:27 GMT+05:30 2022','priya123','http://mifo.000webhostapp.com/users_images/default_image.jpg','2022-03-14 12:55:27.153',0),(33,12,0,'https://sharepixel.000webhostapp.com/story_images/2022-03-15 22:11:51.413.jpg','#nature','Tue Mar 15 22:11:51 GMT+05:30 2022','john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','2022-03-15 22:11:51.413',0),(34,11,1,'https://sharepixel.000webhostapp.com/story_images/2022-03-24 19:41:53.846.jpg','#pattern','Thu Mar 24 19:41:53 GMT+05:30 2022','selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','2022-03-24 19:41:53.846',0),(35,11,0,'https://sharepixel.000webhostapp.com/story_images/2022-03-31 11:37:10.301.jpg','back to college','Thu Mar 31 11:37:10 GMT+05:30 2022','selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','2022-03-31 11:37:10.301',1),(36,12,0,'https://sharepixel.000webhostapp.com/story_images/2022-03-31 12:33:13.915.jpg','Volleyball','Thu Mar 31 12:33:13 GMT+05:30 2022','john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','2022-03-31 12:33:13.915',0),(37,17,1,'https://sharepixel.000webhostapp.com/story_images/2022-04-03 18:09:57.773.jpg','sky ','Sun Apr 03 18:09:57 GMT+05:30 2022','issac_einstein','https://sharepixel.000webhostapp.com/users_images/2022-04-16 11:59:23.787.jpg','2022-04-03 18:09:57.773',0),(38,18,2,'https://sharepixel.000webhostapp.com/story_images/2022-04-03 18:19:20.905.jpg','Jai Shree Ram!','Sun Apr 03 18:19:20 GMT+05:30 2022','albert_newton','http://mifo.000webhostapp.com/users_images/default_image.jpg','2022-04-03 18:19:20.905',0),(39,13,2,'https://sharepixel.000webhostapp.com/story_images/2022-04-04 08:19:04.924.jpg','#fest ٩( ᐛ )و','Mon Apr 04 08:19:04 GMT+05:30 2022','suzan','https://sharepixel.000webhostapp.com/users_images/2022-04-16 12:02:30.908.jpg','2022-04-04 08:19:04.924',0),(40,13,3,'https://sharepixel.000webhostapp.com/story_images/2022-04-04 21:54:53.556.jpg','#Fest','Mon Apr 04 21:54:53 GMT+05:30 2022','suzan','https://sharepixel.000webhostapp.com/users_images/2022-04-16 12:02:30.908.jpg','2022-04-04 21:54:53.556',0),(42,13,2,'https://sharepixel.000webhostapp.com/story_images/2022-04-11 22:03:54.793.jpg','#Dhol ','Mon Apr 11 22:03:54 GMT+05:30 2022','suzan','https://sharepixel.000webhostapp.com/users_images/2022-04-16 12:02:30.908.jpg','2022-04-11 22:03:54.793',0),(45,11,7,'https://sharepixel.000webhostapp.com/story_images/2022-04-16 21:16:44.616.jpg','#painting ','Sat Apr 16 21:16:44 GMT+05:30 2022','selena_doe','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg','2022-04-16 21:16:44.616',0),(46,25,0,'https://sharepixel.000webhostapp.com/story_images/2022-04-17 08:39:11.99.jpg','#nature','Sun Apr 17 08:39:11 GMT+05:30 2022','james','https://sharepixel.000webhostapp.com/users_images/2022-04-17 08:41:56.722.jpg','2022-04-17 08:39:11.99',0),(47,25,0,'https://sharepixel.000webhostapp.com/story_images/2022-04-17 08:40:15.523.jpg','#pic','Sun Apr 17 08:40:15 GMT+05:30 2022','james','https://sharepixel.000webhostapp.com/users_images/2022-04-17 08:41:56.722.jpg','2022-04-17 08:40:15.523',0),(48,12,0,'https://sharepixel.000webhostapp.com/story_images/2022-04-17 18:16:16.113.jpg','#crush','Sun Apr 17 18:16:16 GMT+05:30 2022','john_wilson','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg','2022-04-17 18:16:16.113',1),(49,19,0,'https://sharepixel.000webhostapp.com/story_images/2022-04-21 12:28:14.765.jpg','xyZ','Thu Apr 21 12:28:14 GMT+05:30 2022','vaishnavimanchanda','https://sharepixel.000webhostapp.com/users_images/2022-04-21 13:15:53.021.jpg','2022-04-21 12:28:14.765',0),(50,19,0,'https://sharepixel.000webhostapp.com/story_images/2022-04-21 12:28:14.765.jpg','xyZ','Thu Apr 21 12:28:14 GMT+05:30 2022','vaishnavimanchanda','https://sharepixel.000webhostapp.com/users_images/2022-04-21 13:15:53.021.jpg','2022-04-21 12:28:14.765',0),(51,23,0,'https://sharepixel.000webhostapp.com/story_images/2022-04-22 01:56:34.438.jpg','coding','Fri Apr 22 01:56:34 GMT+05:30 2022','charlie9','https://sharepixel.000webhostapp.com/users_images/2022-04-22 01:57:29.733.jpg','2022-04-22 01:56:34.438',0);
/*!40000 ALTER TABLE `stories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `image` text NOT NULL,
  `followers` int(11) NOT NULL,
  `following` int(11) NOT NULL,
  `posts` int(11) NOT NULL,
  `api_token_hash` char(64) DEFAULT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `api_token_expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (11,'selena_doe','$2y$10$jpl9z7XaPpFGL76BRdwgTesBClaFtuNkiphQKTTwZoREXX34LgHO2','selenadoe345@gmail.com','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:53:21.016.jpg',10,3,0,NULL,0,NULL),(12,'john_wilson','$2y$10$Yso7jaHgAAjyhGJyQbhFMOoAUZwGGKNLVppcOX2JU8P0Y9mai8LYW','johnwilson@gmail.com','https://sharepixel.000webhostapp.com/users_images/2022-03-12 16:56:05.802.jpg',2,3,0,NULL,0,NULL),(13,'suzan','$2y$10$ZFzWopAkMNMp5tNyXcntj.DUXggekPJSuuNucGHV9CP4wt6sJwy1K','suzan@gmail.com','https://sharepixel.000webhostapp.com/users_images/2022-04-16 12:02:30.908.jpg',5,2,0,NULL,0,NULL),(14,'annnuu136','$2y$10$EYU0p2R8P7zy6ePcOhAuUuAF82XfFDfHu6e1rMKpK.lv.HC71Dg4C','anuuuu1306@gmail.com','https://sharepixel.000webhostapp.com/users_images/2022-03-14 12:49:46.75.jpg',2,1,0,NULL,0,NULL),(15,'priya123','$2y$10$cWJ5/oCepRotmLCHGFPwJ.rtjCveFKRxYWghKcVCnHfMHWgPvxn0W','priya@gmail.com','http://mifo.000webhostapp.com/users_images/default_image.jpg',3,1,0,NULL,0,NULL),(16,'jenny333','$2y$10$DL5T/cuisUvd8KR2VV99z.TQGWXwpFnzFO5CzFZaEVocYYIlNbdT.','jenny333@gmail.com','http://mifo.000webhostapp.com/users_images/default_image.jpg',2,0,0,NULL,0,NULL),(17,'issac_einstein','$2y$10$nr41kiY00TW6dfCIcq1ps.W3NfR0Cd7P5OkQZQoFzfTgr8OFeWrce','issac@einstein.com','https://sharepixel.000webhostapp.com/users_images/2022-04-16 11:59:23.787.jpg',1,1,0,NULL,0,NULL),(18,'albert_newton','$2y$10$oL2MmoIHsoQqu4kcmEMOou5tK.Mhh7lyvErqYz8yymv3UK6XfzgN6','albert@newton.com','https://sharepixel.000webhostapp.com/users_images/2022-04-03 18:19:48.275.jpg',2,1,0,NULL,0,NULL),(19,'vaishnavimanchanda','$2y$10$TWFnR2qn/6qJQTLPTiwN.O3AuXgwJTsYyfSjrpcCnUVLx3zesicLK','vaishnavi.manchanda.vm@gmail.com','https://sharepixel.000webhostapp.com/users_images/2022-04-21 13:15:53.021.jpg',0,7,0,NULL,0,NULL),(20,'charles','$2y$10$ELjrED8Xyr2nLh7u5SVhMOVTwkQAeNtZC3ZpxNC2HoPSGLWpQKVzy','charles@gmail.com','http://mifo.000webhostapp.com/users_images/default_image.jpg',0,1,0,NULL,0,NULL),(21,'charlie','$2y$10$qWM.yLmhn6HxlT2HWAvvU.NP8Y0Qk1Mnc6Tgcr1r.yXlYyS4vCteu','charlie@gmail.com','http://mifo.000webhostapp.com/users_images/default_image.jpg',0,1,0,NULL,0,NULL),(22,'charlie123','$2y$10$coWX.f.8m6UaNTELiyW0TuEDUW/GBihVUeXmWMRh4BWR2p1J3h2Jq','charlie133@gmail.com','http://mifo.000webhostapp.com/users_images/default_image.jpg',0,1,0,NULL,0,NULL),(23,'charlie9','$2y$10$QNlIFL/6tJy.G8MeobIi4OnZidEzpoqSC/D09Dff.BxowDQI4vEza','charlie9@gmail.com','https://sharepixel.000webhostapp.com/users_images/2022-04-22 01:57:29.733.jpg',0,2,0,NULL,0,NULL),(24,'charlie5','$2y$10$cT4KVkQCLOdC3JXxgyN20OK3hMLEA9jA79.rCc83z7jf6UGQOZ3y.','charlie_dem@gmail.com','http://mifo.000webhostapp.com/users_images/default_image.jpg',0,1,0,NULL,0,NULL),(25,'james','$2y$10$PHRg2Id1oSlMImSEIB1WeehqNkos.EcbQlNO8i.N4mVG3P/ihhXRu','char@gmail.com','https://sharepixel.000webhostapp.com/users_images/2022-04-17 08:41:56.722.jpg',0,2,0,NULL,0,NULL),(26,'james6','$2y$10$XhGUXo07RR3.dnjiIVFCLOMhCk7PpPRvWK3fO/ThfvmIYr52r6F7C','james6@gmail.com','http://mifo.000webhostapp.com/users_images/default_image.jpg',0,0,0,NULL,0,NULL),(27,'james7','$2y$10$IiziI3jNcuOdPi4eoRJUDO.VxHSzlT39cCbiMH0S6n1F1iBWeR0au','james7@gmail.com','http://mifo.000webhostapp.com/users_images/default_image.jpg',0,0,0,NULL,0,NULL),(28,'p.r','$2y$10$nb1CgHBNtcliilODIXC0eO2NVfrpu865yKiuVQl.YBh.LobMmTs62','p@gmail.com','http://mifo.000webhostapp.com/users_images/default_image.jpg',0,0,0,NULL,0,NULL),(29,'PO','$2y$10$9ABHwI72mFNjGhFGFqTtoexlfSDLmjSDt2A1VCYeJWWarCJencGwS','pggg@gmail.com','http://mifo.000webhostapp.com/users_images/default_image.jpg',0,0,0,NULL,0,NULL),(39,'admin','$2y$10$slgvAOWukwrl.FmwtClSWuzbcCK/j0qq/1WuHBLB7Ihssk5Qr86YK','admin@gmail.com','http://10.0.2.2/SharePixel/users_images/default_user.png',0,0,0,NULL,1,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'id18420043_sharepixel'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-14  1:13:54

-- Consolidated migrations: safe to re-run on this MariaDB database.
ALTER TABLE `users`
  MODIFY `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  ADD COLUMN IF NOT EXISTS `api_token_hash` char(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS `is_admin` tinyint(1) NOT NULL DEFAULT 0;

ALTER TABLE `users`
  ADD COLUMN IF NOT EXISTS `api_token_expires_at` datetime DEFAULT NULL;

DELETE duplicate_like FROM `likes` AS duplicate_like
INNER JOIN `likes` AS retained_like
  ON duplicate_like.`user_id` = retained_like.`user_id`
  AND duplicate_like.`story_id` = retained_like.`story_id`
  AND duplicate_like.`id` > retained_like.`id`;

ALTER TABLE `likes`
  ADD UNIQUE KEY IF NOT EXISTS `uq_likes_user_story` (`user_id`, `story_id`),
  ADD KEY IF NOT EXISTS `idx_likes_story_id` (`story_id`);

DELETE duplicate_report FROM `reports` AS duplicate_report
INNER JOIN `reports` AS retained_report
  ON duplicate_report.`user_id` = retained_report.`user_id`
  AND duplicate_report.`story_id` = retained_report.`story_id`
  AND duplicate_report.`id` > retained_report.`id`;

ALTER TABLE `reports`
  ADD UNIQUE KEY IF NOT EXISTS `uq_reports_user_story` (`user_id`, `story_id`),
  ADD KEY IF NOT EXISTS `idx_reports_story_id` (`story_id`);

UPDATE `stories` AS story
SET story.`num_of_likes` = (
  SELECT COUNT(*) FROM `likes` WHERE `story_id` = story.`id`
);

UPDATE `stories` AS story
SET story.`num_of_reports` = (
  SELECT COUNT(*) FROM `reports` WHERE `story_id` = story.`id`
);

CREATE TABLE IF NOT EXISTS `chat_messages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role` enum('user','model') NOT NULL,
  `message_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_chat_messages_user_id_id` (`user_id`, `id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
