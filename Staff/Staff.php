<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../connect.php');
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    }
    if($_SESSION['Role'] != 1 && $_SESSION['Role'] != 3 && $_SESSION['Role'] != 5) {
        header("Location:../403.php");
    }
    $all_query = mysqli_query($conn,"SELECT * from tbldepartment  ORDER BY id asc");
    $lstDepartment=array();
    while ($row = mysqli_fetch_array($all_query)) 
    {
        $lstDepartment[] = $row;
    }
    $all_query="";
    $all_query = mysqli_query($conn,"SELECT * from tblroles where is_Active = 1 ORDER BY id asc");
    $lstroles=array();
    while ($row = mysqli_fetch_array($all_query)) 
    {
        $lstroles[] = $row;
    }
    //--------------------------------Update-------------------------------
    if(isset($_REQUEST["id"]))
    {
        $id=$_REQUEST['id'];
        $SQL="SELECT u.id,u.EmpId,u.username,u.password,u.email,u.fullname,
                u.phone,u.dob,u.age,u.doj,u.dor,u.roleId,u.deptid  from  tblusers u 
                WHERE u.ID=".$_REQUEST["id"];
        $result = mysqli_query($conn,$SQL);
        while($row = mysqli_fetch_array($result)) 
        {
            $dept = $row['deptid'];
            $uname = $row['username'];
            $pass = base64_decode($row['password']);
            $rpass = base64_decode($row['password']);
            $role = $row['roleId'];
            $name = $row['fullname'];
            $code = $row['EmpId'];
            $email = $row['email'];
            $phone = $row['phone'];
            $dob = $row['dob'];
            $age = $row['age'];
            $dor = $row['dor'];
            $doj = $row['doj'];
            $id=$row['id'];
        }
        $opRole = $role;
        $opDept=$dept;
        
    }
    
    mysqli_close($conn);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <?php include('../links.php'); ?>
    <title>Staff</title>
</head>
<body class="ovflow-y">
    <div id="header">
        <div class="row">
            <div class="col-md-3" >
                <p id="headerUser">Staff Details</h3>
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
        <div class="row " >
            <div class="col-md-12">
                <marquee class="box-title margin-top-base">
                    Staff Master
                </marquee>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <form method="POST" class="form-horizontal" id="frmStaff" >
                    <div class="p-5 mb-4 bg-white rounded-3" style="margin-left:15px;height: 100% !important;">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6 col-lg-4 ">
                                    <label for="input1" class="form-label">Staff Id</label>                
                                </div>
                                <div class=" col-md-6 col-lg-8">
                                    <input type="text" name="sf_id" class="form-control" id="sf_id"
                                        placeholder="Staff Id " value="<?php ECHO $code; ?>" required  autocomplete="off"  />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class="form-label">Staff  Name</label>
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <input type="text" name="sf_name" class="form-control" id="sf_name"
                                         placeholder="staff  Name" value="<?php ECHO $name; ?>"  required  autocomplete="off"  />
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4 ">
                                        <label for="input1" class="form-label">Gmail</label> 
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <input type="Email" name="sf_email" class="form-control" id="sf_email"
                                            placeholder="Email" required  autocomplete="off" value="<?php echo $email; ?>" 
                                         />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group margin-top-base">
                            <div class="row">
                                <div class="col-md-6 col-lg-4 ">
                                    <label for="input1" class="form-label">Phone No</label>
                                </div>
                                <div class=" col-md-6 col-lg-8">
                                    <input type="text" name="sf_phone" class="form-control" id="sf_phone"
                                        placeholder="Phone No" required  autocomplete="off" value="<?php echo $phone; ?>" 
                                    />
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
                                        <select class="form-select" name="sf_dept" id="sf_dept" required  autocomplete="off">
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
                                                $("#sf_dept").val(selectedValue);
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
                                        <label for="input1" class="form-label">User Name</label> 
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <input type="text" name="sf_user" class="form-control" id="sf_user"
                                            placeholder="User Name"     required  autocomplete="off" value="<?php echo $uname; ?>" 
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class=" form-label">Password </label> 
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <input type="password" name="sf_pass" class="form-control" id="sf_pass"
                                            placeholder="Password"required    autocomplete="off" value="<?php echo $pass; ?>" 
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class="form-label">Re Enter Password </label>
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <input type="password" name="sf_rpass" class="form-control" id="sf_rpass"
                                            placeholder="re-Password"     required  autocomplete="off" value="<?php echo $rpass; ?>" 
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4 ">
                                        <label for="input1" class="form-label">Gender</label>
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <input type="radio" name="sf_gender" value="male"  checked readOnly/>
                                        <label for="Male">Male</label><br>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class="form-label">DOB</label>
                                    </div>
                                    <div class="col-md-6 col-lg-8">
                                        <input type="date" name="sf_dob" class="form-control" id="sf_dob"
                                            placeholder="DOB" value="<?php ECHO $dob; ?>"  required  autocomplete="off"  />
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <div class="form-group ">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6  col-lg-4">
                                        <label for="input1" class="form-label">Age</label>
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <input type="text" value="<?php ECHO $age; ?>" name="sf_age" class="form-control" id="sf_age" placeholder="Age"    required  autocomplete="off"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group ">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class="form-label">DOJ</label>
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <input type="date" name="sf_doj" class="form-control" id="sf_doj"
                                        placeholder="Date of Join"     value="<?php ECHO $doj; ?>"  required  autocomplete="off"  />
                                    </div>
                                </div>
                            </div>
                        </div> 
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class="form-label">DOR</label>
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <input type="date" name="sf_dor" class="form-control" id="sf_dor"
                                            placeholder="Date of Releave"   value="<?php ECHO $dor; ?>"  autocomplete="off"  />
                                    </div>
                                </div>
                            </div>
                        </div> 
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class="form-label">Role </label>
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <select class="form-select" name="sf_role" id="sf_role"
                                            placeholder="Select the Role"   required  autocomplete="off">
                                            <?php
                                                foreach ($lstroles as $value => $label2) 
                                                {
                                                    $selected2 = ($opRole == $label2['Id']) ? "selected" : "";
                                                    echo "<option value=\"{$label2['Id']}\" $selected2>{$label2['Description']}</option>";
                                                
                                                }
                                            ?>
                                        </select>
                                        <script>
                                            $(document).ready(function() {
                                                var selectedValue2 = "<?php echo $opRole; ?>";
                                                $("#sf_role").val(selectedValue2);
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
                                        <input type="hidden" name='sf_hid' id='sf_hid' value="<?php echo $id; ?>" />
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
                    </div>
                </form>   
            </div>
            <div class="col-md-2"></div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#frmStaff').submit(function(e) {
              e.preventDefault(); 
              var formData = $(this).serialize();
              var value = $("#sf_hid").val();
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
</body>
</html>