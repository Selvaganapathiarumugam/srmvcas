<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../links.php');
    include('../connect.php');
    if(isset($_REQUEST["did"]))
    {
        $response="";
        $id=$_REQUEST['did'];
        $SQL="delete from tbllackattendance where Id='". $id."'";
        try
        {
            $result = mysqli_query($conn,$SQL);
            echo "<script> deletemsg(); </script>";
        } catch (\Throwable $th) 
        {
            throw $th;
        }
    }
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lack of Attendance</title>
</head>
<body class="ovflow-y">
    <div class="row" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
        <div class="col-md-3">
            <h3 class=" padding-base">Lack of Attendance</h3>
        </div>
        <div class="col-md-6">
            <center><h3 class="">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
        </div>
        <div class="col-md-3">
            <div class="row">
                <div class="col-md-6"></div>
                    <div class="col-md-6">
                        <div class="margin-top-base">
                            <a href="../index.php" class="btn btn-primary btn-sm">
                                <i class="fa-solid fa-backward " style="color: #fff;"></i>
                                <b>BACK</b>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container" style="background-color:rgb(255, 248, 240)">
        <div class="row">
            <div class="col-md-6"></div>  
            <div class="col-md-6">
                <div class="margin-top-base">
                    <a href="./lackAttendance.php" class="btn btn-info btn-sm margin-bottom-base" style="color: #fff;float:right;">
                        <i class="fa fa-plus" ></i><b>Add</b>
                    </a>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 margin-top-base">
                <table id="tbllackatt" class="display" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th scope="col">Reg.NO</th>
                            <th scope="col">Name</th>
                            <th scope="col">Year</th>
                            <th scope="col">Semester</th>
                            <th scope="col">Departmet</th>
                            <th scope="col">Date</th>
                            <!-- <th scope="col">Edit</th> -->
                            <th scope="col">Delete</th>
                        </tr>
                    </thead>
                </table>
            </div>  
        </div>
    </div>
</body>
<script type="text/javascript">
    $(document).ready(function() {
        $('#tbllackatt').dataTable({
            "processing": true,
            "ajax": "./data/list.php",
            "columns": [
                {data: 'regNo'},
                {data: 'firstName'},
                {data: 'year'},
                {data: 'Semester'},
                {data: 'dname'},
                {data: 'date'},
                // { 
                //     data: '',
                //     render: (data,type,row) => {
                //         return `<a href='./timetable.php?id=${row.id}'><i class="fa fa-print"></i></a>`;
                //     }
                // },
                { 
                    data: '',
                    render: (data,type,row) => {
                        return `<?PHP if ($_SESSION['Role'] == "1") {?><a onClick=\"javascript: return confirm('Please confirm deletion');\" href='index.php?did=${row.id}'><i class="fa fa-trash"></i></a>
                    <?php } else{ ?><i class="fa fa-trash"></i><?php } ?>`;
                    }
                }
            ]
        });
    });
</script>
</html>