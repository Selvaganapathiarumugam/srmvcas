-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 12, 2023 at 09:15 AM
-- Server version: 5.1.36
-- PHP Version: 5.3.0

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `attendance`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblattendance`
--

CREATE TABLE IF NOT EXISTS `tblattendance` (
  `id` mediumint(3) NOT NULL AUTO_INCREMENT,
  `regno` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `DayOrder` mediumint(2) NOT NULL,
  `subjectHour` mediumint(2) NOT NULL,
  `IsAbsent` tinyint(3) NOT NULL DEFAULT '0',
  `Staffid` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `tblattendance`
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `tblcourse`
--

INSERT INTO `tblcourse` (`id`, `deptId`, `year`, `semester`, `courseName`, `courseCode`, `AcadamicYear`) VALUES
(1, 1, 'I', 'I', 'Programming In C', '20UIT1C01', '2023'),
(2, 1, 'II', 'II', 'Java Programming', '20UIT3C03', '2023'),
(3, 1, 'III', 'V', 'Fundamentals of Cyber Security', '20UIT5EL01', '2023'),
(4, 1, 'III', 'V', 'Python Programming', '20UIT5C09', '2023');

-- --------------------------------------------------------

--
-- Table structure for table `tbldepartment`
--

CREATE TABLE IF NOT EXISTS `tbldepartment` (
  `id` mediumint(3) NOT NULL AUTO_INCREMENT,
  `dname` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `tbldepartment`
--

INSERT INTO `tbldepartment` (`id`, `dname`) VALUES
(1, 'B.Sc IT'),
(2, 'B.Sc CS'),
(3, 'BCA'),
(4, 'MCA'),
(5, 'B.COM'),
(6, 'B.COM PA'),
(7, 'B.COM CA');

-- --------------------------------------------------------

--
-- Table structure for table `tbllackattendance`
--

CREATE TABLE IF NOT EXISTS `tbllackattendance` (
  `id` mediumint(3) NOT NULL AUTO_INCREMENT,
  `regno` varchar(20) NOT NULL,
  `deptid` mediumint(3) NOT NULL,
  `semester` varchar(5) NOT NULL,
  `year` varchar(5) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `tbllackattendance`
--

INSERT INTO `tbllackattendance` (`id`, `regno`, `deptid`, `semester`, `year`, `date`) VALUES
(1, '22PCA009', 4, 'III', 'II', '2023-07-06'),
(2, '22PCA039', 4, 'III', 'II', '2023-07-09'),
(3, '22PCA006', 4, 'III', 'II', '2023-07-09');

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
(4, 'Supporting Staff', b'1'),
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `tblstudent`
--

INSERT INTO `tblstudent` (`id`, `firstName`, `lastName`, `regNo`, `dob`, `age`, `email`, `gender`, `contactNumber`, `deptid`, `semester`, `year`, `batch`, `fatherName`, `fatherContact`, `motherName`, `motherContect`, `aadharNumber`, `community`, `religion`, `addressLine1`, `addressLine2`, `city`, `pincode`, `state`, `nationality`) VALUES
(2, 'Selvaganapthi', 'A', '22PCA039', '2002-03-17', 22, '22pca039@rmv.ac.in', 'male', '9655120081', 4, 'III', 'II', '2023-2025', 'A', '9784563201', 'M', '9655820084', '123498768521', 'nill', 'nill', 'abc', 'xyz', 'CBE', '641001', 'TN', 'India'),
(3, 'Bharathidhasan', 'R', '22PCA009', '2002-05-05', 22, '22pca009@rmv.ac.in', 'male', '9632587410', 4, 'III', 'II', '2022-2024', 'R', '9632587410', 'M', '8978456512', '789456321023', 'nill', 'nill', 'mmm', 'yyy', 'Sivaganga', '641005', 'TN', 'India'),
(4, 'Arunagiri', 'M', '22PCA006', '2001-12-28', 21, '22pca006@rmv.ac.in', 'male', '9345582334', 4, 'III', 'II', '2022-2024', 'A.Manickavelu', '9095748976', 'K.Victroiya', '9360154497', '395628702750', 'MBC', 'hindu', '102,Mariyamnan Kovil  Street', 'Killkangeyam Kuppam', 'Panruti', '607805', 'Tamilnadu', 'India'),
(5, 'Jawaharsrinath', 'G', '22PCA017', '1998-05-05', 25, '22pca017@rmv.ac.in', 'male', '9345993004', 4, 'III', 'II', '2022-2024', 'N.Govindarajan', '9632587410', 'G.Nenuga', '9632587451', '852207419630', 'nill', 'hindu', '12,north street', 'kangai konda cholapuram', 'Thanjavoor', '685214', 'Tamil nadu', 'India');

-- --------------------------------------------------------

--
-- Table structure for table `tbltimetable`
--

CREATE TABLE IF NOT EXISTS `tbltimetable` (
  `id` mediumint(3) NOT NULL AUTO_INCREMENT,
  `deptId` mediumint(3) NOT NULL,
  `Staffid` mediumint(3) NOT NULL,
  `Year` varchar(5) NOT NULL,
  `Semester` varchar(10) NOT NULL,
  `SubjectId` mediumint(3) NOT NULL,
  `SubjectCore` varchar(150) NOT NULL,
  `DayOrder` mediumint(2) NOT NULL,
  `SubjectHour` mediumint(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `tbltimetable`
--

INSERT INTO `tbltimetable` (`id`, `deptId`, `Staffid`, `Year`, `Semester`, `SubjectId`, `SubjectCore`, `DayOrder`, `SubjectHour`) VALUES
(1, 1, 4, 'I', 'I', 1, 'Theory', 1, 1);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `tblusers`
--

INSERT INTO `tblusers` (`Id`, `EmpId`, `username`, `password`, `email`, `fullname`, `phone`, `gender`, `dob`, `age`, `doj`, `dor`, `roleId`, `deptid`) VALUES
(1, 'DEV_01', 'admin', 'MTIzNDU2Nzg=', 'admin@rmv.ac.in', 'admin', '9655120081', 'male', '1990-03-17', 33, '2023-06-01', '0000-00-00', 1, 4),
(2, 'PCA_01', 'dinesh', 'MTIzNDU2Nzg=', 'dineshkumar@gmail.in', 'Dineshkumar', '9632587410', 'male', '1980-01-01', 43, '2021-01-01', '0000-00-00', 2, 4),
(3, 'UCA_02', 'chandhiran', 'MTIzNDU2Nzg=', 'chandhiran@rmv.ac.in', 'Chandhiran', '9894316150', 'male', '1980-01-01', 43, '2007-01-10', '0000-00-00', 2, 3),
(4, 'UIT_01', 'kamaraj', 'MTIzNDU2Nzg=', 'kamaraj@rmv.ac.in', 'Kamaraj', '9942080458', 'male', '1980-01-01', 43, '2007-01-01', '0000-00-00', 3, 1);
