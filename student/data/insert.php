<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');

    $firstName =  trim($_POST['st_name']);
    $lastName =  trim($_POST['st_lname']);
    $regNo =  trim($_POST['st_regNo']);
    $dob =  trim($_POST['st_dob']);
    $email =  trim($_POST['st_email']);
    $gender =  trim($_POST['st_gender']);
    $contactNumber =  trim($_POST['st_context']);
    $semester =  trim($_POST['st_semester']);
    $year =  trim($_POST['st_year']);
    $batch =  trim($_POST['st_batch']);
    $fatherName =  trim($_POST['st_fatherName']);
    $fatherContact =  trim($_POST['st_fatherNumber']);
    $motherName =  trim($_POST['st_motherName']);
    $motherContect =  trim($_POST['st_motherNumber']);
    $aadharNumber =  trim($_POST['st_aadhar']);
    $community =  trim($_POST['st_community']);
    $religion =  trim($_POST['st_religion']);
    $addressLine1 =  trim($_POST['st_addl1']);
    $addressLine2 =  trim($_POST['st_addl2']);
    $city =  trim($_POST['st_city']);
    $pincode =  trim($_POST['st_pincode']);
    $state =  trim($_POST['st_state']);
    $nationality =  trim($_POST['st_nationality']);
    $age =  trim($_POST['st_age']);
    $deptid = $_POST['st_dept'];

    if(!$conn)
    {
        die('Connection failed: '.mysqli_connect_error());
    }
    $SQL="insert into tblstudent (firstName,lastName,regNo,dob,email,gender,contactNumber,semester,year,
    batch,fatherName,fatherContact,motherName,motherContect,aadharNumber, community,religion,addressLine1,
    addressLine2,city,pincode,state,nationality,age,deptid) 
    values('". $firstName ."','". $lastName ."','". $regNo ."','". $dob ."','". $email ."','". $gender ."', 
    '". $contactNumber ."','". $semester ."','". $year ."','". $batch ."','". $fatherName ."','". $fatherContact ."',
    '". $motherName ."','". $motherContect ."','". $aadharNumber ."','". $community ."','". $religion ."','". $addressLine1 ."',
    '". $addressLine2 ."','". $city ."','". $pincode ."','". $state ."','". $nationality ."', $age , $deptid )";
    if (mysqli_query($conn, $SQL)) {
        $response="Data inserted successfully!";
    } else {
        $response='Error inserting data:'. mysqli_error($conn);
    }
    mysqli_close($conn);
    echo $response;
?>