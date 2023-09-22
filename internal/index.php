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
       $SQL="delete from tblinternalexam where code='". $id."'";
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
  <title>Internal Exam</title>    
</head>
<body class="ovflow-y">
  <div class="row" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
    <div class="col-md-3">
      <h3 class=" padding-base">Internal Exam </h3>
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
      <div class="col-sm-6-12 col-md-6 col-lg-6">
        <div class="margin-top-base">
          <a href="./internalMark.php" class="btn btn-primary btn-sm margin-bottom-base" style="color: #fff;float:left;">
            <i class="fa fa-plus" ></i><b>Add Exam Mark</b>
          </a>
        </div>
      </div>
      <div class="col-sm-6-12 col-md-6 col-lg-6">
        <div class="margin-top-base">
          <a href="./internal.php" class="btn btn-info btn-sm margin-bottom-base" style="color: #fff;float:right;">
            <i class="fa fa-plus" ></i><b>Add New Exam Type</b>
          </a>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12 margin-top-base">  
        <table id="tblInternal" class="display" width="100%" cellspacing="0">
          <thead>
            <tr>
              <th scope="col">Exam Code</th>
              <th scope="col">Name</th>
              <th scope="col">Type</th>
              <th scope="col">Year</th>
              <th scope="col">Max-Mark</th>
              <th scope="col">Convert mark</th>
              <th scope="col">Author</th>
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
    $('#tblInternal').dataTable({
        "processing": true,
        "ajax": "./data/list.php",
        "columns": [
            {data: 'Code'},
            {data: 'Name'},
            {data: 'Type'},
            {data: 'Year'},
            {data: 'Maxmark'},
            {data: 'Convertmark'},
            {data: 'fullname'},
            { 
                data: '',
                render: (data,type,row) => {
                 return `<a href='./internal.php?id=${row.Code}'><i class="fa fa-pencil"></i></a>`;
                }
            },
            { 
                data: '',
                render: (data,type,row) => {
                  return `<?PHP if ($_SESSION['Role'] == "1") {?><a onClick=\"javascript: return confirm('Please confirm deletion');\" href='index.php?did=${row.Code}'><i class="fa fa-trash"></i></a>
                <?php } else{ ?><i class="fa fa-trash"></i><?php } ?>`;
                }
            }
        ]
    });
  });
</script>
</html>
