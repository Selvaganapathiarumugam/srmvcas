<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');

    $EmpId = strtoupper(trim($_POST['sf_id']));
    $fullname = trim($_POST['sf_name']);
    $email = trim($_POST['sf_email']);
    $phone = trim($_POST['sf_phone']);
    $deptid = trim($_POST['sf_dept']);
    $username = trim($_POST['sf_user']);
    $originalPass = trim($_POST['sf_pass']);
    $rePass = trim($_POST['sf_rpass']);
    $password = base64_encode($originalPass);
    $gender = trim($_POST['sf_gender']);
    $dob = trim($_POST['sf_dob']);
    $age = (int)($_POST['sf_age']);
    $doj = trim($_POST['sf_doj']);
    $dor = trim($_POST['sf_dor']);
    $roleId = trim($_POST['sf_role']);
    $id=trim($_POST['sf_hid']);
    if (!$conn) {
        die('Connection failed: ' . mysqli_connect_error());
    }
    if ($originalPass == $rePass) {
        if (($age > 22) && ($age <= 60)) {
            $SQL = "UPDATE tblusers SET EmpId='$EmpId', fullname='$fullname', email='$email', phone='$phone', username='$username', 
                password='$password',deptId=$deptid, roleId=$roleId, dor='$dor', doj='$doj', age=$age, dob='$dob'
                WHERE id=$id ; ";
            if (mysqli_query($conn, $SQL)) {
                $response="Data Updated successfully!";
            } else {
                $response='Error Updated data';
            }
        }
        else
        {
            $response="Invalid Age! Age should be between 25 and 59.";
        }
    }
    else
    {
        $response="Password does not match!";
    }
    mysqli_close($conn);
    echo $response;
?>