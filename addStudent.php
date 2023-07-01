<?php

ob_start();
session_start();
error_reporting(0); 
include("../links.php")

?>
<?php
 include('../connect.php');
 if(isset($_POST['btnAdd'])){
    $firstName =  trim($_REQUEST['st_name']);
    $lastName =  trim($_REQUEST['st_lname']);
    $regNo =  trim($_REQUEST['st_regNo']);
    $dob =  trim($_REQUEST['st_dob']);
    $email =  trim($_REQUEST['st_email']);
    $gender =  trim($_REQUEST['st_gender']);
    $contactNumber =  trim($_REQUEST['st_context']);
    $semester =  trim($_REQUEST['st_semester']);
    $year =  trim($_REQUEST['st_year']);
    $batch =  trim($_REQUEST['st_batch']);
    $fatherName =  trim($_REQUEST['st_fatherName']);
    $fatherContact =  trim($_REQUEST['st_fatherNumber']);
    $motherName =  trim($_REQUEST['st_motherName']);
    $motherContect =  trim($_REQUEST['st_motherNumber']);
    $aadharNumber =  trim($_REQUEST['st_aadhar']);
    $community =  trim($_REQUEST['st_community']);
    $religion =  trim($_REQUEST['st_religion']);
    $addressLine1 =  trim($_REQUEST['st_addl1']);
    $addressLine2 =  trim($_REQUEST['st_addl2']);
    $city =  trim($_REQUEST['st_city']);
    $pincode =  trim($_REQUEST['st_pincode']);
    $state =  trim($_REQUEST['st_state']);
    $nationality =  trim($_REQUEST['st_nationality']);
    $age =  trim($_REQUEST['st_age']);
    $deptid = $_REQUEST['st_dept'];
   $SQL="insert into tblstudent (firstName,lastName,regNo,dob,email,gender,contactNumber,semester,year,
   batch,fatherName,fatherContact,motherName,motherContect,aadharNumber, community,religion,addressLine1,
   addressLine2,city,pincode,state,nationality,age,deptid) 
   values('". $firstName ."','". $lastName ."','". $regNo ."','". $dob ."','". $email ."','". $gender ."', 
   '". $contactNumber ."','". $semester ."','". $year ."','". $batch ."','". $fatherName ."','". $fatherContact ."',
   '". $motherName ."','". $motherContect ."','". $aadharNumber ."','". $community ."','". $religion ."','". $addressLine1 ."',
   '". $addressLine2 ."','". $city ."','". $pincode ."','". $state ."','". $nationality ."', $age , $deptid )";
   $result = mysqli_query($conn,$SQL);
   echo '<script type="text/javascript"> alert("New Row Inserted!!"); </script>';
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Student</title>
</head>

<body>
    <div class="border-1p">
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
                            <a href="./index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-backward" style="color: #fff;"></i> Back</a>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
    </div>
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h4>Add Student's Information</h4>
            </div>
        </div>
        <form method="POST" action="addStudent.php" class="form-horizontal col-md-12 col-lg-12">
            <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label">Reg No</label>
                                </div> 
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_regNo" class="form-control" id="input1"
                                    placeholder="Reg No" required  autocomplete="off"  />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-4 col-lg-4">
                                    <label for="input1" class=" form-label"> First Name</label>
                                </div> 
                                <div class="col-md-8 col-lg-8">
                                    <input type="text" name="st_name" class="form-control" id="input1"
                                        placeholder="First Name" required  autocomplete="off" />
                                </div>
                            </div>
                        </div>
                    </div>
            </div>
        </form>
    </div>
</body>
</html>

<!-- 
     <div class="col-md-6 col-lg-6 ">
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Last Name</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_lname" class="form-control" id="input1"
                                    placeholder="Initial" required  autocomplete="off" />
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Department</label>
                            <div class="col-md-8 col-lg-8">
                                <select class="form-control select2" name="st_dept" id="st_dept"
                                    placeholder="Select the Degree" required  autocomplete="off">
                                    <?php
                                        $i=0;
                                        $all_query = mysqli_query($conn,"SELECT * from tbldepartment ORDER BY id asc");
                                        while ($data = mysqli_fetch_array($all_query)) {
                                          $i++;
                                    ?>
                                     <option value=<?php echo $data['id']; ?>> <?php echo $data['dname']; ?> </option>
                                    <?php 
                                        } 
                                    ?>
                                </select>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Semester</label>
                            <div class="col-md-8 col-lg-8">
                                <select class="form-control select2" name="st_semester" id="st_semester"
                                placeholder="Select the Semester" required  autocomplete="off">
                                    <option value="I">I</option>
                                    <option value="II">II</option>
                                    <option value="III">III</option>
                                    <option value="IV">IV</option>
                                    <option value="V">V</option>
                                    <option value="VI">VI</option>
                                </select>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Year</label>
                            <div class="col-md-8 col-lg-8">
                                <select class="form-control select2" name="st_year" id="st_year"
                                    placeholder="Select the Year" required  autocomplete="off">
                                    <option value=""></option>
                                    <option value="I">I</option>
                                    <option value="II">II</option>
                                    <option value="III">III</option>
                                </select>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Batch</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_batch" class="form-control" id="input1"
                                    placeholder="2023-2025" required  autocomplete="off" />
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Email</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="email" name="st_email" class="form-control" id="st_email"
                                    placeholder="RMKV Email" required  autocomplete="off"/>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Mobile Number</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_context" class="form-control" id="st_context"
                                    placeholder="Student Mobile" required  autocomplete="off" />
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Gender</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="radio" name="st_gender" value="male"  checked readOnly/>
                                <label for="Male">Male</label><br>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Age</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_age" class="form-control" id="input1" placeholder="Age" required  autocomplete="off"/>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">DOB</label>
                            <div class="col-md-8 col-lg-8">
                                    <input type='date' id='st_dob' name='st_dob' class="form-control" required  autocomplete="off"/>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Aadhar Number</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_aadhar" class="form-control" id="st_aadhar" required  autocomplete="off"
                                    placeholder="Aadhar Number" />

                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Father Name</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_fatherName" class="form-control" id="st_fatherName"
                                    placeholder="Father Name" required  autocomplete="off" />
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Mobile Number</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_fatherNumber" class="form-control" id="st_fatherNumber"
                                    placeholder="Father Number" required  autocomplete="off"/>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Mother Name</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_motherName" class="form-control" id="st_motherName"
                                    placeholder="Mother Name" required  autocomplete="off"/>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Mobile Number</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_motherNumber" class="form-control" id="st_motherNumber  "
                                    placeholder="Mother Number" autocomplete="off"/>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Door/Street Name</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_addl1" class="form-control" id="st_addl1"
                                    placeholder="Address Line I" required  autocomplete="off"/>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Area/PO</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_addl2" class="form-control" id="st_addl2"
                                    placeholder="Address Line II" required  autocomplete="off"/>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">City</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_city" class="form-control" id="st_city"
                                    placeholder="Coimbatore " required  autocomplete="off"/>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Pincode</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_pincode" class="form-control" id="st_pincode"
                                    placeholder="641001" required  autocomplete="off"/>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">State</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_state" class="form-control" id="st_state"
                                    placeholder="Tamil Nadu" required  autocomplete="off"/>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Nationality</label>
                            <div class="col-md-8 col-lg-8">
                                <input type="text" name="st_nationality" class="form-control" id="st_nationality"
                                   value="India" required  autocomplete="off"/>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Community</label>
                            <div class="col-md-8 col-lg-8">
                                <select class="form-control select2" name="st_community" id="st_community"
                                    placeholder="Select the Year" required  autocomplete="off">
                                    <option value=""></option>
                                    <option value="FC">First Class </option>
                                    <option value="ST">Scheduled Tribes</option>
                                    <option value="SC">Scheduled Castes</option>
                                    <option value="BC">Backward Class</option>
                                    <option value="MBC">Most Backward Class</option>
                                    <option value="EWS">Economically Weaker Sections</option>
                                    <option value="nill">No Caste</option>
                                </select>
                            </div>
                    </div>
                    <div class="form-group">
                            <label for="input1" class=" col-md-4 col-lg-4 form-label">Religion</label>
                            <div class="col-md-8 col-lg-8">
                                <select class="form-control select2" name="st_religion" id="st_religion"
                                    placeholder="Select the Year" required  autocomplete="off">
                                    <option value=""></option>
                                    <option value="hindu">Hinduism</option>
                                    <option value="christ">Christianity  </option>
                                    <option value="Islam">Islam </option>
                                    <option value="Sikhism">Sikhism </option>
                                    <option value="Buddhism">Buddhism</option>
                                    <option value="Jainism">Jainism </option>
                                    <option value="Adivasi">Adivasi</option> 
                                    <option value="nill">No religion</option>

                                </select>
                            </div>
                    </div>
                    <div class="form-group">
                            <div class="col-md-2 col-md-offset-8">
                                <input type="submit" class="btn btn-primary" value="Add" name="btnAdd" />
                            </div>
                    </div>
                </div>
-->