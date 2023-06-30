<?php
ob_start();
session_start();
error_reporting(0); 
?>

<?php
    include('../connect.php');
    include('../links.php');
    if(isset($_POST['btnAdd']))
    {
       $dname =  trim($_REQUEST['dname']);
       $SQL="insert into  tbldepartment (dname) values('". $dname ."')";
       $result = mysqli_query($conn,$SQL);
    }
    if(isset($_REQUEST["id"]))
    {
       $id=$_REQUEST['id'];
       $SQL="SELECT id ,dname from tbldepartment WHERE ID=".$_REQUEST["id"];
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
       $SQL="update tbldepartment set dname ='". $dname ."' where Id='". $id."'";
       try 
        {
           $result = mysqli_query($conn,$SQL);
        } 
        catch (\Throwable $th) 
        {
           throw $th;
        }
       $dname="";
       $id="";
       $_REQUEST['id']="";

    }
    if(isset($_REQUEST["did"]))
    {
       $id=$_REQUEST['did'];
       $SQL="delete from tbldepartment where Id='". $id."'";
       try 
        {
           $result = mysqli_query($conn,$SQL);
        } 
        catch (\Throwable $th) 
        {
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
</head>
<body>
    <div class="row" style="border:1px solid #ffb9b9;">
        <div class="col-md-3">
            <h3>Department List</h3>
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
                        <a href="../index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-backward" style="color: #fff;"></i> Back</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-6">
            </div>
            <div class="col-md-6">
                <h3 class="box-title">
                    <?php 
                        if(isset($_REQUEST["id"])){
                            echo "Edit Department";
                        }else{
                            echo "Add Department";
                        }
                    ?>
                </h3>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <table id="tblDepartments" class="table table-hover" cellspacing="0">
                    <thead>
                        <tr>
                         <th scope="col">ID</th>
                         <th scope="col">Name</th>
                         <th scope="col">Edit</th>
                         <th scope="col">Delete</th>

                        </tr>
                    </thead>
                </table> 
            </div>
            <div class="col-md-6">
                <div class="p-5 mb-4 bg-light rounded-3" style="margin-left:30px;height: 100% !important;">
                    <form method="POST" action="addDepartment.php" class="form-horizontal">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="input1" class="form-label">Department </label>
                                </div>
                                <div class="col-md-6">
                                    <input type="text" name="dname" class="form-control" id="input1" value="<?php ECHO $dname; ?>"
                                        placeholder="Department Name" required  autocomplete="off"
                                    />
                                    <input type="hidden" name="id" class="form-control" id="input1" value="<?php ECHO $id; ?>"
                                    />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6 col-lg-6 "></div>
                                <div class="col-md-6 col-lg-6 ">
                                    <?php if (isset($_REQUEST["id"])) { ?>
                                    <input type="submit" class="btn btn-primary btn-sm margin-top-base" value="Edit" name="btnEdit" />
                                    <?php } else { ?>
                                    <input type="submit" class="btn btn-primary btn-sm margin-top-base" value="Add" name="btnAdd" />
                                </div>
                                <?php } ?>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
  $(document).ready(function() {
    $('#tblDepartments').dataTable({
        "processing": true,
        "ajax": "./data/department.php",
        "columns": [
            {data: 'id'},
            {data: 'dname'},
            { 
                data: '',
                render: (data,type,row) => {
                 return `<a href='addDepartment.php?id=${row.id}'><i class="fa fa-pencil"></i></a>`;
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

