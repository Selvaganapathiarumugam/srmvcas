<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');
   
    $deptId =  trim($_POST['cs_dept']);
    $year = trim($_POST['cs_year']);
    $semester =  trim($_POST['cs_semester']);
    $courseCode = strtoupper(trim($_POST['cs_code']));
    $courseName = trim($_POST['cs_name']);
    $acadamicYear =trim($_POST['cs_ayear']);
    $StaffId=$_SESSION['EmpId'];
    $SQL = "INSERT INTO tblcourse (deptId,StaffId, year, semester, courseCode, courseName, AcadamicYear)
    VALUES ($deptId,'$EmpId','$year', '$semester', '$courseCode', '$courseName', '$acadamicYear');";
    if (mysqli_query($conn, $SQL)) {
        $response="Data inserted successfully!";
    } else {
        $response='Error inserting data:';
    }
    mysqli_close($conn);
    echo $response;
?>