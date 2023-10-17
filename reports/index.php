<?php 
    ob_start();
    session_start();
    error_reporting(0); 
    include('../connect.php');
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    } 
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <?php include('../links.php'); ?>
    <title>Reports</title>
</head>
<body class="ovflow-y">
    <div id="header">
        <div class="row">
            <div class="col-md-3">
                <p id="headerUser">Reports</p>
            </div>
            <div class="col-md-6">
                <center><h3 id="clgname">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
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
                                <center><img src="../images/atten_1.png" width="60px" height="61px"/><center>
                                <div class="margin-top-base">
                                    <a href="../Attendance/dayReport.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>Attendence</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="padding-base">
                        <div class="card" id="mycard">
                            <div class="card-body">
                                <center><img src="../images/atten_3.png" width="60px" height="61px"/><center>
                                <div class="margin-top-base">
                                    <a href="./internalMark.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>Internal Subject Reports</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="padding-base">
                        <div class="card" id="mycard" style="display:none;">
                            <div class="card-body">
                                <center><img src="../images/exam.png" width="60px" height="61px"/><center>
                                <div class="margin-top-base">
                                    <a href="./inernalfinal.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>Internal Final PG</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>