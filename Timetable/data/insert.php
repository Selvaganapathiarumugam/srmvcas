<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');

    $DeptId =  trim($_POST['tt_dept']);
    $StaffName =  trim($_POST['tt_name']);
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
    $SQL="insert into tbltimetable (StaffName,Year,Semester,SubjectCore,SubjectHour,DayOrder,SubjectId,deptid) 
    values('". $StaffName ."','". $Year ."','". $Semester ."','". $SubjectCore ."',
                $SubjectHour,$DayOrder, $SubjectId , $deptid )";
    if (mysqli_query($conn, $SQL)) {
        $response="Data inserted successfully!";
    } else {
        $response='Error inserting data:'. mysqli_error($conn);
    }
    mysqli_close($conn);
    echo $response;
?>