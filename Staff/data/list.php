<?php
    include('../../connect.php');
    
    $SQL="SELECT u.id,u.EmpId,u.fullname,u.phone,u.doj,r.Description,d.dname from tblusers u
          inner join tbldepartment d on u.deptId = d.id 
          inner join tblroles r on u.roleId = r.id 
          ORDER BY u.id asc ";
    $result = mysqli_query($conn,$SQL);
    
    while($row = mysqli_fetch_array($result)) 
    {
        $array[] = $row;
    }
    $array = array();
    $dataset = array(
        "totalrecords" => count($array),
        "totaldisplayrecords" => count($array),
        "data" => $array
    );
    mysqli_close($conn);
    header('Content-Type: application/json');
    echo json_encode($dataset);
?>