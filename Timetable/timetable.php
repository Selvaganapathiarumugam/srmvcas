<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../connect.php');

    $all_query = mysqli_query($conn,"SELECT * from tbldepartment  ORDER BY id asc");
    $lstDepartment=array();
    while ($row = mysqli_fetch_array($all_query)) 
    {
        $lstDepartment[] = $row;
    }
    if($_SESSION['Role']=="1")
    {
        $sql="SELECT id,courseName from tblcourse ORDER BY id asc";
    }
    else{
        $sql = "SELECT id, courseName FROM tblcourse WHERE deptId='". $_SESSION['Dept'] . "' ORDER BY id ASC";
    }
    $all_query = mysqli_query($conn,$sql);
    $lstSubjects=array();
    while ($NewRow = mysqli_fetch_array($all_query)) 
    {
        $lstSubjects[] = $NewRow;
    }
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
    $lstSubjectCore= array(
        "Theory" => "Theory",
        "Practical" => "Practical",
        "Project" => "Project"
    );
    $lstDayOrder = array(
        1 => "1",
        2 => "2",
        3 => "3",
        4 => "4",
        5 => "5",
        6 => "6"
    );
    $lsthours = array(
        1 => "1",
        2 => "2",
        3 => "3",
        4 => "4",
        5 => "5",
        6 => "6"
    );
    $name=$_SESSION['Username'];
    //--------------------------------Update-------------------------------
    if(isset($_REQUEST["id"]))
    {
        // $id=$_REQUEST['id'];
        // $SQL="SELECT u.id,u.EmpId,u.username,u.password,u.email,u.fullname,
        //         u.phone,u.dob,u.age,u.doj,u.dor,u.roleId,u.deptid  from  tblusers u 
        //         WHERE u.ID=".$_REQUEST["id"];
        // $result = mysqli_query($conn,$SQL);
        // while($row = mysqli_fetch_array($result)) 
        // {
        //     $dept = $row['deptid'];
        //     $uname = $row['username'];
        //     $pass = base64_decode($row['password']);
        //     $rpass = base64_decode($row['password']);
        //     $role = $row['roleId'];
        //     $name = $row['fullname'];
        //     $code = $row['EmpId'];
        //     $email = $row['email'];
        //     $phone = $row['phone'];
        //     $dob = $row['dob'];
        //     $age = $row['age'];
        //     $dor = $row['dor'];
        //     $doj = $row['doj'];
        //     $id=$row['id'];
        // } 
        $opDept=$dept;
        $opSem = $semester;
        $opYear=$year;
        $opsub=$subject;
        $opsubcore=$subjectcore;
        $opDayOrder=$DayOrder;
        $opHours=$Hours;
    }
    
    mysqli_close($conn);
    include("../links.php")
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TimeTable</title>
</head>
<body class="ovflow-y">
    <div class="border-1p" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
        <div class="row">
            <div class="col-md-3" >
                <h3 class=" padding-base">Time Table </h3>
            </div>
            <div class="col-md-6">
                <center><h3>Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
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
    <div class="container">
        <div class="row " >
            <div class="col-md-6">
                <marquee>Time Table Master</marquee>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <form method="POST" class="form-horizontal" id="frmTtable" >
                    <div class="p-5 mb-4 bg-light rounded-3" style="margin-left:15px;height: 100% !important;">
                        <div class="form-group">
                            <div class="row">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class="form-label">Staff  Name</label>
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <input type="text" name="tt_name" class="form-control" id="tt_name"
                                         placeholder="staff  Name" value="<?php ECHO $name; ?>" 
                                         tabindex="1" required  autocomplete="off"  />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class="form-label">Department </label>
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <select class="form-select" name="tt_dept" id="tt_dept" 
                                         tabindex="2" required  autocomplete="off">
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
                                                $("#tt_dept").val(selectedValue);
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
                                        <label for="input1" class=" form-label"> Year</label>
                                    </div> 
                                    <div class="col-md-8 col-lg-8">
                                        <select class="form-select" tabindex="3" name="tt_year" id="tt_year"
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
                                               $("#tt_year").val(selectedValue);
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
                                        <label for="input1" class=" form-label"> Semester</label>
                                    </div> 
                                    <div class="col-md-8 col-lg-8">
                                        <select class="form-select" name="tt_semester" id="tt_semester"
                                             placeholder="Select the Semester" tabindex="4" required  autocomplete="off">
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
                                               $("#tt_semester").val(selectedValue);
                                            });
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class="form-label">Subject</label>
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                    <select class="form-select" name="tt_sub" id="tt_sub" 
                                         tabindex="5" required  autocomplete="off">
                                            <?php
                                                foreach ($lstSubjects as $value => $label) 
                                                {
                                                    $selected = ($opsub == $label['id']) ? "selected" : "";
                                                    echo "<option value=\"{$label['id']}\" $selected>{$label['courseName']}</option>";
                                                }
                                            ?>
                                        </select>
                                        <script>
                                            $(document).ready(function() {
                                                var selectedValue = "<?php echo $opsub; ?>";
                                                $("#tt_sub").val(selectedValue);
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
                                        <label for="input1" class=" form-label"> Subject Core</label>
                                    </div> 
                                    <div class="col-md-8 col-lg-8">
                                        <select class="form-select" tabindex="6" name="tt_score" id="tt_score"
                                            placeholder="Select the Year" required  autocomplete="off" >
                                            <?php
                                                foreach ($lstSubjectCore as $value => $label) {
                                                $selected = ($opsubcore == $value) ? "selected" : "";
                                                echo "<option value=\"$value\" $selected>$label</option>";
                                            }
                                            ?>
                                        </select>
                                        <script>
                                            $(document).ready(function() {
                                                var selectedValue = "<?php echo $opsubcore; ?>";
                                               $("#tt_score").val(selectedValue);
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
                                        <label for="input1" class=" form-label">Day Order</label>
                                    </div> 
                                    <div class="col-md-8 col-lg-8">
                                        <select class="form-select" tabindex="7" name="tt_DO" id="tt_DO"
                                            placeholder="Select the Year" required  autocomplete="off" >
                                            <?php
                                                foreach ($lstDayOrder as $value => $label) {
                                                $selected = ($opDayOrder == $value) ? "selected" : "";
                                                echo "<option value=\"$value\" $selected>$label</option>";
                                            }
                                            ?>
                                        </select>
                                        <script>
                                            $(document).ready(function() {
                                                var selectedValue = "<?php echo $opDayOrder; ?>";
                                               $("#tt_DO").val(selectedValue);
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
                                        <label for="input1" class=" form-label">Subject Hour</label>
                                    </div> 
                                    <div class="col-md-8 col-lg-8">
                                        <select class="form-select" tabindex="8" name="tt_hours" id="tt_hours"
                                            placeholder="Select the Year" required  autocomplete="off" >
                                            <?php
                                                foreach ($lsthours as $value => $label) {
                                                $selected = ($opHours == $value) ? "selected" : "";
                                                echo "<option value=\"$value\" $selected>$label</option>";
                                            }
                                            ?>
                                        </select>
                                        <script>
                                            $(document).ready(function() {
                                                var selectedValue = "<?php echo $opHours; ?>";
                                               $("#tt_hours").val(selectedValue);
                                            });
                                        </script>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-6 "></div>
                                    <div class="col-md-6 col-lg-6 ">
                                        <input type="hidden" name='tt_hid' id='tt_hid' value="<?php echo $id; ?>" />
                                        <?php 
                                            if(isset($_REQUEST["id"])){
                                                $btnName="Edit";
                                            }else{
                                                $btnName="Add";
                                            }
                                        ?>
                                        <input type="submit" class="btn btn-primary"  tabindex="9"  id="btnsave" value="<?php echo $btnName; ?>" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>   
            </div>
            <div class="col-md-2"></div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#frmTtable').submit(function(e) {
              e.preventDefault(); 
              var formData = $(this).serialize();
              var value = $("#tt_hid").val();
              console.log(formData);
              if(value > 0)
              {
                $.ajax({
                  url: './data/edit.php', 
                  method: 'POST',
                  data: formData,
                  success: function(response) {
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
                    },
                    error: function(xhr, status, error) {
                      swal(xhr.responseText); 
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
                        if(response=='This User is already to another course at the same time!')
                        {
                            swal('This User is already to another course at the same time!');
                        }
                        else
                        {
                            if(response == 'Error inserting data')
                            {
                                swal("Error inserting data");
                            }
                            else{
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
</body>
</html>