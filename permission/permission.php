<?php
    ob_start();
    session_start();
    error_reporting(0); 
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    }
    include('../connect.php'); 
    $all_query = mysqli_query($conn,"SELECT * from tblusers  ORDER BY fullname asc");
    $lstUsers=array();
    while ($row = mysqli_fetch_array($all_query)) 
    {
        $lstUsers[] = $row;
    }
    if(isset($_REQUEST["id"]))
    {
        //$listUser="disabled";
        $id=$_REQUEST['id'];
        $SQL="SELECT * from  tblusersrights
                WHERE ID=".$_REQUEST["id"];
        $result = mysqli_query($conn,$SQL);
        //print_r($result);die();
        while($row = mysqli_fetch_array($result)) 
        {
            $userId = $row['EmpId'];
            $permission = $row['permission'];
            $addstudent = ($row['addstudent']);
            $updatestudent = $row['updatestudent'];
            $addcourse = $row['addcourse'];
            $updatecourse = $row['updatecourse'];
            $addtimetable = $row['addtimetable'];
            $updatetimetable = $row['updatetimetable'];
            $bulkattendance = $row['bulkattendance'];
            $attendancereport = $row['attendancereport'];
            $lateAttendance=$row['lateAttendance'];
            $id=$row['Id'];
        }
    }
    $opUsert=$userId;
    $permissiony = $permission == 1 ? 'checked' : " ";
    $permissionn = $permission == 0 ? 'checked' : " ";
    $addstudenty = $addstudent == 1 ? 'checked' : " ";
    $addstudentn = $addstudent == 0 ? 'checked' : " ";
    $updatestudenty = $updatestudent == 1 ? 'checked' : " ";
    $updatestudentn = $updatestudent == 0 ? 'checked' : " ";
    $addcoursey = $addcourse == 1 ? 'checked' : " ";
    $addcoursen = $addcourse == 0 ? 'checked' : " ";
    $updatecoursey = $updatecourse == 1 ? 'checked' : " ";
    $updatecoursen = $updatecourse == 0 ? 'checked' : " ";
    $addtimetabley = $addtimetable == 1 ? 'checked' : " ";
    $addtimetablen = $addtimetable == 0 ? 'checked' : " ";
    $updatetimetabley = $updatetimetable == 1 ? 'checked' : " ";
    $updatetimetablen = $updatetimetable == 0 ? 'checked' : " ";
    $bulkattendancey = $bulkattendance == 1 ? 'checked' : " ";
    $bulkattendancen = $bulkattendance == 0 ? 'checked' : " ";
    $attendancereporty = $attendancereport == 1 ? 'checked' : " ";
    $attendancereportn = $attendancereport == 0 ? 'checked' : " ";
    $lateAttendancey = $lateAttendance == 1 ? 'checked' : " ";
    $lateAttendancen = $lateAttendance == 0 ? 'checked' : " ";
    
?>   

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <?php include('../links.php'); ?>
    <title>User Rights</title>
</head>
<body class="ovflow-y">
    <div id="header">
        <div class="row">
            <div class="col-md-3" >
                <p id="headerUser">User Rights </p>
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
            <div class="col-md-12">
                <marquee>Users Rights's Master</marquee>
            </div>
        </div>
        <div class="margin-to-base">
            <div class="p-5 mb-4 bg-white rounded-3">
                <form method="POST" id="frmPermi" class="form-horizontal padding-base">
                    <div class="row">
                        <div class="col-md-1"></div>
                        <div class="col-md-10">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-2 col-lg-2">
                                        <label for="input1" class=" form-label">Staff </label>
                                    </div> 
                                    <div class="col-md-4 col-lg-4">
                                        <select class="form-select" tabindex="1" name="up_Staff" id="up_Staff"
                                         <?php echo $listUser; ?> required >
                                            <?php
                                                foreach ($lstUsers as $value => $label) 
                                                {
                                                    $selected = ($opUsert == $label['Id']) ? "selected" : "";
                                                    echo "<option value=\"{$label['EmpId']}\" $selected>{$label['fullname']}</option>";
                                                }
                                            ?>
                                        </select>
                                        <script>
                                            $(document).ready(function() {
                                                var selectedValue = "<?php echo $opUsert; ?>";
                                                $("#up_Staff").val(selectedValue);
                                            });
                                        </script>
                                    </div>
                                    <div class="col-md-2 col-lg-2">
                                        <label for="input1" class=" form-label">Permission</label>
                                    </div> 
                                    <div class="col-md-4 col-lg-4">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <input type="radio" name="up_Permission" tabindex="2" value="1" <?php echo $permissiony; ?> />
                                                <label>Yes</label><br>
                                            </div>
                                            <div class="col-md-3">
                                                <input type="radio" name="up_Permission" tabindex="3" value="0" <?php echo $permissionn; ?> />
                                                <label>No</label><br>
                                            </div>
                                            <div class="col-md-6"></div>
                                        </div>
                                    </div> 
                                </div>   
                            </div>
                            <div class="margin-top-base">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-2 col-lg-2">
                                            <label for="input1" class=" form-label">Add Student</label>
                                        </div> 
                                        <div class="col-md-4 col-lg-4">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_addstudent" tabindex="4" value="1" <?php echo $addstudenty; ?> />
                                                    <label>Yes</label><br>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_addstudent" tabindex="5" value="0" <?php echo $addstudentn; ?>  />
                                                    <label>No</label><br>
                                                </div>
                                                <div class="col-md-6"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-2 col-lg-2">
                                            <label for="input1" class=" form-label">Update Student</label>
                                        </div> 
                                        <div class="col-md-4 col-lg-4">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_updatestudent" tabindex="6" value="1" <?php echo $updatestudenty; ?>  />
                                                    <label>Yes</label><br>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_updatestudent" tabindex="7" value="0" <?php echo $updatestudentn; ?>  />
                                                    <label>No</label><br>
                                                </div>
                                                <div class="col-md-6"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="margin-top-base">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-2 col-lg-2">
                                            <label for="input1" class=" form-label">Add Course</label>
                                        </div> 
                                        <div class="col-md-4 col-lg-4">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_addcourse" tabindex="8" value="1" <?php echo $addcoursey; ?> />
                                                    <label>Yes</label><br>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_addcourse" tabindex="9" value="0" <?php echo $addcoursen; ?> />
                                                    <label>No</label><br>
                                                </div>
                                                <div class="col-md-6"></div>
                                            </div>

                                        </div>
                                        <div class="col-md-2 col-lg-2">
                                            <label for="input1" class=" form-label">Update Course</label>
                                        </div> 
                                        <div class="col-md-4 col-lg-4">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_updatecourse" tabindex="10" value="1" <?php echo $updatecoursey; ?>  />
                                                    <label>Yes</label><br>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_updatecourse" value="0" tabindex="11" <?php echo $updatecoursen; ?>  />
                                                    <label>No</label><br>
                                                </div>
                                                <div class="col-md-6"></div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="margin-top-base">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-2 col-lg-2">
                                            <label for="input1" class=" form-label">Add Timetable</label>
                                        </div> 
                                        <div class="col-md-4 col-lg-4">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_addtimetable" tabindex="12" value="1" <?php echo $addtimetabley; ?>  />
                                                    <label>Yes</label><br>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_addtimetable" tabindex="13" value="0" <?php echo $addtimetablen; ?>/>
                                                    <label>No</label><br>
                                                </div>
                                                <div class="col-md-6"></div>
                                            </div>

                                        </div>
                                        <div class="col-md-2 col-lg-2">
                                            <label for="input1" class=" form-label">Update Timetable</label>
                                        </div> 
                                        <div class="col-md-4 col-lg-4">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_updatetimetable" tabindex="14" value="1" <?php echo $updatetimetabley; ?> />
                                                    <label>Yes</label><br>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_updatetimetable" tabindex="15" value="0" <?php echo $updatetimetablen; ?>/>
                                                    <label>No</label><br>
                                                </div>
                                                <div class="col-md-6"></div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="margin-top-base">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-2 col-lg-2">
                                            <label for="input1" class=" form-label">Bulk Attendance</label>
                                        </div> 
                                        <div class="col-md-4 col-lg-4">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_bulkattendance" tabindex="16" value="1" <?php echo $bulkattendancey; ?>  />
                                                    <label>Yes</label><br>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_bulkattendance" tabindex="17" value="0" <?php echo $bulkattendancen; ?> />
                                                    <label>No</label><br>
                                                </div>
                                                <div class="col-md-6"></div>
                                            </div>

                                        </div>
                                        <div class="col-md-2 col-lg-2">
                                            <label for="input1" class=" form-label">Attendance Report</label>
                                        </div> 
                                        <div class="col-md-4 col-lg-4">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_attendancereport" tabindex="18" value="1" <?php echo $attendancereporty; ?>/>
                                                    <label>Yes</label><br>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_attendancereport" tabindex="19" value="0" <?php echo $attendancereportn; ?>/>
                                                    <label>No</label><br>
                                                </div>
                                                <div class="col-md-6"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="margin-top-base">
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-md-2 col-lg-2">
                                            <label for="input1" class=" form-label">Late Attendance</label>
                                        </div> 
                                        <div class="col-md-4 col-lg-4">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_lateAttendance" tabindex="20" value="1" <?php echo $lateAttendancey; ?>/>
                                                    <label>Yes</label><br>
                                                </div>
                                                <div class="col-md-3">
                                                    <input type="radio" name="up_lateAttendance" tabindex="21" value="0" <?php echo $lateAttendancen; ?>/>
                                                    <label>No</label><br>
                                                </div>
                                                <div class="col-md-6"></div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-lg-6">
                                            <div class="row">
                                                <div class="col-md-3">
                                                </div>
                                                <div class="col-md-3">
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group" style="text-align-last:center;">
                                                        <input type="hidden" name='up_hid' id='up_hid' value="<?php echo $id; ?>" />
                                                        <?php 
                                                            if(isset($_REQUEST["id"])){
                                                                $btnName="Edit";
                                                            }else{
                                                                $btnName="Add";
                                                            }
                                                        ?>
                                                        <input type="submit" tabindex="22" class="btn btn-primary btn-sm " id="btnsave" name="btnsave" value="<?php echo $btnName; ?>" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
    $(document).ready(function() {
        $('#frmPermi').submit(function(e) {
          e.preventDefault(); 
          var formData = $(this).serialize();
          var value = $("#up_hid").val();
          //console.log(formData);
          if(value > 0)
          {
            $.ajax({
              url: './data/edit.php', 
              method: 'POST',
              data: formData,
              success: function(response) {
                if(response == "Data Updated successfully!")
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
                        swal("Error :-" + response);
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