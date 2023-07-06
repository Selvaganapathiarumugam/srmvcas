<?php 
    ob_start();
    session_start();
    //error_reporting(0); 
    include('../../connect.php');

    $at_dept =  trim($_POST['at_dept']);
    $at_semester =  trim($_POST['at_semester']);
    $at_year =  trim($_POST['at_year']);

    $SQL="SELECT id,regNo,firstName FROM tblstudent where deptid=".$at_dept." and
                semester='". $at_semester ."' and year='".$at_year ."' order by regno ASC; ";
    $result = mysqli_query($conn,$SQL);
    while ($row = mysqli_fetch_array($result))
    {
        $response[]=$row;
    }
    echo json_encode($response);
?>