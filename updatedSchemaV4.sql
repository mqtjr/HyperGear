CREATE DATABASE  IF NOT EXISTS `ca2_submission` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ca2_submission`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: ca2_submission
-- ------------------------------------------------------
-- Server version	8.4.5

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `product_variant_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `product_variant_id` (`product_variant_id`),
  CONSTRAINT `cart_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  CONSTRAINT `cart_ibfk_2` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` text,
  `is_active` tinyint(1) DEFAULT '1',
  `parent_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_parent_category` (`parent_id`),
  CONSTRAINT `fk_parent_category` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Shoes','Feet Apparel for both men and women',1,NULL),(2,'Equipment','Sports equipment and gear',1,NULL),(3,'Accessories','Fitness accessories and gear',1,NULL),(4,'Men','Men\'s athletic wear',1,NULL),(5,'Women','Women\'s athletic wear',1,NULL),(6,'Kids','Children\'s athletic wear',1,NULL),(7,'Brands','Shop by brand',1,NULL),(8,'Balls','Sports balls',1,2),(9,'Bats','Baseball and cricket bats',1,2),(10,'Gloves','Sports gloves',1,2),(11,'Shirts','Men\'s athletic shirts',1,4),(12,'Shorts','Men\'s athletic shorts',1,4),(13,'Men Shoes','Men\'s athletic shoes',1,4),(14,'Tops','Women\'s athletic tops',1,5),(15,'Leggings','Women\'s leggings',1,5),(16,'Women Shoes','Women\'s athletic shoes',1,5),(17,'Boys','Boys athletic wear',1,6),(18,'Girls','Girls athletic wear',1,6),(19,'Nike','Nike products',1,7),(20,'Adidas','Adidas products',1,7),(21,'Puma','Puma products',1,7),(22,'Running Shoes','Athletic running shoes',1,1),(23,'Casual Shoes','Everyday casual shoes',1,1),(24,'Sports Shoes','Sport-specific shoes',1,1),(25,'Bags','Sports bags and backpacks',1,3),(26,'Headwear','Caps and headbands',1,3),(27,'Socks','Athletic socks',1,3);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discounts`
--

DROP TABLE IF EXISTS `discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` enum('percentage','fixed_amount','free_shipping') NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `min_amount` decimal(10,2) DEFAULT '0.00',
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts`
--

LOCK TABLES `discounts` WRITE;
/*!40000 ALTER TABLE `discounts` DISABLE KEYS */;
INSERT INTO `discounts` VALUES (1,'WELCOME10','Welcome Discount','percentage',10.00,50.00,NULL,NULL,1),(2,'FREESHIP','Free Shipping','free_shipping',0.00,75.00,NULL,NULL,1),(3,'SAVE20','Save $20','fixed_amount',20.00,100.00,NULL,NULL,1);
/*!40000 ALTER TABLE `discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int DEFAULT NULL,
  `product_variant_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_variant_id` (`product_variant_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_variant_id`) REFERENCES `product_variants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `order_number` varchar(50) NOT NULL,
  `status` enum('pending','processing','shipped','delivered','cancelled') DEFAULT 'pending',
  `subtotal` decimal(10,2) NOT NULL,
  `discount_amount` decimal(10,2) DEFAULT '0.00',
  `total_amount` decimal(10,2) NOT NULL,
  `shipping_address` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_number` (`order_number`),
  KEY `userId` (`userId`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_discounts`
--

DROP TABLE IF EXISTS `product_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_discounts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idProducts` int DEFAULT NULL,
  `discount_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idProducts` (`idProducts`),
  KEY `discount_id` (`discount_id`),
  CONSTRAINT `product_discounts_ibfk_1` FOREIGN KEY (`idProducts`) REFERENCES `products` (`idProducts`),
  CONSTRAINT `product_discounts_ibfk_2` FOREIGN KEY (`discount_id`) REFERENCES `discounts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_discounts`
--

LOCK TABLES `product_discounts` WRITE;
/*!40000 ALTER TABLE `product_discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_variants`
--

DROP TABLE IF EXISTS `product_variants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_variants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idProducts` int DEFAULT NULL,
  `size` varchar(10) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `quantity` int DEFAULT '0',
  `price_adjustment` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `idProducts` (`idProducts`),
  CONSTRAINT `product_variants_ibfk_1` FOREIGN KEY (`idProducts`) REFERENCES `products` (`idProducts`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_variants`
--

LOCK TABLES `product_variants` WRITE;
/*!40000 ALTER TABLE `product_variants` DISABLE KEYS */;
INSERT INTO `product_variants` VALUES (1,1,'US 7','Red',2,0.00),(2,1,'US 8','Red',3,0.00),(3,1,'US 9','Red',3,0.00),(4,1,'US 10','Red',2,0.00),(5,2,'US 7','Black',1,0.00),(6,2,'US 8','Black',2,0.00),(7,2,'US 9','Black',1,0.00),(8,2,'US 10','Black',1,0.00),(9,3,'US 7','Blue',3,0.00),(10,3,'US 8','Blue',4,0.00),(11,3,'US 9','Blue',4,0.00),(12,3,'US 10','Blue',3,0.00),(13,4,'US 7','Brown',5,0.00),(14,4,'US 8','Brown',5,0.00),(15,4,'US 9','Brown',5,0.00),(16,4,'US 10','Brown',5,0.00),(17,5,'US 7','White',1,0.00),(18,5,'US 8','White',1,0.00),(19,5,'US 9','White',1,0.00),(20,5,'US 10','White',1,0.00),(21,1,'US 9','Red Premium',1,50.00),(22,3,'US 8','Blue Limited',2,75.00);
/*!40000 ALTER TABLE `product_variants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `idProducts` int NOT NULL AUTO_INCREMENT,
  `productName` varchar(200) NOT NULL,
  `category_id` int DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `quantity` int DEFAULT '0',
  `image` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`idProducts`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'red shoe',24,685.00,10,'red shoe.png'),(2,'black shoe',24,685.00,5,'black shoe.png'),(3,'blue shoe',24,685.00,14,'blue shoe.png'),(4,'brown shoe',24,685.00,20,'brown shoe.png'),(5,'white shoe',24,685.00,4,'white shoe.png'),(6,'Basketball',8,29.99,50,'basketball.png'),(7,'Football',8,24.99,40,'football.jpg'),(8,'Tennis Ball Set',8,12.99,100,'tennis ball.png'),(9,'Baseball Bat',9,89.99,25,'baseball_bat.jpg'),(10,'Cricket Bat',9,129.99,15,'cricket_bat.png'),(11,'Boxing Gloves',10,49.99,30,'boxing_gloves.png'),(12,'Baseball Glove',10,79.99,20,'baseball glove.png');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int DEFAULT NULL,
  `idProducts` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `review_text` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  KEY `idProducts` (`idProducts`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`idProducts`) REFERENCES `products` (`idProducts`),
  CONSTRAINT `reviews_chk_1` CHECK (((`rating` >= 1) and (`rating` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userId` int NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `contact` varchar(10) DEFAULT NULL,
  `role` varchar(10) DEFAULT 'customer',
  PRIMARY KEY (`userId`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (3,'LamarMustard','minorityrick@gmail.com','0a5c6c0774041cd29eb399dbf8638357eb2effcd','73 Mustard Avenue','67676767','admin'),(5,'MustardUser','MustardMan@gmail.com','78dff008119f582e2959fc86f4b289cc9d9e2e1e','73 Mustard Avenue','67676767','user');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-28 14:25:25
