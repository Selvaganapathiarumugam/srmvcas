
<?php
include('../links.php');
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Student</title>    
</head>
<body>
  <div class="row" style="border:1px solid #ffb9b9;">
    <div class="col-md-3">
      <h3>All Students</h3>
    </div>
    <div class="col-md-6">
      <center><h3>Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
    </div>
    <div class="col-md-3">
      <div class="row">
        <div class="col-md-6"></div>
          <div class="col-md-6">
            <div class="margin-top-base">
              <a href="../index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-backward " style="color: #fff;"></i> Back</a>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="container">
    <div class="row">
      <div class="col-sm-6-12 col-md-6 col-lg-6"></div>
      <div class="col-sm-6-12 col-md-6 col-lg-6">
        <div class="margin-top-base">
          <a href="./addStudent.php" class="btn btn-info btn-sm margin-bottom-base" style="color: #fff;float:right;">
            <i class="fa fa-plus" ></i><b>Add New Staff</b>
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
        "ajax": "./data/student.php",
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
                 return `<a href='addStudent.php?id=${row.id}'><i class="fa fa-pencil"></i></a>`;
                }
            },
            { 
                data: '',
                render: (data,type,row) => {
                 return `<a onClick=\"javascript: return confirm('Please confirm deletion');\" href='addStudent.php?did=${row.id}'><i class="fa fa-trash"></i></a>`;
                }
            }
        ]
    });
  });
</script>
</html>
