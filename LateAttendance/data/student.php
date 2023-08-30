<?php
    include('../../connect.php');
    error_reporting(0); 

    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['reg']))
    {
        $number = $_POST['reg'];
        $sql = "SELECT S.firstName, D.dname, S.semester, S.year,S.deptid 
                FROM tblstudent S 
                INNER JOIN tbldepartment D ON S.deptid = D.id
                WHERE S.regNo  = '$number'";
        $result = mysqli_query($conn, $sql);
        if ($result && mysqli_num_rows($result) > 0)
        {
            $row = mysqli_fetch_assoc($result);
            $response = array(
                'firstName' => $row['firstName'],
                'dname' => $row['dname'],
                'semester' => $row['semester'],
                'year' => $row['year'],
                'deptid' => $row['deptid']
            );
            echo json_encode($response);die();
        }
        else
        {
            $response = array('error' => 'No data found');
            echo json_encode($response);
        }
    } 
    else
    {
        $response = array('error' => 'Invalid request');
        echo json_encode($response);
    }
?>