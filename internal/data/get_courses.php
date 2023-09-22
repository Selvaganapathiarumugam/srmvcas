<?php
    include('../../connect.php');
    error_reporting(0); 

    if ($_SERVER["REQUEST_METHOD"] == "POST") {

        $departmentId = $_POST['departmentId'];
        $year = $_POST['year'];
        $semester = $_POST['semester'];
        $sql = "SELECT id, courseCode, courseName FROM tblCourse
         WHERE deptId = '$departmentId' and year='$year' and semester='$semester'
         order by id asc";
        $result = mysqli_query($conn, $sql);

        $courses = array(); 

        while ($row = mysqli_fetch_assoc($result)) {
            $courses[] = $row;
        }

        echo json_encode($courses);
    }

    mysqli_close($conn);
?>


