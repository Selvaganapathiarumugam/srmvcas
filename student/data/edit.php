<?php
    ob_start();
    session_start();
    include('../../connect.php');

    $firstName =  ucfirst(trim($_POST['st_name']));
    $lastName =  strtoupper(trim($_POST['st_lname']));
    $regNo =  strtoupper(trim($_POST['st_regNo']));
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
    $motherContact =  trim($_POST['st_motherNumber']);
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
    $id=$_POST['st_hid'];

    $SQL = "UPDATE tblstudent SET 
    firstName = '$firstName', 
    lastName = '$lastName', 
    regNo = '$regNo', 
    dob = '$dob', 
    email = '$email', 
    gender = '$gender', 
    contactNumber = '$contactNumber', 
    semester = '$semester', 
    year = '$year', 
    batch = '$batch', 
    fatherName = '$fatherName', 
    fatherContact = '$fatherContact', 
    motherName = '$motherName', 
    motherContect = '$motherContact', 
    aadharNumber = '$aadharNumber', 
    community = '$community', 
    religion = '$religion', 
    addressLine1 = '$addressLine1', 
    addressLine2 = '$addressLine2', 
    city = '$city', 
    pincode = '$pincode', 
    state = '$state', 
    nationality = '$nationality', 
    age = $age, 
    deptid = $deptid 
    WHERE id = $id";

    if (mysqli_query($conn, $SQL)) {
        $response="Data Updated successfully!";
    } else {
        $response='Error Updated data';
    }
    mysqli_close($conn);
    echo $response;
?>