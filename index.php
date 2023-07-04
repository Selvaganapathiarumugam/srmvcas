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
    <script src="./js/popper.js"></script>
    <script src="./js/Bootstrap.js"></script>
    <script src="./js/jquery.js"></script>
    <script src="./js/jquery.dataTables.js"></script>
    <script src="./js/fontawesome.js"></script>
    <script src="./js/sweetalert.js"></script>
</head>
<body class="ovflow-y">
    <div class="margin-top-base" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
        <div class="row">
            <div class="col-md-12">
                <?php include("header.php"); ?>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="margin-top-base">
            <div class="row ">
                <div class="col-md-3 col-sm-6">
                    <div class="card" id="mycard">
                        <div class="card-body">
                            <center><img src="./images/tcrl.png" width="100px" height="70px"/><center>
                            <div class="margin-top-base">
                                <a href="./student/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>Go Student</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="card" id="mycard">
                        <div class="card-body">
                            <center><img src="./images/tcrl.png" width="100px" height="70px"/><center>
                            <div class="margin-top-base">
                                <a href="./Department/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff; margin-right:4px;"></i>Go Department</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="card" id="mycard">
                        <div class="card-body">
                            <center><img src="./images/tcrl.png" width="100px" height="70px"/><center>
                            <div class="margin-top-base">
                                <a href="./Course/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>Go Course</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="card" id="mycard">
                        <div class="card-body">
                            <center><img src="./images/tcrl.png" width="100px" height="70px"/><center>
                            <div class="margin-top-base">
                                <a href="./Staff/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>Go Staff</a>
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
                            <center><img src="./images/tcrl.png" width="100px" height="70px"/><center>
                            <div class="margin-top-base">
                                <a href="./Timetable/index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-forward " style="color: #fff;margin-right:4px;"></i>Time Table</a>
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