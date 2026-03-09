-- MySQL dump 10.13  Distrib 8.0.45, for macos15 (arm64)
--
-- Host: localhost    Database: rsud
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `pasien`
--

DROP TABLE IF EXISTS `pasien`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pasien` (
  `no_rm` varchar(15) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `jenis_kelamin` char(1) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `berat_badan` float NOT NULL,
  `tinggi_badan` float NOT NULL,
  PRIMARY KEY (`no_rm`),
  UNIQUE KEY `no_rm` (`no_rm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pasien`
--

LOCK TABLES `pasien` WRITE;
/*!40000 ALTER TABLE `pasien` DISABLE KEYS */;
INSERT INTO `pasien` VALUES ('RM020326001','Renaldy Fatikhur','L','2000-03-15',68.5,172),('RM020326002','Siti Nurhaliza','P','1995-07-22',52,158),('RM020326003','Budi Prasetyo','L','1988-11-05',75,178.5),('RM020326004','Dewi Kusumawati','P','2001-01-30',48.5,155),('RM020326005','Ahmad Zulkarnain','L','1993-04-18',82,180),('RM020326006','Fitria Ramadhani','P','1998-09-12',55.5,161.5),('RM020326007','Hendra Gunawan','L','1985-06-25',90,175),('RM020326008','Nurul Hidayah','P','2003-02-08',45,152),('RM020326010','Anggraini Putri','P','1990-08-03',58,163.5),('RM020326011','Rusaldi Anwa','L','1992-09-12',76,172.9);
/*!40000 ALTER TABLE `pasien` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tanda_vital`
--

DROP TABLE IF EXISTS `tanda_vital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tanda_vital` (
  `id_vital` int NOT NULL AUTO_INCREMENT,
  `no_rm` varchar(30) NOT NULL,
  `tekanan_darah` float NOT NULL,
  `suhu_tubuh` float NOT NULL,
  PRIMARY KEY (`id_vital`),
  KEY `no_rm` (`no_rm`),
  CONSTRAINT `tanda_vital_ibfk_1` FOREIGN KEY (`no_rm`) REFERENCES `pasien` (`no_rm`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tanda_vital`
--

LOCK TABLES `tanda_vital` WRITE;
/*!40000 ALTER TABLE `tanda_vital` DISABLE KEYS */;
INSERT INTO `tanda_vital` VALUES (1,'RM020326001',120.8,36.5),(2,'RM020326002',110.7,36.8),(3,'RM020326003',130.85,37),(4,'RM020326004',115.75,36.6),(5,'RM020326005',140.9,37.2),(6,'RM020326006',118.78,36.9),(7,'RM020326007',150.95,37.5),(8,'RM020326008',108.68,36.4),(10,'RM020326010',112.72,36.3),(11,'RM020326011',145,27.3);
/*!40000 ALTER TABLE `tanda_vital` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-09 19:14:37
