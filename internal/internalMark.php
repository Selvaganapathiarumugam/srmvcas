<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../connect.php');
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    }
    $all_query = mysqli_query($conn,"SELECT * from tbldepartment  ORDER BY id asc");
    $lstDepartment=array();
    while ($row = mysqli_fetch_array($all_query)) 
    {
        $lstDepartment[] = $row;
    }
    

    $lstYear = array(
        "I" => "I",
        "II" => "II",
        "III" => "III"
    );
    $lstSemester = array(
        "I" => "I",
        "II" => "II",
        "III" => "III",
        "IV" => "IV",
        "V" => "V",
        "VI" => "VI"
    );
    $opDept=$deptId;
    $opSem = $Semester;
    $opYear=$year;
    $opReg =$reg;
   //--------------------------------Update-------------------------------
//    if(isset($_REQUEST["id"]))
//    {
//        $id=$_REQUEST['id'];
//        $SQL="SELECT Code,Name,Type,Maxmark,Year,Convertmark from tblinternalexam
//                WHERE Code='".$_REQUEST["id"]."'";
//        $result = mysqli_query($conn,$SQL);
//        while($row = mysqli_fetch_array($result)) 
//        {
//            $ie_code = $row['Code'];
//            $ie_name = $row['Name'];
//            $Type = $row['Type'];
//            //echo $Type;die();
//            $typeug = $Type == "UG" ? 'checked' : " ";
//            $typepg = $Type == "PG" ? 'checked' : " ";
//            //echo $typepg;die();

//            $ie_mmark = $row['Maxmark'];

//            $opYear = $row['Year'];
//            $ie_cmark = $row['Convertmark'];
        
//            $id=$row['Code'];
//        }
//     }
    include("../links.php")
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Internal Exam</title>
</head>
<body class="ovflow-y">
    <div id="header">
        <div class="row">
            <div class="col-md-3" >
                <p id="headerUser">Mark Entry</p>
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
                            <a href="./mark.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-backward" style="color: #fff;"></i> Back</a>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
    </div>
    <div class="container" style="background-color:#EFEFEE">
        <div class="p-5 mb-4 bg-white rounded-3" style="margin-left:15px;height: 100% !important;">
            <form method="POST" class="form-horizontal" id="frmIE" >
                <div class="row">
                    <div class="col-md-4 col-lg-4">
                        <div class="form-group">
                            <label for="input1" class="form-label">Department </label>
                            <select class="form-select" name="ie_dept" id="ie_dept" 
                             tabindex="1" required  autocomplete="off">
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
                                    $("#ie_dept").val(selectedValue);
                                });
                            </script>
                        </div>
                    </div>
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <label for="input1" class=" form-label"> Semester</label>
                            <select class="form-select" name="ie_semester" id="ie_semester"
                                 placeholder="Select the Semester" tabindex="2" required  autocomplete="off">
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
                                   $("#ie_semester").val(selectedValue);
                                });
                            </script>
                        </div>
                    </div>
                    <div class="col-md-3 col-lg-3">
                        <div class="form-group">
                            <label for="input1" class=" form-label">Year</label>
                            <select class="form-select" tabindex="3" name="ie_year" id="ie_year"
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
                                   $("#ie_year").val(selectedValue);
                                });
                            </script>
                        </div>
                    </div>
                    <div class="col-md-2 col-lg-2">
                        <div class="form-group">
                            <input type="submit" class="btn btn-primary btn-sm"  tabindex="4"  id="btnGet" value="Get Subjects" 
                            style=" margin-top: 31px;"/>
                        </div>
                    </div>
                </div>
            </form>   
        </div>
        <div class="row">
            <div class="col-md-4 col-lg-4 col-sm-12">
                <div class="row">
                    <div class="col-md-5">
                        <label class="form-label">Exam Code</label>
                    </div>
                    <div class="col-md-7">
                        <input type="text" class="form-control"  id="Excode" tabindex="5"  required/>
                    </div>
                </div>  
                <div class="margin-top-base">
                    <div class="row">
                        <div class="col-md-5">
                            <label class="form-label">Exam Name</label>
                        </div>
                        <div class="col-md-7">
                            <input type="text" class="form-control" disabled id="ExName" />
                        </div>
                    </div> 
                </div>  
                <div class="margin-top-base">
                    <div class="row">
                        <div class="col-md-5">
                            <label  class="form-label">Max Mark</label>
                        </div>
                        <div class="col-md-7">
                            <input type="text" class="form-control" disabled id="ExMmark" />
                        </div>
                    </div> 
                </div>   
                <div class="margin-top-base">
                    <div class="row">
                        <div class="col-md-5">
                            <label class="form-label">Convert Mark</label>
                        </div>
                        <div class="col-md-7">
                            <input type="text" class="form-control" disabled id="ExCmark" />
                        </div>
                    </div> 
                </div>     
                <div class="margin-top-base">
                    <div class="row">
                        <div class="col-md-5">
                            <label  class="form-label">Year</label>
                        </div>
                        <div class="col-md-7">
                            <input type="text" class="form-control"  disabled id="ExYear" />
                        </div>
                    </div> 
                </div>            
            </div>
            <div class="col-md-8 col-lg-8 col-sm-12">
                <form id='frmIMark' method="POST" class="form-horizontal">
                    <div class="grpStudent">
                        <div class="row">
                            <div class="col-md-3">
                                <label class="form-label">Reg No</label>
                            </div>
                            <div class="col-md-3">
                                <input type="text" id="ie_SReg" class="form-control" tabindex="6" required autocomplete="off"/>
                            </div>
                            <div class="col-md-6">
                                <input type="text" id="ie_SName"  disabled class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="margin-top-base">
                        <div class="row">
                            <div class="form-group">
                                <table id="markTable" class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th>Course Code</th>
                                            <th>Course Name</th>
                                            <th>Mark</th>
                                            <th>Final Mark</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- The dynamic table will be generated here -->
                                    </tbody>
                                </table>
                                <input type='submit' id='savenamark' class='btn btn-success btn-sm' 
                                    style='float:right;'/>
                            </div>
                        </div>
                    </div>
                </form>              
            </div>
        </div>
        
    </div>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#Excode').blur(function() {
                var ExCode = $(this).val();
                if (ExCode != "") {
                    $.ajax({
                    type: "POST",
                    url: "./data/ExamType.php",
                    data: {
                        ExCode: ExCode
                    },
                    success: function(response) {
                        if (response.error) {
                        console.log(response);
                        } else {
                            var sdata=JSON.parse(response);
                            $('#ExName').val(sdata.Name);
                            $('#ExMmark').val(sdata.Maxmark);
                            $('#ExCmark').val(sdata.Convertmark);
                            $('#ExYear').val(sdata.Year);                        
                        }
                    }
                    });
                }
            });
            $('#ie_SReg').blur(function() {
                var StudentNo = $(this).val();
                if (StudentNo != "") {
                    $.ajax({
                    type: "POST",
                    url: "./data/ExamType.php",
                    data: {
                        StudentNo: StudentNo
                    },
                    success: function(response) {
                        if (response.error) {
                        console.log(response);
                        } else {
                            var sdata=JSON.parse(response);
                            $('#ie_SName').val(sdata.Name);              
                        }
                    }
                    });
                }
            });
            //
            $('#frmIE').submit(function(e) {
                e.preventDefault(); 
                var departmentId = $('#ie_dept').val();
                var semester = $('#ie_semester').val();
                var year = $('#ie_year').val();
                $.ajax({
                    url: './data/get_courses.php',
                    method: 'POST',
                    data: { 
                        departmentId: departmentId,
                        semester:semester,
                        year:year
                    },
                    success: function(data) {
                       // $('#grpStudent').css('display', 'inline');
                        $('#markTable tbody').html(data);
                    }
                });
            });
            $('#markTable').on('blur', 'input[name="mark[]"]', function() {
                var $row = $(this).closest('tr');
                var mark = ($(this).val());
                var total = ($('#ExMmark').val());
                var convertedMark = ($('#ExCmark').val());
                var finalMark = (mark / total) * convertedMark;

                $row.find('input[name="final_mark[]"]').val( Math.round(finalMark.toFixed(2))); 
            });
            
        });
        // Save student marks
        $('#frmIMark').submit(function(e) {
            e.preventDefault(); 
            var departmentId = $('#ie_dept').val();
            var semester = $('#ie_semester').val();
            var year = $('#ie_year').val();
            var StudentNo = $('#ie_SReg').val();
            var ExCode=$('#Excode').val();
            var courseCode = $('input[name="courseCode[]"]').map(function() {
                return this.value;
            }).get();
            var studentMarks = $('input[name="mark[]"]').map(function() {
                return this.value;
            }).get();
            var finalmark = $('input[name="final_mark[]"]').map(function() {
                return this.value;
            }).get();
            $.ajax({
                url: './data/saveMark.php',
                method: 'POST',
                data: {
                    courseCode: courseCode,
                    studentMarks: studentMarks,
                    departmentId:departmentId,
                    semester:semester,
                    year:year,
                    StudentNo:StudentNo,
                    ExCode:ExCode,
                    finalmark:finalmark
                },
                success: function(response) {
                    if(response === "Marks saved successfully!")
                    {
                        swal(response, {
                            buttons: {
                                OK: {
                                text: "OK",
                                value: "OK",
                                icon:"success" 
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
                        swal(response,{ icon: "warning",});
                    }
                }
            });
            
        });
        
    </script>
</body>
</html>