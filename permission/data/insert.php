<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');

    $EmpId = strtoupper(trim($_POST['up_Staff']));
    $Permission =trim($_POST['up_Permission']);
    $addstudent = trim($_POST['up_addstudent']);
    $updatestudent = trim($_POST['up_updatestudent']);
    $addcourse = trim($_POST['up_addcourse']);
    $updatecourse = trim($_POST['up_updatecourse']);
    $addtimetable = trim($_POST['up_addtimetable']);
    $updatetimetable = trim($_POST['up_updatetimetable']);
    $bulkattendance = trim($_POST['up_bulkattendance']);
    $attendancereport = trim($_POST['up_attendancereport']);
    $CreatedBY = trim($_SESSION["EmpId"]);
    if(!$conn)
    {
        die('Connection failed: '.mysqli_connect_error());
    }
 
    $SQL = "INSERT INTO tblUsersRights (EmpId, permission, addstudent, updatestudent, addcourse, updatecourse, addtimetable, updatetimetable, bulkattendance, attendancereport, CreatedBY)
            VALUES ('$EmpId', $Permission, $addstudent, $updatestudent, $addcourse, $updatecourse, $addtimetable, $updatetimetable, $bulkattendance, $attendancereport,'$CreatedBY')";
   //echo $SQL;die();
    if (mysqli_query($conn, $SQL)) {
        $response="Data inserted successfully!";
    } else {
        $response='Error inserting data:';
    }

    mysqli_close($conn);
    echo $response;
?>