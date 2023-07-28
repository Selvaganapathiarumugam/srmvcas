
<?php    
    ob_start();
    session_start();
    //error_reporting(0);
    // Your MySQLi procedural method database connection
    include('../../connect.php');

    $startDate = $_GET['at_sdate'];
    $endDate = $_GET['at_ldate'];

    $sql = "SELECT regno,date, status FROM tbldayattendance 
            WHERE date BETWEEN '". $startDate ." ' AND ' ".$endDate ."' order by date asc;";
    //echo $sql;die();
    $result = mysqli_query($conn, $sql);
   // print_r($result); die();
    //while ($row = mysqli_fetch_array($result)) {
      //  $data[] = $row;
    //}
    //$dataset = array(
        //"startDate" => $startDate,
      //  "endDate" =>  $endDate,
    //    "data" => $data
   //);
    //print_r($data);die();
    //mysqli_close($conn);
    //header('Content-Type: application/json');
    // Send the JSON response back to the client
    //echo json_encode($dataset); 
    $data = array();
    while ($row = mysqli_fetch_array($result)) {
        $regno = $row['regno'];
        $date= $row['date'];
        $status= $row['status'];
        $statusArray = json_decode($status,true);
        $data[] = array('Regno' => $regno,"date" =>$date, 'Status' => $status);
    }
    
    mysqli_close($conn);
    
    // Send the JSON response back to the client
    echo json_encode(array('startDate' => $startDate, 'endDate' => $endDate, 'data' => $data));
    ?>