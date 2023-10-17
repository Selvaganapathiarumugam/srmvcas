<?php
    include('../../connect.php');
    error_reporting(0); 

    if ($_SERVER["REQUEST_METHOD"] == "POST" ) {

        $departmentId = $_POST['departmentId'];
        $year = $_POST['year'];
        $semester = $_POST['semester'];

        // Start with an empty option
        $rows = "<option id=''>Select a course</option>";

        $sql = "SELECT id, CourseCode, CourseName FROM tblcourse
        WHERE deptId = '$departmentId' and year='$year' and semester='$semester'
        ORDER BY id ASC";
        //echo $sql; die();
        $result = mysqli_query($conn, $sql);

        while ($row = mysqli_fetch_assoc($result)) {
            // Use single quotes for the 'id' attribute
            $rows .= "<option id='{$row['CourseCode']}'>";
            $rows .= "{$row['CourseName']}";
            $rows .= "</option>";
        }
        echo $rows;
    }

    mysqli_close($conn);
?>
