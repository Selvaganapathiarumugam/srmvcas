-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 04, 2023 at 10:33 AM
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
(1, 1, 'I', 'I', 'Programing In C', '20UIT1C01', '2023-2024'),
(2, 4, 'I', 'I', 'OOPs with CPP', '20PCA1C01', '2023-2024');

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

-- --------------------------------------------------------

--
-- Table structure for table `tbltimetable`
--

CREATE TABLE `tbltimetable` (
  `id` mediumint(3) NOT NULL,
  `deptId` mediumint(3) NOT NULL,
  `StaffName` varchar(255) NOT NULL,
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

INSERT INTO `tbltimetable` (`id`, `deptId`, `StaffName`, `Year`, `Semester`, `SubjectId`, `SubjectCore`, `DayOrder`, `SubjectHour`) VALUES
(1, 1, 'Selvaganapathi', 'I', 'I', 1, 'Theory', 1, 1),
(2, 1, 'Selvaganapathi', 'I', 'I', 2, 'Theory', 2, 1);

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
(1, 'DEV_01', 'dev_selva', 'MTIzNDU2Nzg=', 'selvaganapathi.am@gmail.com', 'Selvaganapathi', '9655120081', 'male', '2002-03-17', 23, '2023-06-16', '0000-00-00', 1, 4),
(2, 'PCA_01', 'dinesh', 'MTIzNDU2Nzg=', 'dineshkumar@gmail.in', 'Dineshkumar', '9632587410', 'male', '1980-01-01', 43, '2021-01-01', '0000-00-00', 2, 4);

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
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbltimetable`
--
ALTER TABLE `tbltimetable`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblusers`
--
ALTER TABLE `tblusers`
  MODIFY `Id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
