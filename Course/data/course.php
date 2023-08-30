<?php

include('../../connect.php');
// fetch records
$SQL="SELECT c.id ,d.dname,c.semester,c.year,c.courseName,c.courseCode,c.AcadamicYear from  tblcourse c
      inner join tbldepartment d on c.deptId = d.id 
      ORDER BY c.id asc ";
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

echo json_encode($dataset);
?>