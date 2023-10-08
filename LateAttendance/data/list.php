<?php
    include('../../connect.php');
    ob_start();
    session_start();
    error_reporting(0); 
    if($_SESSION['Role'] == "1" && $_SESSION['Role'] == "5" )
    {
        $con="";
    }
    else
    {
        $con=" where s.deptid =".$_SESSION['Dept'];
    }
    //fetch records
    $SQL=" SELECT s.batch,la.id,la.regNo,s.firstName,la.year,la.Semester,d.dname,la.date
                from  tblLateattendance la
                inner join tbldepartment d on la.deptid = d.id
                inner join  tblstudent s on la.regno= s.regNo
                ".$con."                
                ORDER BY la.regNo asc ";
    //echo $SQL; die();
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

    mysqli_close($conn);
    header('Content-Type: application/json');
    echo json_encode($dataset);
?>