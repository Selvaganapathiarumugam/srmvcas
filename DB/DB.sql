-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 30, 2023 at 10:52 AM
-- Server version: 5.1.36
-- PHP Version: 5.3.0

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `attendance`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblcourse`
--

CREATE TABLE IF NOT EXISTS `tblcourse` (
  `id` mediumint(3) NOT NULL AUTO_INCREMENT,
  `deptId` mediumint(3) NOT NULL,
  `year` varchar(3) DEFAULT NULL,
  `semester` varchar(3) DEFAULT NULL,
  `courseName` varchar(150) DEFAULT NULL,
  `courseCode` varchar(20) DEFAULT NULL,
  `AcadamicYear` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `courseCode` (`courseCode`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `tblcourse`
--

INSERT INTO `tblcourse` (`id`, `deptId`, `year`, `semester`, `courseName`, `courseCode`, `AcadamicYear`) VALUES
(5, 2, 'I', 'I', 'Programing in C', '20UIT1C01', '2023'),
(6, 2, 'I', 'I', 'AmuthaTamil', '20UIT101', '2023'),
(4, 1, 'I', 'I', 'Programing in C', '20UCA1C01', '2023');

-- --------------------------------------------------------

--
-- Table structure for table `tbldepartment`
--

CREATE TABLE IF NOT EXISTS `tbldepartment` (
  `id` mediumint(3) NOT NULL AUTO_INCREMENT,
  `dname` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `tbldepartment`
--

INSERT INTO `tbldepartment` (`id`, `dname`) VALUES
(1, 'B.C.A'),
(2, 'B.Sc IT'),
(3, 'B.Sc CS'),
(4, 'B.COM'),
(5, 'B.COM PA'),
(6, 'B.COM CA'),
(7, 'B.Sc Maths'),
(8, 'M.C.A'),
(10, 'B.Sc Math');

-- --------------------------------------------------------

--
-- Table structure for table `tblroles`
--

CREATE TABLE IF NOT EXISTS `tblroles` (
  `Id` mediumint(3) NOT NULL AUTO_INCREMENT,
  `Description` varchar(250) NOT NULL,
  `is_Active` bit(1) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Description` (`Description`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `tblroles`
--

INSERT INTO `tblroles` (`Id`, `Description`, `is_Active`) VALUES
(1, 'Admin', b'1'),
(2, 'Staff', b'1'),
(3, 'HOD', b'1'),
(4, 'Student', b'1'),
(5, 'principal ', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `tblstudent`
--

CREATE TABLE IF NOT EXISTS `tblstudent` (
  `id` mediumint(3) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(250) NOT NULL,
  `lastName` varchar(250) NOT NULL,
  `regNo` varchar(10) NOT NULL,
  `dob` date NOT NULL,
  `age` mediumint(2) NOT NULL,
  `email` varchar(255) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `contactNumber` varchar(15) NOT NULL,
  `deptid` mediumint(3) NOT NULL,
  `semester` varchar(3) NOT NULL,
  `year` varchar(3) NOT NULL,
  `batch` varchar(20) NOT NULL,
  `fatherName` varchar(255) NOT NULL,
  `fatherContact` varchar(20) NOT NULL,
  `motherName` varchar(255) NOT NULL,
  `motherContect` varchar(20) NOT NULL,
  `aadharNumber` varchar(25) NOT NULL,
  `community` varchar(10) NOT NULL,
  `religion` varchar(100) NOT NULL,
  `addressLine1` varchar(255) NOT NULL,
  `addressLine2` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `pincode` varchar(10) NOT NULL,
  `state` varchar(255) NOT NULL,
  `nationality` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `tblstudent`
--

INSERT INTO `tblstudent` (`id`, `firstName`, `lastName`, `regNo`, `dob`, `age`, `email`, `gender`, `contactNumber`, `deptid`, `semester`, `year`, `batch`, `fatherName`, `fatherContact`, `motherName`, `motherContect`, `aadharNumber`, `community`, `religion`, `addressLine1`, `addressLine2`, `city`, `pincode`, `state`, `nationality`) VALUES
(1, 'Selvaganapathi', 'A', '22PCA039', '2002-03-17', 22, '22pca039@rmv.ac.in', 'male', '9655120081', 8, 'III', 'II', '2022-2024', 'Arumugam', '9874563210', 'Muthulakshmi', '7894563210', '1212 2121 3213', 'BC', 'hindu', '31/4,North Street', 'KarisalPatty', 'Dindigul', '624705', 'Tamil Nadu', 'India'),
(2, 'Bharathidhasan', 'R', '22PCA009', '2002-05-08', 22, '22pca009@rmv.ac.in', 'male', '9632587410', 8, 'III', 'II', '2022-2024', 'R', '12345678', 'M', '1234567890', '741085209630', 'nill', 'hindu', 'qqqq', 'qqqq', 'Sivaganga', '852741', 'Tamil Nadu	', 'India');

-- --------------------------------------------------------

--
-- Table structure for table `tblusers`
--

CREATE TABLE IF NOT EXISTS `tblusers` (
  `Id` mediumint(3) NOT NULL AUTO_INCREMENT,
  `EmpId` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `fullname` varchar(20) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `dob` date NOT NULL,
  `age` mediumint(3) NOT NULL,
  `doj` date NOT NULL,
  `dor` date NOT NULL,
  `roleId` mediumint(3) NOT NULL,
  `deptid` mediumint(3) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `EmpId` (`EmpId`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `tblusers`
--

INSERT INTO `tblusers` (`Id`, `EmpId`, `username`, `password`, `email`, `fullname`, `phone`, `gender`, `dob`, `age`, `doj`, `dor`, `roleId`, `deptid`) VALUES
(2, 'PCA001', 'Chanran', 'MTIzNDU2Nzg=', 'chanran@gmail.com', 'Chanran', '9632587410', 'male', '1983-01-01', 40, '2023-06-06', '0000-00-00', 1, 8),
(4, 'DEV001', 'dev_selva', 'MTIzNDU2Nzg=', 'selvaganapathi.am@gmail.com', 'Selvaganapathi.A', '9655120081', 'male', '2002-03-17', 26, '2023-06-30', '0000-00-00', 1, 8),
(5, 'PCA002', 'dinesh', 'ODc2NTQzMjE=', 'dineshkumar@gmail.com', 'Dineshkumar', '9632587410', 'male', '1980-01-01', 44, '2023-06-30', '0000-00-00', 2, 8),
(6, 'PCA003', 'sridhar', 'MTIzNDU2Nzg=', 'sridhar@gmail.com', 'sridhar', '9658741236', 'male', '1970-01-01', 54, '2000-01-01', '0000-00-00', 3, 8),
(7, 'UCA001', 'Somu', 'U29tdQ==', 'somu@gmail.com', 'Somusundharam', '9632587410', 'male', '1990-01-01', 34, '2020-10-10', '0000-00-00', 2, 8);
