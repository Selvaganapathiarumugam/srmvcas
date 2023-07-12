<?php
  ob_start();
  session_start();
  error_reporting(0);
  include('../links.php');
  include('../connect.php'); 
  if(!isset($_SESSION['Username'])) {
    header("Location:../login.php");
  }
  if(isset($_REQUEST["did"]))
    {
       $id=$_REQUEST['did'];
       $SQL="delete from  tblstudent where Id='". $id."'";
       try 
        {
           $result = mysqli_query($conn,$SQL);
           echo "<script> deletemsg(); </script>";

        } 
        catch (\Throwable $th) 
        {
           throw $th;
        }
    }
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Student</title>    
</head>
<body class="ovflow-y">
  <div class="row" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
    <div class="col-md-3">
      <h3 class=" padding-base">All Students</h3>
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
      <div class="col-sm-6-12 col-md-6 col-lg-6"></div>
      <div class="col-sm-6-12 col-md-6 col-lg-6">
        <div class="margin-top-base">
          <a href="./student.php" class="btn btn-info btn-sm margin-bottom-base" style="color: #fff;float:right;">
            <i class="fa fa-plus" ></i><b>Add New Student</b>
          </a>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12 margin-top-base">  
        <table id="tblStudents" class="display" width="100%" cellspacing="0">
          <thead>
            <tr>
              <th scope="col">Registration No.</th>
              <th scope="col">Name</th>
              <th scope="col">Department</th>
              <th scope="col">Semester</th>
              <th scope="col">Batch</th>
              <th scope="col">Email</th>
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
    $('#tblStudents').dataTable({
        "processing": true,
        "ajax": "./data/list.php",
        "columns": [
            {data: 'regNo'},
            {data: 'firstName'},
            {data: 'dname'},
            {data: 'semester'},
            {data: 'batch'},
            {data: 'email'},
            { 
                data: '',
                render: (data,type,row) => {
                 return `<a href='./Student.php?id=${row.id}'><i class="fa fa-pencil"></i></a>`;
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
