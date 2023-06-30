<?php
ob_start();
session_start();
error_reporting(0); 
?>

<?php
    include('../connect.php');
    if(isset($_REQUEST["id"]))
    {
        $id=$_REQUEST['id'];
        $SQL="SELECT id ,dname from tblcourse WHERE ID=".$_REQUEST["id"];
        $result = mysqli_query($conn,$SQL);
        while($row = mysqli_fetch_array($result)) 
        {
            $dname = $row['dname'];
        }
    }
    if(isset($_POST['btnEdit']))
    {
        $SQL="";
        $dname =  trim($_REQUEST['dname']);
        $SQL="update tblcourse set dname ='". $dname ."' where Id='". $id."'";
        try {
            $result = mysqli_query($conn,$SQL);

        } catch (\Throwable $th) {
            throw $th;
        }
        $dname="";
        $id="";
        $_REQUEST['id']="";
    }
    if(isset($_REQUEST["did"]))
    {
        $id=$_REQUEST['did'];
        $SQL="delete from tblcourse where Id='". $id."'";
        try {
            $result = mysqli_query($conn,$SQL);
        
        } catch (\Throwable $th) {
            throw $th;
        }
        $id="";
        $_REQUEST['did']="";
    }
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Department</title>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <link rel="stylesheet" href="../css/main.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.12/css/jquery.dataTables.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/js/all.min.js" integrity="sha512-fD9DI5bZwQxOi7MhYWnnNPlvXdp/2Pj3XSTRrFs5FQa4mizyGLnJcN6tuvUS6LbmgN1ut+XGSABKvjN0H6Aoow==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js" type="text/javascript"></script>
  <script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.js" charset="utf8" type="text/javascript"></script>
</head>

<body>
<div class="row" style="border:1px solid #ffb9b9;">
        <div class="col-md-3">
            <h3>Course</h3>
        </div>
        <div class="col-md-6">
            <center><h3>Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
        </div>
        <div class="col-md-3">
            <div class="row">
                <div class="col-md-6">

                </div>
                <div class="col-md-6">
                    <div class="margin-top-base">
                        <a href="../index.php" class="btn btn-primary"><i class="fa-solid fa-backward fa-2xl" style="color: #fff;"></i> Back</a>
                    </div>
                </div>
            </div>
        </div>
    </div> 
    <div class="container">
        <div class="row margin-top-base">
            <div class="col-md-6">
                <h3 class="box-title">
                    Course List
               </h3>
            </div>
            <div class="col-md-6">
                <a href="./course.php" class="btn btn-info">
                    <i class="fa fa-plus"></i>
                    Add New Course
                </a>
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
                 return `<a onClick=\"javascript: return confirm('Please confirm deletion');\" href='addDepartment.php?did=${row.id}'><i class="fa fa-trash"></i></a>`;
                }
            }
            

        ]
    });
  });
</script>
</html>

