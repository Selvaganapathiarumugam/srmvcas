<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');

    $EmpId = strtoupper(trim($_POST['up_Staff']));
    $permission = ucfirst(trim($_POST['up_Permission']));
    $addstudent = trim($_POST['up_addstudent']);
    $updatestudent = trim($_POST['up_updatestudent']);
    $addcourse = trim($_POST['up_addcourse']);
    $updatecourse = trim($_POST['up_updatecourse']);
    $addtimetable = trim($_POST['up_addtimetable']);
    $updatetimetable = trim($_POST['up_updatetimetable']);
    $bulkattendance = trim($_POST['up_bulkattendance']);
    $attendancereport = trim($_POST['up_attendancereport']);
    $ModifyBy=trim($_SESSION["EmpId"]);
    $id=trim($_POST['up_hid']);

    $SQL = "UPDATE tblUsersRights SET EmpId='$EmpId', permission=$permission, addstudent=$addstudent, updatestudent=$updatestudent, addcourse=$addcourse, 
        updatecourse=$updatecourse,addtimetable=$addtimetable, updatetimetable=$updatetimetable, bulkattendance=$bulkattendance, attendancereport=$attendancereport
        ,ModifyBy='$ModifyBy' WHERE Id=$id ; ";
    //echo $SQL;Die();
    if (mysqli_query($conn, $SQL)) {
        $response="Data Updated successfully!";
    } else {
        $response='Error Updated data';
    }
    mysqli_close($conn);
    echo $response;
?>