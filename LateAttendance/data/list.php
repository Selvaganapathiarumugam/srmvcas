<?php
    include('../../connect.php');
    error_reporting(0); 

    //fetch records
    $SQL=" SELECT la.id,la.regNo,s.firstName,la.year,la.Semester,d.dname,la.date
                from  tblLateattendance la
                inner join tbldepartment d on la.deptid = d.id
                inner join  tblstudent s on la.regno= s.regNo
                ORDER BY la.regNo asc ";
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