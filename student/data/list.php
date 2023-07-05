<?php
    error_reporting(0);
    include('../../connect.php');
    // fetch records
    $SQL="SELECT s.id,s.regNo,s.firstName,d.dname,s.semester,s.batch,s.email from  tblstudent s inner join tbldepartment d on s.deptid = d.id ORDER BY s.id asc ";
    $result = mysqli_query($conn,$SQL);

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