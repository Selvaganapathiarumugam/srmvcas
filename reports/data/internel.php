<?php
    include('../../connect.php');
    ob_start();
    session_start();
    error_reporting(0); 
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $departmentId = $_POST['departmentId'];
        $year = $_POST['year'];
        $semester = $_POST['semester'];
        $exam = $_POST['exam'];
        $course = $_POST['course'];
        $SQL="SELECT im.Id,ie.Name,im.RegNo,d.dname,c.courseName,c.courseCode,
                 im.semester,im.year,ie.Maxmark,im.CurrentMark
                from tblinternalmarks im
                inner join tblinternalexam ie on im.ExamCode = ie.Code 
                inner join tblcourse c on im.CourseCode = c.courseCode 
                inner join tbldepartment d on im.DeptId = d.id 
                inner join tblstudent s on im.RegNo = s.regNo 
                where im.deptid=$departmentId and im.CourseCode= '$course'
                and im.Year='$year'  and im.Semester='$semester' and im.ExamCode='$exam'
                ORDER BY im.Id asc ";
        //echo $SQL;
        //die();
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
    }
    mysqli_close($conn);
    header('Content-Type: application/json');
    echo json_encode($dataset);
?>