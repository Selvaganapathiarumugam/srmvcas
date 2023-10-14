
DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Sp_FinalInternalReportUG` (IN `p_deptid` INT, IN `p_Year` VARCHAR(255), IN `p_Semester` VARCHAR(255), IN `p_CourseCode` VARCHAR(255))   BEGIN
    DECLARE dynamicColumns TEXT;
    DECLARE dynamicColumns2 TEXT;
    DECLARE rowNumber INT DEFAULT 1; -- Initialize the row number
    
    SET SESSION group_concat_max_len = 1000000;
    
    SET @sql_dynamicColumns = (
        SELECT GROUP_CONCAT(DISTINCT
            CONCAT(
                'MAX(CASE WHEN im.ExamCode = ''',
                Code,
                ''' THEN IFNULL(im.CurrentMark, 0) END) AS Code', rowNumber
            )
        )
        FROM tblinternalexam
        WHERE Type = 'PG'
    );
    
    SET @sql_dynamicColumns2 = (
        SELECT GROUP_CONCAT(DISTINCT
            CONCAT(
                'MAX(CASE WHEN im.ExamCode = ''',
                Code,
                ''' THEN IFNULL(im.FinalMark, 0) END) AS T', rowNumber
            )
        )
        FROM tblinternalexam
        WHERE Type = 'PG'
    );
    
    SET @sql = CONCAT('
        SELECT  im.CourseCode,im.Id,im.Semester,im.Year, im.RegNo,d.dname,c.courseName,
        ', @sql_dynamicColumns, ', ', @sql_dynamicColumns2, '
        FROM tblinternalmarks im
        inner join tbldepartment d on im.deptid=d.id
        inner join tblcourse c on im.CourseCode=c.courseCode
        WHERE im.deptid = ', p_deptid, '
            AND im.Year = ''', p_Year, '''
            AND im.Semester = ''', p_Semester, '''
            AND im.CourseCode = ''', p_CourseCode, '''
        GROUP BY im.RegNo
    ');
    
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tblattendance`
--

CREATE TABLE `tblattendance` (
  `id` int(10) NOT NULL,
  `Staffid` varchar(50) NOT NULL,
  `regno` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `DayOrder` mediumint(2) NOT NULL,
  `subjectHour` mediumint(2) NOT NULL,
  `IsAbsent` tinyint(3) NOT NULL DEFAULT 0,
  `CourseTaught` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblcourse`
--

CREATE TABLE `tblcourse` (
  `id` mediumint(3) NOT NULL,
  `deptId` mediumint(3) NOT NULL,
  `year` varchar(3) NOT NULL,
  `semester` varchar(3) NOT NULL,
  `courseName` varchar(150) NOT NULL,
  `courseCode` varchar(20) NOT NULL,
  `AcadamicYear` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
(11, 1, 'I', 'I', 'English - 1', '20UIT1EN01', '2023'),
(12, 1, 'I', 'I', 'PC Software', '20UIT1C02', '2023'),
(13, 4, 'II', 'III', 'Windows Application Development', '22PCA3C08', '2023'),
(14, 4, 'II', 'III', 'Data Science using R', '22PCA3C09', '2023'),
(15, 4, 'II', 'III', 'Open Source Application Development with Android', '22PCA3EB2', '2023');

-- --------------------------------------------------------

--
-- Table structure for table `tbldayattendance`
--

CREATE TABLE `tbldayattendance` (
  `id` int(10) NOT NULL,
  `deptId` mediumint(3) NOT NULL,
  `staffId` varchar(50) NOT NULL,
  `semester` varchar(3) NOT NULL,
  `year` varchar(3) NOT NULL,
  `regno` varchar(20) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbldepartment`
--

CREATE TABLE `tbldepartment` (
  `id` mediumint(3) NOT NULL,
  `dname` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
(7, 'B.COM CA'),
(8, 'PGDCA'),
(9, 'Physical Education');

-- --------------------------------------------------------

--
-- Table structure for table `tblinternalexam`
--

CREATE TABLE `tblinternalexam` (
  `Code` varchar(30) NOT NULL,
  `CreatedBy` varchar(50) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Type` varchar(4) NOT NULL,
  `Maxmark` mediumint(3) NOT NULL,
  `Convertmark` mediumint(3) NOT NULL,
  `Year` varchar(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblinternalexam`
--

INSERT INTO `tblinternalexam` (`Code`, `CreatedBy`, `Name`, `Type`, `Maxmark`, `Convertmark`, `Year`) VALUES
('EX01', 'DEV_01', 'CIA01', 'PG', 45, 15, 'II'),
('EX02', 'DEV_01', 'CIA-UG', 'UG', 45, 15, 'II'),
('EX03', 'DEV_01', 'Model', 'PG', 75, 20, 'II'),
('EX04', 'DEV_01', 'Seminar', 'PG', 10, 10, 'II'),
('EX05', 'DEV_01', 'Attendence', 'PG', 5, 5, 'II');

-- --------------------------------------------------------

--
-- Table structure for table `tblinternalmarks`
--

CREATE TABLE `tblinternalmarks` (
  `Id` int(10) NOT NULL,
  `ExamCode` varchar(30) NOT NULL,
  `DeptId` mediumint(3) NOT NULL,
  `RegNo` varchar(10) NOT NULL,
  `Semester` varchar(4) NOT NULL,
  `Year` varchar(4) NOT NULL,
  `CourseCode` varchar(20) NOT NULL,
  `CurrentMark` mediumint(3) NOT NULL,
  `FinalMark` varchar(3) NOT NULL,
  `CreatedBy` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblinternalmarks`
--

INSERT INTO `tblinternalmarks` (`Id`, `ExamCode`, `DeptId`, `RegNo`, `Semester`, `Year`, `CourseCode`, `CurrentMark`, `FinalMark`, `CreatedBy`) VALUES
(1, 'EX01', 4, '22PCA001', 'III', 'II', '22PCA3C08', 40, '13', 'DEV_01'),
(2, 'EX01', 4, '22PCA002', 'III', 'II', '22PCA3C08', 40, '13', 'DEV_01'),
(3, 'EX01', 4, '22PCA003', 'III', 'II', '22PCA3C08', 40, '13', 'DEV_01'),
(4, 'EX01', 4, '22PCA004', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(5, 'EX01', 4, '22PCA005', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(6, 'EX01', 4, '22PCA006', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(7, 'EX01', 4, '22PCA007', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(8, 'EX01', 4, '22PCA008', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(9, 'EX01', 4, '22PCA009', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(10, 'EX01', 4, '22PCA010', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(11, 'EX01', 4, '22PCA011', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(12, 'EX01', 4, '22PCA012', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(13, 'EX01', 4, '22PCA013', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(14, 'EX01', 4, '22PCA014', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(15, 'EX01', 4, '22PCA015', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(16, 'EX01', 4, '22PCA016', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(17, 'EX01', 4, '22PCA017', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(18, 'EX01', 4, '22PCA018', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(19, 'EX01', 4, '22PCA019', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(20, 'EX01', 4, '22PCA020', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(21, 'EX01', 4, '22PCA021', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(22, 'EX01', 4, '22PCA022', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(23, 'EX01', 4, '22PCA023', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(24, 'EX01', 4, '22PCA024', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(25, 'EX01', 4, '22PCA025', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(26, 'EX01', 4, '22PCA026', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(27, 'EX01', 4, '22PCA027', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(28, 'EX01', 4, '22PCA028', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(29, 'EX01', 4, '22PCA029', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(30, 'EX01', 4, '22PCA030', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(31, 'EX01', 4, '22PCA031', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(32, 'EX01', 4, '22PCA032', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(33, 'EX01', 4, '22PCA033', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(34, 'EX01', 4, '22PCA034', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(35, 'EX01', 4, '22PCA035', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(36, 'EX01', 4, '22PCA036', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(37, 'EX01', 4, '22PCA037', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(38, 'EX01', 4, '22PCA038', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(39, 'EX01', 4, '22PCA039', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(40, 'EX01', 4, '22PCA040', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(41, 'EX01', 4, '22PCA041', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(42, 'EX01', 4, '22PCA042', 'III', 'II', '22PCA3C08', 45, '15', 'DEV_01'),
(43, 'EX01', 4, '22PCA043', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(44, 'EX01', 4, '22PCA044', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(45, 'EX01', 4, '22PCA045', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(46, 'EX01', 4, '22PCA046', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(47, 'EX01', 4, '22PCA047', 'III', 'II', '22PCA3C08', 35, '12', 'DEV_01'),
(48, 'EX01', 4, '22PCA048', 'III', 'II', '22PCA3C08', 30, '10', 'DEV_01'),
(49, 'EX01', 4, '22PCA049', 'III', 'II', '22PCA3C08', 30, '10', 'DEV_01'),
(50, 'EX01', 4, '22PCA050', 'III', 'II', '22PCA3C08', 30, '10', 'DEV_01');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tblroles`
--

CREATE TABLE `tblroles` (
  `Id` mediumint(3) NOT NULL,
  `Description` varchar(250) NOT NULL,
  `is_Active` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
  `deptid` mediumint(3) NOT NULL,
  `firstName` varchar(250) NOT NULL,
  `lastName` varchar(250) DEFAULT NULL,
  `regNo` varchar(10) NOT NULL,
  `dob` date DEFAULT NULL,
  `age` mediumint(2) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `gender` varchar(10) NOT NULL DEFAULT 'male',
  `contactNumber` varchar(15) DEFAULT NULL,
  `semester` varchar(3) NOT NULL,
  `year` varchar(3) NOT NULL,
  `batch` varchar(20) DEFAULT NULL,
  `fatherName` varchar(255) DEFAULT NULL,
  `fatherContact` varchar(20) DEFAULT NULL,
  `motherName` varchar(255) DEFAULT NULL,
  `motherContect` varchar(20) DEFAULT NULL,
  `aadharNumber` varchar(25) DEFAULT NULL,
  `community` varchar(10) NOT NULL DEFAULT 'nill',
  `religion` varchar(100) NOT NULL DEFAULT 'nill',
  `addressLine1` varchar(255) DEFAULT NULL,
  `addressLine2` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `pincode` varchar(10) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `nationality` varchar(255) NOT NULL DEFAULT 'India'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblstudent`
--

INSERT INTO `tblstudent` (`id`, `deptid`, `firstName`, `lastName`, `regNo`, `dob`, `age`, `email`, `gender`, `contactNumber`, `semester`, `year`, `batch`, `fatherName`, `fatherContact`, `motherName`, `motherContect`, `aadharNumber`, `community`, `religion`, `addressLine1`, `addressLine2`, `city`, `pincode`, `state`, `nationality`) VALUES
(1, 8, 'AJITH.R', NULL, '21PGDC01', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(2, 8, 'ASHWIN R', NULL, '21PGDC02', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(3, 8, 'ASWIN SRIRAM R', NULL, '21PGDC03', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(4, 8, 'BALAMURUGAN P', NULL, '21PGDC04', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(5, 8, 'CLARISON CHINNADURAI M', NULL, '21PGDC05', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(6, 8, 'DEEPAK KUMAR K', NULL, '21PGDC06', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(7, 8, 'DEVAKUMARAN S', NULL, '21PGDC07', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(8, 8, 'GNANAVEL.T', NULL, '21PGDC08', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(9, 8, 'GOKUL G', NULL, '21PGDC09', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(10, 8, 'HARISH PANDIAN K', NULL, '21PGDC10', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(11, 8, 'JAIKRISHNA R', NULL, '21PGDC11', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(12, 8, 'JEEVAN PRASANTH J', NULL, '21PGDC12', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(13, 8, 'JENAGARAJ S', NULL, '21PGDC13', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(14, 8, 'KAVIN.G', NULL, '21PGDC14', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(15, 8, 'MAHADEVAN A', NULL, '21PGDC15', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(16, 8, 'MAHESH RAJKUMAR  V', NULL, '21PGDC16', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(17, 8, 'MANIKANDAPRABU R', NULL, '21PGDC17', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(18, 8, 'MOHANKUMAR.P', NULL, '21PGDC18', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(19, 8, 'MURUGAN. N', NULL, '21PGDC19', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(20, 8, 'NANDHAPRASADH.K', NULL, '21PGDC20', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(21, 8, 'NITESH P', NULL, '21PGDC21', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(22, 8, 'NITHYANANATH V', NULL, '21PGDC22', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(23, 8, 'PRADEEP KUMAR.Y', NULL, '21PGDC23', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(24, 8, 'PRADEESH.J', NULL, '21PGDC24', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(25, 8, 'RANJITHKUMAR.R', NULL, '21PGDC25', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(26, 8, 'SARAVANARAJ.SS', NULL, '21PGDC26', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(27, 8, 'SASIKUMAR S', NULL, '21PGDC27', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(28, 8, 'SATHYAPRANESH.A', NULL, '21PGDC28', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(29, 8, 'SUSEENDIRAN C', NULL, '21PGDC29', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(30, 8, 'T R. SHRIRAM', NULL, '21PGDC30', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(31, 8, 'THARUNPRASATH M', NULL, '21PGDC31', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(32, 8, 'VINOL BENEDIC P', NULL, '21PGDC32', NULL, NULL, NULL, 'male', NULL, 'II', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(33, 3, 'ABINESH B', NULL, '21UCA001', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(34, 3, 'AMEET KUMAR A', NULL, '21UCA002', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(35, 3, 'ARAVINDKUMAR S', NULL, '21UCA003', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(36, 3, 'ARUN BABU K P', NULL, '21UCA004', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(37, 3, 'BARATH V', NULL, '21UCA005', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(38, 3, 'DEEPAK S', NULL, '21UCA006', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(39, 3, 'DEEPAN K', NULL, '21UCA007', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(40, 3, 'DHAMODHARAN G', NULL, '21UCA008', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(41, 3, 'DIVAKARAN G', NULL, '21UCA009', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(42, 3, 'DIWAKAR T K', NULL, '21UCA010', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(43, 3, 'GOKUL DHAS M S', NULL, '21UCA012', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(44, 3, 'GURU SHARAN S', NULL, '21UCA013', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(45, 3, 'HARIHARAN R', NULL, '21UCA014', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(46, 3, 'JAYASURYA K', NULL, '21UCA015', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(47, 3, 'KAAMESH C', NULL, '21UCA016', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(48, 3, 'KABIRESH R', NULL, '21UCA017', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(49, 3, 'KANISH R', NULL, '21UCA018', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(50, 3, 'KARTHICK B', NULL, '21UCA019', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(51, 3, 'KARTHICKEYAN N', NULL, '21UCA020', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(52, 3, 'KARTHIKEYAN P', NULL, '21UCA021', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(53, 3, 'KAVIN S V', NULL, '21UCA022', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(54, 3, 'KRISHNAKANTH V', NULL, '21UCA023', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(55, 3, 'KUMARAVEL V', NULL, '21UCA024', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(56, 3, 'LALITPRAVIN P S', NULL, '21UCA025', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(57, 3, 'MANOJKUMAR M', NULL, '21UCA026', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(58, 3, 'MUKESHBABU G', NULL, '21UCA027', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(59, 3, 'NANTHAKUMAR S', NULL, '21UCA028', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(60, 3, 'NISWAN S', NULL, '21UCA029', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(61, 3, 'PAVISH M R', NULL, '21UCA030', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(62, 3, 'PRANESH R', NULL, '21UCA031', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(63, 3, 'PRATEEK C S', NULL, '21UCA032', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(64, 3, 'PREMKUMAR G', NULL, '21UCA033', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(65, 3, 'PRINCE PRABU R', NULL, '21UCA034', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(66, 3, 'RANIL M', NULL, '21UCA035', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(67, 3, 'ROHITH A', NULL, '21UCA036', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(68, 3, 'SABARI M', NULL, '21UCA037', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(69, 3, 'SABARINATHAN S', NULL, '21UCA038', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(70, 3, 'SAI RISHI A', NULL, '21UCA039', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(71, 3, 'SANJAY S', NULL, '21UCA040', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(72, 3, 'SANTHOSH KUMAR R', NULL, '21UCA041', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(73, 3, 'SARVESHWARAN M', NULL, '21UCA042', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(74, 3, 'SHAKIR AHAMED S', NULL, '21UCA043', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(75, 3, 'SIVARAMAKRISHNAN R', NULL, '21UCA044', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(76, 3, 'SRIDHAR R', NULL, '21UCA045', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(77, 3, 'SRIHARI R', NULL, '21UCA046', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(78, 3, 'SYED ABUTHAHIR T', NULL, '21UCA047', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(79, 3, 'TARUN N', NULL, '21UCA048', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(80, 3, 'THAMIL MANI V', NULL, '21UCA049', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(81, 3, 'THANUSH K', NULL, '21UCA050', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(82, 7, 'ABISAKE J', NULL, '21UCC001', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(83, 7, 'ABISHEK KANNAN G', NULL, '21UCC002', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(84, 7, 'AJAY S', NULL, '21UCC003', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(85, 7, 'ANANDA KRISHNAN D', NULL, '21UCC004', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(86, 7, 'ARAVINTHAN R', NULL, '21UCC005', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(87, 7, 'ASWATH B', NULL, '21UCC006', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(88, 7, 'ASWIN R', NULL, '21UCC007', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(89, 7, 'BALAMURUGAN J', NULL, '21UCC008', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(90, 7, 'BISWAJIT DAS B', NULL, '21UCC009', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(91, 7, 'BUVANESH S', NULL, '21UCC010', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(92, 7, 'DEEPAK R', NULL, '21UCC011', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(93, 7, 'DHARSHAN S', NULL, '21UCC012', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(94, 7, 'DHINAKARAN S', NULL, '21UCC013', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(95, 7, 'GUHAN S', NULL, '21UCC014', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(96, 7, 'HARSHAVARDHAN R', NULL, '21UCC015', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(97, 7, 'JAGANATHAN D', NULL, '21UCC016', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(98, 7, 'KAMALESH G', NULL, '21UCC017', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(99, 7, 'KOWSHIK G', NULL, '21UCC018', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(100, 7, 'LINGARAJ R', NULL, '21UCC019', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(101, 7, 'MANICKARAJA G', NULL, '21UCC020', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(102, 7, 'MARUTHU S', NULL, '21UCC021', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(103, 7, 'MITHUNRAJ M', NULL, '21UCC022', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(104, 7, 'MOHANA SUNDARAM G S', NULL, '21UCC023', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(105, 7, 'MURUGADOSS  K', NULL, '21UCC024', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(106, 7, 'NARESH R', NULL, '21UCC025', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(107, 7, 'NITHEESH D V', NULL, '21UCC026', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(108, 7, 'NITHISH V', NULL, '21UCC027', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(109, 7, 'PRASANTH M', NULL, '21UCC028', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(110, 7, 'RADHA KRISHNAN G', NULL, '21UCC029', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(111, 7, 'RAGURAM K', NULL, '21UCC030', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(112, 7, 'RITHICK K', NULL, '21UCC031', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(113, 7, 'SAJIN C', NULL, '21UCC032', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(114, 7, 'SAKTHIVEL M', NULL, '21UCC033', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(115, 7, 'SANJITH S', NULL, '21UCC034', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(116, 7, 'SARVESH R', NULL, '21UCC035', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(117, 7, 'SIBI RAM V S', NULL, '21UCC036', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(118, 7, 'SIDDHARTH R', NULL, '21UCC037', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(119, 7, 'SRI RAM R', NULL, '21UCC038', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(120, 7, 'SRIDHAR S', NULL, '21UCC039', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(121, 7, 'SUJITH K', NULL, '21UCC040', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(122, 7, 'SURENDRAN R', NULL, '21UCC041', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(123, 7, 'VARUN VIGNESH B', NULL, '21UCC042', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(124, 7, 'VIGNESH M', NULL, '21UCC043', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(125, 7, 'VIJAY S K', NULL, '21UCC044', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(126, 7, 'VIJAYAKUMAR S S', NULL, '21UCC045', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(127, 7, 'VINOTHKUMAR M', NULL, '21UCC046', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(128, 7, 'VISHNU D', NULL, '21UCC047', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(129, 7, 'YADAV K N', NULL, '21UCC048', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(130, 7, 'YASWANTH I J', NULL, '21UCC049', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(131, 7, 'YUVA PRASATH S', NULL, '21UCC050', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(132, 7, 'ANUSHAK N', NULL, '21UCC051', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(133, 7, 'AKASH A', NULL, '21UCC052', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(134, 7, 'M ARUN PRASAD', NULL, '21UCC053', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(135, 7, 'ASHWIN S', NULL, '21UCC054', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(136, 7, 'BALASAKTHI AVINASH K', NULL, '21UCC055', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(137, 7, 'CHELLADURAI G', NULL, '21UCC056', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(138, 7, 'DHANUSH K', NULL, '21UCC057', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(139, 7, 'DHEGAUMBARESH B V', NULL, '21UCC058', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(140, 7, 'DINESH K', NULL, '21UCC059', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(141, 7, 'EDWARD FRANCIS S', NULL, '21UCC060', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(142, 7, 'HAREESH A', NULL, '21UCC061', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(143, 7, 'JAGADISH M', NULL, '21UCC062', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(144, 7, 'JEYAKRISHNAN N', NULL, '21UCC063', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(145, 7, 'KATHIRESHKUMAR R', NULL, '21UCC064', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(146, 7, 'LOKESH M', NULL, '21UCC065', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(147, 7, 'MANISH', NULL, '21UCC066', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(148, 7, 'MANOJ S', NULL, '21UCC067', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(149, 7, 'MITHUN K', NULL, '21UCC068', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(150, 7, 'MOHAMMED SUHAIL A', NULL, '21UCC069', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(151, 7, 'MOURIAN M', NULL, '21UCC070', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(152, 7, 'MURUGAVEL H', NULL, '21UCC071', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(153, 7, 'NAGULAN T', NULL, '21UCC072', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(154, 7, 'NAVEENKUMAR V', NULL, '21UCC073', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(155, 7, 'NITHISH KUMAR G', NULL, '21UCC074', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(156, 7, 'PRABHAKARAN K', NULL, '21UCC075', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(157, 7, 'PRANESH S', NULL, '21UCC076', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(158, 7, 'PRAVEEN ADITYA P', NULL, '21UCC077', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(159, 7, 'RAGUPATHI N', NULL, '21UCC078', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(160, 7, 'RAHUL S', NULL, '21UCC079', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(161, 7, 'RAKSHITH A P', NULL, '21UCC080', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(162, 7, 'ROHITH S', NULL, '21UCC081', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(163, 7, 'SAKTHINATHAN R', NULL, '21UCC082', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(164, 7, 'SANJAY KRISHNAN M', NULL, '21UCC083', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(165, 7, 'SARAVANABALAN V S', NULL, '21UCC084', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(166, 7, 'SELVAYOKESH P', NULL, '21UCC085', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(167, 7, 'SHANMUGAM P', NULL, '21UCC086', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(168, 7, 'SOLAIPANDIYAN K', NULL, '21UCC087', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(169, 7, 'SREE NATH K', NULL, '21UCC088', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(170, 7, 'SUGIRTHAN J', NULL, '21UCC089', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(171, 7, 'SUNIL KUMAR N', NULL, '21UCC090', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(172, 7, 'SURYA S', NULL, '21UCC091', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(173, 7, 'VASANTH S', NULL, '21UCC092', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(174, 7, 'JEEVANANTHAM R', NULL, '21UCC093', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(175, 7, 'MUKESH R', NULL, '21UCC094', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(176, 7, 'SHADAGOPAN M V', NULL, '21UCC095', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(177, 5, 'ADHAVAN S', NULL, '21UCM001', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(178, 5, 'AGASH P', NULL, '21UCM002', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(179, 5, 'ANBARASU S', NULL, '21UCM003', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(180, 5, 'AVINASH S', NULL, '21UCM004', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(181, 5, 'BARANIDHARAN R', NULL, '21UCM005', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(182, 5, 'BHARATH KUMAR S A', NULL, '21UCM007', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(183, 5, 'CHANDRADITHYAN M', NULL, '21UCM008', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(184, 5, 'CIBI CHAKRAVARTHI R', NULL, '21UCM009', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(185, 5, 'DARMENDRA K S', NULL, '21UCM010', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(186, 5, 'DEEPAN A M', NULL, '21UCM011', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(187, 5, 'DHARANIBALAN S', NULL, '21UCM012', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(188, 5, 'DHAYAN K', NULL, '21UCM013', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(189, 5, 'DHULASI RAM T S', NULL, '21UCM014', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(190, 5, 'DINESH KUMAR S', NULL, '21UCM015', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(191, 5, 'DIVAKAR S', NULL, '21UCM016', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(192, 5, 'DRAVIDGANESH E', NULL, '21UCM017', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(193, 5, 'ESAIAMUDHAN S', NULL, '21UCM018', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(194, 5, 'GANESH G', NULL, '21UCM019', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(195, 5, 'GNANASATHRUKNAN G', NULL, '21UCM020', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(196, 5, 'GOKUL VASU V', NULL, '21UCM021', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(197, 5, 'HARISH A', NULL, '21UCM022', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(198, 5, 'JAGADEESH KUMAR S', NULL, '21UCM023', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(199, 5, 'JASWANTH M', NULL, '21UCM024', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(200, 5, 'KARTHIKEYAN R', NULL, '21UCM025', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(201, 5, 'KATHIRESH V', NULL, '21UCM026', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(202, 5, 'KIRAN M S', NULL, '21UCM027', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(203, 5, 'KURALARASAN K', NULL, '21UCM028', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(204, 5, 'MANIKANDAN M', NULL, '21UCM029', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(205, 5, 'NAMASIVAYAM N', NULL, '21UCM030', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(206, 5, 'NANDHA KUMAR S', NULL, '21UCM031', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(207, 5, 'NANDHISHWARAN R', NULL, '21UCM032', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(208, 5, 'NITHISH KUMAR M', NULL, '21UCM033', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(209, 5, 'PRADEEP KUMAR P', NULL, '21UCM034', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(210, 5, 'PRASANTH K V', NULL, '21UCM035', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(211, 5, 'PRAVIN KUMAR A', NULL, '21UCM036', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(212, 5, 'RAM KUMAR S', NULL, '21UCM037', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(213, 5, 'SANTHOSHKUMAR S', NULL, '21UCM038', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(214, 5, 'SHYAM PRASATH M', NULL, '21UCM039', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(215, 5, 'SRI DHARAN M', NULL, '21UCM040', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(216, 5, 'SRI RAMANAN K', NULL, '21UCM041', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(217, 5, 'SRIJAYAGOPAN R', NULL, '21UCM042', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(218, 5, 'SURENDRAN M', NULL, '21UCM043', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(219, 5, 'SWAMINATHAN NA', NULL, '21UCM044', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(220, 5, 'THIYAGAVINOTHAN T', NULL, '21UCM045', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(221, 5, 'UTHAYAKUMAR I', NULL, '21UCM046', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(222, 5, 'VARUN PRASAD V R', NULL, '21UCM047', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(223, 5, 'VASANTHARAJAN G S', NULL, '21UCM048', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(224, 5, 'VIKRAMRAJU S', NULL, '21UCM049', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(225, 5, 'VISHAL K', NULL, '21UCM050', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(226, 5, 'AATHAVAN M', NULL, '21UCM051', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(227, 5, 'ACHUTHAN V', NULL, '21UCM052', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(228, 5, 'ASHWIN RAJA B', NULL, '21UCM053', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(229, 5, 'ASWIN K', NULL, '21UCM054', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(230, 5, 'BALASUBRAMANIAN CT', NULL, '21UCM055', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(231, 5, 'DANIEL RUBUS M', NULL, '21UCM056', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(232, 5, 'DEVANSH SHAKTI', NULL, '21UCM057', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(233, 5, 'DHANUSH S M', NULL, '21UCM058', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(234, 5, 'DINESH R', NULL, '21UCM059', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(235, 5, 'DINESHKUMAR S', NULL, '21UCM060', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(236, 5, 'ELAMURUGAN N', NULL, '21UCM061', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(237, 5, 'GOKUL J B', NULL, '21UCM062', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(238, 5, 'GOWTHAM D', NULL, '21UCM063', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(239, 5, 'GOWTHAM M', NULL, '21UCM064', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(240, 5, 'HARIHARAN M D R', NULL, '21UCM065', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(241, 5, 'HARISH R', NULL, '21UCM066', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(242, 5, 'JAYANTH U', NULL, '21UCM067', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(243, 5, 'KETAN APPASO KAMBLE', NULL, '21UCM068', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(244, 5, 'KUMARAVEL A', NULL, '21UCM069', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(245, 5, 'MIDHUN SAJEESH G', NULL, '21UCM070', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(246, 5, 'MOHAN KARTHICK M', NULL, '21UCM071', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(247, 5, 'NARENDRAKUMAR B', NULL, '21UCM072', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(248, 5, 'NATARAJLAKSHMAN V', NULL, '21UCM073', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(249, 5, 'NIRANJAN V', NULL, '21UCM074', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(250, 5, 'RAGU V L', NULL, '21UCM075', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(251, 5, 'RAMANUJAM A B', NULL, '21UCM076', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(252, 5, 'SANJAY K', NULL, '21UCM077', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(253, 5, 'SANJAY K', NULL, '21UCM078', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(254, 5, 'SANJAYKUMAR G', NULL, '21UCM079', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(255, 5, 'SARAN PRAKESH S', NULL, '21UCM080', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(256, 5, 'SRINIVAS G B', NULL, '21UCM081', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(257, 5, 'SRIVENKATESAN P', NULL, '21UCM082', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(258, 5, 'SUMAN N', NULL, '21UCM083', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(259, 5, 'SURIAKANDH T S', NULL, '21UCM084', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(260, 5, 'VARUN M', NULL, '21UCM085', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(261, 5, 'VIJAYA NATHAN P', NULL, '21UCM086', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(262, 5, 'VIKAS T V', NULL, '21UCM087', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(263, 5, 'VIKASH NANDHAN M', NULL, '21UCM088', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(264, 5, 'VIKASH U', NULL, '21UCM089', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(265, 5, 'VIKESH P S', NULL, '21UCM090', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(266, 5, 'VINOTH R', NULL, '21UCM091', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(267, 5, 'VISHVA C', NULL, '21UCM092', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(268, 5, 'VISWAK RASWANTH T', NULL, '21UCM093', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(269, 5, 'RISHABH S', NULL, '21UCM094', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India');
INSERT INTO `tblstudent` (`id`, `deptid`, `firstName`, `lastName`, `regNo`, `dob`, `age`, `email`, `gender`, `contactNumber`, `semester`, `year`, `batch`, `fatherName`, `fatherContact`, `motherName`, `motherContect`, `aadharNumber`, `community`, `religion`, `addressLine1`, `addressLine2`, `city`, `pincode`, `state`, `nationality`) VALUES
(270, 1, 'AKILESH P', NULL, '21UIT001', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(271, 1, 'DINESH KUMAR S', NULL, '21UIT002', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(272, 1, 'GOKULAKUMARAN P', NULL, '21UIT003', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(273, 1, 'GOWRISHANKAR P', NULL, '21UIT004', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(274, 1, 'INBARAJ S', NULL, '21UIT005', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(275, 1, 'JEGATHESH K', NULL, '21UIT006', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(276, 1, 'KALAIVANAN U', NULL, '21UIT007', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(277, 1, 'KAVIBHARATHI S', NULL, '21UIT008', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(278, 1, 'KISHORE S', NULL, '21UIT009', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(279, 1, 'MANOVA R', NULL, '21UIT010', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(280, 1, 'MOWLEESWARAN G V', NULL, '21UIT011', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(281, 1, 'PRASANNAKUMAR P', NULL, '21UIT012', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(282, 1, 'PRASANNAKUMAR S', NULL, '21UIT013', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(283, 1, 'RAGESH H', NULL, '21UIT014', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(284, 1, 'SARAN C V', NULL, '21UIT015', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(285, 1, 'SHALOM DANIEL U', NULL, '21UIT016', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(286, 1, 'SHANTHOSH S', NULL, '21UIT017', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(287, 1, 'SRIDHAR S', NULL, '21UIT019', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(288, 1, 'SRIRAM V', NULL, '21UIT020', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(289, 1, 'VENKATESAN P', NULL, '21UIT021', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(290, 1, 'VENKATESHWARAN L', NULL, '21UIT022', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(291, 6, 'DASARATH BALAJI K', NULL, '21UPA001', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(292, 6, 'DEEPAK  S', NULL, '21UPA002', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(293, 6, 'DHANUSH R', NULL, '21UPA003', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(294, 6, 'DHANUSH S G', NULL, '21UPA004', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(295, 6, 'GOKUL G M', NULL, '21UPA005', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(296, 6, 'HARISH K', NULL, '21UPA007', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(297, 6, 'KALYAN S', NULL, '21UPA008', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(298, 6, 'KUMAR D', NULL, '21UPA010', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(299, 6, 'KUMARAN R', NULL, '21UPA011', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(300, 6, 'LOGESHWARAN S', NULL, '21UPA012', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(301, 6, 'MOHANARAVINTH S M', NULL, '21UPA013', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(302, 6, 'MONISH K', NULL, '21UPA014', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(303, 6, 'MONISH S', NULL, '21UPA015', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(304, 6, 'MOUNISHWARAN M', NULL, '21UPA016', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(305, 6, 'NAVEEN KUMAR R', NULL, '21UPA017', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(306, 6, 'NAVEEN V', NULL, '21UPA018', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(307, 6, 'NAVEEN KUMAR B', NULL, '21UPA019', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(308, 6, 'POOVARASAN M', NULL, '21UPA020', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(309, 6, 'RAHUL G', NULL, '21UPA021', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(310, 6, 'RAHUL T', NULL, '21UPA022', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(311, 6, 'RANGA SUDHARSAN T', NULL, '21UPA023', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(312, 6, 'SANTHOSH KUMAR  R', NULL, '21UPA024', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(313, 6, 'SARATHI KRISHNA  S', NULL, '21UPA025', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(314, 6, 'SHYAM VARSHAN D', NULL, '21UPA026', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(315, 6, 'SIBIRAJ R', NULL, '21UPA027', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(316, 6, 'SIVA KUMAR B', NULL, '21UPA028', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(317, 6, 'SREEPATHI R', NULL, '21UPA029', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(318, 6, 'SREEYASH M R', NULL, '21UPA030', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(319, 6, 'SRI SHYAM GANESH S', NULL, '21UPA031', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(320, 6, 'SRINATH B', NULL, '21UPA032', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(321, 6, 'SUDHARSAN V', NULL, '21UPA033', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(322, 6, 'SURIYA B', NULL, '21UPA034', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(323, 6, 'TAMILARASAN V', NULL, '21UPA035', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(324, 6, 'VISHNU M', NULL, '21UPA036', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(325, 6, 'YOGESH  BA', NULL, '21UPA037', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(326, 6, 'YUVARAJ I', NULL, '21UPA038', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(327, 6, 'YUVARAJ R', NULL, '21UPA039', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(328, 9, 'S ABILASH', NULL, '21UPE001', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(329, 9, 'AKASH V', NULL, '21UPE002', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(330, 9, 'ARAVINTHAN B', NULL, '21UPE003', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(331, 9, 'ASHWIN D', NULL, '21UPE004', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(332, 9, 'DHANUSH S', NULL, '21UPE005', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(333, 9, 'DINESHRAJ R', NULL, '21UPE006', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(334, 9, 'DIWAKARAN P', NULL, '21UPE007', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(335, 9, 'ELAKIYAN S', NULL, '21UPE008', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(336, 9, 'GOPINATH N', NULL, '21UPE009', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(337, 9, 'GOWTHAM C', NULL, '21UPE010', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(338, 9, 'GURUSATH P', NULL, '21UPE011', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(339, 9, 'HARISHDEEPAK B', NULL, '21UPE012', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(340, 9, 'HARISH H S', NULL, '21UPE013', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(341, 9, 'INBAKUMAR C', NULL, '21UPE014', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(342, 9, 'JERIN. J', NULL, '21UPE015', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(343, 9, 'KARTHIKEYAN S', NULL, '21UPE016', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(344, 9, 'KAVIYARASAN M', NULL, '21UPE017', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(345, 9, 'KEBIN INFANT D', NULL, '21UPE018', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(346, 9, 'MANIKANDAN S', NULL, '21UPE019', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(347, 9, 'MANIKANDAN S', NULL, '21UPE020', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(348, 9, 'NAGESUWARAN T', NULL, '21UPE021', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(349, 9, 'NIKHIL S', NULL, '21UPE022', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(350, 9, 'NISHANTHVARMA R', NULL, '21UPE023', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(351, 9, 'PRADEEP S', NULL, '21UPE024', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(352, 9, 'PREMKUMAR R', NULL, '21UPE025', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(353, 9, 'RITHIK M', NULL, '21UPE026', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(354, 9, 'SABARINATHAN S', NULL, '21UPE027', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(355, 9, 'SHARAN G', NULL, '21UPE028', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(356, 9, 'SHRI HARI K', NULL, '21UPE029', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(357, 9, 'SRI BALAJI K', NULL, '21UPE030', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(358, 9, 'SRI LAKSHMANAN V', NULL, '21UPE031', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(359, 9, 'SUGENDRAN D', NULL, '21UPE032', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(360, 9, 'SUNDARESAN J M', NULL, '21UPE033', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(361, 9, 'THULASI S', NULL, '21UPE034', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(362, 9, 'UDIT NARAYAN V', NULL, '21UPE035', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(363, 9, 'UTHAYAKUMAR R', NULL, '21UPE036', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(364, 9, 'VELUSAMY S', NULL, '21UPE037', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(365, 9, 'VENKATESHWARAN P', NULL, '21UPE038', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(366, 9, 'VIGNESH E', NULL, '21UPE039', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(367, 9, 'VIJAY C', NULL, '21UPE040', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(368, 9, 'STEPHEN PRAKASH P', NULL, '21UPE041', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(369, 2, 'ABISWARAN M', NULL, '21USC001', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(370, 2, 'AJAYKUMAR M', NULL, '21USC002', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(371, 2, 'BHUVANESH M', NULL, '21USC003', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(372, 2, 'BOOBALAN S', NULL, '21USC004', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(373, 2, 'DEEPAK M', NULL, '21USC005', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(374, 2, 'GIRISANTH C', NULL, '21USC006', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(375, 2, 'GOKUL G', NULL, '21USC007', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(376, 2, 'GUNA M', NULL, '21USC008', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(377, 2, 'HARIBHASKER B', NULL, '21USC009', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(378, 2, 'KATHIRAVAN R', NULL, '21USC010', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(379, 2, 'KAVIN KUMAR K', NULL, '21USC011', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(380, 2, 'LOGABALAJI J', NULL, '21USC012', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(381, 2, 'MADESH R', NULL, '21USC013', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(382, 2, 'MUGUNDHAN S', NULL, '21USC014', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(383, 2, 'NAVEEN KUMAR V', NULL, '21USC015', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(384, 2, 'PRADEEP D', NULL, '21USC016', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(385, 2, 'PRAVEEN P', NULL, '21USC017', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(386, 2, 'SABARI S', NULL, '21USC018', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(387, 2, 'SANJAY R', NULL, '21USC019', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(388, 2, 'SARAN P', NULL, '21USC020', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(389, 2, 'SELVABALA T', NULL, '21USC021', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(390, 2, 'SRI BHARATH M', NULL, '21USC023', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(391, 2, 'SUDHARSAN P', NULL, '21USC024', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(392, 2, 'SUVIN K', NULL, '21USC025', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(393, 2, 'VASANTHA KUMAR M', NULL, '21USC026', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(394, 2, 'VIJAY PA', NULL, '21USC027', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(395, 2, 'VIKNESH T', NULL, '21USC028', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(396, 2, 'VISHAAL RAO', NULL, '21USC029', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(397, 2, 'VIVEKANANDHAN S', NULL, '21USC030', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(398, 2, 'YOGESHWARAN P', NULL, '21USC031', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(399, 2, 'ARUNKARTHICK S', NULL, '21USC032', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(400, 2, 'SARAN G', NULL, '21USC033', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(401, 2, 'SANKARANARAYANAN T', NULL, '21USC034', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(402, 2, 'S SANJAY KUMAR', NULL, '21USC035', NULL, NULL, NULL, 'male', NULL, 'V', 'III', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(403, 4, 'AAKASH R', NULL, '22PCA001', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(404, 4, 'AKASH P.T', NULL, '22PCA002', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(405, 4, 'ALAGU SUNDARA VEL A', NULL, '22PCA003', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(406, 4, 'ARAVIND G', NULL, '22PCA004', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(407, 4, 'ARUN PRASATH G', NULL, '22PCA005', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(408, 4, 'ARUNAGIRI M', NULL, '22PCA006', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(409, 4, 'ARUNKUMAR UT', NULL, '22PCA007', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(410, 4, 'BALAMURUGAN A', NULL, '22PCA008', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(411, 4, 'BHARATHIDHASAN R', NULL, '22PCA009', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(412, 4, 'DINESH K', NULL, '22PCA010', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(413, 4, 'DINESHKUMAR M', NULL, '22PCA011', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(414, 4, 'GOVARTHANAN NA', NULL, '22PCA012', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(415, 4, 'HARESH U', NULL, '22PCA013', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(416, 4, 'HARIKRISHNAN A', NULL, '22PCA014', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(417, 4, 'HARISH GHANTH V N', NULL, '22PCA015', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(418, 4, 'HARISH SUBBIAH R', NULL, '22PCA016', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(419, 4, 'JAWAHARSRINATH G', NULL, '22PCA017', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(420, 4, 'KANISH S', NULL, '22PCA018', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(421, 4, 'KARTHIKEYAN D', NULL, '22PCA019', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(422, 4, 'KAVEEN N', NULL, '22PCA020', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(423, 4, 'KUMARESAN V', NULL, '22PCA021', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(424, 4, 'LOGESHWAR S', NULL, '22PCA022', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(425, 4, 'MAHESHKUMAR S', NULL, '22PCA023', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(426, 4, 'MARIMUTHU N', NULL, '22PCA024', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(427, 4, 'MUNUSAMY A', NULL, '22PCA025', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(428, 4, 'MUTHUSELVAN S', NULL, '22PCA026', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(429, 4, 'NANDHAKUMAR E', NULL, '22PCA027', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(430, 4, 'NAVEEN K', NULL, '22PCA028', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(431, 4, 'NAVEEN S', NULL, '22PCA029', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(432, 4, 'NAVINKUMAR M', NULL, '22PCA030', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(433, 4, 'NISHANTH K', NULL, '22PCA031', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(434, 4, 'PARATHESH H', NULL, '22PCA032', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(435, 4, 'PRADHEEP G', NULL, '22PCA033', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(436, 4, 'RAHUL S', NULL, '22PCA034', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(437, 4, 'RAMKUMAR M', NULL, '22PCA035', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(438, 4, 'RANJITH C', NULL, '22PCA036', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(439, 4, 'SAKTHIVEL V', NULL, '22PCA037', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(440, 4, 'SHARANESH B L', NULL, '22PCA038', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(441, 4, 'SELVA GANAPATHI', 'A', '22PCA039', '2002-03-17', 21, '22pca039@rmv.ac.in', 'male', '9655120081', 'III', 'II', '2022-2024', 'Arumugam', 'Muthulakshmi', '9786292684', '9626316074', '000000000000', 'BC', 'hindu', '31/4,NorthStreet,Karisalpatty', 'Old kannivadi(Po),Aathor (Tk)', 'Dindigul', '624705', 'Tamil Nadu', 'India'),
(442, 4, 'SERAN T', NULL, '22PCA040', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(443, 4, 'SESAN K', NULL, '22PCA041', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(444, 4, 'SHARMA V', NULL, '22PCA042', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(445, 4, 'SIVASANKARAN K', NULL, '22PCA043', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(446, 4, 'SOWNDAR A', NULL, '22PCA044', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(447, 4, 'SUGREEV S T', NULL, '22PCA045', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(448, 4, 'VENKATESH S', NULL, '22PCA046', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(449, 4, 'YOGARAJ M', NULL, '22PCA047', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(450, 4, 'YOGESH S', NULL, '22PCA048', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(451, 4, 'YOGESHWARAN S', NULL, '22PCA049', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(452, 4, 'YUVA PRASATH S', NULL, '22PCA050', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(453, 8, 'ARUN PRASATH', NULL, '22PGDC01', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(454, 8, 'ASWANTH M R', NULL, '22PGDC02', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(455, 8, 'ASWIN V', NULL, '22PGDC03', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(456, 8, 'FAROUK BASHA S', NULL, '22PGDC04', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(457, 8, 'GOWTHAM M', NULL, '22PGDC05', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(458, 8, 'LOGESH S', NULL, '22PGDC06', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(459, 8, 'MULLAISARAN S', NULL, '22PGDC07', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(460, 8, 'NATRAJ E', NULL, '22PGDC08', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(461, 8, 'NIRMAL RAJ U', NULL, '22PGDC09', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(462, 8, 'NITHISH J R', NULL, '22PGDC10', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(463, 8, 'PRAKASH KUMAR K', NULL, '22PGDC11', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(464, 8, 'RAMKUMAR S', NULL, '22PGDC12', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(465, 8, 'SARATHKUMARAN S', NULL, '22PGDC13', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(466, 8, 'SIBHICHAKRAVARTHI R', NULL, '22PGDC14', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(467, 8, 'SRIHARIHARAN A', NULL, '22PGDC15', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(468, 8, 'TAMIL SELVAN S', NULL, '22PGDC16', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(469, 8, 'TIRUPATHI A', NULL, '22PGDC17', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(470, 8, 'VIJAY L', NULL, '22PGDC18', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(471, 3, 'ABISHEK S', NULL, '22UCA001', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(472, 3, 'ABISHEK T C S', NULL, '22UCA002', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(473, 3, 'ADITHYA DEV P', NULL, '22UCA003', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(474, 3, 'ALWIN A', NULL, '22UCA004', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(475, 3, 'ANBARASAN M', NULL, '22UCA005', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(476, 3, 'ANBARASAN S', NULL, '22UCA006', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(477, 3, 'ARAVIND SP', NULL, '22UCA007', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(478, 3, 'ARAVINTHA RAJ N', NULL, '22UCA008', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(479, 3, 'ASWANTH R', NULL, '22UCA009', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(480, 3, 'BASKARAN L', NULL, '22UCA010', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(481, 3, 'BATHMANATHAN G', NULL, '22UCA011', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(482, 3, 'BOOPATHI G', NULL, '22UCA012', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(483, 3, 'BOOPESH P', NULL, '22UCA013', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(484, 3, 'DHINESHKUMAR P G', NULL, '22UCA014', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(485, 3, 'GOWDHAM A', NULL, '22UCA015', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(486, 3, 'HARI S', NULL, '22UCA016', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(487, 3, 'HARIKUMAR R', NULL, '22UCA017', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(488, 3, 'HEMNATH S', NULL, '22UCA018', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(489, 3, 'JEEVANESH S G', NULL, '22UCA019', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(490, 3, 'KAMALESHRAJA G', NULL, '22UCA020', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(491, 3, 'KANISH R', NULL, '22UCA021', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(492, 3, 'KARUPPUSAMY S', NULL, '22UCA022', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(493, 3, 'KADHIRAVAN N', NULL, '22UCA023', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(494, 3, 'KAVIN R', NULL, '22UCA024', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(495, 3, 'KIRUBAKARAN S', NULL, '22UCA025', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(496, 3, 'LOGESH A', NULL, '22UCA026', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(497, 3, 'MADHAVAN P', NULL, '22UCA027', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(498, 3, 'MUKESH M', NULL, '22UCA028', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(499, 3, 'NANDAKRISHNA G S', NULL, '22UCA029', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(500, 3, 'NAVANEETHA KRISHNAN A', NULL, '22UCA030', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(501, 3, 'PRANESH B', NULL, '22UCA031', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(502, 3, 'PREMNATH S', NULL, '22UCA032', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(503, 3, 'PRIYAK S', NULL, '22UCA033', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(504, 3, 'PUGALENTHI K', NULL, '22UCA034', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(505, 3, 'RAJ KUMAR K', NULL, '22UCA035', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(506, 3, 'RAVIPRASANTH M', NULL, '22UCA036', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(507, 3, 'SAKTHITHAR S', NULL, '22UCA037', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(508, 3, 'SANJU S', NULL, '22UCA038', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(509, 3, 'SANTHOSHKUMAR V', NULL, '22UCA039', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(510, 3, 'SARAVANAN S', NULL, '22UCA040', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(511, 3, 'SHANANDH AADHITHYA S', NULL, '22UCA041', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(512, 3, 'SRIDHARAN.P', NULL, '22UCA042', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(513, 3, 'SUJITH T', NULL, '22UCA043', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(514, 3, 'SUNDARAPANDI S', NULL, '22UCA044', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(515, 3, 'SURESH KUMAR R', NULL, '22UCA045', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(516, 3, 'THANGAMATHAVAN A', NULL, '22UCA046', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(517, 3, 'THARUN D', NULL, '22UCA047', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(518, 3, 'VARUN R', NULL, '22UCA048', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(519, 3, 'VISWANATH S', NULL, '22UCA049', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(520, 7, 'AATHI SRI V', NULL, '22UCC001', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(521, 7, 'ABISHEK K', NULL, '22UCC002', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(522, 7, 'AJAY D', NULL, '22UCC003', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(523, 7, 'AKASH R', NULL, '22UCC004', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(524, 7, 'ANBUSELVAN B', NULL, '22UCC005', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(525, 7, 'ARUNACHALAM B', NULL, '22UCC006', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(526, 7, 'ASWIN S', NULL, '22UCC007', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(527, 7, 'BALAJI S', NULL, '22UCC008', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(528, 7, 'CHIDANANDA B', NULL, '22UCC009', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(529, 7, 'DEVABALA T', NULL, '22UCC010', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(530, 7, 'EDWIN S', NULL, '22UCC011', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(531, 7, 'GOKUL B', NULL, '22UCC012', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(532, 7, 'GOKUL KRISHNAN B', NULL, '22UCC013', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(533, 7, 'GOWTHAM J', NULL, '22UCC014', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(534, 7, 'GURU G', NULL, '22UCC015', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(535, 7, 'HARIKARAN P', NULL, '22UCC016', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(536, 7, 'HARISH K', NULL, '22UCC017', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(537, 7, 'HARIVATHSAN R', NULL, '22UCC018', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India');
INSERT INTO `tblstudent` (`id`, `deptid`, `firstName`, `lastName`, `regNo`, `dob`, `age`, `email`, `gender`, `contactNumber`, `semester`, `year`, `batch`, `fatherName`, `fatherContact`, `motherName`, `motherContect`, `aadharNumber`, `community`, `religion`, `addressLine1`, `addressLine2`, `city`, `pincode`, `state`, `nationality`) VALUES
(538, 7, 'JALAGANDESWARAN V', NULL, '22UCC019', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(539, 7, 'JAYANTHAN R', NULL, '22UCC020', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(540, 7, 'KAMALESH R', NULL, '22UCC021', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(541, 7, 'LEOREX A', NULL, '22UCC022', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(542, 7, 'MALLEESWARAN K', NULL, '22UCC023', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(543, 7, 'MOHAN M', NULL, '22UCC024', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(544, 7, 'MONESH JEYANTH S', NULL, '22UCC025', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(545, 7, 'MUGUNTHAN B', NULL, '22UCC026', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(546, 7, 'PARAMA SIVA R', NULL, '22UCC027', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(547, 7, 'R PARATH KANNAN', NULL, '22UCC028', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(548, 7, 'PRANESH R', NULL, '22UCC029', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(549, 7, 'RAJA N', NULL, '22UCC030', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(550, 7, 'RAJ GANESH M', NULL, '22UCC031', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(551, 7, 'RISHI M', NULL, '22UCC032', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(552, 7, 'SACHIN A', NULL, '22UCC033', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(553, 7, 'SAKTHI S', NULL, '22UCC034', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(554, 7, 'SANJAY A P', NULL, '22UCC035', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(555, 7, 'SANJAY R', NULL, '22UCC036', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(556, 7, 'SANJAY S', NULL, '22UCC037', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(557, 7, 'M SANTHOSH BALAJI', NULL, '22UCC038', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(558, 7, 'SANTHOSHKUMAR V', NULL, '22UCC039', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(559, 7, 'SARAVANAKUMAR R', NULL, '22UCC040', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(560, 7, 'SARAVANAN G', NULL, '22UCC041', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(561, 7, 'SARAVANAN K', NULL, '22UCC042', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(562, 7, 'SEENIARAFATH A M', NULL, '22UCC043', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(563, 7, 'SELVASURYA S S', NULL, '22UCC044', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(564, 7, 'SIVA A', NULL, '22UCC045', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(565, 7, 'SRIHARIPRASAD N', NULL, '22UCC046', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(566, 7, 'SURYAPRAKASH S', NULL, '22UCC047', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(567, 7, 'SURYA VARSHAN S', NULL, '22UCC048', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(568, 7, 'THAVAMANI N', NULL, '22UCC049', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(569, 7, 'VISHAL PRANAV U S', NULL, '22UCC050', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(570, 7, 'ABHIJITH S', NULL, '22UCC051', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(571, 7, 'ABISHEK M', NULL, '22UCC052', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(572, 7, 'AKASH D', NULL, '22UCC053', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(573, 7, 'AMITH KUMAR I', NULL, '22UCC054', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(574, 7, 'ARAVIN B', NULL, '22UCC055', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(575, 7, 'ASWIN KUMAR P', NULL, '22UCC056', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(576, 7, 'ASWIN R', NULL, '22UCC057', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(577, 7, 'BHARATH HARISH R', NULL, '22UCC058', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(578, 7, 'DEENU MADESH P', NULL, '22UCC059', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(579, 7, 'DHIVYAPRAKASH G', NULL, '22UCC060', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(580, 7, 'GOKUL B', NULL, '22UCC061', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(581, 7, 'HARIPRASANTH S', NULL, '22UCC062', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(582, 7, 'HARIHARAN G', NULL, '22UCC063', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(583, 7, 'IYAPPAN.S', NULL, '22UCC064', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(584, 7, 'JAYARAM P', NULL, '22UCC065', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(585, 7, 'JEYAKUMAR R', NULL, '22UCC066', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(586, 7, 'KARAN G', NULL, '22UCC067', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(587, 7, 'KARTHI R', NULL, '22UCC068', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(588, 7, 'KASINAGARAJ K', NULL, '22UCC069', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(589, 7, 'KISHORE M', NULL, '22UCC070', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(590, 7, 'MADESH A', NULL, '22UCC071', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(591, 7, 'MANOJ PRABHAKAR J', NULL, '22UCC072', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(592, 7, 'MOHANRAJ S', NULL, '22UCC073', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(593, 7, 'MOKESHWARAN R', NULL, '22UCC074', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(594, 7, 'MUKESH K', NULL, '22UCC075', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(595, 7, 'PAVILESH R', NULL, '22UCC076', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(596, 7, 'PRANAV T', NULL, '22UCC077', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(597, 7, 'RENISH K', NULL, '22UCC078', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(598, 7, 'RISHI R', NULL, '22UCC079', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(599, 7, 'ROHITH T', NULL, '22UCC080', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(600, 7, 'SAIAKASH A', NULL, '22UCC081', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(601, 7, 'SANTHOSHKUMAR M', NULL, '22UCC082', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(602, 7, 'S SREE SASTHA', NULL, '22UCC083', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(603, 7, 'SURYAPRAKASH S', NULL, '22UCC084', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(604, 7, 'TAMILARASU R', NULL, '22UCC085', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(605, 7, 'YASWANTH R', NULL, '22UCC086', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(606, 5, 'ADITHYA S', NULL, '22UCM001', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(607, 5, 'ADITHYAN D', NULL, '22UCM002', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(608, 5, 'AKASH VARMA R S', NULL, '22UCM003', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(609, 5, 'AMAL A', NULL, '22UCM004', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(610, 5, 'ANANTHA NARAYANAN B', NULL, '22UCM005', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(611, 5, 'ARUN KUMAR P', NULL, '22UCM006', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(612, 5, 'ARUNACHALAM S', NULL, '22UCM007', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(613, 5, 'BHARANIDHARAN P', NULL, '22UCM008', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(614, 5, 'BHARANI PRASATH N', NULL, '22UCM009', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(615, 5, 'CHANJAI E J', NULL, '22UCM010', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(616, 5, 'DURAIMURUGAN K', NULL, '22UCM011', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(617, 5, 'EZEKIEL EBRONE P', NULL, '22UCM012', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(618, 5, 'GOKHUL S', NULL, '22UCM013', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(619, 5, 'GOKULAVARSHAN V', NULL, '22UCM014', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(620, 5, 'GURUNATH P V', NULL, '22UCM015', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(621, 5, 'HARI P', NULL, '22UCM016', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(622, 5, 'HARI PRASATH A', NULL, '22UCM017', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(623, 5, 'HARIBHARATHI J', NULL, '22UCM018', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(624, 5, 'HARIHARRAJ V', NULL, '22UCM019', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(625, 5, 'HARISH S', NULL, '22UCM020', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(626, 5, 'KARTHIKEYAN M', NULL, '22UCM021', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(627, 5, 'KARUPPICHINATHAN N', NULL, '22UCM022', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(628, 5, 'KAVIN KUMAR A', NULL, '22UCM023', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(629, 5, 'S.KEERTHIVASAN', NULL, '22UCM024', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(630, 5, 'MANIKANDAN R', NULL, '22UCM025', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(631, 5, 'MOHAN N', NULL, '22UCM026', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(632, 5, 'NAGARAJ K', NULL, '22UCM027', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(633, 5, 'NANDHA KUMAR T', NULL, '22UCM028', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(634, 5, 'NAVEENRAJA K', NULL, '22UCM029', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(635, 5, 'PARAMESHWARAN M', NULL, '22UCM030', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(636, 5, 'POOVENDIRAN T', NULL, '22UCM031', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(637, 5, 'PRAKASH T', NULL, '22UCM032', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(638, 5, 'PRATHAP K', NULL, '22UCM033', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(639, 5, 'RAGURAMAN L', NULL, '22UCM034', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(640, 5, 'RAHUL P', NULL, '22UCM035', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(641, 5, 'RITHIKRAJ S', NULL, '22UCM036', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(642, 5, 'SARAN K B', NULL, '22UCM037', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(643, 5, 'SELVA K', NULL, '22UCM038', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(644, 5, 'SHARAN R J', NULL, '22UCM039', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(645, 5, 'SHARVESH K A', NULL, '22UCM040', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(646, 5, 'SIVA M', NULL, '22UCM041', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(647, 5, 'SRIRAM R', NULL, '22UCM042', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(648, 5, 'SRI SANTHARAM A', NULL, '22UCM043', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(649, 5, 'SRIDHRAN M', NULL, '22UCM044', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(650, 5, 'SRINIVASAN K', NULL, '22UCM045', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(651, 5, 'SUBRAMANIAM K', NULL, '22UCM046', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(652, 5, 'SUNDAR T', NULL, '22UCM047', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(653, 5, 'SURIYAA D', NULL, '22UCM048', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(654, 5, 'TAMILARASAN S', NULL, '22UCM049', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(655, 5, 'THENAMUDHAN C', NULL, '22UCM050', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(656, 5, 'VENISHKUMAR S', NULL, '22UCM051', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(657, 5, 'VIGNESH N', NULL, '22UCM052', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(658, 5, 'VIGNESHWARAN T', NULL, '22UCM053', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(659, 5, 'VISHAL E', NULL, '22UCM054', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(660, 5, 'VISHAL K', NULL, '22UCM055', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(661, 5, 'VISHAL KARTHIK R', NULL, '22UCM056', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(662, 5, 'VISSVA S', NULL, '22UCM057', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(663, 5, 'DIVAKAR B', NULL, '22UCM058', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(664, 1, 'AADHI  M', NULL, '22UIT001', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(665, 1, 'ABDUL HAKKEEM  R', NULL, '22UIT002', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(666, 1, 'AJITHKUMAR  S A', NULL, '22UIT003', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(667, 1, 'AKSHAY  M', NULL, '22UIT004', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(668, 1, 'AMARNATH  S', NULL, '22UIT005', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(669, 1, 'BARATH  S', NULL, '22UIT006', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(670, 1, 'DEEPAK A', NULL, '22UIT007', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(671, 1, 'DHANUSH  R', NULL, '22UIT008', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(672, 1, 'DHARSHAN  B', NULL, '22UIT009', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(673, 1, 'DHARSIN KANNA  M', NULL, '22UIT010', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(674, 1, 'GNANAPRAKASH  P', NULL, '22UIT011', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(675, 1, 'GOKULKANNAN  M', NULL, '22UIT012', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(676, 1, 'GOKULRAJ  M S', NULL, '22UIT013', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(677, 1, 'GOWTHAM M', NULL, '22UIT014', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(678, 1, 'GURUMOORTHY  B', NULL, '22UIT015', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(679, 1, 'HASFACK AHAMED H', NULL, '22UIT016', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(680, 1, 'JAISURIYA  D', NULL, '22UIT017', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(681, 1, 'JAYAPRAKASH  S', NULL, '22UIT018', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(682, 1, 'KEERTHIK  M', NULL, '22UIT019', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(683, 1, 'KIRTHIK ROSHAN  M', NULL, '22UIT020', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(684, 1, 'LAKSHMANAN  S', NULL, '22UIT021', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(685, 1, 'MADHU SUDHANAN  C', NULL, '22UIT022', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(686, 1, 'MANIKANDAN  B', NULL, '22UIT023', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(687, 1, 'MOHAMADHU SHEIK NOOR A', NULL, '22UIT024', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(688, 1, 'MOHAMMED FAZIL  M', NULL, '22UIT025', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(689, 1, 'MOHANBABU  V', NULL, '22UIT026', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(690, 1, 'MUKESH  J', NULL, '22UIT027', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(691, 1, 'NAVEEN  K', NULL, '22UIT028', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(692, 1, 'NISHATH  S', NULL, '22UIT029', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(693, 1, 'NITHIN  S', NULL, '22UIT030', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(694, 1, 'PRAVEEN  R', NULL, '22UIT031', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(695, 1, 'RAHUL  M', NULL, '22UIT032', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(696, 1, 'RAMAN  S', NULL, '22UIT033', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(697, 1, 'ROHAN GANESH G', NULL, '22UIT034', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(698, 1, 'ROHITH  A', NULL, '22UIT035', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(699, 1, 'ROSHAN JEREMIAH  J', NULL, '22UIT036', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(700, 1, 'SABITH  A', NULL, '22UIT037', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(701, 1, 'SANTHOSHKUMAR P', NULL, '22UIT038', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(702, 1, 'SELVAM  M', NULL, '22UIT039', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(703, 1, 'SHIVANATHAN K R', NULL, '22UIT040', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(704, 1, 'SRIRAM   G S', NULL, '22UIT041', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(705, 1, 'SRIRAM  B', NULL, '22UIT042', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(706, 1, 'SUBI  C', NULL, '22UIT043', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(707, 1, 'SURENDAR  J', NULL, '22UIT044', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(708, 1, 'SURYANARAYANAN G', NULL, '22UIT045', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(709, 1, 'THANGADURAI   T', NULL, '22UIT046', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(710, 1, 'VIJAYASOORIYA   V K', NULL, '22UIT047', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(711, 1, 'YESHVIN   M', NULL, '22UIT048', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(712, 1, 'SYAM KAMALESH J', NULL, '22UIT049', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(713, 1, 'SRIVATHSAN M', NULL, '22UIT050', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(714, 6, 'AANANDA PRASAN J', NULL, '22UPA001', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(715, 6, 'AJAI SANKAR K S', NULL, '22UPA002', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(716, 6, 'AJAY PRASATH N', NULL, '22UPA003', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(717, 6, 'ANIRUDH S', NULL, '22UPA004', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(718, 6, 'ARAVINTH K', NULL, '22UPA005', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(719, 6, 'S BARANI THARAN', NULL, '22UPA006', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(720, 6, 'DHARSHAN CHENAPPA V K', NULL, '22UPA007', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(721, 6, 'DINESH V', NULL, '22UPA008', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(722, 6, 'GOKUL P', NULL, '22UPA009', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(723, 6, 'GOKULRAJ K S', NULL, '22UPA010', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(724, 6, 'S GOPAL', NULL, '22UPA011', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(725, 6, 'HARIPRASATH V R', NULL, '22UPA012', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(726, 6, 'INDHESHWARA G', NULL, '22UPA013', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(727, 6, 'JITHU DHANUK T', NULL, '22UPA014', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(728, 6, 'KAMALESH V S', NULL, '22UPA015', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(729, 6, 'KISHORE KUMAR S R', NULL, '22UPA016', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(730, 6, 'KOWSHICK S', NULL, '22UPA017', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(731, 6, 'MADHAN KUMAR N', NULL, '22UPA018', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(732, 6, 'MURALIKRISHNA R M', NULL, '22UPA019', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(733, 6, 'NAVIN M', NULL, '22UPA020', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(734, 6, 'PRADEEP S', NULL, '22UPA021', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(735, 6, 'PRITHVIN C V', NULL, '22UPA022', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(736, 6, 'RAKESH ABINAV R', NULL, '22UPA023', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(737, 6, 'RAVI SHANKAR N', NULL, '22UPA024', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(738, 6, 'RIDHEEB B', NULL, '22UPA025', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(739, 6, 'SABARINATH K', NULL, '22UPA026', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(740, 6, 'SACHIN S', NULL, '22UPA027', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(741, 6, 'SANTHOSH KUMAR B', NULL, '22UPA028', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(742, 6, 'SASITHARAN K', NULL, '22UPA029', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(743, 6, 'SATHEESKUMAR S', NULL, '22UPA030', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(744, 6, 'SIBIDHARAN B', NULL, '22UPA031', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(745, 6, 'SIVAGURU T', NULL, '22UPA032', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(746, 6, 'SYED AASHIQ S', NULL, '22UPA033', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(747, 6, 'THARUN V P', NULL, '22UPA034', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(748, 6, 'VIGNESH S', NULL, '22UPA035', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(749, 6, 'VIGNESH S', NULL, '22UPA036', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(750, 9, 'AARIYAN A', NULL, '22UPE001', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(751, 9, 'ADIDEVA M', NULL, '22UPE002', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(752, 9, 'AKASH V', NULL, '22UPE003', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(753, 9, 'CHINNADURAI M', NULL, '22UPE004', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(754, 9, 'N GOKULRAJ (CBSC)', NULL, '22UPE005', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(755, 9, 'GOVINTHASAMY V', NULL, '22UPE006', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(756, 9, 'LOGESWARAN T', NULL, '22UPE007', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(757, 9, 'LOKESHWARAN R', NULL, '22UPE008', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(758, 9, 'MARUTHI PRASATH G', NULL, '22UPE009', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(759, 9, 'MOHAMED MUSTHAFA S', NULL, '22UPE010', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(760, 9, 'NIVIN HARIGARAN K', NULL, '22UPE011', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(761, 9, 'PRADEESH C', NULL, '22UPE012', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(762, 9, 'PRAVEENKUMAR B', NULL, '22UPE013', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(763, 9, 'RAGUL V', NULL, '22UPE014', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(764, 9, 'RAMACHANDRAN P', NULL, '22UPE015', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(765, 9, 'RAMKUMAR P', NULL, '22UPE016', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(766, 9, 'K S SAI PUNITH (CBSC)', NULL, '22UPE017', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(767, 9, 'SAKTHINISHANTH C', NULL, '22UPE018', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(768, 9, 'SANJAY KANTH D', NULL, '22UPE019', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(769, 9, 'SARAVANAN G', NULL, '22UPE020', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(770, 9, 'SATHYA PRIYAN M', NULL, '22UPE021', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(771, 9, 'VEERARAGAVAN V', NULL, '22UPE022', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(772, 9, 'VENGATESHWARAN M', NULL, '22UPE023', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(773, 9, 'VISHNUPRASATH V', NULL, '22UPE024', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(774, 2, 'ABISHEK M', NULL, '22USC001', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(775, 2, 'AHIL R', NULL, '22USC002', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(776, 2, 'AJITH AGARKAR B', NULL, '22USC003', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(777, 2, 'AKASH P', NULL, '22USC004', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(778, 2, 'AKSHAY VARUN A', NULL, '22USC005', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(779, 2, 'ARAVIND M', NULL, '22USC006', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(780, 2, 'ARAVINTH M', NULL, '22USC007', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(781, 2, 'ASWATH SOORYA P V', NULL, '22USC008', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(782, 2, 'DHANUSH C', NULL, '22USC009', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(783, 2, 'DHARSHAN S', NULL, '22USC010', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(784, 2, 'DHILIP V', NULL, '22USC011', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(785, 2, 'DINESH A', NULL, '22USC012', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(786, 2, 'GOKUL C', NULL, '22USC013', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(787, 2, 'GUNALAN C', NULL, '22USC014', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(788, 2, 'HARIHARAN D', NULL, '22USC015', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(789, 2, 'HARI KRISHNAN D', NULL, '22USC016', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(790, 2, 'JANARTHANAN S', NULL, '22USC017', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(791, 2, 'JAYASURYA S', NULL, '22USC018', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(792, 2, 'JEKESHWARAN G', NULL, '22USC019', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(793, 2, 'KEERTHIVASAN S', NULL, '22USC020', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(794, 2, 'LAKSHMI NARASIMAN K', NULL, '22USC021', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(795, 2, 'LOGANATH N', NULL, '22USC022', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(796, 2, 'LOKESH R', NULL, '22USC023', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(797, 2, 'LOKESHWARAN K', NULL, '22USC024', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(798, 2, 'MADHANRAJ M', NULL, '22USC025', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(799, 2, 'MAHALINGAM R', NULL, '22USC026', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(800, 2, 'MAHESWARAN A', NULL, '22USC027', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(801, 2, 'MANISKUMAR S', NULL, '22USC028', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(802, 2, 'MANOJ KUMAR M', NULL, '22USC029', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(803, 2, 'NARASIMHAN S', NULL, '22USC030', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(804, 2, 'NAVASAKTHI N', NULL, '22USC031', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India');
INSERT INTO `tblstudent` (`id`, `deptid`, `firstName`, `lastName`, `regNo`, `dob`, `age`, `email`, `gender`, `contactNumber`, `semester`, `year`, `batch`, `fatherName`, `fatherContact`, `motherName`, `motherContect`, `aadharNumber`, `community`, `religion`, `addressLine1`, `addressLine2`, `city`, `pincode`, `state`, `nationality`) VALUES
(805, 2, 'NISHANTH B', NULL, '22USC032', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(806, 2, 'NITHISH A', NULL, '22USC033', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(807, 2, 'NITHISH N S', NULL, '22USC034', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(808, 2, 'NITHISHKUMAR S', NULL, '22USC035', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(809, 2, 'PRITHIVI RAJ K', NULL, '22USC036', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(810, 2, 'RAGURAM M', NULL, '22USC037', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(811, 2, 'RAJATH R VENKITESH', NULL, '22USC038', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(812, 2, 'RAKESH J', NULL, '22USC039', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(813, 2, 'RAVI KUMAR S', NULL, '22USC040', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(814, 2, 'RISHIP M', NULL, '22USC041', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(815, 2, 'ROHITHKUMAR S', NULL, '22USC042', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(816, 2, 'RUTHRESH P', NULL, '22USC043', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(817, 2, 'SANTHANA KRISHNAN B', NULL, '22USC044', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(818, 2, 'SARANKUMAR P', NULL, '22USC045', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(819, 2, 'SIVA S', NULL, '22USC046', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(820, 2, 'SUDHARSAN P', NULL, '22USC047', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(821, 2, 'THARAKESH C R', NULL, '22USC048', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(822, 2, 'YADHISIVAN S R', NULL, '22USC049', NULL, NULL, NULL, 'male', NULL, 'III', 'II', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(823, 3, 'ADHI S', NULL, '23UCA001', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(824, 3, 'AHAMED ABUNIZAR J', NULL, '23UCA002', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(825, 3, 'ANBUDAS S', NULL, '23UCA003', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(826, 3, 'ANISH R', NULL, '23UCA004', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(827, 3, 'ASHARAFUL RIFAS F', NULL, '23UCA005', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(828, 3, 'BHUVANESWARAN S', NULL, '23UCA006', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(829, 3, 'DEEPANRAJ N', NULL, '23UCA007', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(830, 3, 'DHANESH KUMAR R', NULL, '23UCA008', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(831, 3, 'DHARANIDHARAN N', NULL, '23UCA009', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(832, 3, 'EDWARD JONES P', NULL, '23UCA010', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(833, 3, 'GOKUL K', NULL, '23UCA011', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(834, 3, 'HARIHARAN K', NULL, '23UCA012', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(835, 3, 'INIYAN K', NULL, '23UCA013', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(836, 3, 'JAGADESHWARAN S', NULL, '23UCA014', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(837, 3, 'JEEVA PRAVEEN S', NULL, '23UCA015', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(838, 3, 'JUNITH KUMAR M', NULL, '23UCA016', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(839, 3, 'KAMALESH S', NULL, '23UCA017', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(840, 3, 'KARTHIKEYAN E', NULL, '23UCA018', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(841, 3, 'KAVIN KUMAR S', NULL, '23UCA019', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(842, 3, 'LINGESAN S G', NULL, '23UCA020', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(843, 3, 'LOGESHWARAN G', NULL, '23UCA021', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(844, 3, 'MADHAN G', NULL, '23UCA022', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(845, 3, 'MADHAN S', NULL, '23UCA023', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(846, 3, 'MADHANBABU M', NULL, '23UCA024', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(847, 3, 'MANOJ A', NULL, '23UCA025', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(848, 3, 'MUTHU VEL S', NULL, '23UCA026', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(849, 3, 'NAVEEN S', NULL, '23UCA027', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(850, 3, 'PRADEEN K', NULL, '23UCA028', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(851, 3, 'PRADEEP M', NULL, '23UCA029', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(852, 3, 'PRAJIN R', NULL, '23UCA030', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(853, 3, 'PRAKASH RAJ B', NULL, '23UCA031', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(854, 3, 'PRAVEENKUMAR J', NULL, '23UCA032', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(855, 3, 'RAMKISHORE. M', NULL, '23UCA033', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(856, 3, 'SANJAI S', NULL, '23UCA034', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(857, 3, 'SANTHOSH M', NULL, '23UCA035', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(858, 3, 'SANTHOSH S', NULL, '23UCA036', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(859, 3, 'SHANJAI K', NULL, '23UCA037', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(860, 3, 'SHANKAR RAM M', NULL, '23UCA038', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(861, 3, 'SRI RAMANA C', NULL, '23UCA039', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(862, 3, 'SUDEV THAMPI S C', NULL, '23UCA040', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(863, 3, 'SUKRITH.K', NULL, '23UCA041', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(864, 3, 'SWETHAN B', NULL, '23UCA042', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(865, 3, 'THULASI NATHAN M B', NULL, '23UCA043', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(866, 3, 'VIGNESH M', NULL, '23UCA044', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(867, 3, 'VINOTHKUMAR R', NULL, '23UCA045', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(868, 3, 'VISHAL RAJA K R', NULL, '23UCA046', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(869, 3, 'VISHVAHARIHARAN S', NULL, '23UCA047', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(870, 3, 'YADESH P', NULL, '23UCA048', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(871, 3, 'YUVARAJAKUMARAN R', NULL, '23UCA049', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(872, 7, 'ABHIJITH B', NULL, '23UCC001', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(873, 7, 'ABISHEK M', NULL, '23UCC002', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(874, 7, 'ABISHEK V', NULL, '23UCC003', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(875, 7, 'AVINASH S', NULL, '23UCC004', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(876, 7, 'BALAJI M', NULL, '23UCC005', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(877, 7, 'BHARANIVEL G', NULL, '23UCC006', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(878, 7, 'DHINAKAR S', NULL, '23UCC007', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(879, 7, 'GAUTHAMAN VIJAYAKUMAR', NULL, '23UCC008', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(880, 7, 'GOWTHAM G', NULL, '23UCC009', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(881, 7, 'HARISH BALAMURUGAN R', NULL, '23UCC010', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(882, 7, 'HARISH K', NULL, '23UCC011', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(883, 7, 'HEMANTH KUMAR K', NULL, '23UCC012', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(884, 7, 'JAYANTHAN M', NULL, '23UCC013', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(885, 7, 'JAYAPRADHAPAN M', NULL, '23UCC014', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(886, 7, 'KANAKESHWARAN R', NULL, '23UCC015', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(887, 7, 'KANNAN A', NULL, '23UCC016', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(888, 7, 'KARUN M K', NULL, '23UCC017', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(889, 7, 'KOWSHIK H', NULL, '23UCC018', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(890, 7, 'KUMARAN M', NULL, '23UCC019', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(891, 7, 'NITHEEN C', NULL, '23UCC020', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(892, 7, 'PARAMASIVAN T', NULL, '23UCC021', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(893, 7, 'PRAJIN M K', NULL, '23UCC022', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(894, 7, 'PRAVEEN KUMAR T', NULL, '23UCC023', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(895, 7, 'PRAVEEN KUMAR S', NULL, '23UCC024', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(896, 7, 'PUNNIYAN K', NULL, '23UCC025', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(897, 7, 'RAGHUL S', NULL, '23UCC026', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(898, 7, 'RAGUL M', NULL, '23UCC027', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(899, 7, 'ROHESH M R', NULL, '23UCC028', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(900, 7, 'SABAREESH K', NULL, '23UCC029', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(901, 7, 'SAMBATH KUMAR K', NULL, '23UCC030', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(902, 7, 'SANJAI K', NULL, '23UCC031', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(903, 7, 'SANJAY K', NULL, '23UCC032', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(904, 7, 'SANJITH S', NULL, '23UCC033', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(905, 7, 'SANTHOSH KUMAR M', NULL, '23UCC034', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(906, 7, 'SARAVANA K', NULL, '23UCC035', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(907, 7, 'SARAVANAN M', NULL, '23UCC036', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(908, 7, 'SHREEHARI V', NULL, '23UCC037', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(909, 7, 'SHYAM K', NULL, '23UCC038', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(910, 7, 'SUBASH S', NULL, '23UCC039', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(911, 7, 'SUJIN KUMAR M J', NULL, '23UCC040', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(912, 7, 'SUNILKUMAR A', NULL, '23UCC041', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(913, 7, 'SURYA K', NULL, '23UCC042', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(914, 7, 'TAMILARASU V', NULL, '23UCC043', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(915, 7, 'TAMILSELVAN M', NULL, '23UCC044', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(916, 7, 'THULASINATHAN K', NULL, '23UCC045', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(917, 7, 'VIGNESH KUMAR R', NULL, '23UCC046', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(918, 7, 'VIGNESHWARAN J', NULL, '23UCC047', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(919, 7, 'YASHWANTH S', NULL, '23UCC048', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(920, 7, 'YOGESH KARTHIK K', NULL, '23UCC049', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(921, 7, 'YUKESH KRISHNA S', NULL, '23UCC050', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(922, 5, 'ANBARASU P V', NULL, '23UCM001', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(923, 5, 'BALA MURUGAN G', NULL, '23UCM002', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(924, 5, 'BHUVANESH R', NULL, '23UCM003', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(925, 5, 'DESINGU D', NULL, '23UCM004', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(926, 5, 'DHILIP P', NULL, '23UCM005', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(927, 5, 'DINESH KARTHI S', NULL, '23UCM006', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(928, 5, 'DIVAKAR K', NULL, '23UCM007', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(929, 5, 'DIVIYA PRABHU M', NULL, '23UCM008', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(930, 5, 'GOKUL P', NULL, '23UCM009', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(931, 5, 'GOPISANKAR T', NULL, '23UCM010', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(932, 5, 'GOWTHAM D', NULL, '23UCM011', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(933, 5, 'INBARAJ R', NULL, '23UCM012', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(934, 5, 'JAGADEESH K', NULL, '23UCM013', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(935, 5, 'JAIDEEP BALAJI M', NULL, '23UCM014', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(936, 5, 'JEEVAN SAKTHI C S', NULL, '23UCM015', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(937, 5, 'JEEVANATHAN R', NULL, '23UCM016', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(938, 5, 'KAMALAKANNAN K G', NULL, '23UCM017', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(939, 5, 'KISHORE S', NULL, '23UCM018', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(940, 5, 'MAGESH CHENAPPA V K', NULL, '23UCM019', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(941, 5, 'MAHENDRAN S', NULL, '23UCM020', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(942, 5, 'MANIGANDAN S', NULL, '23UCM021', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(943, 5, 'MANIKANDAN K', NULL, '23UCM022', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(944, 5, 'MITHUN AKASH M', NULL, '23UCM023', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(945, 5, 'MUHAMMED SHAFEEL M', NULL, '23UCM024', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(946, 5, 'MOHAN KUMAR S K', NULL, '23UCM025', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(947, 5, 'MUKHIL  A P', NULL, '23UCM026', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(948, 5, 'NAVEENKUMAR R', NULL, '23UCM027', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(949, 5, 'SANJAY S', NULL, '23UCM028', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(950, 5, 'SANJEEVAN M', NULL, '23UCM029', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(951, 5, 'SATHISHKUMAR K', NULL, '23UCM030', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(952, 5, 'SARUKESH S', NULL, '23UCM031', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(953, 5, 'SHYAM RITHICK G', NULL, '23UCM032', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(954, 5, 'SIVA K', NULL, '23UCM033', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(955, 5, 'SRIDHAR J', NULL, '23UCM034', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(956, 5, 'SRINIKASH G.V', NULL, '23UCM035', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(957, 5, 'SUKUMAR P', NULL, '23UCM036', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(958, 5, 'VIGNESH S', NULL, '23UCM037', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(959, 5, 'VIKAS V', NULL, '23UCM038', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(960, 5, 'VISHNU BHARATHI K S', NULL, '23UCM039', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(961, 5, 'YESWANTH BALAJI A S', NULL, '23UCM040', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(962, 5, 'HARIRAM G', NULL, '23UCM041', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(963, 1, 'ABISHEK T', NULL, '23UIT001', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(964, 1, 'ADITHYA V', NULL, '23UIT002', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(965, 1, 'ARULKUMARAN A N', NULL, '23UIT003', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(966, 1, 'ARUNKUMAR S', NULL, '23UIT004', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(967, 1, 'BALAVIGNESH S B', NULL, '23UIT005', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(968, 1, 'DEEPAK S', NULL, '23UIT006', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(969, 1, 'DHANUMAALAIYAN K', NULL, '23UIT007', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(970, 1, 'DHATCHANAMOORTHY N', NULL, '23UIT008', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(971, 1, 'DILLIBABU P', NULL, '23UIT009', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(972, 1, 'GOWTHAMAN V', NULL, '23UIT010', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(973, 1, 'HARIHARAN K', NULL, '23UIT011', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(974, 1, 'HARIHARAN M', NULL, '23UIT012', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(975, 1, 'HARIRAJ G', NULL, '23UIT013', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(976, 1, 'HARISH V', NULL, '23UIT014', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(977, 1, 'KISHORE G', NULL, '23UIT015', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(978, 1, 'LAKESH M', NULL, '23UIT016', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(979, 1, 'LOKESH M', NULL, '23UIT017', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(980, 1, 'MADHAN KUMAR D', NULL, '23UIT018', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(981, 1, 'MANIYARASU R', NULL, '23UIT019', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(982, 1, 'MANOJ V', NULL, '23UIT020', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(983, 1, 'MANOJ KUMAR N', NULL, '23UIT021', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(984, 1, 'MOHAN RAJ S', NULL, '23UIT022', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(985, 1, 'NAVEEN  M D', NULL, '23UIT023', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(986, 1, 'PRAVEEN KUMAR P', NULL, '23UIT024', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(987, 1, 'RITHICK R', NULL, '23UIT025', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(988, 1, 'SABARI DHANUSH S', NULL, '23UIT026', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(989, 1, 'SANJAY M', NULL, '23UIT027', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(990, 1, 'SANTHOSH R', NULL, '23UIT028', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(991, 1, 'SARATHY R', NULL, '23UIT029', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(992, 1, 'SARVESH K', NULL, '23UIT030', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(993, 1, 'SASIKUMAR M', NULL, '23UIT031', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(994, 1, 'SIVAKUMAR S', NULL, '23UIT032', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(995, 1, 'SIVASAKTHI PANDIYAN P', NULL, '23UIT033', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(996, 1, 'SUBASH S', NULL, '23UIT034', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(997, 1, 'THARUN S', NULL, '23UIT035', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(998, 1, 'VANABAVAN M', NULL, '23UIT036', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(999, 1, 'VISHNUVARDHAN J', NULL, '23UIT037', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1000, 1, 'YUREN BALAJI R', NULL, '23UIT038', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1001, 1, 'JAYA RAMESHWARAN M D', NULL, '23UIT039', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1002, 6, 'ADHITHYA B', NULL, '23UPA001', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1003, 6, 'ATHISH S B', NULL, '23UPA002', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1004, 6, 'DHANUSH V', NULL, '23UPA003', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1005, 6, 'DHARUN JOGINDER E', NULL, '23UPA004', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1006, 6, 'DHAVATHIRUMANI R', NULL, '23UPA005', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1007, 6, 'DHEEPAK R', NULL, '23UPA006', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1008, 6, 'ESWARAN P', NULL, '23UPA007', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1009, 6, 'GOKUL KRISHNAN J', NULL, '23UPA008', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1010, 6, 'GOWTHAM R', NULL, '23UPA009', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1011, 6, 'HARI PRASAD S V', NULL, '23UPA010', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1012, 6, 'JAGAN KUMAR S', NULL, '23UPA011', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1013, 6, 'JAYANTHAN S R', NULL, '23UPA012', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1014, 6, 'KAMALESH R', NULL, '23UPA013', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1015, 6, 'KARUPPASAMY M', NULL, '23UPA014', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1016, 6, 'MAGESWARAN M', NULL, '23UPA015', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1017, 6, 'MANIKANDAN R', NULL, '23UPA016', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1018, 6, 'MATHESH S', NULL, '23UPA017', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1019, 6, 'MUGUNDHAN S', NULL, '23UPA018', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1020, 6, 'NARESHGUPTHA P', NULL, '23UPA019', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1021, 6, 'PONNUSAMY E', NULL, '23UPA020', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1022, 6, 'RAWIN SURIYA R R', NULL, '23UPA021', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1023, 6, 'SACHIN S', NULL, '23UPA022', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1024, 6, 'SANJAY A', NULL, '23UPA023', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1025, 6, 'SANJAY M', NULL, '23UPA024', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1026, 6, 'SANJAYKUMAR V', NULL, '23UPA025', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1027, 6, 'SARAVANAKUMAR M', NULL, '23UPA026', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1028, 6, 'SARAVANAN P', NULL, '23UPA027', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1029, 6, 'SRIDHAR B', NULL, '23UPA028', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1030, 6, 'SRIRAM K', NULL, '23UPA029', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1031, 6, 'SURENDHAR R', NULL, '23UPA030', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1032, 6, 'UMASUNDARAM S', NULL, '23UPA031', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1033, 6, 'VEERASAMY P', NULL, '23UPA032', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1034, 6, 'VENKATESH G', NULL, '23UPA033', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1035, 6, 'VIGNESH G', NULL, '23UPA034', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1036, 6, 'VIJAY N', NULL, '23UPA035', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1037, 6, 'VINOTHKUMAR P', NULL, '23UPA036', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1038, 9, 'AKASH R', NULL, '23UPE001', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1039, 9, 'AKILAN SARAVANAN', NULL, '23UPE002', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1040, 9, 'ARUNKUMAR R', NULL, '23UPE003', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1041, 9, 'ARUNPANDI P', NULL, '23UPE004', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1042, 9, 'BHARATH R', NULL, '23UPE005', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1043, 9, 'DEVARAJ M', NULL, '23UPE006', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1044, 9, 'GOKUL K', NULL, '23UPE007', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1045, 9, 'GOWDHAM S', NULL, '23UPE008', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1046, 9, 'GURU MOORTHY D', NULL, '23UPE009', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1047, 9, 'HARIPRASATH T', NULL, '23UPE010', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1048, 9, 'HARISH M', NULL, '23UPE011', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1049, 9, 'KARTHIKEYAN M', NULL, '23UPE012', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1050, 9, 'KAVINKUMAR K', NULL, '23UPE013', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1051, 9, 'KIRUBAKAR V', NULL, '23UPE014', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1052, 9, 'LAKSHMANAN E', NULL, '23UPE015', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1053, 9, 'MAHENDRAN P', NULL, '23UPE016', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1054, 9, 'MURUGESAN M', NULL, '23UPE017', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1055, 9, 'MUTHURAJ G', NULL, '23UPE018', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1056, 9, 'NANDHA KUMAR N', NULL, '23UPE019', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1057, 9, 'NAVEENKUMAR A', NULL, '23UPE020', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1058, 9, 'OM PRAKASH J', NULL, '23UPE021', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1059, 9, 'PRAVEEN KUMAR S', NULL, '23UPE022', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1060, 9, 'RAMAR E', NULL, '23UPE023', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1061, 9, 'RUBESH A', NULL, '23UPE024', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1062, 9, 'SENTHILKUMAR P', NULL, '23UPE025', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1063, 9, 'SIVAGIRI R', NULL, '23UPE026', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1064, 9, 'SUDESH KUMAR S', NULL, '23UPE027', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1065, 9, 'SURENDRAN K', NULL, '23UPE028', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1066, 9, 'VASANTHAKUMAR R', NULL, '23UPE029', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1067, 9, 'VIGNESH K', NULL, '23UPE030', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1068, 9, 'VIGNESH S B', NULL, '23UPE031', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1069, 9, 'VIJAY A', NULL, '23UPE032', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1070, 9, 'VIJAYAKUMAR N', NULL, '23UPE033', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1071, 9, 'VINOTHAGAN V', NULL, '23UPE034', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1072, 9, 'WILLIAM RICHARD T', NULL, '23UPE035', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1073, 2, 'ABISHEK U', NULL, '23USC001', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1074, 2, 'ABISHEKKUMAR P', NULL, '23USC002', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1075, 2, 'AGAWIN S', NULL, '23USC003', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India');
INSERT INTO `tblstudent` (`id`, `deptid`, `firstName`, `lastName`, `regNo`, `dob`, `age`, `email`, `gender`, `contactNumber`, `semester`, `year`, `batch`, `fatherName`, `fatherContact`, `motherName`, `motherContect`, `aadharNumber`, `community`, `religion`, `addressLine1`, `addressLine2`, `city`, `pincode`, `state`, `nationality`) VALUES
(1076, 2, 'ANAND V', NULL, '23USC004', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1077, 2, 'BALACHANDRAN A', NULL, '23USC005', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1078, 2, 'BALAVASANTH M', NULL, '23USC006', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1079, 2, 'DEEPAK R', NULL, '23USC007', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1080, 2, 'DHANUSH M', NULL, '23USC008', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1081, 2, 'DHARMAPRAKASH R', NULL, '23USC009', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1082, 2, 'DHARUN B', NULL, '23USC010', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1083, 2, 'DINESH S', NULL, '23USC011', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1084, 2, 'DINESHWARAN P N', NULL, '23USC012', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1085, 2, 'ENOCH JOSUVA E', NULL, '23USC013', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1086, 2, 'GOWTHAM K', NULL, '23USC014', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1087, 2, 'HARIHARAN T', NULL, '23USC015', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1088, 2, 'HARINIVAS S', NULL, '23USC016', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1089, 2, 'HARISH A P', NULL, '23USC017', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1090, 2, 'KAMESH R', NULL, '23USC018', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1091, 2, 'KARTHIKEYAN V', NULL, '23USC019', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1092, 2, 'KRISHANTH S', NULL, '23USC020', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1093, 2, 'MADHAN S', NULL, '23USC021', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1094, 2, 'MADHAN V C', NULL, '23USC022', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1095, 2, 'MANIVASAGAM K', NULL, '23USC023', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1096, 2, 'NARESH M', NULL, '23USC024', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1097, 2, 'NAVANEETHA KRISHNAN   L', NULL, '23USC025', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1098, 2, 'NAVANEETHAN S', NULL, '23USC026', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1099, 2, 'NAVEEN S', NULL, '23USC027', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1100, 2, 'PRAGADEESHWARAN T', NULL, '23USC028', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1101, 2, 'PRAJAN LAL V A', NULL, '23USC029', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1102, 2, 'RAHULKANNAN P C', NULL, '23USC030', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1103, 2, 'RANGANATHAN R', NULL, '23USC031', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1104, 2, 'SAMGRASAN R', NULL, '23USC032', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1105, 2, 'SANGEETHAN L K', NULL, '23USC033', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1106, 2, 'SARAVANA SRINIVASH  N', NULL, '23USC034', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1107, 2, 'SREENATH N', NULL, '23USC035', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1108, 2, 'SRI KRISHNAN V', NULL, '23USC036', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1109, 2, 'SRIDHAR R', NULL, '23USC037', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1110, 2, 'SRIDHARAN D', NULL, '23USC038', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1111, 2, 'SUHAS S B', NULL, '23USC039', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1112, 2, 'SUTHISH KANNAN S', NULL, '23USC040', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1113, 2, 'THIRU PRASHAD G S', NULL, '23USC041', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1114, 2, 'THIRUPATHI R', NULL, '23USC042', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1115, 2, 'UDHAYAKUMAR B', NULL, '23USC043', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1116, 2, 'VIJAY R', NULL, '23USC044', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1117, 2, 'VIKAS S L', NULL, '23USC045', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1118, 2, 'VISHWA S', NULL, '23USC046', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1119, 2, 'YOGESWARAN M', NULL, '23USC047', NULL, NULL, NULL, 'male', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, 'Tamil Nadu', 'India'),
(1120, 4, 'ABDUL KALAM N', NULL, '23PCA001', '0000-00-00', NULL, 'abdulsmart123456789@gmail.com', 'male', '9444615141', 'I', 'I', NULL, 'Noor Mohamed A', '9442008829', NULL, '7904816915', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1121, 4, 'ABINESHKUMAR K', NULL, '23PCA002', '0000-00-00', NULL, 'abineshkumarabinesh967@gmail.com', 'male', '7604965058', 'I', 'I', NULL, 'KALIMUTHU K', '9942755319', NULL, '9626869300', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1122, 4, 'AJAY A', NULL, '23PCA003', '0000-00-00', NULL, 'ajayakash2502@gmail.com', 'male', '9384965286', 'I', 'I', NULL, 'ARJUNAN K', '8220172039', NULL, '8220717790', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1123, 4, 'AKASH B', NULL, '23PCA004', '0000-00-00', NULL, 'akashriderofficial@gmail.com', 'male', '8608613113', 'I', 'I', NULL, 'BALAKRISHNAN M.P.', '9790313113', NULL, '9655313113', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1124, 4, 'AKASH K', NULL, '23PCA005', '0000-00-00', NULL, 'aakasharavindh.k@gmail.com', 'male', '7825055798', 'I', 'I', NULL, 'KRISHNA KUMAR B', '9585296262', NULL, '8098859046', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1125, 4, 'ASHWIN. S', NULL, '23PCA006', '0000-00-00', NULL, 'ashwinsakthi2043@gmail.com', 'male', '9790331140', 'I', 'I', NULL, 'SAKTHIVEL. K', '9750057335', NULL, '8122313570', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1126, 4, 'BALAKUMAR T', NULL, '23PCA007', '0000-00-00', NULL, 'balavimal2012004@gmail.com', 'male', '7904824781', 'I', 'I', NULL, 'THANGARAJ.P', '9092833694', NULL, '9092833694', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1127, 4, 'BHARATH.S', NULL, '23PCA008', '0000-00-00', NULL, 'bharathsubbiah@gmail.com', 'male', '9952800369', 'I', 'I', NULL, 'SUBBIAH.V', '9360703169', NULL, '9791913097', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1128, 4, 'DHARUN V', NULL, '23PCA009', '0000-00-00', NULL, 'dharunvenkatesan2002@gmail.com', 'male', '6369489176', 'I', 'I', NULL, 'VENKATESAN S', '9443193144', NULL, '9443474353', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1129, 4, 'DHIVYA PRAKASH .K', NULL, '23PCA010', '0000-00-00', NULL, 'dhivyaprakash611@gmail.com', 'male', '9677493169', 'I', 'I', NULL, 'KUMAR .S', '9443237169', NULL, '9488410658', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1130, 4, 'ESWARAMOORTHI.K', NULL, '23PCA011', '0000-00-00', NULL, 'eswaramoorthi9876@gmail.com', 'male', '9500672746', 'I', 'I', NULL, 'KRISHNAN.P', '9786646511', NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1131, 4, 'GOWRISHANKAR. N', NULL, '23PCA012', '0000-00-00', NULL, 'sgowri182@gmail.com', 'male', '9025175502', 'I', 'I', NULL, 'NARAYANASAMY. P', '8608185376', NULL, '9363496268', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1132, 4, 'HARIBALA S', NULL, '23PCA013', '0000-00-00', NULL, 'haribala132003@gmail.com', 'male', '8825995700', 'I', 'I', NULL, 'SURESH R', '9994115990', NULL, '9715281137', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1133, 4, 'HARIKRISHNAN D', NULL, '23PCA014', '0000-00-00', NULL, 'harikrish852483@gmail.com', 'male', '8524836767', 'I', 'I', NULL, 'DURAISAMY', '9489327532', NULL, '9626947746', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1134, 4, 'HARISH V P', NULL, '23PCA015', '0000-00-00', NULL, 'harishvp2002@gmail.com', 'male', '6374518040', 'I', 'I', NULL, 'VENKATESH K K', '9944882242', NULL, '9944882242', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1135, 4, 'JAYABHARATH S', NULL, '23PCA016', '0000-00-00', NULL, 'thalabharath1433@gmail.com', 'male', '9095555763', 'I', 'I', NULL, 'SEMBARAYAN M', '9943369825', NULL, '9344188494', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1136, 4, 'JEYARAM.P', NULL, '23PCA017', '0000-00-00', NULL, 'jeyaramj24@gmail.com', 'male', '6379286331', 'I', 'I', NULL, 'PALANICHAMY K', '9786561997', NULL, '6374293224', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1137, 4, 'Johan Nithish G.K', NULL, '23PCA018', '0000-00-00', NULL, 'johangkjohangk287@gmail.com', 'male', '8110044743', 'I', 'I', NULL, 'Gunasekeran V', '9360224350', NULL, '9626143759', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1138, 4, 'KAMESH A', NULL, '23PCA019', '0000-00-00', NULL, 'kameshananth11@gmail.com', 'male', '8838273522', 'I', 'I', NULL, 'Ananth Kumar K', '8148519405', NULL, '9042679771', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1139, 4, 'KAPILAN S', NULL, '23PCA020', '0000-00-00', NULL, 'kabilankabilan784@gmail.com', 'male', '9345845911', 'I', 'I', NULL, 'SARGUNAN S', '9788013662', NULL, '8778644130', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1140, 4, 'KARTHICK.K', NULL, '23PCA021', '0000-00-00', NULL, 'karthickshiv060@gmail.com', 'male', '6382783060', 'I', 'I', NULL, 'KAMARAJ.M', '7639897155', NULL, '9751638767', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1141, 4, 'KEERTHIK ROSHAN.M', NULL, '23PCA022', '0000-00-00', NULL, 'mkroshan46@gmail.com', 'male', '8438898684', 'I', 'I', NULL, 'MAHENDIRAN K', '9786264801', NULL, '9786264801', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1142, 4, 'KOWSIK K', NULL, '23PCA023', '0000-00-00', NULL, 'kkowsik90@gmail.com', 'male', '6379086596', 'I', 'I', NULL, 'Kanagaraj.k', '6379086596', NULL, '8785824085', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1143, 4, 'LOGESH.B', NULL, '23PCA024', '0000-00-00', NULL, 'logeshbeeman@gmail.com', 'male', '9025069070', 'I', 'I', NULL, 'BEEMAN.A', '6379189148', NULL, '8754625461', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1144, 4, 'LOGESH S', NULL, '23PCA025', '0000-00-00', NULL, 'logeshsubramaniam4545@gmail.com', 'male', '9360540488', 'I', 'I', NULL, 'SUBRAMANIAM R', '7402222525', NULL, '9360540488', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1145, 4, 'MADHAVAN R', NULL, '23PCA026', '0000-00-00', NULL, 'rmadhavan200230@gmail.com', 'male', '8248024249', 'I', 'I', NULL, 'RAJAPANDI', '9597594141', NULL, '9597594141', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1146, 4, 'MANIKANDAN.S.S', NULL, '23PCA027', '0000-00-00', NULL, 'manisagunthala37@gmail.com', 'male', '7812870640', 'I', 'I', NULL, 'M.SENTHIL KUMAR', '-', NULL, '9843309179', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1147, 4, 'NANDHAKUMAR C', NULL, '23PCA028', '0000-00-00', NULL, 'nandhunavi2213@gmail.com', 'male', '7598342176', 'I', 'I', NULL, 'CHAKRAVARTHI G', '9751086884', NULL, '8940602010', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1148, 4, 'NITHISH.C', NULL, '23PCA029', '0000-00-00', NULL, '20bscnithish@gmail.com', 'male', '9344862714', 'I', 'I', NULL, 'CHANDRAN.V', '8967988746', NULL, '93600 78193', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1149, 4, 'OAM PRASATH.V', NULL, '23PCA030', '0000-00-00', NULL, 'oamprasath@gmail.com', 'male', '9025850365', 'I', 'I', NULL, 'VANCHIAPPAN.K', '9942421457', NULL, '9865044427', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1150, 4, 'PERIYASAMY.S', NULL, '23PCA031', '0000-00-00', NULL, 'spsamy728@gmail.com', 'male', '9361544606', 'I', 'I', NULL, 'SUBRAMANI.P', '9787956529', NULL, '9585154728', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1151, 4, 'PRADEESH SAM PAUL.H', NULL, '23PCA032', '0000-00-00', NULL, 'pradeesh20uit013@gmail.com', 'male', '8531845095', 'I', 'I', NULL, 'HENRY PRAKASH.S', '9943380047', NULL, '7639046590', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1152, 4, 'PRAKASH S', NULL, '23PCA033', '0000-00-00', NULL, 'sprakashjoyel003@gmail.com', 'male', '9345391138', 'I', 'I', NULL, 'Selvan', '9751602842', NULL, '9095877542', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1153, 4, 'RAHULGANDHI. S', NULL, '23PCA034', '0000-00-00', NULL, 'raghuls133@gmail.com', 'male', '6369314826', 'I', 'I', NULL, 'SUBSH GANESH', '9159242824', NULL, '9159242824', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1154, 4, 'RAMAKRISHNAN A', NULL, '23PCA035', '0000-00-00', NULL, 'raamu817@gmail.com', 'male', '6374068507', 'I', 'I', NULL, 'ALAGAN R', '8760405545', NULL, '9600897186', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1155, 4, 'RATHIS KUMAR. R', NULL, '23PCA036', '0000-00-00', NULL, 'rathiskumar736@gmail.com', 'male', '6374968075', 'I', 'I', NULL, 'RAMAN UNNI. K', '8015509670', NULL, '9361468469', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1156, 4, 'SANTHOSH.D', NULL, '23PCA037', '0000-00-00', NULL, 'santhoshsiva567@gmail.com', 'male', '8778029217', 'I', 'I', NULL, 'DEIVENDRAN S', '9790062020', NULL, '9994827994', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1157, 4, 'SANTHOSH.P', NULL, '23PCA038', '0000-00-00', NULL, 'santhoshp7136@gmail.com', 'male', '8610694544', 'I', 'I', NULL, 'PANNEER SELVAM', '9994642833', NULL, '8220594165', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1158, 4, 'SATHISH KUMAR.P', NULL, '23PCA039', '0000-00-00', NULL, 'sathishkumarp3011@gmail.com', 'male', '6374522683', 'I', 'I', NULL, 'PONNUSAMY', '8300875946', NULL, '6374522683', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1159, 4, 'SHANMUGAM K', NULL, '23PCA040', '0000-00-00', NULL, 'shanmugamvirat7@gmail.com', 'male', '6381622830', 'I', 'I', NULL, 'KURUNTHASALAM N', '9965242753', NULL, '9500456957', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1160, 4, 'SHANMUGANATHAN. M', NULL, '23PCA041', '0000-00-00', NULL, '20bsashanmuganathan@gmail.com', 'male', '8870466876', 'I', 'I', NULL, 'MUTHUKUMAR. P', '9688763872', NULL, '8270157852', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1161, 4, 'SHIVARAM BABU T G', NULL, '23PCA042', '0000-00-00', NULL, 'shivarambabumdu@gmail.com', 'male', '6380005718', 'I', 'I', NULL, 'GANESH BABU T R K', '9443833772', NULL, '8925106627', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1162, 4, 'SIVALINGAM S', NULL, '23PCA043', '0000-00-00', NULL, 'sivalingampsm2002@gmail.com', 'male', '6374447600', 'I', 'I', NULL, 'SANKARAN P', '9751898219', NULL, '9751898219', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1163, 4, 'SIVAPRANET D', NULL, '23PCA044', '0000-00-00', NULL, 'Sivapranetmtp@gmail.com', 'male', '7598787876', 'I', 'I', NULL, 'B.Dhanabal', '9486220910', NULL, '8778280810', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1164, 4, 'SURENTHAR S', NULL, '23PCA045', '0000-00-00', NULL, 'surentharss217@gmail.com', 'male', '9342585854', 'I', 'I', NULL, 'SENTHILKUMAR T', '9025323109', NULL, '9750722950', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1165, 4, 'SYAM PRASANTH.M', NULL, '23PCA046', '0000-00-00', NULL, 'shiyamprasanthm03@gmail.com', 'male', '9597857753', 'I', 'I', NULL, 'MYILSAMY.K', '9566372430', NULL, '9566372430', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1166, 4, 'UDHAYA KUMAR. R', NULL, '23PCA047', '0000-00-00', NULL, 'Udhayaudhaya4751@gmail.com', 'male', '9345485986', 'I', 'I', NULL, 'RAVI. U', '9786572742', NULL, '9489211038', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1167, 4, 'VENKATESAN D', NULL, '23PCA048', '0000-00-00', NULL, 'venkatvijay9688@gmail.com', 'male', '9688881664', 'I', 'I', NULL, 'DEVARAJ M', '9688881664', NULL, NULL, NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1168, 4, 'VIKRAM M', NULL, '23PCA049', '0000-00-00', NULL, 'vikramadhithya2002@gmail.com', 'male', '7708289299', 'I', 'I', NULL, 'MATHAVAN K', '6382535439', NULL, '7708289299', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India'),
(1169, 4, 'YUVARAJ T', NULL, '23PCA050', '0000-00-00', NULL, 'yuvaraj1172003@gmail.com', 'male', '9500418954', 'I', 'I', NULL, 'THANGAPANDIAN R', '9442937672', NULL, '9486972883', NULL, 'nill', 'nill', NULL, NULL, NULL, NULL, NULL, 'India');

-- --------------------------------------------------------

--
-- Table structure for table `tbltimetable`
--

CREATE TABLE `tbltimetable` (
  `id` mediumint(3) NOT NULL,
  `deptId` mediumint(3) NOT NULL,
  `SubjectId` mediumint(3) NOT NULL,
  `Staffid` mediumint(3) NOT NULL,
  `Year` varchar(5) NOT NULL,
  `Semester` varchar(10) NOT NULL,
  `SubjectCore` varchar(150) NOT NULL,
  `DayOrder` mediumint(2) NOT NULL,
  `SubjectHour` mediumint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
(1, 'DEV_01', 'admin', 'MTIzNDU2Nzg=', 'admin@rmv.ac.in', 'administrator', '9655120081', 'male', '1990-03-17', 33, '2023-06-01', '0000-00-00', 1, 4),
(2, 'PCA_01', 'dinesh', 'MTIzNDU2Nzg=', 'dineshkumar@gmail.in', 'Dineshkumar', '9632587410', 'male', '1980-01-01', 43, '2021-01-01', '0000-00-00', 2, 4),
(3, 'UCA_02', 'chandhiran', 'MTIzNDU2Nzg=', 'chandhiran@rmv.ac.in', 'Chandhiran', '9894316150', 'male', '1980-01-01', 43, '2007-01-10', '0000-00-00', 2, 3),
(4, 'UIT_01', 'kamaraj', 'MTIzNDU2Nzg=', 'kamaraj@rmv.ac.in', 'Kamaraj', '9942080458', 'male', '1980-01-01', 43, '2007-01-01', '0000-00-00', 3, 1),
(5, 'PCA_02', 'prakash', 'MTIzNDU2Nzg=', 'prakash.mk@rmv.ac.in', 'Prakash MK', '9876543210', 'male', '1990-01-01', 33, '2015-01-01', '0000-00-00', 2, 4);

-- --------------------------------------------------------

--
-- Table structure for table `tblusersrights`
--

CREATE TABLE `tblusersrights` (
  `Id` mediumint(3) NOT NULL,
  `EmpId` varchar(50) NOT NULL,
  `permission` tinyint(1) NOT NULL DEFAULT 0,
  `addstudent` tinyint(1) NOT NULL DEFAULT 0,
  `updatestudent` tinyint(1) NOT NULL,
  `addcourse` tinyint(1) NOT NULL DEFAULT 0,
  `updatecourse` tinyint(1) NOT NULL DEFAULT 0,
  `addtimetable` tinyint(1) NOT NULL DEFAULT 0,
  `updatetimetable` tinyint(1) NOT NULL DEFAULT 0,
  `bulkattendance` tinyint(1) NOT NULL DEFAULT 0,
  `attendancereport` tinyint(1) NOT NULL DEFAULT 0,
  `lateAttendance` int(1) NOT NULL DEFAULT 0,
  `CreatedBy` varchar(50) NOT NULL,
  `ModifyBy` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tblusersrights`
--

INSERT INTO `tblusersrights` (`Id`, `EmpId`, `permission`, `addstudent`, `updatestudent`, `addcourse`, `updatecourse`, `addtimetable`, `updatetimetable`, `bulkattendance`, `attendancereport`, `lateAttendance`, `CreatedBy`, `ModifyBy`) VALUES
(1, 'DEV_01', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 'DEV_01', 'DEV_01'),
(2, 'UCA_02', 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 'DEV_01', 'UCA_02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tblattendance`
--
ALTER TABLE `tblattendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_staffid` (`Staffid`);

--
-- Indexes for table `tblcourse`
--
ALTER TABLE `tblcourse`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `courseCode` (`courseCode`),
  ADD KEY `fk_DeptIdid` (`deptId`);

--
-- Indexes for table `tbldayattendance`
--
ALTER TABLE `tbldayattendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Deptid_Da` (`deptId`),
  ADD KEY `fk_staffid_Da` (`staffId`);

--
-- Indexes for table `tbldepartment`
--
ALTER TABLE `tbldepartment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tblinternalexam`
--
ALTER TABLE `tblinternalexam`
  ADD PRIMARY KEY (`Code`),
  ADD KEY `CreatedBy` (`CreatedBy`);

--
-- Indexes for table `tblinternalmarks`
--
ALTER TABLE `tblinternalmarks`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_DeptId_IM` (`DeptId`),
  ADD KEY `fk_Examcode_IM` (`ExamCode`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_deptId_s` (`deptid`);

--
-- Indexes for table `tbltimetable`
--
ALTER TABLE `tbltimetable`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_course_TT` (`SubjectId`),
  ADD KEY `fk_user_TT` (`Staffid`),
  ADD KEY `fk_deptid_u` (`deptId`);

--
-- Indexes for table `tblusers`
--
ALTER TABLE `tblusers`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `EmpId` (`EmpId`),
  ADD KEY `fk_roles_u` (`roleId`),
  ADD KEY `fk_depart_u` (`deptid`);

--
-- Indexes for table `tblusersrights`
--
ALTER TABLE `tblusersrights`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_user_ur` (`EmpId`),
  ADD KEY `fk_userc_ur` (`CreatedBy`),
  ADD KEY `fk_userm_ur` (`ModifyBy`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tblattendance`
--
ALTER TABLE `tblattendance`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblcourse`
--
ALTER TABLE `tblcourse`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tbldayattendance`
--
ALTER TABLE `tbldayattendance`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbldepartment`
--
ALTER TABLE `tbldepartment`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tblinternalmarks`
--
ALTER TABLE `tblinternalmarks`
  MODIFY `Id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `tbllateattendance`
--
ALTER TABLE `tbllateattendance`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblroles`
--
ALTER TABLE `tblroles`
  MODIFY `Id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblstudent`
--
ALTER TABLE `tblstudent`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1170;

--
-- AUTO_INCREMENT for table `tbltimetable`
--
ALTER TABLE `tbltimetable`
  MODIFY `id` mediumint(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tblusers`
--
ALTER TABLE `tblusers`
  MODIFY `Id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tblusersrights`
--
ALTER TABLE `tblusersrights`
  MODIFY `Id` mediumint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tblattendance`
--
ALTER TABLE `tblattendance`
  ADD CONSTRAINT `fk_staffid` FOREIGN KEY (`Staffid`) REFERENCES `tblusers` (`EmpId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tblcourse`
--
ALTER TABLE `tblcourse`
  ADD CONSTRAINT `fk_DeptIdid` FOREIGN KEY (`deptId`) REFERENCES `tbldepartment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tbldayattendance`
--
ALTER TABLE `tbldayattendance`
  ADD CONSTRAINT `fk_Deptid_Da` FOREIGN KEY (`deptId`) REFERENCES `tbldepartment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_staffid_Da` FOREIGN KEY (`staffId`) REFERENCES `tblusers` (`EmpId`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tblinternalexam`
--
ALTER TABLE `tblinternalexam`
  ADD CONSTRAINT `tblinternalexam_ibfk_1` FOREIGN KEY (`CreatedBy`) REFERENCES `tblusers` (`EmpId`);

--
-- Constraints for table `tblinternalmarks`
--
ALTER TABLE `tblinternalmarks`
  ADD CONSTRAINT `fk_DeptId_IM` FOREIGN KEY (`DeptId`) REFERENCES `tbldepartment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Examcode_IM` FOREIGN KEY (`ExamCode`) REFERENCES `tblinternalexam` (`Code`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tblstudent`
--
ALTER TABLE `tblstudent`
  ADD CONSTRAINT `fk_deptId_s` FOREIGN KEY (`deptid`) REFERENCES `tbldepartment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tbltimetable`
--
ALTER TABLE `tbltimetable`
  ADD CONSTRAINT `fk_course_TT` FOREIGN KEY (`SubjectId`) REFERENCES `tblcourse` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_deptId_la` FOREIGN KEY (`deptId`) REFERENCES `tbldepartment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_dept_TT` FOREIGN KEY (`deptId`) REFERENCES `tbldepartment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_deptid_u` FOREIGN KEY (`deptId`) REFERENCES `tbldepartment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_user_TT` FOREIGN KEY (`Staffid`) REFERENCES `tblusers` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tblusers`
--
ALTER TABLE `tblusers`
  ADD CONSTRAINT `fk_depart_u` FOREIGN KEY (`deptid`) REFERENCES `tbldepartment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_roles_u` FOREIGN KEY (`roleId`) REFERENCES `tblroles` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `tblusersrights`
--
ALTER TABLE `tblusersrights`
  ADD CONSTRAINT `fk_user_ur` FOREIGN KEY (`EmpId`) REFERENCES `tblusers` (`EmpId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_userc_ur` FOREIGN KEY (`CreatedBy`) REFERENCES `tblusers` (`EmpId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_userm_ur` FOREIGN KEY (`ModifyBy`) REFERENCES `tblusers` (`EmpId`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;
