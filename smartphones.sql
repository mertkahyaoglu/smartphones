-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 04, 2015 at 07:10 PM
-- Server version: 5.5.32
-- PHP Version: 5.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `smartphones`
--
CREATE DATABASE IF NOT EXISTS `smartphones` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `smartphones`;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE IF NOT EXISTS `brands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(32) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `brand`) VALUES
(1, 'Apple'),
(2, 'Samsung'),
(3, 'LG'),
(4, 'Sony'),
(5, 'HTC'),
(6, 'Nokia'),
(7, 'Motorola'),
(8, 'Asus');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` text NOT NULL,
  `username` varchar(64) NOT NULL,
  `sid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `comment`, `username`, `sid`) VALUES
(19, 'Perfect phone! Highly recommmended.', 'Mert Kahyaoglu', 1);

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE IF NOT EXISTS `images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sid` int(11) NOT NULL,
  `image` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sid` (`sid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `sid`, `image`) VALUES
(1, 1, '/static/img/ip6-item-detail.jpg'),
(2, 1, '/static/img/ip6-item-detail2.jpg'),
(3, 1, '/static/img/ip6-item-detail3.jpg'),
(4, 2, '/static/img/note4-item-detail.jpg'),
(5, 2, '/static/img/note4-item-detail2.jpg'),
(6, 2, '/static/img/note4-item-detail3.jpg'),
(7, 3, '/static/img/g3-item-detail.jpg'),
(8, 3, '/static/img/g3-item-detail2.jpg'),
(9, 3, '/static/img/g3-item-detail3.jpg'),
(10, 4, '/static/img/z3-item-detail.jpg'),
(11, 4, '/static/img/z3-item-detail2.jpg'),
(12, 4, '/static/img/z3-item-detail3.jpg'),
(13, 5, '/static/img/nexus6-item-detail.jpg'),
(14, 5, '/static/img/nexus6-item-detail2.jpg'),
(15, 5, '/static/img/nexus6-item-detail3.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(128) NOT NULL,
  `title` varchar(128) NOT NULL,
  `permalink` varchar(128) NOT NULL,
  `review` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `image`, `title`, `permalink`, `review`) VALUES
(1, '/static/img/review1.jpg', 'Motorola Nexus 6 Review', 'motorola-nexus-6-review', 'Nexus 6 by Motorola marks a shift in market positioning for Google''s smartphone lineup. Whereas the duo of LG-made devices that precede it cut back on certain features to stay attractively'),
(2, '/static/img/review2.jpg', 'Iphone 6 Plus vs Note 4', 'iphone6-plus-vs-note-4', 'Samsung''s release cadence dictates that the Galaxy Note is the H2 flagship, keen to assert its superiority over an already feature-rich Galaxy S. iPhones come once a year, even the first-time iPhone 6 Plus phablet.');

-- --------------------------------------------------------

--
-- Table structure for table `smartphones`
--

CREATE TABLE IF NOT EXISTS `smartphones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bid` int(32) NOT NULL,
  `display` varchar(128) NOT NULL,
  `power` varchar(128) NOT NULL,
  `camera` varchar(128) NOT NULL,
  `sensors` varchar(128) NOT NULL,
  `model` varchar(32) NOT NULL,
  `released` date NOT NULL,
  `dimensions` varchar(50) NOT NULL,
  `weight` int(4) NOT NULL,
  `battery` int(6) NOT NULL,
  `colors` varchar(128) NOT NULL,
  `content` text NOT NULL,
  `imagemini` varchar(128) NOT NULL,
  `featured` varchar(128) DEFAULT NULL,
  `popular` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bid` (`bid`),
  KEY `did` (`display`),
  KEY `cid` (`camera`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `smartphones`
--

INSERT INTO `smartphones` (`id`, `bid`, `display`, `power`, `camera`, `sensors`, `model`, `released`, `dimensions`, `weight`, `battery`, `colors`, `content`, `imagemini`, `featured`, `popular`) VALUES
(1, 1, '750 x 1334 pixels, 4.7 inches', 'Apple A8 Dual-core 1.4 GHz CPU, PowerVR GX6450 Quad-core GPU', '8 MP 1/3'''' sensor size, 1.5µm pixel size , 1.2 MP front camera, dual-led flash', 'Fingerprint scanner, accelerometer, gyro, proximity, compass, barometer', 'iPhone 6', '2014-09-11', '138.1 x 67 x 6.9 mm', 129, 1810, 'Space Gray, Silver, Gold', 'This is Apple like we''ve never seen before. Apple like we never thought we''ll see.', '/static/img/item.jpg', '/static/img/3.jpg', 1),
(2, 2, '1440 x 2560 pixels, 5.7 inches Super AMOLED', 'Qualcomm Snapdragon 805 Quad-core 2.7 GHz CPU, Adreno 420 GPU', '16 MP rear, 3.7 MP front camera, led flash', 'Accelerometer, gyro, proximity, compass, barometer, gesture, UV, heart rate, SpO2', 'Galaxy Note 4', '2014-10-10', '153.5 x 78.6 x 8.5 mm', 175, 3220, 'Black, White, Pink', 'From an oddball that everyone was laughing at to becoming one of the most important Samsung announcement of the year - the Note 4!', '/static/img/item2.jpg', '/static/img/2.jpg', 1),
(3, 3, '1440 x 2560 pixels, 5.5 inches True HD-IPS + LCD', 'Qualcomm Snapdragon 801 Quad-core 2.5 GHz Krait 400 CPU, Adreno 330 GPU', '13 MP 1/3'''' sensor size rear, 2.1 MP front', 'Accelerometer, gyro, proximity, compass', 'G3', '2014-06-11', '146.3 x 74.6 x 8.9 mm', 149, 3000, 'Metallic Black, Silk White, Shine Gold, Moon Violet, Burgundy Red, Blue Steel', 'Late as usual but ever so strong.', '/static/img/item4.jpg', NULL, NULL),
(4, 4, '1080 x 1920 pixels, 5.2 inches IPS LCD', 'Qualcomm Snapdragon 801 Quad-core 2.5 GHz Krait 400 CPU, Adreno 330 GPU', '20.7 MP 1/2.3" sensor size rear, 2.2 MP front camera', 'Accelerometer, gyro, proximity, compass, barometer', 'Xperia Z3', '2014-09-01', '146 x 72 x 7.3 mm', 152, 3100, 'Black, White, Copper, Silver Green', 'To say we are eager to get the Xperia Z3 out for a spin would be a massive understatement', '/static/img/item3.jpg', '/static/img/4.jpg', 1),
(5, 7, '1440 x 2560 pixels, 5.96 inches 1440 x 2560 pixels, 5.96 inches', 'Qualcomm Snapdragon 805 Quad-core 2.7 GHz Krait 450 CPU, Adreno 420 GPU', '13 MP rear, 2.0 MP front', 'Accelerometer, gyro, proximity, compass, barometer', 'Nexus 6', '2014-11-12', '159.3 x 83 x 10.1 mm', 184, 3220, 'Midnight Blue, Cloud White', 'Nexus 6 by Motorola marks a shift in market positioning for Google''s smartphone lineup.', '/static/img/item5.jpg', '/static/img/1.jpg', NULL),
(8, 5, '1080 x 1920 pixels, 5.0 inches', 'Qualcomm Snapdragon 801Quad-core 2.3 GHz CPU, Adreno 330 GPU', 'Dual 4 MP rear, 5 MP front camera', 'Accelerometer, gyro, proximity, compass, barometer', 'M8', '2014-03-03', '146.4 x 70.6 x 9.4 mm', 160, 2600, 'Gunmetal Gray, Glacial Silver, Amber Gold', 'To say there are great expectations of the freshly announced HTC One (M8) would be a massive understatement.', '/static/img/m8.jpg', '', 0),
(9, 2, '1080 x 1920 pixels, 5.1 inches Super AMOLED', 'Qualcomm Snapdragon 801 Quad-core 2.5 GHz CPU Adreno 330 GPU', '16 MP rear, 2 MP front', 'Accelerometer, gyro, proximity, compass, barometer, gesture, heart rate', 'Galaxy S5', '2014-04-09', '142 x 72.5 x 8.1 mm', 145, 2800, 'Charcoal Black, Copper Gold, Electric Blue, Shimmery White', 'Every time the Samsung Galaxy S counter flips a digit, the world is getting ready to be amazed.', '/static/img/samsung-galaxy-s5.jpg', '', NULL),
(10, 8, '720 x 1280 pixels, 5.0 inches IPS', 'Intel Atom Z2580 Dual-core 2 GHz CPU PowerVR SGX544MP2', '8MP rear, 1.2 MP Front', 'Accelerometer, proximity, compass', 'Zenfone 5', '2014-04-02', '148.2 x 72.8 x 5.5mm', 145, 2110, 'Charcoal Black, Pearl White, Cherry Red, Champagne Gold, Twilight Purple', 'he ASUS Zenfone 5 is one of the three Zonefone devices that were announced at CES earlier this year. Based on Intel’s x86 Atom processors, the Zenfones run ASUS’ new ZenUI on top of Android.', '/static/img/asus-zenfone-5.jpg', '', NULL),
(12, 3, '1080 x 1920 pixels, 5.2 inches True HD-IPS + LCD', 'Qualcomm Snapdragon 800 Quad-core 2.26 GHz CPU Adreno 330 GPU', '12 MP rear, 2.1 MP front', 'Accelerometer, gyro, proximity, compass', 'G2', '2013-09-19', '138.5 x 70.9 x 8.9 mm', 143, 3000, 'Black, White, Red, Gold', 'While other companies were bracing for war at the IFA 2013 expo and lining up their latest phablets, LG was counting down to the G2 launch.', '/static/img/lg-g2-ofic.jpg', '', NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
