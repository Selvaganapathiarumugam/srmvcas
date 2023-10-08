<?php
    include('../../connect.php');
    
    $SQL="SELECT ie.*,u.fullname from tblinternalexam ie
          inner join tblusers u on u.EmpId = ie.CreatedBy 
          ORDER BY ie.Code asc ";
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