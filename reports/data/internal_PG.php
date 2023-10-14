<?php
    include('../../connect.php');
    ob_start();
    session_start();
    //error_reporting(0); 
    if ($_SERVER["REQUEST_METHOD"] == "POST") {

        $departmentId = $_POST['departmentId'];
        $year = $_POST['year'];
        $semester = $_POST['semester'];
        $course = $_POST['course'];
        //$SQL="call Sp_FinalInternalReportUG($departmentId,'$year','$semester','$course');";
        $dynamicColumns = "";
        $dynamicColumns2 = "";
        $rowNumber = 1;

        // Query to get dynamicColumns
        $query_dynamicColumns = "SELECT GROUP_CONCAT(DISTINCT
         CONCAT(
         'MAX(CASE WHEN im.ExamCode = ''',
         Code,
         ''' THEN IFNULL(im.CurrentMark, 0) END) AS C', $rowNumber
         )
        ) AS dynamicColumns
        FROM tblinternalexam
        WHERE Type = 'PG'";

        $result_dynamicColumns = mysqli_query($conn, $query_dynamicColumns);
        
        if ($result_dynamicColumns) {
         $row = mysqli_fetch_assoc($result_dynamicColumns);
         $dynamicColumns = $row['dynamicColumns'];
        }

        // Query to get dynamicColumns2
        $query_dynamicColumns2 = "SELECT GROUP_CONCAT(DISTINCT
         CONCAT(
         'MAX(CASE WHEN im.ExamCode = ''',
         Code,
         ''' THEN IFNULL(im.FinalMark, 0) END) AS M', $rowNumber
         )
        ) AS dynamicColumns2
        FROM tblinternalexam
        WHERE Type = 'PG'";

        $result_dynamicColumns2 = mysqli_query($conn, $query_dynamicColumns2);
        
        if ($result_dynamicColumns2) {
         $row = mysqli_fetch_assoc($result_dynamicColumns2);
         $dynamicColumns2 = $row['dynamicColumns2'];
        }

        // Build the main query
        $sql = "SELECT im.CourseCode, im.Id, im.Semester, im.Year, im.RegNo, d.dname, c.courseName,
         $dynamicColumns, $dynamicColumns2
        FROM tblinternalmarks im
        INNER JOIN tbldepartment d ON im.deptid = d.id
        INNER JOIN tblcourse c ON im.CourseCode = c.courseCode
        WHERE im.deptid = $departmentId
         AND im.Year = '$year'
         AND im.Semester = '$semester'
         AND im.CourseCode = '$course'
        GROUP BY im.RegNo";


        // Execute the query
        $result = mysqli_query($conn, $sql);

        //echo $SQL;die();
        //$result = mysqli_query($conn,$SQL);
        $array = array();
        while($row = mysqli_fetch_array($result)) 
        {
            $array[] = $row;
        }
    
        $dataset = array(
            "totalrecords" => count($array),
            "totaldisplayrecords" => count($array),
            "data" => $array
        );
        //$data[] = array('Regno' => $regno,"date" =>$date, 'Status' => $status);
    }
    mysqli_close($conn);
    header('Content-Type: application/json');
    echo json_encode($dataset);
?>