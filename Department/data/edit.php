<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');

    $dname =  trim($_POST['dname']);
    $id=trim($_POST['id']);
    $SQL="update tbldepartment set dname ='". $dname ."' where Id='". $id."'";
    if (mysqli_query($conn, $SQL)) {
        $response="Data Updated successfully!";
    } else {
        $response='Error inserting data:';
    }

    mysqli_close($conn);
    echo $response;
?>
