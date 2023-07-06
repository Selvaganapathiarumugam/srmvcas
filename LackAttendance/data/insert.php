<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');

    $la_reg =  strtoupper(trim($_POST['la_reg']));
    $la_date =  trim($_POST['la_date']);
    $la_year =  trim($_POST['la_year']);
    $la_sem =  trim($_POST['la_sem']);
    $la_deptid =  trim($_POST['la_deptid']);

    $SQL="insert into tbllackattendance (regno,Year,Semester,date,deptid) 
    values('".$la_reg."','". $la_year ."','". $la_sem ."','". $la_date ."',$la_deptid);";
    if (mysqli_query($conn, $SQL)) {
        $response="Data inserted successfully!";
    } else {
        $response='Error inserting data';
    }
    mysqli_close($conn);
    echo $response;
?>