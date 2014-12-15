-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Dec 15, 2014 at 01:08 AM
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

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
(7, 'Motorola');

-- --------------------------------------------------------

--
-- Table structure for table `camera`
--

CREATE TABLE IF NOT EXISTS `camera` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `primary` varchar(128) NOT NULL,
  `secondary` varchar(128) NOT NULL,
  `features` varchar(128) NOT NULL,
  `video` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `camera`
--

INSERT INTO `camera` (`id`, `primary`, `secondary`, `features`, `video`) VALUES
(1, '8 MP, phase detection autofocus, dual-LED flash', '1.2 MP, 720p@30fps, face detection, HDR, FaceTime ', '1/3'''' sensor size, 1.5µm pixel size, geo-tagging, simultaneous HD video and image recording, touch focus, face/smile detection', '1080p@60fps, 720p@240fps'),
(2, '16 MP, optical image stabilization, autofocus, LED flash', '3.7 MP, 1440p', 'Dual Shot, Simultaneous HD video and image recording, geo-tagging, touch focus, face/smile detection, panorama, HDR', '2160p@30fps, 1080p@60fps, optical stabilization, dual-video record'),
(3, '13 MP, phase detection/laser autofocus, optical image stabilization, dual-LED flash', '2.1 MP, 1080p@30fps', '1/3'''' sensor size, simultaneous video and image recording, geo-tagging, face detection, HDR', '2160p@30fps, 1080p@30fps, optical stabilization, HDR, stereo sound rec'),
(4, '20.7 MP, autofocus, LED flash', '2.2 MP, 1080p@30fps', '1/2.3" sensor size, geo-tagging, touch focus, face detection, HDR, panorama', '2160p@30fps, 1080p@60fps, 720p@120fps, HDR'),
(5, '13 MP, 4128 x 3096 pixels, autofocus, optical image ', '2.0 MP', 'Dual recording, geo-tagging, touch focus, face detection, photo sphere, panorama, HDR', '2160p@30fps, optical stabilization');

-- --------------------------------------------------------

--
-- Table structure for table `display`
--

CREATE TABLE IF NOT EXISTS `display` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(256) NOT NULL,
  `size` varchar(128) NOT NULL,
  `protection` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `display`
--

INSERT INTO `display` (`id`, `type`, `size`, `protection`) VALUES
(1, 'LED-backlit IPS LCD, capacitive touchscreen, 16M colors', '750 x 1334 pixels, 4.7 inches (~326 ppi pixel density)', 'Shatter proof glass, oleophobic coating'),
(2, 'Super AMOLED capacitive touchscreen, 16M colors', '1440 x 2560 pixels, 5.7 inches (~515 ppi pixel density)', 'Corning Gorilla Glass 4'),
(3, 'True HD-IPS + LCD capacitive touchscreen, 16M colors', '1440 x 2560 pixels, 5.5 inches (~534 ppi pixel density)', 'Corning Gorilla Glass 3'),
(4, 'IPS LCD capacitive touchscreen, 16M colors', '1080 x 1920 pixels, 5.2 inches', 'Shatter proof glass'),
(5, 'AMOLED capacitive touchscreen, 16M colors', '1440 x 2560 pixels, 5.96 inches', 'Corning Gorilla Glass 3');

-- --------------------------------------------------------

--
-- Table structure for table `features`
--

CREATE TABLE IF NOT EXISTS `features` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `os` varchar(128) NOT NULL,
  `chipset` varchar(128) NOT NULL,
  `cpu` varchar(128) NOT NULL,
  `gpu` varchar(128) NOT NULL,
  `sensors` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `features`
--

INSERT INTO `features` (`id`, `os`, `chipset`, `cpu`, `gpu`, `sensors`) VALUES
(1, 'iOS 8, upgradable to iOS 8.1.2', 'Apple A8', 'Dual-core 1.4 GHz Cyclone', 'PowerVR GX6450 Quad-core', 'Fingerprint scanner, accelerometer, gyro, proximity, compass, barometer'),
(2, 'Android OS, v4.4.4 (KitKat)', 'Qualcomm Snapdragon 805', 'Quad-core 2.7 GHz Krait 450', 'Adreno 420', 'Accelerometer, gyro, proximity, compass, barometer, gesture, UV, heart rate, SpO2'),
(3, 'Android OS, v4.4.2', 'Qualcomm MSM8975AC Snapdragon 801', 'Quad-core 2.5 GHz Krait 400', 'Adreno 330', 'Accelerometer, gyro, proximity, compass'),
(4, 'Android OS, v4.4.4 (KitKat), planned upgrade to v5.0 ', 'Qualcomm MSM8974AC Snapdragon 801', 'Quad-core 2.5 GHz Krait 400', 'Adreno 330', 'Accelerometer, gyro, proximity, compass, barometer'),
(5, 'Android OS, v5.0', 'Qualcomm Snapdragon 805', 'Quad-core 2.7 GHz Krait 450', 'Adreno 420', 'Accelerometer, gyro, proximity, compass, barometer');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

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
  `did` int(11) NOT NULL,
  `cid` int(11) NOT NULL,
  `model` varchar(32) NOT NULL,
  `released` date NOT NULL,
  `dimensions` varchar(50) NOT NULL,
  `weight` int(4) NOT NULL,
  `battery` int(6) NOT NULL,
  `colors` varchar(128) NOT NULL,
  `content` text NOT NULL,
  `imagemini` varchar(128) NOT NULL,
  `featured` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bid` (`bid`),
  KEY `did` (`did`),
  KEY `cid` (`cid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `smartphones`
--

INSERT INTO `smartphones` (`id`, `bid`, `did`, `cid`, `model`, `released`, `dimensions`, `weight`, `battery`, `colors`, `content`, `imagemini`, `featured`) VALUES
(1, 1, 1, 1, 'iPhone 6', '2014-09-01', '138.1 x 67 x 6.9 mm', 129, 1810, 'Space Gray, Silver, Gold', 'This is Apple like we''ve never seen before. Apple like we never thought we''ll see.', '/static/img/item.jpg', '/static/img/3.jpg'),
(2, 2, 2, 2, 'Galaxy Note 4', '2014-09-01', '153.5 x 78.6 x 8.5 mm', 175, 3220, 'Black, White, Pink', 'From an oddball that everyone was laughing at to becoming one of the most important Samsung announcement of the year - the Note 4!', '/static/img/item2.jpg', '/static/img/2.jpg'),
(3, 3, 3, 3, 'G3', '2014-06-01', '146.3 x 74.6 x 8.9 mm', 149, 3000, 'Metallic Black, Silk White, Shine Gold, Moon Violet, Burgundy Red, Blue Steel', 'Late as usual but ever so strong.', '/static/img/item4.jpg', NULL),
(4, 4, 4, 4, 'Xperia Z3', '2014-09-01', '146 x 72 x 7.3 mm', 152, 3100, 'Black, White, Copper, Silver Green', 'To say we are eager to get the Xperia Z3 out for a spin would be a massive understatement', '/static/img/item3.jpg', '/static/img/4.jpg'),
(5, 7, 5, 5, 'Nexus 6', '2014-11-01', '159.3 x 83 x 10.1 mm', 184, 3220, 'Midnight Blue, Cloud White', 'Nexus 6 by Motorola marks a shift in market positioning for Google''s smartphone lineup.', '/static/img/item5.jpg', '/static/img/1.jpg');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
