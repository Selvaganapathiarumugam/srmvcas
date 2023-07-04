<?php

ob_start();
session_start();
error_reporting(0); 
include("../links.php")
?>
<?php
    include('../connect.php'); 

    $all_query = mysqli_query($conn,"SELECT * from tbldepartment  ORDER BY id asc");
    $lstDepartment=array();
    while ($row = mysqli_fetch_array($all_query)) 
    {
        $lstDepartment[] = $row;
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
    $lstCommunity = array(
        "FC" => "First Class",
        "ST" => "Scheduled Tribes",
        "SC" => "Scheduled Castes",
        "BC" => "Backward Class",
        "MBC" => "Most Backward Class",
        "EWS" => "Economically Weaker Sections",
        "nill"=> "No Caste"
    );
    $lstReligion = array(
        "hindu" => "Hinduism",
        "christ" => "Christianity",
        "Islam" => "Islam",
        "Sikhism" => "Sikhism",
        "Buddhism" => "Buddhism",
        "Jainism" => "Jainism",
        "Adivasi" => "Adivasi",
        "nill"=> "No Religion"
    );
    //--------------------------------Update-------------------------------
    if(isset($_REQUEST["id"]))
    {
        $id=$_REQUEST['id'];
        $SQL="SELECT s.* from  tblstudent s
                WHERE s.ID=".$_REQUEST["id"];
        $result = mysqli_query($conn,$SQL);
        while($row = mysqli_fetch_array($result)) 
        {
            $firstName =  trim($row['firstName']);
            $lastName =  trim($row['lastName']);
            $regNo =  trim($row['regNo']);
            $dob =  trim($row['dob']);
            $email =  trim($row['email']);
            $gender =  trim($row['gender']);
            $contactNumber =  trim($row['contactNumber']);
            $semester =  trim($row['semester']);
            $year =  trim($row['year']);
            $batch =  trim($row['batch']);
            $fatherName =  trim($row['fatherName']);
            $fatherContact =  trim($row['fatherContact']);
            $motherName =  trim($row['motherName']);
            $motherContect =  trim($row['motherContect']);
            $aadharNumber =  trim($row['aadharNumber']);
            $community =  trim($row['community']);
            $religion =  ($row['religion']);
            $addressLine1 =  trim($row['addressLine1']);
            $addressLine2 =  trim($row['addressLine2']);
            $city =  trim($row['city']);
            $pincode =  trim($row['pincode']);
            $state =  trim($row['state']);
            $nationality =  trim($row['nationality']);
            $age =  trim($row['age']);
            $deptid = $row['deptid'];
            $id=$row['id'];
        }      
    }   
    $opSem = $semester;
    $opYear=$year;
    $opDept=$deptid;
    $opCommunity=$community;
    $opReligion=$religion;
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student</title>
</head>
<body class="ovflow-y">
    <div class="border-1p" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
        <div class="row">
            <div class="col-md-3" >
                <h3 class="text-muted padding-base">Student Details</h3>
            </div>
            <div class="col-md-6">
                <center><h3 class="text-muted ">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
            </div>
            <div class="col-3">
                <div class="row">
                    <div class="col-md-6">
                    </div>
                    <div class="col-md-6">
                        <div class="margin-top-base">
                            <a href="./index.php" class="btn btn-primary btn-sm">
                                <i class="fa-solid fa-backward" style="color: #fff;"></i>
                                <b>BACK</b>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
    </div>
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h4 class="text-muted">Add Student's Information</h4>
            </div>
        </div>
        <form method="POST" id="frmStudent" class="form-horizontal">
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4 col-lg-4">
                                <label for="input1" class=" form-label">Reg No</label>
                            </div> 
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_regNo" class="form-control" id="input1"
                                placeholder="Reg No" tabindex="1" value="<?php echo $regNo; ?>" required  autocomplete="off"  />
                            </div>
                        </div>
                    </div>
                </div><!-- Reg No -->
                <div class="col-md-6">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-4 col-lg-4">
                                <label for="input1" class=" form-label">Aadhar Number</label>
                            </div> 
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_aadhar" class="form-control" id="st_aadhar" required  autocomplete="off"
                                    placeholder="Aadhar Number" value="<?php echo $aadharNumber; ?>" tabindex="7" />
                            </div>
                        </div><!-- Aadhar Number -->
                    </div>
                </div>
            </div><!-- Row 1 -->
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> First Name</label>
                                </div> 
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_name" class="form-control" id="input1"
                                        placeholder="First Name" value="<?php echo $firstName; ?>" tabindex="2" required  autocomplete="off" />
                                </div>
                            </div><!-- Name -->
                        </div>
                    </div> 
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class="form-label">Department</label>
                                </div>
                                <div class="col-md-8 col-lg-8">
                                    <select class="form-select" tabindex="8" name="st_dept" id="st_dept" required  autocomplete="off">
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
                                            $("#st_dept").val(selectedValue);
                                        });
                                    </script>
                                </div><!-- Department -->
                            </div>
                        </div>
                    </div>
                </div><!-- Row 2 -->
            </div>
            <div class="margin-top-base">
                <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4 col-lg-4">
                                        <label for="input1" class="form-label">Last Name</label>
                                    </div>
                                    <div class="col-md-8 col-lg-8">
                                        <input type="text" name="st_lname" class="form-control" id="input1"
                                            placeholder="Initial" value="<?php echo $lastName; ?>" tabindex="3" required  autocomplete="off" />
                                    </div>
                                </div><!-- Age -->
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4 col-lg-4">
                                        <label for="input1" class=" form-label"> Semester</label>
                                    </div> 
                                    <div class="col-md-8 col-lg-8">
                                        <select class="form-select" name="st_semester" id="st_semester"
                                             placeholder="Select the Semester" tabindex="9" required  autocomplete="off">
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
                                               $("#st_semester").val(selectedValue);
                                            });
                                        </script>
                                    </div>
                                </div>
                            </div><!-- semester -->
                        </div>
                </div><!-- Row 3 -->
            </div>
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-6">
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4 col-lg-4">
                                        <label for="input1" class="form-label">Age</label>
                                    </div>
                                    <div class="col-md-8 col-lg-8">
                                        <input type="text" name="st_age" class="form-control" id="input1" 
                                            placeholder="Age" value="<?php echo $age; ?>" required tabindex="4"  autocomplete="off"/>
                                    </div>
                                </div><!-- Age -->
                            </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                                <div class="row">
                                    <div class="col-md-4 col-lg-4">
                                        <label for="input1" class=" form-label"> Year</label>
                                    </div> 
                                    <div class="col-md-8 col-lg-8">
                                        <select class="form-select" tabindex="10" name="st_year" id="st_year"
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
                                               $("#st_year").val(selectedValue);
                                            });
                                        </script>
                                    </div>
                                </div>
                        </div><!-- year -->
                    </div>
                </div><!-- Row 4 -->
            </div>
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class="form-label">Email</label>
                                </div>
                                <div class="col-md-8 col-lg-8">
                                    <input type="email" name="st_email" class="form-control" id="st_email"
                                        placeholder="Gmail" value="<?php echo $email; ?>" required tabindex="5" autocomplete="off"/>
                                </div>
                            </div><!-- Email -->
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> Batch </label>
                                </div> 
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_batch" class="form-control" id="input1"
                                        placeholder="2023-2025" value="<?php echo $batch; ?>" tabindex="11" required  autocomplete="off" />
                                </div>
                            </div>
                        </div><!-- Batch -->
                    </div>
                </div><!-- Row 5 -->
            </div>
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class="form-label">Mobile Number</label>
                                </div>
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_context" class="form-control" id="st_context"
                                        placeholder="Student Mobile" value="<?php echo $contactNumber; ?>" tabindex="6" required  autocomplete="off" />
                                </div>
                            </div><!-- Mobile Number -->
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> DOB </label>
                                </div> 
                                <div class="col-md-8 col-lg-8">
                                    <input type='date' id='st_dob' name='st_dob' class="form-control" required 
                                        tabindex="12" value="<?php echo $dob; ?>" autocomplete="off"/>
                                </div>
                            </div>
                        </div><!-- DOB -->
                    </div>
                </div><!-- Row 6 -->
            </div>
            <hr>
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> Father Name </label>
                                </div> 
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_fatherName" class="form-control" id="st_fatherName"
                                        placeholder="Father Name" value="<?php echo $fatherName; ?>" tabindex="13" required  autocomplete="off" 
                                    /> 
                                </div>
                            </div>
                        </div><!-- Father Name -->
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> Mobile Number </label>
                                </div> 
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_fatherNumber" class="form-control" id="st_fatherNumber"
                                        placeholder="Father Number" value="<?php echo $fatherContact; ?>" tabindex="14" required  autocomplete="off"/>                                </div>
                            </div>
                        </div><!-- Mobile Number -->
                    </div>
                </div><!-- Row 7 -->
            </div> 
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> Mother Name </label>
                                </div>
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_motherName" class="form-control" id="st_motherName"
                                        placeholder="Mother Name" value="<?php echo $motherName; ?>" tabindex="15" required autocomplete="off" />
                                </div>
                            </div>
                        </div><!-- Mother Name -->
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> Mobile Number </label>
                                </div>
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_motherNumber" class="form-control" id="st_motherNumber  "
                                        placeholder="Mother Number" value="<?php echo $motherContect; ?>" tabindex="16" autocomplete="off" />
                                </div>
                            </div>
                        </div><!-- Mobile Number -->
                    </div>
                </div><!-- Row 8 -->
            </div>
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> Door/Street Name</label>
                                </div>
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_addl1" class="form-control" id="st_addl1"
                                        placeholder="Address Line I" value="<?php echo $addressLine1; ?>"  tabindex="17" required  autocomplete="off"/>
                                </div>
                            </div>
                        </div><!-- Door/Street Name -->
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> Area/PO </label>
                                </div>
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_addl2" class="form-control" id="st_addl2"
                                            placeholder="Address Line II" value="<?php echo $addressLine2; ?>" tabindex="18" required  autocomplete="off"/>
                                </div>
                            </div>
                        </div><!-- Area/PO -->
                    </div>
                </div><!-- Row 8 -->
            </div>
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> City</label>
                                </div>
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_city" class="form-control" id="st_city"
                                            placeholder="Coimbatore" value="<?php echo $city; ?>" tabindex="19" required  autocomplete="off"/>
                                </div>
                            </div>
                        </div><!-- City -->
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> Pincode </label>
                                </div>
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_pincode" class="form-control" id="st_pincode"
                                            placeholder="641001" value="<?php echo $pincode; ?>" required tabindex="20" autocomplete="off"/>
                                </div>
                            </div>
                        </div><!-- Pincode -->
                    </div>
                </div><!-- Row 9 -->
            </div>
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> State</label>
                                </div>
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_state" class="form-control" id="st_state"
                                        placeholder="Tamil Nadu"  value="<?php echo $state; ?>" required tabindex="21" autocomplete="off"/>
                                </div>
                            </div>
                        </div><!-- State -->
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> Nationality </label>
                                </div>
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_nationality" class="form-control" id="st_nationality"
                                           value="India" tabindex="22" value="<?php echo $nationality; ?>"  required  autocomplete="off"/>
                                </div>
                            </div>
                        </div><!-- Nationality -->
                    </div>
                </div><!-- Row 10 -->
            </div>
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> Community</label>
                                </div> 
                                <div class="col-md-8 col-lg-8">
                                    <select class="form-select" name="st_community" id="st_community"
                                        tabindex="23" required  autocomplete="off">
                                        <?php
                                            foreach ($lstCommunity as $value => $label) {
                                            $selected = ($opCommunity == $value) ? "selected" : "";
                                            echo "<option value=\"$value\" $selected>$label</option>";
                                            }
                                        ?>
                                    </select>
                                    <script>
                                        $(document).ready(function() {
                                            var selectedValue = "<?php echo $opCommunity; ?>";
                                           $("#st_community").val(selectedValue);
                                        });
                                    </script>
                                </div>
                            </div>
                        </div><!-- Community -->
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> Religion</label>
                                </div> 
                                <div class="col-md-8 col-lg-8">
                                    <select class="form-select" name="st_religion" id="st_religion"
                                        tabindex="24" required  autocomplete="off">
                                        <?php
                                            foreach ($lstReligion as $value => $label) {
                                            $selected = ($opSem == $value) ? "selected" : "";
                                            echo "<option value=\"$value\" $selected>$label</option>";
                                            }
                                        ?>
                                    </select>
                                    <script>
                                        $(document).ready(function() {
                                            var selectedValue = "<?php echo $opReligion; ?>";
                                           $("#st_religion").val(selectedValue);
                                        });
                                    </script>
                                </div>
                            </div>
                        </div><!-- Nationality -->
                    </div>
                </div><!-- Row 11 -->
            </div>
            <div class="margin-top-base">
                <div class="row">
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-4 col-lg-4">
                                <label for="input1" class=" form-label"> Gender</label>
                            </div> 
                            <div class="col-md-8 col-lg-8">
                                <input type="radio" name="st_gender" value="male" checked readOnly />
                                <label for="Male">Male</label><br>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group" style="float:right;">
                            <input type="hidden" name='st_hid' id='st_hid' value="<?php echo $id; ?>" />
                            <?php 
                                if(isset($_REQUEST["id"])){
                                    $btnName="Edit";
                                }else{
                                    $btnName="Add";
                                }
                            ?>
                            <input type="submit" tabindex="25" class="btn btn-primary " id="btnsave" value="<?php echo $btnName; ?>" />
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#frmStudent').submit(function(e) {
              e.preventDefault(); 
              var formData = $(this).serialize();
              var value = $("#st_hid").val();
              console.log(formData);
              if(value > 0){
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
            });
        });
    </script>
</body>
</html>