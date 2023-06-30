<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../connect.php');
    $all_query = mysqli_query($conn,"SELECT * from tbldepartment ORDER BY id asc");
    $lstDepartment=array();
    while ($row = mysqli_fetch_array($all_query)) 
    {
        $lstDepartment[] = $row;
    }
    if(isset($_POST['btnAdd']))
    {
        $deptId =  trim($_REQUEST['cs_dept']);
        $year = trim($_REQUEST['cs_year']);
        $semester =  trim($_REQUEST['cs_semester']);
        $courseCode = strtoupper(trim($_REQUEST['cs_code']));
        $courseName = trim($_REQUEST['cs_name']);
        $acadamicYear =trim($_REQUEST['cs_ayear']);
        $SQL = "INSERT INTO tblcourse (deptId, year, semester, courseCode, courseName, AcadamicYear)
        VALUES ($deptId, '$year', '$semester', '$courseCode', '$courseName', '$acadamicYear');";
        try {
            $result = mysqli_query($conn,$SQL);
            echo '<script type="text/javascript"> alert("New Row Inserted!!"); </script>';
        } catch (\Throwable $th) {
            throw $th;
        }
        header('location: index.php');
    }
    //--------------------------------Update-------------------------------
    if(isset($_REQUEST["id"]))
    {
        $id=$_REQUEST['id'];
        $SQL="SELECT c.id ,c.deptid,c.semester,c.year,c.courseName,c.courseCode,c.AcadamicYear from  tblcourse c
        WHERE c.ID=".$_REQUEST["id"];
        $result = mysqli_query($conn,$SQL);
        while($row = mysqli_fetch_array($result)) 
        {
            $dept = $row['deptid'];
            $sem = $row['semester'];
            $year = $row['year'];
            $name = $row['courseName'];
            $code = $row['courseCode'];
            $ayear = $row['AcadamicYear'];
            $id=$row['id'];
        }
        $opSem = $sem;
        $opYear=$year;
        $opDept=$dept;
        $lstSemester = array(
            "I" => "I",
            "II" => "II",
            "III" => "III",
            "IV" => "IV",
            "V" => "V",
            "VI" => "VI"
        );
        $lstYear = array(
            "I" => "I",
            "II" => "II",
            "III" => "III"
        );
    }else{
        $lstSemester = array(
            "I" => "I",
            "II" => "II",
            "III" => "III",
            "IV" => "IV",
            "V" => "V",
            "VI" => "VI"
        );
        $lstYear = array(
            "I" => "I",
            "II" => "II",
            "III" => "III"
        );
    }
    if(isset($_POST['btnEdit']))
    {
        $SQL="";
        $dept =trim($_REQUEST['cs_dept']);
        $sem = trim($_REQUEST['cs_semester']);
        $year =trim($_REQUEST['cs_year']);
        $code =strtoupper(trim($_REQUEST['cs_code']));
        $name =trim($_REQUEST['cs_name']);
        $ayear=trim($_REQUEST['cs_ayear']);
        $id=$_REQUEST['id'];
        $SQL = "UPDATE tblcourse SET deptid=" . $dept . ",
        semester='" . $sem . "', year='" . $year . "', courseName='" . $name . "',
        courseCode='" . $code . "', AcadamicYear='" . $ayear . "' WHERE Id='" . $id . "'";
        try {
            $result = mysqli_query($conn,$SQL);
        } catch (\Throwable $th) {
            throw $th;
        }
        $dname="";
        $id="";
        $_REQUEST['id']="";
        echo '<script type="text/javascript"> alert("Updated!!"); </script>';
        header('location: index.php');
    }
    //------------------------------------------delete--------------
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
    <title>Course</title>
    <link rel="stylesheet" type="text/css" href="../css/main.css">
    <link rel="stylesheet" href="styles.css">
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
            <h3>Course Details</h3>
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
                        <a href="./index.php" class="btn btn-primary"><i class="fa-solid fa-backward fa-2xl" style="color: #fff;"></i> Back</a>
                    </div>
                </div>
            </div>
        </div>
    </div> 
<div class="container"><div class="row">
<div class="col-md-6">
    <h3 class="box-title">
        <?php 
            if(isset($_REQUEST["id"])){
                echo "Edit Course";
            }else{
                echo "Add Course";
            }
            ?>
    </h3>
</div></div>
<div class="row">
    <div class="col-md-12">
        <div class="jumbotron" style="margin-left:30px;height: 100% !important;">
            <form method="POST" action="course.php" class="form-horizontal">
                <div class="form-group">
                    <label for="input1" class="col-sm-6  col-md-4 col-lg-4 control-label">Department </label>
                    <div class="col-sm-6 col-md-8 col-lg-8">
                        <select class="form-control select2" name="cs_dept" id="cs_dept"
                            placeholder="Select the Degree" required  autocomplete="off">
                            <?php

                                foreach ($lstDepartment as $value => $label) 
                                {
                                    $selected = ($opDept == $label['id']) ? "selected" : "";
                                    echo "<option value=\"{$label['id']}\" $selected>{$label['dname']}</option>";

                                }
                            ?>
                        </select>
                        <script>
                        $(document).ready(function() {
                            var selectedValue = "<?php echo $opDept; ?>";
                           $("#cs_dept").val(selectedValue);
                        });
                    </script>
                    </div>
                </div>
                <div class="form-group">
                    <label for="input1" class="col-sm-6  col-md-4 col-lg-4 control-label">Semester </label>
                    <div class="col-sm-6 col-md-8 col-lg-8">
                    <select class="form-control select2" name="cs_semester" id="cs_semester"
                            placeholder="Select the Semester" required  autocomplete="off">
                        <?php
                            foreach ($lstSemester as $value => $label) {
                            $selected = ($opSem == $value) ? "selected" : "";
                            echo "<option value=\"$value\" $selected>$label</option>";
                            }
                        ?>
                    </select>

                    <script>
                        $(document).ready(function() {
                            var selectedValue = "<?php echo $opSem; ?>";
                           $("#cs_semester").val(selectedValue);
                        });
                    </script>
                    </div>
                </div>
                <div class="form-group">
                    <label for="input1" class="col-sm-6  col-md-4 col-lg-4 control-label">Year</label>
                    <div class="col-sm-6 col-md-8 col-lg-8">
                        <select class="form-control select2" name="cs_year" id="cs_year"
                            placeholder="Select the Year" required  autocomplete="off" >
                            <?php
                            foreach ($lstYear as $value => $label) {
                            $selected = ($opYear == $value) ? "selected" : "";
                            echo "<option value=\"$value\" $selected>$label</option>";
                            }
                        ?>
                        </select>
                        <script>
                        $(document).ready(function() {
                            var selectedValue = "<?php echo $opYear; ?>";
                           $("#cs_year").val(selectedValue);
                        });
                    </script>
                    </div>
                </div>
                <div class="form-group">
                    <label for="input1" class="col-sm-6  col-md-4 col-lg-4 control-label">Course Code</label>                
                    <div class="col-sm-6 col-md-8 col-lg-8">
                        <input type="text" name="cs_code" class="form-control" id="cs_code"
                        placeholder="Course Code " value="<?php ECHO $code; ?>" required  autocomplete="off"  />
                    </div>
                </div>
                <div class="form-group">
                    <label for="input1" class="col-sm-6  col-md-4 col-lg-4 control-label">Course  Name</label>
                    <div class="col-sm-6 col-md-8 col-lg-8">
                        <input type="text" name="cs_name" class="form-control" id="cs_name"
                        placeholder="Course  Name" required  value="<?php ECHO $name; ?>"  autocomplete="off"  />
                    </div>
                </div>  
                <div class="form-group">
                    <label for="input1" class="col-sm-6  col-md-4 col-lg-4 control-label">Acadamic Year</label> 
                    <div class="col-sm-6 col-md-8 col-lg-8">
                        <input type="text" name="cs_ayear" class="form-control" id="cs_ayear"
                            placeholder="Acadamic Year" required  autocomplete="off" value="<?php echo $ayear; ?>" 
                        />
                        <input type="hidden" name="id" class="form-control" id="input1" value="<?php ECHO $id; ?>" />
                    </div>
                </div>
                <div class="form-group">
                    <?php if (isset($_REQUEST["id"])) { ?>
                        <div class="col-sm-6 col-md-2 col-md-offset-8">
                            <input type="submit" class="btn btn-primary" value="Edit" name="btnEdit" />
                        </div>
                    <?php } else { ?>
                        <div class="col-sm-6 col-md-2 col-md-offset-8">
                            <input type="submit" class="btn btn-primary" value="Add" name="btnAdd" />
                        </div>
                    <?php } ?>
                </div>
            </form>
        </div>
    </div>
</div></div>
</body>
</html>