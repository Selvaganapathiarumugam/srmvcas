<?php

include('../../connect.php');
$SQL="SELECT id ,dname from tbldepartment ORDER BY id asc ";
$result = mysqli_query($conn,$SQL) or die($SQL."<br/><br/>".mysql_error());

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