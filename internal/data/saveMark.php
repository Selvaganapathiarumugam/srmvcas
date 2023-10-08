<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');
    
    if ($_SERVER["REQUEST_METHOD"] === "POST") 
    {
       
        $courseCodes  = $_POST['courseCode'];
        $studentMarks = $_POST['studentMarks'];
        $finalmarks   = $_POST['finalmark'];
        $departmentId = $_POST["departmentId"];
        $semester     = $_POST["semester"];
        $year         = $_POST["year"];
        $StudentNo    = strtoupper($_POST["StudentNo"]);
        $ExCode       = $_POST["ExCode"];
        $Author       = $_SESSION['EmpId'];
        $count = count($courseCodes);
        // var_dump($courseCodes);
        // var_dump($studentMarks);
        // die();
        
        $checkSQL="SELECT count(*) as Total FROM tblinternalmarks where RegNo ='".$StudentNo."' and
        ExamCode='". $ExCode ."'; ";
        
        $result=mysqli_query($conn, $checkSQL);
        $value = mysqli_fetch_array($result);
       
        if($value['Total'] == 0)
        {
      
            for ($i = 0; $i < $count; $i++) {
                $courseCode = strtoupper($courseCodes[$i]);
                $mark = $studentMarks[$i];
                $finalmark= $finalmarks[$i];

              $sql = "INSERT INTO tblinternalmarks (ExamCode,RegNo,DeptId,Semester,Year,CourseCode,CurrentMark,FinalMark,CreatedBy)
                      VALUES('$ExCode','$StudentNo',$departmentId,'$semester','$year','$courseCode',$mark,$finalmark,'$Author')";
                //echo $sql;
                //die();   
                if (mysqli_query($conn, $sql)) 
                {
                  $response = "Marks saved successfully!";
                } 
                else 
                {
                
                    $response = "Error insert Data";
                    exit; 
                }
            }
            echo $response;
        }
        else
        {
            echo "The internal mark has already been given to this student.";
        }
    }

    mysqli_close($conn);
?>