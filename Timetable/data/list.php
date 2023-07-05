<?php
    include('../../connect.php');
    error_reporting(0); 

    // fetch records
    $SQL="SELECT tt.id,U.fullname,d.dname,tt.year,tt.Semester,c.courseCode,
                 c.courseName,tt.SubjectCore,tt.DayOrder,tt.subjectHour
          from  tbltimetable tt
          inner join tbldepartment d on tt.deptid = d.id
          inner join  tblcourse c on tt.SubjectId= c.id
          inner join  tblusers U on tt.Staffid= U.id
          ORDER BY tt.id asc ";
    $result = mysqli_query($conn,$SQL);

    while($row = mysqli_fetch_array($result)) 
    {
        $array[] = $row;
    }

    $dataset = array(
        "totalrecords" => count($array),
        "totaldisplayrecords" => count($array),
        "data" => $array
    );
    if($_POST["mode"]=="cid")
    {	
        $srchQuery = "SELECT courseCode FROM tblcourse WHERE  id = ". $_POST["cid"];
        $srchRecords = mysqli_query($conn,$srchQuery);
        //echo $srchRecords;die();

        $code="";
        while($row = mysqli_fetch_array($srchRecords))
        {
            $code = $row['courseCode'];
        }
        echo $code; die();
    }
    
    mysqli_close($conn);
    header('Content-Type: application/json');
    echo json_encode($dataset);
?>