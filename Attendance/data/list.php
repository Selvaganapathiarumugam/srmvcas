<?php
    include('../../connect.php');
    
    $SQL="SELECT *  from tblattendance where IsAbsent=1  ORDER BY id asc ";
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