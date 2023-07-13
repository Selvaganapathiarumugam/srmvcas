<?php 
    ob_start();
    session_start();
    error_reporting(0); 
    include('../links.php');
    include('../connect.php');
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    } 
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance</title>
</head>
<body class="ovflow-y">
    <div class="border-1p" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
        <div class="row">
            <div class="col-md-3">
                <h3 class=" padding-base">Attendance</h3>
            </div>
            <div class="col-md-6">
                <center><h3 class="">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
            </div>
            <div class="col-md-3">
                <div class="row">
                    <div class="col-md-6">

                    </div>
                    <div class="col-md-6">
                        <div class="margin-top-base" >
                            <a href="../index.php" class="btn btn-primary btn-sm" style="color: #fff;">
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
                <div class="co-md-1"></div>
                <div class="col-md-3 col-sm-6">
                    <div class="padding-base">
                        <div class="card" id="mycard">
                            <div class="card-body">
                                <center><img src="../images/atten_1.png" width="100px" height="70px"/><center>
                                <div class="margin-top-base">
                                    <a href="./absentindex.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>Hour Based Absent</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="padding-base">
                        <div class="card" id="mycard">
                            <div class="card-body">
                                <center><img src="../images/atten_3.png" width="100px" height="70px"/><center>
                                <div class="margin-top-base">
                                    <a href="./bulkImport.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>Day Attendance</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="co-md-1"></div>
            </div>
        </div>
    </div>
</body>
</html>