<?php
    include('../../connect.php');
    ob_start();
    session_start();
    //error_reporting(0); 
    if ($_SERVER["REQUEST_METHOD"] == "POST") {

        $departmentId = $_POST['departmentId'];
        $year = $_POST['year'];
        $semester = $_POST['semester'];
        $course = $_POST['course'];
        $SQL="call sp_InternalFinalPG('$course','$year');";

        //echo $SQL;die();
        $result = mysqli_query($conn,$SQL);
        $array = array();
        while($row = mysqli_fetch_array($result)) 
        {
            $array[] = $row;
        }
    
        $dataset = array(
            "totalrecords" => count($array),
            "totaldisplayrecords" => count($array),
            "data" => $array
        );
    }
    mysqli_close($conn);
    header('Content-Type: application/json');
    echo json_encode($dataset);
?>