<?php
    include('../../connect.php');
    ob_start();
    session_start();
    error_reporting(0); 
    if($_SESSION['Role'] == 1 || $_SESSION['Role'] == 5 )
    {
        $con="";
    }
    else
    {
        $con=" where im.DeptId =".$_SESSION['Dept'];
    }
    $SQL="SELECT im.Id,ie.Name,im.RegNo,D.dname,s.firstName,c.courseName,
                 im.CurrentMark,im.FinalMark
                from tblinternalmarks im
                inner join tblinternalexam ie on im.ExamCode = ie.Code 
                inner join tblcourse c on im.CourseCode = c.courseCode 
                inner join tbldepartment d on im.DeptId = d.id 
                inner join tblstudent s on im.RegNo = s.regNo 
                ".$con." 
                ORDER BY im.Id asc ";
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