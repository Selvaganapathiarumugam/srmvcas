<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');

    $dname =  trim($_POST['dname']);
    if (substr($dname, 0, 1) === 'B') {
        $type = 'UG';
    } elseif (substr($dname, 0, 1) === 'M') {
        $type = 'PG';
    } else {
        $type = 'UG'; 
    }
    $SQL="insert into  tbldepartment (dname,Type) values('". $dname ."','".$type."')";
    if (mysqli_query($conn, $SQL)) {
        $response="Data inserted successfully!";
    } else {
        $response='Error inserting data';
    }
    mysqli_close($conn);
    echo $response;
?>