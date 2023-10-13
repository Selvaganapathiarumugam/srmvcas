<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../connect.php');
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    
    }
    $Eid=$_SESSION['EmpId'];
    $SQL="SELECT lateAttendance from  tblusersrights where EmpId ='". $Eid."'";
    $result = mysqli_query($conn,$SQL);
    
    while($row = mysqli_fetch_array($result)) 
    {
        $isRight = $row['lateAttendance'];
    }
    if($isRight == 0) {
        header("Location:../403.php");
    }

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
    $la_date= date('Y-m-d');
    mysqli_close($conn);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <?php include('../links.php'); ?>
    <title>Late  Attendance</title>
</head>
<body class="ovflow-y">
    <div id="header">
        <div class="row">
            <div class="col-md-3" >
                <p id="headerUser">Late Attendance</p>
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
                <marquee>Late of Attendance Master</marquee>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <form method="POST" class="form-horizontal" id="frmlatt" >
                    <div class="p-5 mb-4 bg-white rounded-3" style="margin-left:15px;height: 100% !important;">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6 col-lg-4">
                                    <label for="input1" class="form-label">Date</label>
                                </div>
                                <div class=" col-md-6 col-lg-8">
                                    <input type='date' id='la_date' name='la_date' class="form-control" required 
                                        tabindex="1" value="<?php echo $la_date; ?>" autocomplete="off"
                                    />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class="form-label">Reg.No</label>
                                    </div>
                                    <div class=" col-md-2 col-lg-4">
                                        <input type='text' id='la_reg' name='la_reg' class="form-control" required 
                                            tabindex="2" value="<?php echo $la_reg; ?>" autocomplete="off"
                                        />
                                    </div>
                                    <div class="col-md-4 col-lg-4">
                                        <input type="text" id="la_name" class="form-control" disabled>
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
                                        <input type="text" id="la_dept" class="form-control" disabled>
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
                                        <input type="text" id="la_year" class="form-control" disabled>
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
                                        <input type="text" id="la_sem" class="form-control" disabled>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6"></div>
                                    <div class="col-md-6">
                                        <input type="hidden" name='la_deptid' id='la_deptid' value="<?php echo $id; ?>" />
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
            $('#la_reg').blur(function() {
                var reg = $(this).val();
                if (reg != "") {
                    $.ajax({
                    type: "POST",
                    url: "./data/student.php",
                    data: {
                        reg: reg
                    },
                    success: function(response) {
                        if (response.error) {
                        console.log(response);
                        } else {
                            var sdata=JSON.parse(response);
                            $('#la_name').val(sdata.firstName);
                            $('#la_sem').val(sdata.semester);
                            $('#la_year').val(sdata.year);
                            $('#la_dept').val(sdata.dname);
                            $('#la_deptid').val(sdata.deptid);
                        
                        }
                    }
                    });
                }
            });
            $('#frmlatt').submit(function(e) {
                e.preventDefault(); 
                var la_date = $('#la_date').val();
                var la_sem = $('#la_sem').val();
                var la_reg = $('#la_reg').val();
                var la_deptid = $('#la_deptid').val();
                var la_year = $('#la_year').val();
                $.ajax({
                url: './data/insert.php', 
                method: 'POST',
                data: {
                    la_reg: la_reg,
                    la_date: la_date,
                    la_year: la_year,
                    la_sem: la_sem,
                    la_deptid: la_deptid
                    },
                success: function(response) {
                    if(response =='Data inserted successfully!')
                    {
                        swal(response, {
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
                    else{
                        swal(response,{ icon: "warning",});
                    }
                    },
                    error: function(xhr, status, error) 
                    {
                        swal(xhr.responseText); 
                    }
                });
            });
        });
    </script>
</body>
</html>