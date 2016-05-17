-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2016 at 11:00 PM
-- Server version: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `qtechdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE IF NOT EXISTS `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `bio` varchar(500) DEFAULT NULL,
  `activated` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `quotation`
--

CREATE TABLE IF NOT EXISTS `quotation` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `quotation`
--

INSERT INTO `quotation` (`id`, `name`, `description`) VALUES
(1, 'Motor', NULL),
(2, 'Property', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quotation_request`
--

CREATE TABLE IF NOT EXISTS `quotation_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `details` longtext,
  `date_created` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `type` int(4) DEFAULT NULL,
  `activated` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_quotation_request_user1_idx` (`created_by`),
  KEY `fk_quotation_request_quotation1_idx` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=100003 ;

--
-- Dumping data for table `quotation_request`
--

INSERT INTO `quotation_request` (`id`, `details`, `date_created`, `created_by`, `type`, `activated`) VALUES
(100001, '"{"Year":"2010"}"', '2016-04-30 22:29:24', NULL, 1, 1),
(100002, '"{"Year":"2010"}"', '2016-04-30 22:58:01', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `quotation_response`
--

CREATE TABLE IF NOT EXISTS `quotation_response` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `responder` int(11) DEFAULT NULL,
  `date_responded` datetime DEFAULT NULL,
  `quotation_request_id` int(11) DEFAULT NULL,
  `activated` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_quotation_response_quotation_request1_idx` (`quotation_request_id`),
  KEY `fk_responder_company` (`responder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `request_interest`
--

CREATE TABLE IF NOT EXISTS `request_interest` (
  `type` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  PRIMARY KEY (`type`,`company_id`),
  KEY `fk_request_interest_company1_idx` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(60) NOT NULL,
  `last_name` varchar(65) DEFAULT NULL,
  `password` varchar(45) NOT NULL,
  `email_address` varchar(100) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `role` char(2) DEFAULT NULL,
  `activated` tinyint(1) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_address_UNIQUE` (`email_address`),
  UNIQUE KEY `phone_number_UNIQUE` (`phone_number`),
  KEY `fk_user_company_idx` (`company_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_log`
--

CREATE TABLE IF NOT EXISTS `user_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action` char(2) DEFAULT NULL,
  `date_committed` datetime DEFAULT NULL,
  `logged_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_log_user1_idx` (`logged_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `quotation_request`
--
ALTER TABLE `quotation_request`
  ADD CONSTRAINT `fk_quotation_request_quotation1` FOREIGN KEY (`type`) REFERENCES `quotation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_quotation_request_user1` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `quotation_response`
--
ALTER TABLE `quotation_response`
  ADD CONSTRAINT `fk_quotation_response_quotation_request1` FOREIGN KEY (`quotation_request_id`) REFERENCES `quotation_request` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_responder_company` FOREIGN KEY (`responder`) REFERENCES `company` (`id`);

--
-- Constraints for table `request_interest`
--
ALTER TABLE `request_interest`
  ADD CONSTRAINT `fk_request_interest_company1` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_request_interest_quotation1` FOREIGN KEY (`type`) REFERENCES `quotation` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `fk_user_company` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_log`
--
ALTER TABLE `user_log`
  ADD CONSTRAINT `fk_user_log_user1` FOREIGN KEY (`logged_by`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
