-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 05, 2023 at 07:36 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `attendance`
--

-- --------------------------------------------------------

--
-- Table structure for table `tblcourse`
--

CREATE TABLE `tblcourse` (
  `id` mediumint(3) NOT NULL,
  `deptId` mediumint(3) NOT NULL,
  `year` varchar(3) DEFAULT NULL,
  `semester` varchar(3) DEFAULT NULL,
  `courseName` varchar(150) DEFAULT NULL,
  `courseCode` varchar(20) DEFAULT NULL,
  `AcadamicYear` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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

CREATE TABLE `tbldepartment` (
  `id` mediumint(3) NOT NULL,
  `dname` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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
-- Table structure for table `tblroles`
--

CREATE TABLE `tblroles` (
  `Id` mediumint(3) NOT NULL,
  `Description` varchar(250) NOT NULL,
  `is_Active` bit(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

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

CREATE TABLE `tblstudent` (
  `id` mediumint(3) NOT NULL,
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
  `nationality` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblstudent`
--

INSERT INTO `tblstudent` (`id`, `firstName`, `lastName`, `regNo`, `dob`, `age`, `email`, `gender`, `contactNumber`, `deptid`, `semester`, `year`, `batch`, `fatherName`, `fatherContact`, `motherName`, `motherContect`, `aadharNumber`, `community`, `religion`, `addressLine1`, `addressLine2`, `city`, `pincode`, `state`, `nationality`) VALUES
(2, 'Selvaganapthi', 'A', '22PCA039', '2002-03-17', 22, '22pca039@rmv.ac.in', 'male', '9655120081', 4, 'III', 'I', '2023-2025', 'A', '9784563201', 'M', '9655820084', '123498768521', 'nill', 'nill', 'abc', 'xyz', 'CBE', '641001', 'TN', 'India');

-- --------------------------------------------------------

--
-- Table structure for table `tbltimetable`
--

CREATE TABLE `tbltimetable` (
  `id` mediumint(3) NOT NULL,
  `deptId` mediumint(3) NOT NULL,
  `Staffid` mediumint(3) NOT NULL,
  `Year` varchar(5) NOT NULL,
  `Semester` varchar(10) NOT NULL,
  `SubjectId` mediumint(3) NOT NULL,
  `SubjectCore` varchar(150) NOT NULL,
  `DayOrder` mediumint(2) NOT NULL,
  `SubjectHour` mediumint(2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbltimetable`
--

INSERT INTO `tbltimetable` (`id`, `deptId`, `Staffid`, `Year`, `Semester`, `SubjectId`, `SubjectCore`, `DayOrder`, `SubjectHour`) VALUES
(1, 1, 4, 'I', 'I', 1, 'Theory', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tblusers`
--

CREATE TABLE `tblusers` (
  `Id` mediumint(3) NOT NULL,
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
  `deptid` mediumint(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tblusers`
--

INSERT INTO `tblusers` (`Id`, `EmpId`, `username`, `password`, `email`, `fullname`, `phone`, `gender`, `dob`, `age`, `doj`, `dor`, `roleId`, `deptid`) VALUES
(1, 'DEV_01', 'admin', 'MTIzNDU2Nzg=', 'admin@rmv.ac.in', 'admin', '9655120081', 'male', '1990-03-17', 33, '2023-06-16', '0000-00-00', 1, 4),
(2, 'PCA_01', 'dinesh', 'MTIzNDU2Nzg=', 'dineshkumar@gmail.in', 'Dineshkumar', '9632587410', 'male', '1980-01-01', 43, '2021-01-01', '0000-00-00', 2, 4),
(3, 'UCA_02', 'chandhiran', 'MTIzNDU2Nzg=', 'chandhiran@rmv.ac.in', 'Chandhiran', '9894316150', 'male', '1980-01-01', 43, '2007-01-10', '0000-00-00', 2, 3),
(4, 'UIT_01', 'kamaraj', 'MTIzNDU2Nzg=', 'kamaraj@rmv.ac.in', 'Kamaraj', '9942080458', 'male', '1980-01-01', 43, '2007-01-01', '0000-00-00', 3, 1),
(5, 'UIT_02', 'sk', 'MTIzNDU2Nzg=', 'santhaanakrishnan@rmv.ac.in', 'Santhanakrishnan', '9080742935', 'male', '1990-01-01', 33, '2022-04-10', '0000-00-00', 2, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblcourse`
--
ALTER TABLE `tblcourse`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `courseCode` (`courseCode`);

--
-- Indexes for table `tbldepartment`
--
ALTER TABLE `tbldepartment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblroles`
--
ALTER TABLE `tblroles`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Description` (`Description`);

--
-- Indexes for table `tblstudent`
--
ALTER TABLE `tblstudent`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbltimetable`
--
ALTER TABLE `tbltimetable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblusers`
--
ALTER TABLE `tblusers`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `EmpId` (`EmpId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tblcourse`
--
ALTER TABLE `tblcourse`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tbldepartment`
--
ALTER TABLE `tbldepartment`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tblroles`
--
ALTER TABLE `tblroles`
  MODIFY `Id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblstudent`
--
ALTER TABLE `tblstudent`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tbltimetable`
--
ALTER TABLE `tbltimetable`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblusers`
--
ALTER TABLE `tblusers`
  MODIFY `Id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
