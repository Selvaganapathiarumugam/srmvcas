<?php
    ob_start();
    session_start();
    error_reporting(0); 
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    }
    include('../connect.php');
    $Eid=$_SESSION['EmpId'];
    $SQL="SELECT addcourse,updatecourse from  tblusersrights where EmpId ='". $Eid."'";
    $result = mysqli_query($conn,$SQL);
    
    while($row = mysqli_fetch_array($result)) 
    {
        $isAddRight = $row['addcourse'];
        $isUpRight = $row['updatecourse'];
    }
    if($isAddRight == 0) {
        header("Location:../403.php");
    }
    include('../links.php');
    $all_query = mysqli_query($conn,"SELECT * from tbldepartment ORDER BY id asc");
    $lstDepartment=array();
    while ($row = mysqli_fetch_array($all_query)) 
    {
        $lstDepartment[] = $row;
    }
    //--------------------------------Update-------------------------------
    if(isset($_REQUEST["id"]))
    {
        $id=$_REQUEST['id'];
        if($isUpRight == 0) {
            header("Location:../403.php");
        }
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
                        <a href="./index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-backward" style="color: #fff;"></i> Back</a>
                    </div>
                </div>
            </div>
        </div>
    </div> 
<div class="container">
        <div class="row">
            <div class="col-md-12">
                <marquee>
                    Course Master
                </marquee>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <div class="p-5 mb-4 bg-light rounded-3" style="margin-left:30px;height: 100% !important;">
                    <form method="POST" id="frmcourse" class="form-horizontal">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class="form-label">Department </label>
                                </div>
                                <div class="col-md-8 col-lg-8">
                                    <select class="form-select" name="cs_dept" id="cs_dept"
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
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-4 col-lg-4">
                                        <label for="input1" class="form-label">Semester </label>
                                    </div>
                                    <div class="col-md-8 col-lg-8">
                                        <select class="form-select" name="cs_semester" id="cs_semester"
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
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-4 col-lg-4">
                                        <label for="input1" class="form-label">Year</label>
                                    </div>
                                    <div class="col-md-8 col-lg-8">
                                        <select class="form-select" name="cs_year" id="cs_year"
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
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-4 col-lg-4">
                                        <label for="input1" class="form-label">Course Code</label> 
                                    </div>
                                    <div class="col-md-8 col-lg-8">
                                        <input type="text" name="cs_code" class="form-control" id="cs_code"
                                            placeholder="Course Code " value="<?php ECHO $code; ?>" required  autocomplete="off"  />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-4 col-md-4">
                                        <label for="input1" class="form-label">Course  Name</label>
                                    </div>
                                    <div class="col-md-8 col-lg-8">
                                        <input type="text" name="cs_name" class="form-control" id="cs_name"
                                            placeholder="Course  Name" required  value="<?php ECHO $name; ?>"  autocomplete="off"  />
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-4 col-lg-4">
                                        <label for="input1" class="form-label">Acadamic Year</label> 
                                    </div>
                                    <div class="col-md-8 col-lg-8">
                                        <input type="text" name="cs_ayear" class="form-control" id="cs_ayear"
                                            placeholder="Acadamic Year" required  autocomplete="off" value="<?php echo $ayear; ?>" 
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-6 "></div>
                                    <div class="col-md-6 col-lg-6 ">
                                        <input type="hidden" name='cs_hid' id='cs_hid' value="<?php echo $id; ?>" />
                                        <?php 
                                            if(isset($_REQUEST["id"])){
                                                $btnName="Edit";
                                            }else{
                                                $btnName="Add";
                                            }
                                        ?>
                                        <input type="submit" class="btn btn-primary" id="btnsave" value="<?php echo $btnName; ?>" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="col-md-6"></div>
        </div>
    </div>
</body>
<script>
    $(document).ready(function() {
        $('#frmcourse').submit(function(e) {
          e.preventDefault(); 
          var formData = $(this).serialize();
          var value = $("#cs_hid").val();
          console.log(formData);
          if(value > 0)
          {
            $.ajax({
              url: './data/edit.php', 
              method: 'POST',
              data: formData,
              success: function(response) {
                if(response == "Data Updated successfully!")
                {
                    swal(response,{
                        icon: "success", 
                        buttons: {
                            OK: {
                            text: "OK",
                            value: "OK",
                        },
                    },
                    }).then((value) => {
                        switch (value) {
                            case "OK":window.location.href='./index.php'; break;
                            default:window.location.href='./index.php';
                        }
                    });
                }
                else
                {
                    swal(response,{icon: "warning",});
                }
                },
                error: function(xhr, status, error) {
                  swal(xhr.responseText,{icon: "warning",}); 
                }
            });
          }
          else
          {
            $.ajax({
                url: './data/insert.php', 
                method: 'POST',
                data: formData,
                success: function(response) {
                    if(response == "Data inserted successfully!")
                    {
                        swal(response, {
                            buttons: {
                                OK: {
                                text: "OK",
                                value: "OK",
                            }, 
                        },
                        }).then((value) => {
                            switch (value) {
                                case "OK":window.location.href='./index.php'; break;
                                default:window.location.href='./index.php';
                            }
                        });
                    }
                    else
                    {
                        swal(response);
                    }
                },
                error: function(xhr, status, error) {
                    swal(xhr.responseText); 
                }
            });
          }          
        });
    });
</script>
</html>