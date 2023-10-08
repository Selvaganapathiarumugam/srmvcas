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
        $rows = "";
        while ($row = mysqli_fetch_assoc($result)) {
            $rows .= "<tr>";
            $rows .= "<td><input type='text' class='form-control'disabled name='courseCode[]' value = {$row['courseCode']} /></td>";
            $rows .= "<td>{$row['courseName']}</td>";
            $rows .= "<td><input type='number' class='form-control' autocomplete='off' name='mark[]'></td>";
            $rows .= "<td><input type='number' class='form-control' name='final_mark[]' disabled></td>";
            $rows .= "</tr>";
            
        }

        echo $rows;
    }

    mysqli_close($conn);
?>


