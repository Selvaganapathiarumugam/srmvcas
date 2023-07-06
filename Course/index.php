
<?php
    ob_start();
    session_start();
    error_reporting(0);

    include('../connect.php');
    include("../links.php");
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    }
    if(isset($_REQUEST["did"]))
    {
        $id=$_REQUEST['did'];
        $SQL="delete from tblcourse where Id='". $id."'";
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
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course</title>
</head>

<body class="ovflow-y">
<div class="row" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
        <div class="col-md-3">
            <h3 class=" padding-base">Course</h3>
        </div>
        <div class="col-md-6">
            <center><h3 class="">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
        </div>
        <div class="col-md-3">
            <div class="row">
                <div class="col-md-6">

                </div>
                <div class="col-md-6">
                    <div class="margin-top-base">
                        <a href="../index.php" class="btn btn-primary btn-sm ">
                            <i class="fa-solid fa-backward" style="color: #fff;"></i>
                            Back
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div> 
    <div class="container">
        <div class="row margin-top-base">
            <div class="col-md-6">
            </div>
            <div class="col-md-6">
                <div class="margin-top-base">
                    <a href="./course.php" class="btn btn-info btn-sm margin-bottom-base" style="color: #fff;float:right;">
                        <i class="fa fa-plus " ></i>
                        <b>Add New Course</b>
                    </a>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table id="tblcourses" class="table table-responsive table-hover" cellspacing="0">
                    <thead>
                        <tr>
                        <th scope="col">courseCode</th>
                        <th scope="col">courseName</th>
                         <th scope="col">Department</th>
                         <th scope="col">semester</th>
                         <th scope="col">year</th>
                         <th scope="col">AcadamicYear</th>
                         <th scope="col">Edit</th>
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
    $('#tblcourses').dataTable({
        "processing": true,
        "ajax": "./data/course.php",
        "columns": [
            {data: 'courseCode'},
            {data: 'courseName'},
            {data: 'dname'},
            {data: 'semester'},
            {data: 'year'},
            {data: 'AcadamicYear'},
            { 
                data: '',
                render: (data,type,row) => {
                 return `<a href='course.php?id=${row.id}'><i class="fa fa-pencil"></i></a>`;
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

