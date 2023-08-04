<?php
    ob_start();
    session_start();
    // error_reporting(0);
    include('../../connect.php');
    $sql = "SELECT id, Regno,date, SubjectHour, IsAbsent FROM tblAttendance 
            ";
    $result = mysqli_query($conn, $sql);

    $data = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $data[] = $row;
    }

    mysqli_close($conn);

    echo json_encode($data);
?>