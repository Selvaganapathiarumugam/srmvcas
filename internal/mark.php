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
       $SQL="delete from tblinternalmarks where Id='". $id."'";
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
  <title>Internal Marks</title>    
</head>
<body class="ovflow-y">
  <div id="header">
    <div class="row">
        <div class="col-md-3" >
            <p id="headerUser">Internal Mark</p>
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
                        <a href="./index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-backward" style="color: #fff;"></i> Back</a>
                    </div>
                </div>
            </div>
        </div>
    </div> 
  </div>
  <div class="container" style="background-color:#EFEFEE">
    <div class="row">
      <div class="col-sm-6-12 col-md-6 col-lg-6">
      </div>
      <div class="col-sm-6-12 col-md-6 col-lg-6">
        <div class="margin-top-base">
          <a href="./internalMark.php" class="btn btn-primary btn-sm margin-bottom-base" style="color: #fff;float:right;">
            <i class="fa fa-plus" ></i><b>Add Exam Mark</b>
          </a>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12 margin-top-base">  
        <div style="overflow:auto">
            <table id="tblInternal" class="table table-hover" width="100%" cellspacing="0">
              <thead>
                <tr>
                  <th scope="col">Exam Name</th>
                  <th scope="col">Department</th>
                  <th scope="col">Reg.No</th>
                  <th scope="col">Name</th>
                  <th scope="col">Course Name</th>
                  <th scope="col">Mark</th>
                  <th scope="col">Final mark</th>
                  <!-- <th scope="col">Edit</th>
                  <th scope="col">Delete</th> -->
                </tr>
              </thead>
            </table>
        </div>
      </div>     
    </div>
  </div>
</body>
<script type="text/javascript">
  $(document).ready(function() {
    $('#tblInternal').dataTable({
        "processing": true,
        "ajax": "./data/marklist.php",
        "columns": [
            {data: 'Name'},
            {data: 'dname'},
            {data: 'RegNo'},
            {data: 'firstName'},
            {data: 'courseName'},
            {data: 'CurrentMark'},
            {data: 'FinalMark'}
            // { 
            //     data: '',
            //     render: (data,type,row) => {
            //      return `<a href='./internal.php?id=${row.Id}'><i class="fa fa-pencil"></i></a>`;
            //     }
            // },
            // { 
            //     data: '',
            //     render: (data,type,row) => {
            //       return `<?PHP if ($_SESSION['Role'] == "1") {?><a onClick=\"javascript: return confirm('Please confirm deletion');\" href='index.php?did=${row.Id}'><i class="fa fa-trash"></i></a>
            //     <?php } else{ ?><i class="fa fa-trash"></i><?php } ?>`;
            //     }
            //}
        ]
    });
  });
</script>
</html>
