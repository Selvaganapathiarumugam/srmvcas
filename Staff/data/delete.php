<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');

    $id=$_POST['did'];
    $SQL="delete from tblusers where Id='". $id."'";
    try {
        //$result = mysqli_query($conn,$SQL);
        $res="success"

    } catch (\Throwable $th) {
        throw $th;
    }
    echo $res;
?>