<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');

    $EmpId = strtoupper(trim($_POST['sf_id']));
    $fullname = ucfirst(trim($_POST['sf_name']));
    $email = trim($_POST['sf_email']);
    $phone = trim($_POST['sf_phone']);
    $deptid = trim($_POST['sf_dept']);
    $username = trim($_POST['sf_user']);
    $originalPass = trim($_POST['sf_pass']);
    $rePass = trim($_POST['sf_rpass']);
    $password = base64_encode($originalPass);
    $gender = trim($_POST['sf_gender']);
    $dob = trim($_POST['sf_dob']);
    $age = trim($_POST['sf_age']);
    $doj = trim($_POST['sf_doj']);
    $dor = trim($_POST['sf_dor']);
    $roleId = trim($_POST['sf_role']);
    if(!$conn)
    {
        die('Connection failed: '.mysqli_connect_error());
    }
    if($originalPass == $rePass) {
        if (($age > 22) && ($age <= 60)) {
            $SQL = "INSERT INTO tblusers (EmpId, fullname, email, phone, username, password, deptId, roleId, dor, doj, age, dob, gender)
                    VALUES ('$EmpId', '$fullname', '$email', '$phone', '$username', '$password', $deptid, $roleId, '$dor', '$doj', $age, '$dob', '$gender')";
            if (mysqli_query($conn, $SQL)) {
                $response="Data inserted successfully!";
            } else {
                $response='Error inserting data:';
            }
        } else {
            $response="Invalid Age! Age should be between 25 and 59.";
        }
    } else {
        $response="Password does not match!";
    }
    mysqli_close($conn);
    echo $response;
?>