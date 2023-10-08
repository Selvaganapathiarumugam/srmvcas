<?php
    ob_start();
    session_start();
    error_reporting(0);

    if(!isset($_SESSION['Username'])) {
        header("Location:./login.php");
    }
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SRMVCAS</title>
    <link rel="stylesheet" type="text/css" href="./css/main.css">
    <link rel="stylesheet" type="text/css" href="./css/Bootstrap.css">
    <link rel="stylesheet" type="text/css" href="./css/jquery.dataTables.css">
    <link rel="stylesheet" type="text/css" href="./css/fontawesome.css">
    <link rel="shortcut icon" href="./images/favicon/favicon.ico" type="image/x-icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200&display=swap" rel="stylesheet">
    <script src="./js/popper.js"></script>
    <script src="./js/Bootstrap.js"></script>
    <script src="./js/jquery.js"></script>
    <script src="./js/jquery.dataTables.js"></script>
    <script src="./js/fontawesome.js"></script>
    <script src="./js/sweetalert.js"></script>
</head>
<body class="ovflow-y">
    <div >
        <div class="row">
            <div class="col-md-12">
                <?php include("header.php"); ?>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="margin-top-base padding-base">
            <div class="row ">
                <div class="col-md-3 col-sm-6">
                    <div class="card" id="mycard">
                        <div class="card-body">
                            <a href="./student/index.php">
                                <center>
                                    <img src="./images/student.png" width="61px" height="61px"/>
                                <center>
                            </a>
                            <div class="margin-top-base">
                                <a class="btn btn-primary btn-sm"  href="./student/index.php"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>STUDENTS</a>
                            </div>
                        </div>
                        
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="card" id="mycard">
                        <div class="card-body">
                            <center><img src="./images/depart.png" width="61px" height="61px"/><center>
                            <div class="margin-top-base">
                                <a href="./Department/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff; margin-right:4px;"></i>DEPARTMENTS</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="card" id="mycard">
                        <div class="card-body">
                            <center><img src="./images/course.png" width="61px" height="61px"/><center>
                            <div class="margin-top-base">
                                <a href="./Course/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>COURSES</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="card" id="mycard">
                        <div class="card-body">
                            <center><img src="./images/staff.png" width="61px" height="61px"/><center>
                            <div class="margin-top-base">
                                <a href="./Staff/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>STAFF</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-3 col-sm-6">
                        <div class="card" id="mycard">
                            <div class="card-body">
                                <center><img src="./images/setting.png" width="61px" height="61px"/><center>
                                <div class="margin-top-base">
                                    <a href="./permission/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>USER RIGHTS</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="card" id="mycard">
                            <div class="card-body">
                                <center><img src="./images/timetable.png" width="61px" height="61px"/><center>
                                <div class="margin-top-base">
                                    <a href="./Timetable/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>TIME TABLE</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="card" id="mycard">
                            <div class="card-body">
                                <center><img src="./images/atten_2.png" width="61px" height="61px"/><center>
                                <div class="margin-top-base">
                                    <a href="./Attendance/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>ATTENDANCE</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="card" id="mycard">
                            <div class="card-body">
                                <center><img src="./images/atten_1.png" width="61px" height="61px"/><center>
                                <div class="margin-top-base">
                                    <a href="./lateAttendance/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>LATE ATTENDANCE</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-3 col-sm-6">
                        <div class="card" id="mycard">
                            <div class="card-body">
                                <center><img src="./images/exam.png" width="61px" height="61px"/><center>
                                <div class="margin-top-base">
                                    <a href="./internal/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>INTERNAL PORTAL</a>
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