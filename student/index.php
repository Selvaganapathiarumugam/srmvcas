<?php
  ob_start();
  session_start();
  error_reporting(0);
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
  <?php include('../links.php'); ?>
  <title>Student</title>    
</head>
<body class="ovflow-y">
  <div class="row" id="header">
    <div class="col-md-3">
      <p id="headerUser">All Students</p>
    </div>
    <div class="col-md-6">
      <center><h3 id="clgname">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
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
  <div class="container" style="background-color:#EFEFEE">
    <div class="row">
      <div class="col-sm-6-12 col-md-6 col-lg-6"></div>
      <div class="col-sm-6-12 col-md-6 col-lg-6">
        <div class="margin-top-base">
          <a href="./student.php" class="btn btn-primary btn-sm margin-bottom-base" style="color: #fff;float:right;">
            <i class="fa fa-plus" ></i><b>Add New Student</b>
          </a>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12 margin-top-base">  
        <table id="tblStudents" class="table table-hover" width="100%" cellspacing="0">
          <thead>
            <tr>
              <th scope="col">Register No</th>
              <th scope="col">Name</th>
              <th scope="col">Department</th>
              <th scope="col">Year</th>
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
            {data: 'year'},
            {data: 'semester'},
            {data: 'batch'},
            {data: 'email'},
            { 
                data: '',
                render: (data,type,row) => {
                 return `<a href='./student.php?id=${row.id}'><i class="fa fa-pencil"></i></a>`;
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
