<?php
    ob_start();
    session_start();
    //error_reporting(0); 
    include('../../connect.php');

    $ie_code =  strtoupper(trim($_POST['ie_code']));
    $ie_name =  trim($_POST['ie_name']);
    $ie_type =  trim($_POST['ie_type']);
    $ie_year =  trim($_POST['ie_year']);
    $ie_mmark =  trim($_POST['ie_mmark']);
    $ie_cmark =  trim($_POST['ie_cmark']);
    $Author=$_SESSION['EmpId'];
    $SQL="insert into tblinternalexam (code,Name,Type,Maxmark,Convertmark,year,CreatedBy) 
    values('".$ie_code."','". $ie_name ."','". $ie_type ."',$ie_mmark ,$ie_cmark,'".$ie_year."','".$Author."');";
   // echo $SQL;Die();
    if (mysqli_query($conn, $SQL)) {
        $response="Data inserted successfully!";
    } else {
        $response='Error inserting data';
    }
    mysqli_close($conn);
    echo $response;
?>