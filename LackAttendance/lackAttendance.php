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
    //--------------------------------Update-------------------------------
    // if(isset($_REQUEST["id"]))
    // {
    //     $id=$_REQUEST['id'];
    //     $SQL="SELECT *  from  tbltimetable 
    //              WHERE ID=".$_REQUEST["id"];
    //     $result = mysqli_query($conn,$SQL);
    //     while($row = mysqli_fetch_array($result)) 
    //     {
    //         $deptId = $row['deptId'];
    //         $Staffid = $row['Staffid'];
    //         $year = ($row['Year']);
    //         $Semester = ($row['Semester']);
    //         $SubjectId = $row['SubjectId'];
    //         $SubjectCore = $row['SubjectCore'];
    //         $DayOrder = $row['DayOrder'];
    //         $SubjectHour = $row['SubjectHour'];
    //         $id=$row['id'];
    //     } 
    //     $opDept=$deptId;
    //     $opSem = $Semester;
    //     $opYear=$year;
    //     $opsub=$SubjectId;
    //     $opsubcore=$SubjectCore;
    //     $opDayOrder=$DayOrder;
    //     $opHours=$SubjectHour;
    //     $opstname=$Staffid;
    // }
    
    mysqli_close($conn);
    include("../links.php")
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lack of Attendance</title>
</head>
<body class="ovflow-y">
    <div class="border-1p" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
        <div class="row">
            <div class="col-md-3" >
                <h3 class=" padding-base">Lack of Attendance</h3>
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
            <div class="col-md-12">
                <marquee>Lack of Attendance Master</marquee>
            </div>
        </div>
        <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
                <form method="POST" class="form-horizontal" id="frmlatt" >
                    <div class="p-5 mb-4 bg-light rounded-3" style="margin-left:15px;height: 100% !important;">
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
            <div class="col-md-3"></div>
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