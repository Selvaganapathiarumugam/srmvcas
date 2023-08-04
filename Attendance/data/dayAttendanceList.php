<?php
    include('../../connect.php');
    
    $SQL="SELECT da.id,da.regno,d.dname AS department,da.semester,da.year,da.date,da.status FROM tbldayattendance da
    INNER JOIN tbldepartment d ON da.deptId=d.id
    ORDER BY da.date";
    
    $result = mysqli_query($conn,$SQL);
    $array=array();
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