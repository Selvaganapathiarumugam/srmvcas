<?php
    include('../../connect.php');
    error_reporting(0); 

    if ($_SERVER["REQUEST_METHOD"] == "POST" ) {

        $departmentId = $_POST['departmentId'];
        $year = $_POST['year'];
        $semester = $_POST['semester'];
        $sql = "SELECT id, regNo, firstName FROM tblStudent
         WHERE deptId = '$departmentId' and year='$year' and semester='$semester'
         order by id asc";
        $result = mysqli_query($conn, $sql);
        $rows = "";
        //echo $sql;die();
        while ($row = mysqli_fetch_assoc($result)) {
            $rows .= "<tr>";
            $rows .= "<td><input type='text' value='{$row['regNo']}' disabled class='form-control' style='height: 23px;' autocomplete='off' name='ie_SReg[]'></td>";
            $rows .= "<td>{$row['firstName']}</td>";
            $rows .= "<td><input type='number' style='height: 23px;' class='form-control' autocomplete='off' name='mark[]'></td>";
            $rows .= "<td><input type='number' style='height: 23px;' class='form-control' name='final_mark[]' disabled></td>";
            $rows .= "</tr>";
            
        }

        echo $rows;
    }
    mysqli_close($conn);
?>


