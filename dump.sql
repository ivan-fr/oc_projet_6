-- MySQL dump 10.13  Distrib 8.0.13, for macos10.14 (x86_64)
--
-- Host: 127.0.0.1    Database: pizzeria
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `Adresse`
--

LOCK TABLES `Adresse` WRITE;
/*!40000 ALTER TABLE `Adresse` DISABLE KEYS */;
INSERT INTO `Adresse` VALUES (1,'75010','Rue de Crimée','248'),(2,'75018','Rue Marcadet','52'),(3,'75009','Rue de Babylone','33'),(4,'75019','Rue de Curial','33'),(5,'75013','Rue de Tolbiac','50'),(6,'75007','Rue Vannau','34');
/*!40000 ALTER TABLE `Adresse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Categorie`
--

LOCK TABLES `Categorie` WRITE;
/*!40000 ALTER TABLE `Categorie` DISABLE KEYS */;
INSERT INTO `Categorie` VALUES (3,'entree'),(4,'grande boisson'),(2,'petite boisson'),(1,'pizza');
/*!40000 ALTER TABLE `Categorie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Categorie_Menu`
--

LOCK TABLES `Categorie_Menu` WRITE;
/*!40000 ALTER TABLE `Categorie_Menu` DISABLE KEYS */;
INSERT INTO `Categorie_Menu` VALUES (1,1,1),(1,2,2),(1,3,3),(2,1,1),(3,1,1),(3,2,2),(3,3,2),(4,2,1),(4,3,1);
/*!40000 ALTER TABLE `Categorie_Menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Commande`
--

LOCK TABLES `Commande` WRITE;
/*!40000 ALTER TABLE `Commande` DISABLE KEYS */;
INSERT INTO `Commande` VALUES (1,1,'2018-11-05 13:17:17','en attente','espèce',1),(2,1,'2018-11-08 00:00:00','en attente','espèce',2),(3,1,'2018-11-07 00:00:00','en attente','espèce',1);
/*!40000 ALTER TABLE `Commande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Commande_Menu`
--

LOCK TABLES `Commande_Menu` WRITE;
/*!40000 ALTER TABLE `Commande_Menu` DISABLE KEYS */;
INSERT INTO `Commande_Menu` VALUES (1,1,1),(2,1,1),(3,1,2),(4,1,3);
/*!40000 ALTER TABLE `Commande_Menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Commande_Menu_Produit`
--

LOCK TABLES `Commande_Menu_Produit` WRITE;
/*!40000 ALTER TABLE `Commande_Menu_Produit` DISABLE KEYS */;
INSERT INTO `Commande_Menu_Produit` VALUES (1,1,1),(2,2,1),(2,3,1),(2,4,1),(7,1,1),(7,2,1),(7,3,1),(7,4,1),(8,1,1),(8,2,1),(8,3,1),(8,4,1);
/*!40000 ALTER TABLE `Commande_Menu_Produit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Ingredient`
--

LOCK TABLES `Ingredient` WRITE;
/*!40000 ALTER TABLE `Ingredient` DISABLE KEYS */;
INSERT INTO `Ingredient` VALUES (31,'ananas'),(19,'champignon frais'),(16,'crème fraîche légère'),(8,'emmental'),(12,'filet de poulet rôti et mariné'),(9,'fourme d\'Ambert AOP'),(18,'fromage à raclette'),(7,'fromage de chèvre'),(11,'haché au boeuf'),(3,'jambon'),(17,'jambon cru'),(21,'lardons'),(13,'merguez'),(23,'miel'),(2,'mozzarella fraîche'),(24,'oignons frais'),(32,'olives noires du Maroc'),(29,'piments Mexicain'),(25,'poivrons verts'),(20,'pommes de terre'),(36,'salade verte'),(10,'sauce barbecue'),(30,'sauce blanche kebab'),(28,'sauce Samouraï'),(1,'sauce tomate à l\'Origan'),(15,'saucisse pepperoni'),(26,'saumon de Norvège'),(33,'thon'),(27,'tomates fraîches');
/*!40000 ALTER TABLE `Ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Ingredient_Produit`
--

LOCK TABLES `Ingredient_Produit` WRITE;
/*!40000 ALTER TABLE `Ingredient_Produit` DISABLE KEYS */;
INSERT INTO `Ingredient_Produit` VALUES (1,1),(2,1),(3,1),(19,1),(1,2),(2,2),(7,2),(8,2),(9,2),(2,3),(10,3),(11,3),(12,3),(13,3),(27,6),(36,6),(9,7),(17,7),(27,7),(36,7);
/*!40000 ALTER TABLE `Ingredient_Produit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Menu`
--

LOCK TABLES `Menu` WRITE;
/*!40000 ALTER TABLE `Menu` DISABLE KEYS */;
INSERT INTO `Menu` VALUES (1,'Extra Menu',19.95),(2,'Mega Menu',32.95),(3,'Giga Menu',39.95);
/*!40000 ALTER TABLE `Menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Pizzeria`
--

LOCK TABLES `Pizzeria` WRITE;
/*!40000 ALTER TABLE `Pizzeria` DISABLE KEYS */;
INSERT INTO `Pizzeria` VALUES (1,'OC Pizza',1),(2,'OC Pizza 2',3),(3,'OC Pizza 3',4),(4,'OC Pizza 4',5),(5,'OC Pizza 5',6);
/*!40000 ALTER TABLE `Pizzeria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Pizzeria_Ingredient`
--

LOCK TABLES `Pizzeria_Ingredient` WRITE;
/*!40000 ALTER TABLE `Pizzeria_Ingredient` DISABLE KEYS */;
INSERT INTO `Pizzeria_Ingredient` VALUES (1,1,1),(1,2,1),(1,3,1),(1,7,1),(1,8,1),(1,9,1),(1,10,1),(1,11,1),(1,12,1),(1,13,1),(1,15,1),(1,16,1),(1,17,1),(1,18,1),(1,19,1),(1,20,1),(1,21,1),(1,23,1),(1,24,1),(1,25,1),(1,26,1),(1,27,1),(1,28,1),(1,29,1),(1,30,1),(1,31,1),(1,32,1),(1,33,1),(1,36,1);
/*!40000 ALTER TABLE `Pizzeria_Ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Produit`
--

LOCK TABLES `Produit` WRITE;
/*!40000 ALTER TABLE `Produit` DISABLE KEYS */;
INSERT INTO `Produit` VALUES (1,'queen',15.00,1,NULL),(2,'4 fromages',17.00,1,NULL),(3,'BPM',15.00,1,NULL),(6,'salade verte',6.50,3,NULL),(7,'salade chicken',6.50,3,NULL),(8,'coca-cola 33cl',1.80,2,NULL),(9,'coca-cola 1,25L',3.40,4,NULL),(10,'oasis tropical 2L',3.40,4,NULL);
/*!40000 ALTER TABLE `Produit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Produit_Commande`
--

LOCK TABLES `Produit_Commande` WRITE;
/*!40000 ALTER TABLE `Produit_Commande` DISABLE KEYS */;
INSERT INTO `Produit_Commande` VALUES (1,1,2),(3,1,2);
/*!40000 ALTER TABLE `Produit_Commande` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
INSERT INTO `Role` VALUES (1,'client'),(2,'préparateur de commande'),(3,'livreur'),(4,'manager');
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `Utilisateur`
--

LOCK TABLES `Utilisateur` WRITE;
/*!40000 ALTER TABLE `Utilisateur` DISABLE KEYS */;
INSERT INTO `Utilisateur` VALUES (1,'Besevic','Ivan','ivan.besevic_fr@yahoo.com',1,'mdp',2);
/*!40000 ALTER TABLE `Utilisateur` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-18 18:31:22
