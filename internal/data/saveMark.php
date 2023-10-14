<?php
    ob_start();
    session_start();
    error_reporting(0);
    include('../../connect.php');

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
        $count = count($StudentNo);

        for ($i = 0; $i < $count; $i++) 
        {
            $regno = $StudentNo[$i]; 
            $courseCode = strtoupper($courseCode);
            $mark = $studentMarks[$i];
            $finalmark = $finalmarks[$i];
            $sql = "INSERT INTO tblinternalmarks (ExamCode, RegNo, DeptId, Semester, Year, CourseCode, CurrentMark, FinalMark, CreatedBy)
              VALUES ('$ExCode', '$regno', $departmentId, '$semester', '$year', '$courseCode', $mark, $finalmark, '$Author')";

            if (mysqli_query($conn, $sql))
            {
                $response = "Marks saved successfully!";
            } 
            else 
            {
                $response = "Error inserting data: " . mysqli_error($conn);
            }
        }
        echo $response;
    }
    mysqli_close($conn);
?>