<?php
    ob_start();
    session_start();
    include('../../connect.php');

    $deptId = $_POST['tt_dept'];
    $Staffid = $_POST['tt_Name'];
    $year = ($_POST['tt_year']);
    $Semester = ($_POST['tt_semester']);
    $SubjectId = $_POST['tt_sub'];
    $SubjectCore = $_POST['tt_score'];
    $DayOrder = $_POST['tt_DO'];
    $SubjectHour = $_POST['tt_hours'];
    $id=$_POST['tt_hid'];
    if (!$conn) {
        die('Connection failed: ' . mysqli_connect_error());
    }
    
    $SQL = "UPDATE tbltimetable SET  year='$year', Semester='$Semester', SubjectCore='$SubjectCore',
        SubjectId=$SubjectId,deptId=$deptId, Staffid=$Staffid,DayOrder=$DayOrder,SubjectHour=$SubjectHour
        WHERE id=$id ; ";
    if (mysqli_query($conn, $SQL)) {
        $response="Data Updated successfully!";
    } else {
        $response='Error Updated data';
    }
    mysqli_close($conn);
    echo $response;
?>