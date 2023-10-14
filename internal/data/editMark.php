<?php
    include('../../connect.php');
    error_reporting(0); 
    session_start();

    if ($_SERVER["REQUEST_METHOD"] === "POST") 
    {
        $courseCode = $_POST['courseCode'];
        $studentMarks = $_POST['studentMarks'];
        $finalmarks = $_POST['finalmark'];
        $departmentId = $_POST["departmentId"];
        $semester = $_POST["semester"];
        $year = $_POST["year"];
        $StudentNo = $_POST["StudentNo"];
        $ExCode = $_POST["ExCode"];
        $Author = $_SESSION['EmpId'];
        $ids = $_POST["Id"];
        $count = count($ids);

        for ($i = 0; $i < $count; $i++) {
            $id = $ids[$i];
            $mark = $studentMarks[$i];
            $finalmark = $finalmarks[$i];

            $sql = "UPDATE tblinternalmarks 
                    SET CurrentMark = $mark, FinalMark = $finalmark, CreatedBy = '$Author'
                    WHERE Id = $id AND ExamCode = '$ExCode' 
                    AND RegNo = '$StudentNo[$i]' 
                    AND DeptId = $departmentId 
                    AND Semester = '$semester' 
                    AND Year = '$year' 
                    AND CourseCode = '$courseCode'";

            if (mysqli_query($conn, $sql)) {
                $response = "Marks updated successfully!";
            } else {
                $response = "Error updating data: " . mysqli_error($conn);
            }
        }

        echo $response;
    }
    mysqli_close($conn);
?>
