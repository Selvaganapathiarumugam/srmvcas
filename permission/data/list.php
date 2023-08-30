
<?php 
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');
    header('Content-Type: application/json');
    $SQL="SELECT p.id,u.EmpId,u.username,p.addstudent,p.updatestudent,p.addcourse,p.updatecourse,p.addtimetable,p.updatetimetable,p.bulkattendance,p.attendancereport,p.permission 
    FROM tblusersrights p inner join tblusers u on p.EmpId=u.EmpId order by u.username ASC; ";
    
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
