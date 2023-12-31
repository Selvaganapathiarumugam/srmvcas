<?php
    include('../../connect.php');
    error_reporting(0); 
   
    if($_SERVER['REQUEST_METHOD'] === 'POST' &&  isset($_POST['ExCode']))
    {
        $ExCode = $_POST['ExCode'];
        $sql = "SELECT Name, Maxmark, Convertmark,Year
                FROM tblinternalexam 
                WHERE Code  = '$ExCode'";
        $result = mysqli_query($conn, $sql);
        if ($result && mysqli_num_rows($result) > 0)
        {
            $row = mysqli_fetch_assoc($result);
            $response = array(
                'Name' => $row['Name'],
                'Maxmark' => $row['Maxmark'],
                'Convertmark' => $row['Convertmark'],
                'Year' => $row['Year']
            );
            echo json_encode($response);die();
        }
        else
        {
            $response = array('error' => 'No data found');
            echo json_encode($response);
        }
    } 
    if($_SERVER['REQUEST_METHOD'] === 'POST' &&  isset($_POST['type']))
    {
        $type = $_POST['type'];
        $year = $_POST['year'];
        $sql = "SELECT Code, Name
                FROM tblinternalexam 
                WHERE Type  = '$type' and year='$year'";
        $result = mysqli_query($conn, $sql);
        $rows = "<option id=''>Select a exam</option>";
        if ($result && mysqli_num_rows($result) > 0)
        {
            while ($row = mysqli_fetch_assoc($result)) {
                // Use single quotes for the 'id' attribute
                $rows .= "<option id='{$row['Code']}'>";
                $rows .= "{$row['Name']}";
                $rows .= "</option>";
            }
            echo $rows;
            die();
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