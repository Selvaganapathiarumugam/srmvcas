-- phpMyAdmin SQL Dump
-- version 3.2.0.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 13, 2023 at 10:11 AM
-- Server version: 5.1.36
-- PHP Version: 5.3.0

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `attendance`
--
CREATE DATABASE `attendance` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `attendance`;

-- --------------------------------------------------------

--
-- Table structure for table `tblattendance`
--

CREATE TABLE `tblattendance` (
  `id` mediumint(3) NOT NULL,
  `regno` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `DayOrder` mediumint(2) NOT NULL,
  `subjectHour` mediumint(2) NOT NULL,
  `CourseTaught` varchar(500) NOT NULL,
  `IsAbsent` tinyint(3) NOT NULL DEFAULT 0,
  `Staffid` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblattendance`
--

INSERT INTO `tblattendance` (`id`, `regno`, `date`, `DayOrder`, `subjectHour`, `CourseTaught`, `IsAbsent`, `Staffid`) VALUES
(1, '22PCA006', '2023-07-21', 1, 1, '', 0, 'DEV_01'),
(2, '22PCA009', '2023-07-21', 1, 1, '', 0, 'DEV_01'),
(3, '22PCA017', '2023-07-21', 1, 1, '', 1, 'DEV_01'),
(4, '22PCA039', '2023-07-21', 1, 1, '', 1, 'DEV_01'),
(5, '22PCA006', '2023-07-21', 1, 2, 'PHP', 0, 'DEV_01'),
(6, '22PCA009', '2023-07-21', 1, 2, 'PHP', 0, 'DEV_01'),
(7, '22PCA017', '2023-07-21', 1, 2, 'PHP', 1, 'DEV_01'),
(8, '22PCA039', '2023-07-21', 1, 2, 'PHP', 0, 'DEV_01'),
(9, '22PCA006', '2023-07-21', 1, 3, 'PHP', 0, 'DEV_01'),
(10, '22PCA009', '2023-07-21', 1, 3, 'PHP', 0, 'DEV_01'),
(11, '22PCA017', '2023-07-21', 1, 3, 'PHP', 1, 'DEV_01'),
(12, '22PCA039', '2023-07-21', 1, 3, 'PHP', 0, 'DEV_01'),
(13, '22PCA006', '2023-07-21', 1, 4, '', 0, 'DEV_01'),
(14, '22PCA009', '2023-07-21', 1, 4, '', 1, 'DEV_01'),
(15, '22PCA017', '2023-07-21', 1, 4, '', 1, 'DEV_01'),
(16, '22PCA039', '2023-07-21', 1, 4, '', 0, 'DEV_01'),
(17, '22PCA006', '2023-07-21', 1, 5, 'Android', 0, 'DEV_01'),
(18, '22PCA009', '2023-07-21', 1, 5, 'Android', 1, 'DEV_01'),
(19, '22PCA017', '2023-07-21', 1, 5, 'Android', 1, 'DEV_01'),
(20, '22PCA039', '2023-07-21', 1, 5, 'Android', 0, 'DEV_01'),
(21, '22PCA006', '2023-07-24', 1, 1, 'php', 0, 'DEV_01'),
(22, '22PCA009', '2023-07-24', 1, 1, 'php', 1, 'DEV_01'),
(23, '22PCA017', '2023-07-24', 1, 1, 'php', 0, 'DEV_01'),
(24, '22PCA039', '2023-07-24', 1, 1, 'php', 1, 'DEV_01'),
(25, '22PCA006', '2023-07-24', 1, 2, 'php', 0, 'DEV_01'),
(26, '22PCA009', '2023-07-24', 1, 2, 'php', 1, 'DEV_01'),
(27, '22PCA017', '2023-07-24', 1, 2, 'php', 0, 'DEV_01'),
(28, '22PCA039', '2023-07-24', 1, 2, 'php', 1, 'DEV_01'),
(29, '22PCA006', '2023-07-24', 1, 3, 'php', 1, 'DEV_01'),
(30, '22PCA009', '2023-07-24', 1, 3, 'php', 1, 'DEV_01'),
(31, '22PCA017', '2023-07-24', 1, 3, 'php', 0, 'DEV_01'),
(32, '22PCA039', '2023-07-24', 1, 3, 'php', 1, 'DEV_01'),
(33, '22PCA006', '2023-07-24', 1, 4, 'php', 0, 'DEV_01'),
(34, '22PCA009', '2023-07-24', 1, 4, 'php', 1, 'DEV_01'),
(35, '22PCA017', '2023-07-24', 1, 4, 'php', 0, 'DEV_01'),
(36, '22PCA039', '2023-07-24', 1, 4, 'php', 1, 'DEV_01'),
(37, '22PCA006', '2023-07-24', 1, 5, 'java', 0, 'DEV_01'),
(38, '22PCA009', '2023-07-24', 1, 5, 'java', 1, 'DEV_01'),
(39, '22PCA017', '2023-07-24', 1, 5, 'java', 0, 'DEV_01'),
(40, '22PCA039', '2023-07-24', 1, 5, 'java', 1, 'DEV_01'),
(41, '22PCA006', '2023-07-25', 2, 1, '', 1, 'DEV_01'),
(42, '22PCA009', '2023-07-25', 2, 1, '', 0, 'DEV_01'),
(43, '22PCA017', '2023-07-25', 2, 1, '', 0, 'DEV_01'),
(44, '22PCA039', '2023-07-25', 2, 1, '', 0, 'DEV_01'),
(45, '22PCA006', '2023-07-25', 2, 2, '', 0, 'DEV_01'),
(46, '22PCA009', '2023-07-25', 2, 2, '', 1, 'DEV_01'),
(47, '22PCA017', '2023-07-25', 2, 2, '', 0, 'DEV_01'),
(48, '22PCA039', '2023-07-25', 2, 2, '', 0, 'DEV_01'),
(49, '22PCA006', '2023-07-25', 2, 3, '', 0, 'DEV_01'),
(50, '22PCA009', '2023-07-25', 2, 3, '', 0, 'DEV_01'),
(51, '22PCA017', '2023-07-25', 2, 3, '', 1, 'DEV_01'),
(52, '22PCA039', '2023-07-25', 2, 3, '', 0, 'DEV_01'),
(53, '22PCA006', '2023-07-25', 2, 4, '', 0, 'DEV_01'),
(54, '22PCA009', '2023-07-25', 2, 4, '', 0, 'DEV_01'),
(55, '22PCA017', '2023-07-25', 2, 4, '', 0, 'DEV_01'),
(56, '22PCA039', '2023-07-25', 2, 4, '', 1, 'DEV_01'),
(57, '22PCA006', '2023-07-25', 2, 5, '', 0, 'DEV_01'),
(58, '22PCA009', '2023-07-25', 2, 5, '', 0, 'DEV_01'),
(59, '22PCA017', '2023-07-25', 2, 5, '', 0, 'DEV_01'),
(60, '22PCA039', '2023-07-25', 2, 5, '', 1, 'DEV_01'),
(61, '19UIT001', '2023-07-29', 1, 1, 'C', 1, 'DEV_01'),
(62, '19UIT002', '2023-07-29', 1, 1, 'C', 0, 'DEV_01'),
(63, '19UIT003', '2023-07-29', 1, 1, 'C', 0, 'DEV_01'),
(64, '19UIT004', '2023-07-29', 1, 1, 'C', 0, 'DEV_01'),
(65, '19UIT005', '2023-07-29', 1, 1, 'C', 1, 'DEV_01'),
(66, '19UIT006', '2023-07-29', 1, 1, 'C', 0, 'DEV_01'),
(67, '19UIT007', '2023-07-29', 1, 1, 'C', 0, 'DEV_01'),
(68, '19UIT001', '2023-07-29', 1, 2, 'C', 1, 'DEV_01'),
(69, '19UIT002', '2023-07-29', 1, 2, 'C', 0, 'DEV_01'),
(70, '19UIT003', '2023-07-29', 1, 2, 'C', 0, 'DEV_01'),
(71, '19UIT004', '2023-07-29', 1, 2, 'C', 1, 'DEV_01'),
(72, '19UIT005', '2023-07-29', 1, 2, 'C', 1, 'DEV_01'),
(73, '19UIT006', '2023-07-29', 1, 2, 'C', 0, 'DEV_01'),
(74, '19UIT007', '2023-07-29', 1, 2, 'C', 0, 'DEV_01'),
(75, '19UIT001', '2023-07-29', 1, 3, 'CPP', 1, 'DEV_01'),
(76, '19UIT002', '2023-07-29', 1, 3, 'CPP', 0, 'DEV_01'),
(77, '19UIT003', '2023-07-29', 1, 3, 'CPP', 0, 'DEV_01'),
(78, '19UIT004', '2023-07-29', 1, 3, 'CPP', 1, 'DEV_01'),
(79, '19UIT005', '2023-07-29', 1, 3, 'CPP', 1, 'DEV_01'),
(80, '19UIT006', '2023-07-29', 1, 3, 'CPP', 0, 'DEV_01'),
(81, '19UIT007', '2023-07-29', 1, 3, 'CPP', 0, 'DEV_01'),
(82, '19UIT001', '2023-07-29', 1, 4, 'CPP', 1, 'DEV_01'),
(83, '19UIT002', '2023-07-29', 1, 4, 'CPP', 0, 'DEV_01'),
(84, '19UIT003', '2023-07-29', 1, 4, 'CPP', 0, 'DEV_01'),
(85, '19UIT004', '2023-07-29', 1, 4, 'CPP', 0, 'DEV_01'),
(86, '19UIT005', '2023-07-29', 1, 4, 'CPP', 1, 'DEV_01'),
(87, '19UIT006', '2023-07-29', 1, 4, 'CPP', 1, 'DEV_01'),
(88, '19UIT007', '2023-07-29', 1, 4, 'CPP', 0, 'DEV_01'),
(89, '19UIT001', '2023-07-29', 1, 5, 'C', 1, 'DEV_01'),
(90, '19UIT002', '2023-07-29', 1, 5, 'C', 0, 'DEV_01'),
(91, '19UIT003', '2023-07-29', 1, 5, 'C', 0, 'DEV_01'),
(92, '19UIT004', '2023-07-29', 1, 5, 'C', 0, 'DEV_01'),
(93, '19UIT005', '2023-07-29', 1, 5, 'C', 1, 'DEV_01'),
(94, '19UIT006', '2023-07-29', 1, 5, 'C', 1, 'DEV_01'),
(95, '19UIT007', '2023-07-29', 1, 5, 'C', 0, 'DEV_01');

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblcourse`
--

INSERT INTO `tblcourse` (`id`, `deptId`, `year`, `semester`, `courseName`, `courseCode`, `AcadamicYear`) VALUES
(1, 1, 'I', 'I', 'Programming In C', '20UIT1C01', '2023'),
(2, 1, 'II', 'II', 'Java Programming', '20UIT3C03', '2023'),
(3, 1, 'III', 'V', 'Fundamentals of Cyber Security', '20UIT5EL01', '2023'),
(4, 1, 'III', 'V', 'Python Programming', '20UIT5C09', '2023'),
(5, 4, 'I', 'I', 'OOPs With CPP', '22PCA1C01', '2023'),
(6, 4, 'I', 'I', 'Relational Database Management System', '22PCA1C02', '2023'),
(7, 4, 'I', 'I', 'Data Structures & Algorithms With CPP', '22PCA1C03', '2023'),
(8, 4, 'I', 'I', 'Fundamentals of Accounts', '22PCA1C04', '2023'),
(9, 1, 'I', 'I', 'Amutha Tamil -1', '20UIT1TA01', '2023'),
(10, 1, 'I', 'I', 'Mathematics -1', '20UIT1AL01', '2023'),
(11, 1, 'I', 'I', 'English - 1', '20UIT1EN01', '2023');

-- --------------------------------------------------------

--
-- Table structure for table `tbldayattendance`
--

CREATE TABLE `tbldayattendance` (
  `id` mediumint(3) NOT NULL,
  `deptId` mediumint(3) NOT NULL,
  `semester` varchar(3) NOT NULL,
  `year` varchar(3) NOT NULL,
  `regno` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(10) NOT NULL,
  `staffId` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbldayattendance`
--

INSERT INTO `tbldayattendance` (`id`, `deptId`, `semester`, `year`, `regno`, `date`, `status`, `staffId`) VALUES
(1, 1, 'I', 'I', '19UIT001', '2023-07-29', 'A', 'DEV_01'),
(2, 1, 'I', 'I', '19UIT005', '2023-07-29', 'A', 'DEV_01'),
(3, 1, 'I', 'I', '19UIT002', '2023-07-29', 'P', 'DEV_01'),
(4, 1, 'I', 'I', '19UIT003', '2023-07-29', 'P', 'DEV_01'),
(5, 1, 'I', 'I', '19UIT007', '2023-07-29', 'P', 'DEV_01'),
(6, 1, 'I', 'I', '19UIT004', '2023-07-29', 'AP', 'DEV_01'),
(7, 1, 'I', 'I', '19UIT006', '2023-07-29', 'PA', 'DEV_01'),
(8, 4, 'III', 'II', '22PCA017', '2023-07-21', 'A', 'DEV_01'),
(9, 4, 'III', 'II', '22PCA006', '2023-07-21', 'P', 'DEV_01'),
(10, 4, 'III', 'II', '22PCA039', '2023-07-21', 'AP', 'DEV_01');

-- --------------------------------------------------------

--
-- Table structure for table `tbldepartment`
--

CREATE TABLE `tbldepartment` (
  `id` mediumint(3) NOT NULL,
  `dname` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
-- Table structure for table `tbllateattendance`
--

CREATE TABLE `tbllateattendance` (
  `id` mediumint(3) NOT NULL,
  `regno` varchar(20) NOT NULL,
  `deptid` mediumint(3) NOT NULL,
  `semester` varchar(5) NOT NULL,
  `year` varchar(5) NOT NULL,
  `date` date NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbllateattendance`
--

INSERT INTO `tbllateattendance` (`id`, `regno`, `deptid`, `semester`, `year`, `date`) VALUES
(1, '22PCA009', 4, 'III', 'II', '2023-07-06'),
(2, '22PCA039', 4, 'III', 'II', '2023-07-09'),
(3, '22PCA006', 4, 'III', 'II', '2023-07-09'),
(4, '22PCA009', 4, 'III', 'II', '2023-07-12');

-- --------------------------------------------------------

--
-- Table structure for table `tblroles`
--

CREATE TABLE `tblroles` (
  `Id` mediumint(3) NOT NULL,
  `Description` varchar(250) NOT NULL,
  `is_Active` bit(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblstudent`
--

INSERT INTO `tblstudent` (`id`, `firstName`, `lastName`, `regNo`, `dob`, `age`, `email`, `gender`, `contactNumber`, `deptid`, `semester`, `year`, `batch`, `fatherName`, `fatherContact`, `motherName`, `motherContect`, `aadharNumber`, `community`, `religion`, `addressLine1`, `addressLine2`, `city`, `pincode`, `state`, `nationality`) VALUES
(2, 'Selvaganapthi', 'A', '22PCA039', '2002-03-17', 22, '22pca039@rmv.ac.in', 'male', '9655120081', 4, 'III', 'II', '2023-2025', 'A', '9784563201', 'M', '9655820084', '123498768521', 'nill', 'nill', 'abc', 'xyz', 'CBE', '641001', 'TN', 'India'),
(3, 'Bharathidhasan', 'R', '22PCA009', '2002-05-05', 22, '22pca009@rmv.ac.in', 'male', '9632587410', 4, 'III', 'II', '2022-2024', 'R', '9632587410', 'M', '8978456512', '789456321023', 'nill', 'nill', 'mmm', 'yyy', 'Sivaganga', '641005', 'TN', 'India'),
(4, 'Arunagiri', 'M', '22PCA006', '2001-12-28', 21, '22pca006@rmv.ac.in', 'male', '9345582334', 4, 'III', 'II', '2022-2024', 'A.Manickavelu', '9095748976', 'K.Victroiya', '9360154497', '395628702750', 'MBC', 'hindu', '102,Mariyamnan Kovil Street', 'Killkangeyam Kuppam', 'Panruti', '607805', 'Tamilnadu', 'India'),
(5, 'Jawaharsrinath', 'G', '22PCA017', '1998-05-05', 25, '22pca017@rmv.ac.in', 'male', '9345993004', 4, 'III', 'II', '2022-2024', 'N.Govindarajan', '9632587410', 'G.Nenuga', '9632587451', '852207419630', 'nill', 'hindu', '12,north street', 'kangai konda cholapuram', 'Thanjavoor', '685214', 'Tamil nadu', 'India'),
(6, 'Balaji', 'A', '19UIT001', '2002-01-01', 17, 'onbalaji@gmail.com', 'male', '9876543210', 1, 'I', 'I', '2019-2022', 'Appa', '9876543210', 'Amma', '9876543210', '123456789012', 'nill', 'nill', '01/04, North street', 'Aruppukottai', 'Viruthunagar', '626001', 'Tamil Nadu', 'India'),
(7, 'Balamurugan', 'A', '19UIT002', '2002-01-01', 17, 'balamuruganit@gmail.com', 'male', '9876543210', 1, 'I', 'I', '2019-2022', 'Appa', '9876543210', 'Amma', '9876543210', '1234567890098', 'nill', 'nill', '01/03, midile  street', 'Rasipuram', 'Namakkal', '637001', 'Tamil Nadu', 'India'),
(8, 'Balamurugan', 'M', '19UIT003', '2002-01-01', 17, 'balamuruganitm@gmail.com', 'male', '9876543210', 1, 'I', 'I', '2019-2022', 'Appa', '9876543210', 'Amma', '9876543210', '6781234590098', 'nill', 'nill', '01/04,North street', 'GNMills', 'Coimbatore', '641001', 'Tamil Nadu', 'India'),
(9, 'Bharathidhasan', 'R', '19UIT004', '2002-01-01', 17, 'kannabharathi2244@gmail.com', 'male', '9876543210', 1, 'I', 'I', '2019-2022', 'Appa', '9876543210', 'Amma', '9876543210', '9009812345678', 'nill', 'nill', '01/03, kadani', 'Thayamankalam', 'Sivagangai', '630561', 'Tamil Nadu', 'India'),
(10, 'Chinnakannu', 'N', '19UIT005', '2002-01-01', 19, 'smalleye@gmail.com', 'male', '9876543210', 1, 'I', 'I', '2019-2022', 'Appa', '9876543210', 'Amma', '9876543210', '341256789012', 'nill', 'nill', '09/08 North street', 'Ganapathi', 'Coimbatore', '641001', 'Tamil Nadu', 'India'),
(11, 'Dayananthan', 'A', '19UIT006', '2000-01-17', 19, 'dhaya@gmail.com', 'male', '9876543210', 1, 'I', 'I', '2019-2022', 'Appa', '9876543210', 'Amma', '9876543210', '987654321034', 'nill', 'nill', '23,part street,', 'cummbum', 'Theni', '625900', 'Tamil Nadu', 'India'),
(12, 'Hariharan', 'A', '19UIT007', '2002-01-01', 17, 'hari@gmail.com', 'male', '9087653412', 1, 'I', 'I', '2019-2022', 'Appa', '9087653412', 'Amma', '9087653412', '908765341290', 'nill', 'nill', '31/4,vadakku theru', 'oottandipuram', 'Coimbatore', '641001', 'Tamil Nadu', 'India');

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
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblusers`
--

INSERT INTO `tblusers` (`Id`, `EmpId`, `username`, `password`, `email`, `fullname`, `phone`, `gender`, `dob`, `age`, `doj`, `dor`, `roleId`, `deptid`) VALUES
(1, 'DEV_01', 'admin', 'MTIzNDU2Nzg=', 'admin@rmv.ac.in', 'admin', '9655120081', 'male', '1990-03-17', 33, '2023-06-01', '0000-00-00', 1, 4),
(2, 'PCA_01', 'dinesh', 'MTIzNDU2Nzg=', 'dineshkumar@gmail.in', 'Dineshkumar', '9632587410', 'male', '1980-01-01', 43, '2021-01-01', '0000-00-00', 2, 4),
(3, 'UCA_02', 'chandhiran', 'MTIzNDU2Nzg=', 'chandhiran@rmv.ac.in', 'Chandhiran', '9894316150', 'male', '1980-01-01', 43, '2007-01-10', '0000-00-00', 2, 3),
(4, 'UIT_01', 'kamaraj', 'MTIzNDU2Nzg=', 'kamaraj@rmv.ac.in', 'Kamaraj', '9942080458', 'male', '1980-01-01', 43, '2007-01-01', '0000-00-00', 3, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblattendance`
--
ALTER TABLE `tblattendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblcourse`
--
ALTER TABLE `tblcourse`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `courseCode` (`courseCode`);

--
-- Indexes for table `tbldayattendance`
--
ALTER TABLE `tbldayattendance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbldepartment`
--
ALTER TABLE `tbldepartment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbllateattendance`
--
ALTER TABLE `tbllateattendance`
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
-- AUTO_INCREMENT for table `tblattendance`
--
ALTER TABLE `tblattendance`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `tblcourse`
--
ALTER TABLE `tblcourse`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `tbldayattendance`
--
ALTER TABLE `tbldayattendance`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tbldepartment`
--
ALTER TABLE `tbldepartment`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `tbllateattendance`
--
ALTER TABLE `tbllateattendance`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tblroles`
--
ALTER TABLE `tblroles`
  MODIFY `Id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblstudent`
--
ALTER TABLE `tblstudent`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `tbltimetable`
--
ALTER TABLE `tbltimetable`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tblusers`
--
ALTER TABLE `tblusers`
  MODIFY `Id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;