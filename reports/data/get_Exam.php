<?php
    include('../../connect.php');
    error_reporting(0); 

    if ($_SERVER["REQUEST_METHOD"] == "POST" ) {

        $departmentId = $_POST['departmentId'];
       
        // Start with an empty option
        $rows = "<option id=''></option>";
        
        $SQL=" Select Type from tblDepartment  WHERE Id = '$departmentId';";
        //echo $SQL;Die();
        $result = mysqli_query($conn,$SQL);
    
        if ($result) {
            $row = mysqli_fetch_array($result);
            if ($row) {
                $value = $row['Type'];
            } else {
                $value = "Not found";
            }
        } else {
            $value = "Error fetching data";
        }
        
        $sql = "SELECT Code, Name FROM  tblinternalexam
        where Type ='$value'
        ORDER BY Code ASC";
        //echo $sql;Die();
        $result = mysqli_query($conn, $sql);

        while ($row = mysqli_fetch_assoc($result)) {
            // Use single quotes for the 'id' attribute
            $rows .= "<option id='{$row['Code']}'>";
            $rows .= "{$row['Name']}";
            $rows .= "</option>";
        }
        echo $rows;
    }

    mysqli_close($conn);
?>