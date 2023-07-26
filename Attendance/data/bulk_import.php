<?php
    ob_start();
    session_start();
    //error_reporting(0);
    include('../../connect.php');


    if(isset($_REQUEST['btnbulkimport'])){
        $current_date=$_REQUEST['at_date'];
        $semester=$_REQUEST['at_semester'];
        $department=$_REQUEST['at_dept'];
        $year=$_REQUEST['at_year'];
        $staffId=$_SESSION['EmpId'];

        $check_sql="SELECT  COUNT(*) AS total FROM tbldayattendance WHERE date='". $current_date ."'";
        $check_result = mysqli_query($conn,$check_sql);

       $total= mysqli_fetch_array($check_result);

        if($total['total']==0){

                $aSQL="SELECT A.* FROM ( SELECT regno FROM tblattendance WHERE date = '". $current_date ."' GROUP BY regno HAVING SUM(CASE WHEN IsAbsent = 1 THEN 1 ELSE 0 END) = 5 ) AS A INNER JOIN tblstudent S ON A.regno = S.regNo WHERE S.deptid = '". $department ."' AND S.semester = '". $semester ."' AND S.year = '". $year ."' GROUP BY A.regno;";
                $aresult = mysqli_query($conn,$aSQL);
            while($arow = mysqli_fetch_array($aresult)) 
                {
                $regno=$arow['regno'];
                    $aquery = "INSERT INTO tbldayattendance (deptId,semester,year,regno,status,staffId,date)
                    VALUES ($department, '$semester', '$year', '$regno','A','$staffId','$current_date')";
                    mysqli_query($conn, $aquery);               

                }
                //-------------Present---------------
                $pSQL="SELECT A.* FROM ( SELECT regno FROM tblattendance WHERE date = '". $current_date ."' GROUP BY regno HAVING SUM(CASE WHEN IsAbsent = 0 THEN 1 ELSE 0 END) = 5 ) AS A INNER JOIN tblstudent S ON A.regno = S.regNo WHERE S.deptid = '". $department ."' AND S.semester = '". $semester ."' AND S.year = '". $year ."' GROUP BY A.regno;";

                $presult = mysqli_query($conn,$pSQL);

                while($prow = mysqli_fetch_array($presult)) 
                {

                    $regno=$prow['regno'];

                    $pquery = "INSERT INTO tbldayattendance (deptId,semester,year,regno,status,staffId,date)
                    VALUES ($department, '$semester', '$year', '$regno','P','$staffId','$current_date');";
                
                    mysqli_query($conn, $pquery);           

                }           
                
                //---------------Absent - present---------------

                $apSQL="SELECT A.*
                FROM (
                SELECT *
                FROM tblattendance
                WHERE subjectHour IN (4, 5)
                    AND isAbsent = 0
                    and date ='". $current_date ."'
                    AND regno NOT IN (
                    SELECT regno
                    FROM tblattendance
                    GROUP BY regno
                    HAVING SUM(CASE WHEN isAbsent = 1 THEN 1 ELSE 0 END) = 5
                    )
                ) AS A INNER JOIN tblstudent S ON A.regno = S.regNo WHERE S.deptid = '". $department ."' 
                AND S.semester = '". $semester ."' AND S.year = '". $year ."' GROUP BY A.regno;";

                $apresult = mysqli_query($conn,$apSQL);
                
                while($aprow = mysqli_fetch_array($apresult)) 
                {
                
                    $regno=$aprow['regno'];
                
                    $apquery = "INSERT INTO tbldayattendance (deptId,semester,year,regno,status,staffId,date)
                    VALUES ($department, '$semester', '$year', '$regno','AP','$staffId','$current_date');";
                    mysqli_query($conn, $apquery);           
                
                }
#---------------------------Pesent Absent ------------------------------------------
                $paSQL="SELECT A.*
                FROM (
                SELECT *
                FROM tblattendance
                WHERE subjectHour IN (4, 5)
                    AND isAbsent = 1
                    and date ='". $current_date ."'
                    AND regno NOT IN (
                    SELECT regno
                    FROM tblattendance
                    GROUP BY regno
                    HAVING SUM(CASE WHEN isAbsent = 0 THEN 1 ELSE 0 END) = 5
                    )
                ) AS A INNER JOIN tblstudent S ON A.regno = S.regNo WHERE S.deptid = '". $department ."' 
                AND S.semester = '". $semester ."' AND S.year = '". $year ."' GROUP BY A.regno;";

                $paresult = mysqli_query($conn,$paSQL);
                
                while($parow = mysqli_fetch_array($paresult)) 
                {
                
                    $regno=$parow['regno'];
                
                    $paquery = "INSERT INTO tbldayattendance (deptId,semester,year,regno,status,staffId,date)
                    VALUES ($department, '$semester', '$year', '$regno','PA','$staffId','$current_date');";
                    mysqli_query($conn, $paquery);           
                
                }
                mysqli_close($conn);
                header("location:../bulkImport.php");            
                    
        }else{
            echo "Already Inserted";
         }

 
    }   

?>