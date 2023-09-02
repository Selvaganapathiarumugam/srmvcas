<?php
    error_reporting(0);
    ob_start();
    session_start();
    include('../../connect.php');
    if($_SESSION['Role'] == "1" && $_SESSION['Role'] == "5" )
    {
        $con="";
    }
    else
    {
        $con=" where s.deptid =".$_SESSION['Dept'];
    }
    // fetch records
    $SQL="SELECT s.id,s.regNo,s.firstName,d.dname,s.semester,s.batch,s.email
     from  tblstudent s inner join tbldepartment d on s.deptid = d.id 
     ".$con." 
     ORDER BY s.id asc ";
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