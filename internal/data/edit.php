<?php
    ob_start();
    session_start();
    //error_reporting(0); 
    include('../../connect.php');
    $ie_code = (trim($_POST['ie_code']));
    $ie_name = (trim($_POST['ie_name']));
    $ie_type = trim($_POST['ie_type']);
    $ie_year = trim($_POST['ie_year']);
    $ie_mmark = trim($_POST['ie_mmark']);
    $ie_cmark = trim($_POST['ie_cmark']);
    $CreatedBy=$_SESSION['EmpId'];
    $ie_order=$_POST['ie_Order'];
    $ie_isActive=$_POST['ie_isActive'];
    //echo $ie_cmark;Die();
    if (!$conn) {
        die('Connection failed: ' . mysqli_connect_error());
    }
    $SQL = "UPDATE tblinternalexam SET Code='$ie_code', Name='$ie_name', Type='$ie_type', Year='$ie_year', 
        Maxmark=$ie_mmark, Convertmark=$ie_cmark, CreatedBy='$CreatedBy' ,RowOrder=$ie_order,isActive=$ie_isActive  
        WHERE Code='$ie_code' ; ";
    //echo $SQL;Die();
    if (mysqli_query($conn, $SQL)) {
        $response="Data Updated successfully!";
    } else {
        $response='Error Updated data';
    }
    mysqli_close($conn);
    echo $response;
?>