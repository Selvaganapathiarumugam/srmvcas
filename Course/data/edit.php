<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');
    if (!$conn) {
        die('Connection failed: ' . mysqli_connect_error());
    }
    $dept =trim($_POST['cs_dept']);
    $sem = trim($_POST['cs_semester']);
    $year =trim($_POST['cs_year']);
    $code =strtoupper(trim($_POST['cs_code']));
    $name =trim($_POST['cs_name']);
    $ayear=trim($_POST['cs_ayear']);
    $id=$_POST['cs_hid'];
    $SQL = "UPDATE tblcourse SET deptid=" . $dept . ",
        semester='" . $sem . "', year='" . $year . "', courseName='" . $name . "',
        courseCode='" . $code . "', AcadamicYear='" . $ayear . "' WHERE Id='" . $id . "'";
    if (mysqli_query($conn, $SQL)) {
        $response="Data Updated successfully!";
    } else {
        $response='Error Updated data';
    }
    mysqli_close($conn);
    echo $response;
?>