<?php 
    ob_start();
    session_start();
    //error_reporting(0); 
    include('../links.php');
    include('../connect.php');
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    } 
    $txtdate = $_REQUEST['date'];
    $txtRegno=$_REQUEST["id"];
    $query = "SELECT id, isAbsent FROM tblAttendance
    where date='$txtdate' and regno ='$txtRegno' and SubjectHour=1";
    $result = mysqli_query($conn, $query);
    // print_r($result);die();
    $row = mysqli_fetch_assoc($result);
    $txthouri=$row["isAbsent"];
    $txtidi=$row["id"];

    $queryii = "SELECT id, isAbsent FROM tblAttendance
    where date='$txtdate' and regno ='$txtRegno' and SubjectHour=2";
    $resultii = mysqli_query($conn, $queryii);
    // print_r($result);die();
    $rowii = mysqli_fetch_assoc($resultii);
    $txthourii=$rowii["isAbsent"];
    $txtidii=$row["id"];

    $queryiii = "SELECT id, isAbsent FROM tblAttendance
    where date='$txtdate' and regno ='$txtRegno' and SubjectHour=3";
    $resultiii = mysqli_query($conn, $queryiii);
    // print_r($result);die();
    $rowiii = mysqli_fetch_assoc($resultiii);
    $txthouriii=$rowiii["isAbsent"];
    $txtidiii=$row["id"];

    $queryiv = "SELECT id, isAbsent FROM tblAttendance
    where date='$txtdate' and regno ='$txtRegno' and SubjectHour=4";
    $resultiv = mysqli_query($conn, $queryiv);
    // print_r($result);die();
    $rowiv = mysqli_fetch_assoc($resultiv);
    $txthouriv=$rowiv["isAbsent"];
    $txtidiv=$row["id"];

    $queryv = "SELECT id, isAbsent FROM tblAttendance
    where date='$txtdate' and regno ='$txtRegno' and SubjectHour=5";
    $resultv = mysqli_query($conn, $queryv);
    // print_r($result);die();
    $rowv = mysqli_fetch_assoc($resultv);
    $txthourv=$rowv["isAbsent"];
    $txtidv=$row["id"];

   
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body class="ovflow-y">
    <div class="border-1p" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
        <div class="row">
            <div class="col-md-9">
                <center><h3 class="">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science <br /> Coimbatore 641020</h3></center>
            </div>
            <div class="col-md-3">
                <div class="row">
                    <div class="col-md-6">

                    </div>
                    <div class="col-md-6">
                        <div class="margin-top-base" >
                            <a href="./index.php" class="btn btn-primary btn-sm" style="color: #fff;">
                                <i class="fa-solid fa-backward"></i> 
                                <b>BACK</b>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
    </div>
    <div class="margin-top-base">
        <div class="container">
            <div class="row">
                <div class="col-md-2">
                    <div class="card">
                        <div class="row">
                            <div class="col-md-12">
                                <label for="regno">Reg.NO</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <input type="text" name="txtRegno" class="form-control" autocomplete="off" 
                                value = "<?php echo $txtRegno; ?>" disabled />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="card" >
                        <div class="row">
                            <div class="col-md-12">
                                <label for="regno">DATE</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <input type="text" name="txtDate" class="form-control" autocomplete="off" 
                                 value = "<?php echo date("d/m/Y",strtotime($txtdate)); ?>" disabled />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <div class="card" >
                        <div class="row">
                            <div class="col-md-12">
                               <p class="padding-base">Please Enter 1 and 0 . If 1 is Absent &<br /> 0 is present</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div>
        <marquee>Please verify the attendance</marquee>
    </div>
    <div class="margin-top-base">
        <div class="container">
            <div class="row">
                <div class="col-md-2">

                </div>
                <div class="col-md-6">
                    <form action="" method="POST" class="card padding-base">
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <p>I<sup>st</sup> Hour</p>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <input type="text" name="txthouri" class="form-control" autocomplete="off" 
                                    value = "<?php echo $txthouri; ?>" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <p>II<sup>end</sup> Hour</p>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <input type="text" name="txthourii" class="form-control" autocomplete="off" 
                                    value = "<?php echo $txthourii; ?>" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <p>III<sup>rd</sup>  Hour</p>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <input type="text" name="txthouriii" class="form-control" autocomplete="off" 
                                    value = "<?php echo $txthouriii; ?>"  />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <p>IV<sup>th</sup> Hour</p>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <input type="text" name="txthouriv" class="form-control" autocomplete="off" 
                                    value = "<?php echo $txthouriv; ?>"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <p>V<sup>th</sup> Hour</p>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <input type="text" name="txthourv" class="form-control" autocomplete="off" 
                                    value = "<?php echo $txthourv; ?>" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    
                                </div>
                            </div>
                            <div class="col-md-5">
                                <div class="form-group">
                                    <input type="submit" name="btnsave" class="btn btn-primary"  value="Save" 
                                     />
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md-2">
                    
                </div>
            </div>
        </div>
    </div>
</body>
</html>