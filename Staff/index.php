<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include("../links.php");
    include("../connect.php");
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    }
    if(isset($_REQUEST["did"]))
    {
        $id=$_REQUEST['did'];
        $SQL="delete from tblusers where Id='". $id."'";
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
    <title>Staff</title>
</head>

<body class="ovflow-y">
    <div  id="header">
        <div class="row">
            <div class="col-md-3">
                <p id="headerUser">Staff List</p>
            </div>
            <div class="col-md-6">
                <center><h3 id="clgname">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
            </div>
            <div class="col-md-3">
                <div class="row ">
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
    <div class="container" style="background-color:#EFEFEE">
        <div class="row">
            <div class="col-md-6">
            </div>
            <div class="col-md-6">
                <a href="./staff.php" class="btn btn-primary btn-sm margin-bottom-base" style="float:right;">
                    <i class="fa fa-plus" ></i>
                    <b>Add New Staff</b>
                </a>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table id="tblStaff" class="table table-responsive table-hover" cellspacing="0">
                    <thead>
                        <tr>
                         <th scope="col">Staff Id</th>
                         <th scope="col">Name</th>
                         <th scope="col">Phone</th>
                         <th scope="col">DOJ</th>
                         <th scope="col">Role</th>
                         <th scope="col">Department</th>
                         <th scope="col">Edit</th>
                         <th scope="col">Delete</th>
                        </tr>
                    </thead>
                </table> 
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#tblStaff').dataTable({
                "processing": true,
                "ajax": "./data/list.php",
                "columns": [
                    {data: 'EmpId'},
                    {data: 'fullname'},
                    {data: 'phone'},
                    {data: 'doj'},
                    {data: 'Description'},
                    {data: 'dname'},
                    { 
                        data: '',
                        render: (data,type,row) => {
                         return `<a href='staff.php?id=${row.id}'><i class="fa fa-pencil" style="color: #005eff;"></i></a>`;
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
</body>
</html>
