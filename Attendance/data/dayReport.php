
<?php    
    ob_start();
    session_start();
    error_reporting(0);
    include('../../connect.php');

    $startDate = $_GET['at_sdate'];
    $endDate = $_GET['at_ldate'];

    $sql = "SELECT regno,date, status FROM tbldayattendance 
            WHERE date BETWEEN '". $startDate ." ' AND ' ".$endDate ."' order by regno asc;";
    //echo $sql;die();
    $result = mysqli_query($conn, $sql);
   // print_r($result); die();

    $data = array();
    while ($row = mysqli_fetch_array($result)) {
        $regno = $row['regno'];
        $date= $row['date'];
        $status= $row['status'];
        $statusArray = json_decode($status,true);
        $data[] = array('Regno' => $regno,"date" =>$date, 'Status' => $status);
    }
    
    mysqli_close($conn);
    
    echo json_encode(array('startDate' => $startDate, 'endDate' => $endDate, 'data' => $data));
    ?>