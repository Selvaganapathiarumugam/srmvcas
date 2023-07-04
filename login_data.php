<?php
    ob_start();
    session_start();
    error_reporting(0);

    include('./connect.php');
    $username = $_POST['username'];
    $password = base64_encode($_POST['password']);
    $SQL="SELECT U.* from  tblusers U
          Where U.userName='$username' and password='$password'";
    $result = mysqli_query($conn,$SQL);
    while($row = mysqli_fetch_array($result)) 
    {
        $Dept = $row['deptid'];
        $_Role= $row['roleId'];
        $Username = $row['fullname'];
        $EmpId= $row['EmpId'];
        $userId=$row['id'];
    }

    if (isset($Username)) {
        $_SESSION['Dept'] = $Dept;
        $_SESSION['Role']=  $_Role;
        $_SESSION['Username'] =  $Username;
        $_SESSION['EmpId'] =  $EmpId;
        $_SESSION['userId']=$userId;
      echo 'success';
    } else {
      echo 'error';
    }
?>