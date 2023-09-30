<?php
    ob_start();
    session_start();
    error_reporting(0); 
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    }

    include('../connect.php');
    include('../links.php');
    if(isset($_REQUEST["did"]))
    {
        $id=$_REQUEST['did'];
        $SQL="delete from tblusersrights where Id='". $id."'";
        try {
            $result = mysqli_query($conn,$SQL);
            echo "<script> deletemsg(); </script>";
        } catch (\Throwable $th) {
            throw $th;
        }
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Permission</title>
</head>
<body class="ovflow-y">
    <div id="header">
        <div class="row">
            <div class="col-md-3" >
                <p id="headerUser">User Rights </p>
            </div>
            <div class="col-md-6">
                <center><h3 id="clgname">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
            </div>
            <div class="col-3">
                <div class="row">
                    <div class="col-md-6">
                    </div>
                    <div class="col-md-6">
                        <div class="margin-top-base">
                            <a href="../index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-backward" style="color: #fff;"></i> Back</a>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
    </div>
    <div class="container" style="background-color:#EFEFEE">
        <div class="row">
            <div class="col-md-10">

            </div>
            <div class="col-md-2">
                <div class="margin-top-base">
                  <a href="./permission.php" class="btn btn-primary btn-sm margin-bottom-base" style="color: #fff;float:right;">
                    <i class="fa fa-plus" ></i><b>Add New Rights</b>
                  </a>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10 overflow-auto">
                <div class="margin-top-base">
                    <table id="tblRights" class="table table-hover table-responsive" width="80%">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Add Student</th>
                                <th>Update Student</th>
                                <th>Add Course</th>
                                <th>Update Course</th>
                                <th>Add Timetable</th>
                                <th>Update Timetable</th>
                                <th>Bulk Attendance</th>
                                <th>Attendance Report</th>
                                <th>Permission</th>
                                <th>Late Attendance</th>
                                <th>Edit</th>
                                <th>Delete</th>
                            </tr>   
                        </thead>
                    </table>
                </div>
            </div>
            <div class="col-md-1"></div>
        </div>
    </div>
</body>
<script type="text/javascript">
    $(document).ready(function() {
        $('#tblRights').dataTable({
            "processing": true,
            "ajax": "./data/list.php",
            "columns": [
                {data: 'username'},
                {data: '',
                    render: (data,type,row) => {
                        var ic1=row.addstudent == 1 ?  '<i class="fa-regular fa-square-check"></i>' :'<i class="fa-regular fa-square">'
                       return `<center>${ic1}</center>`;
                    }
                },
                {data: '',
                    render: (data,type,row) => {
                        var ic1=row.updatestudent == 1 ?  '<i class="fa-regular fa-square-check"></i>' :'<i class="fa-regular fa-square">'
                       return `<center>${ic1}</center>`;
                    }
                },
                {data: '',
                    render: (data,type,row) => {
                        var ic1=row.addcourse == 1 ?  '<i class="fa-regular fa-square-check"></i>' :'<i class="fa-regular fa-square">'
                       return `<center>${ic1}</center>`;
                    }
                },
                {data: '',
                    render: (data,type,row) => {
                        var ic1=row.updatecourse == 1 ?  '<i class="fa-regular fa-square-check"></i>' :'<i class="fa-regular fa-square">'
                       return `<center>${ic1}</center>`;
                    }
                },
                {data: '',
                    render: (data,type,row) => {
                        var ic1=row.addtimetable == 1 ?  '<i class="fa-regular fa-square-check"></i>' :'<i class="fa-regular fa-square">'
                       return `<center>${ic1}</center>`;
                    }
                },
                {data: '',
                    render: (data,type,row) => {
                        var ic1=row.updatetimetable == 1 ?  '<i class="fa-regular fa-square-check"></i>' :'<i class="fa-regular fa-square">'
                       return `<center>${ic1}</center>`;
                    }
                },
                {data: '',
                    render: (data,type,row) => {
                        var ic1=row.bulkattendance == 1 ?  '<i class="fa-regular fa-square-check"></i>' :'<i class="fa-regular fa-square">'
                       return `<center>${ic1}</center>`;
                    }
                },
                {data: '',
                    render: (data,type,row) => {
                        var ic1=row.attendancereport == 1 ?  '<i class="fa-regular fa-square-check"></i>' :'<i class="fa-regular fa-square">'
                        return `<center>${ic1}</center>`;
                    }
                },
                {data: '',
                    render: (data,type,row) => {
                        var ic1=row.permission == 1 ?  '<i class="fa-regular fa-square-check"></i>' :'<i class="fa-regular fa-square">'
                        return `<center>${ic1}</center>`;
                    }
                },
                {data: '',
                    render: (data,type,row) => {
                        var ic1=row.lateAttendance == 1 ?  '<i class="fa-regular fa-square-check"></i>' :'<i class="fa-regular fa-square">'
                        return `<center>${ic1}</center>`;
                    }
                },
                { 
                    data: '',
                    render: (data,type,row) => {
                     return `<a href='permission.php?id=${row.id}'><i class="fa fa-pencil" style="color: #005eff;"></i></a>`;
                    }
                },
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