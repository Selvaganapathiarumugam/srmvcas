<?php
    include('../../connect.php');
    error_reporting(0); 
    if ($_SERVER["REQUEST_METHOD"] == "POST" ) {

        $year = $_POST['year'];
        $type = $_POST['type'];


        $sql = " SELECT Count(*) as Row_Order FROM `tblinternalexam` 
        WHERE  `Type`='$type' AND  `Year`='$year' AND isActive =1 ";
        //echo $sql; die();
        $result = mysqli_query($conn, $sql);

        while ($row = mysqli_fetch_assoc($result)) {
            $rows =$row["Row_Order"] ;
           
        }
        echo $rows+1;
    }

    mysqli_close($conn);
?>