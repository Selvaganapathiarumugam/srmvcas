<?php
    include('../../connect.php');
    error_reporting(0); 

    if ($_SERVER["REQUEST_METHOD"] == "POST" ) 
    {
        $departmentId = $_POST['departmentId'];
        $year = $_POST['year'];
        $semester = $_POST['semester'];
        $Code=$_POST['CCode'];
        $Excode=$_POST['ExCode'];

        $sql = "SELECT im.Id, im.RegNo, S.firstName,im.CurrentMark,im.FinalMark
                FROM tblinternalmarks im 
                Inner Join tblStudent S on im.Regno = S.regNo 
                WHERE im.DeptId = '$departmentId' and im.Year='$year' and im.Semester='$semester'
                and im.CourseCode='$Code' and im.ExamCode='$Excode'
                order by im.id asc";
                //echo $sql;die();
        $result = mysqli_query($conn, $sql);
        $rows = "";
        while ($row = mysqli_fetch_assoc($result)) {
            $rows .= "<tr>";
            $rows .= "<td><input type='hidden' value='{$row['Id']}'name='ie_Id[]'><input type='text' value='{$row['RegNo']}' disabled class='form-control' style='height: 23px;'  autocomplete='off' name='ie_SReg[]'></td>";
            $rows .= "<td>{$row['firstName']}</td>";
            $rows .= "<td><input type='number' style='height: 23px;' class='form-control' autocomplete='off' name='mark[]' value='{$row['CurrentMark']}' ></td>";
            $rows .= "<td><input type='number' style='height: 23px;'  class='form-control' name='final_mark[]' disabled value='{$row['FinalMark']}'></td>";
            $rows .= "</tr>";
            
        }

        echo $rows;
    }

    mysqli_close($conn);
?>


