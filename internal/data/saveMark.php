<?php
    include('../../connect.php');
    error_reporting(0); 

    if ($_SERVER["REQUEST_METHOD"] == "POST") 
    {

        $courseIds = $_POST['courseId'];
        $studentMarks = $_POST['studentMarks'];

        for ($i = 0; $i < count($courseIds); $i++) {
            $courseId = $courseIds[$i];
            $mark = $studentMarks[$i];


            $sql = "INSERT INTO mark (courseId, studentMark) VALUES ('$courseId', '$mark')";

            if (mysqli_query($conn, $sql)) {
              
            } 
            else 
            {
               
                echo "Error: " . $sql . "<br>" . mysqli_error($conn);
                exit; 
            }
        }
        echo "Student marks saved successfully!";
    }

    mysqli_close($conn);
?>