<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');

    $DeptId =  trim($_POST['tt_dept']);
    $Staffid =  trim($_POST['tt_Name']);
    $Year =  trim($_POST['tt_year']);
    $Semester =  trim($_POST['tt_semester']);
    $SubjectId =  trim($_POST['tt_sub']);
    $SubjectCore =  trim($_POST['tt_score']);
    $DayOrder =  trim($_POST['tt_DO']);
    $SubjectHour =  trim($_POST['tt_hours']);
    
    if(!$conn)
    {
        die('Connection failed: '.mysqli_connect_error());
    }
    $checkSQL="SELECT count(*) as Total FROM tbltimetable where Staffid=".$Staffid." and
                DayOrder=". $DayOrder ." and SubjectHour=".$SubjectHour ."; ";
    $result=mysqli_query($conn, $checkSQL);
    $value = mysqli_fetch_array($result);
    if($value['Total'] < 1)
    {
        $SQL="insert into tbltimetable (Staffid,Year,Semester,SubjectCore,SubjectHour,DayOrder,SubjectId,deptid) 
        values($Staffid,'". $Year ."','". $Semester ."','". $SubjectCore ."',$SubjectHour,$DayOrder, $SubjectId, $DeptId);";
        if (mysqli_query($conn, $SQL)) {
            $response="Data inserted successfully!";
        } else {
            $response='Error inserting data';
        }
    }
    else
    {
        $response="This User is already to another course at the same time!";
    }
    mysqli_close($conn);
    echo $response;
?>