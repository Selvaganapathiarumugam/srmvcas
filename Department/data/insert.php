<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');

    $dname =  trim($_POST['dname']);
    $SQL="insert into  tbldepartment (dname) values('". $dname ."')";
    if (mysqli_query($conn, $SQL)) {
        $response="Data inserted successfully!";
    } else {
        $response='Error inserting data';
    }
    mysqli_close($conn);
    echo $response;
?>