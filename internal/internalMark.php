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
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <?php include('../links.php'); ?>
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
                        <label for="input1" class=" form-label">Year</label>
                        <select class="form-select" tabindex="2" name="ie_year" id="ie_year"
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
                <div class="col-md-3 col-lg-3">
                    <div class="form-group">
                        <label for="input1" class=" form-label"> Semester</label>
                        <select class="form-select" name="ie_semester" id="ie_semester"
                             placeholder="Select the Semester" tabindex="3" required  autocomplete="off">
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
                <div class="col-md-2 col-lg-2">
                </div>
            </div>
        </form>   
        <div class="grpopertion padding-base">
            <div class="row">
                <div class="col-md-11">
                    <div style="float:right" >
                        <button class="btn btn-primary btn-sm" id="btnGet" > Get Students</button>
                    </div>
                </div>
                <div class="col-md-1" >
                    <h6 id="Edit" class="badge bg-secondary" style="float:right;"> Edit </h6>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 col-lg-4 col-sm-12">
                <div class="row">
                    <div class="col-md-5">
                        <label class="form-label">Type</label>
                    </div>
                    <div class="col-md-7">
                        <div class="row">
                            <div class="col-md-6">
                                <input type="radio" name="ie_Type" value="UG" />
                                <label>UG</label><br>
                            </div>
                            <div class="col-md-6">
                                <input type="radio" name="ie_Type" value="PG" />
                                <label>PG</label><br>
                            </div>
                        </div>
                    </div>
                </div>  
                <div class="margin-top-base">
                    <div class="row">
                        <div class="col-md-5">
                            <label class="form-label">Exam</label>
                        </div>
                        <div class="col-md-7">
                            <select class="form-select" name="ie_EName" id="ie_EName" 
                                  required  autocomplete="off">

                            </select>
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
                    <div class="grpCourset">
                        <div class="row">
                            <div class="col-md-2">
                                <label class="form-label">Course</label>
                            </div>
                            <div class="col-md-7">
                                <select class="form-select" name="ie_Cname" id="ie_Cname">
                                </select>
                            </div>
                            <div class="col-md-3">
                                <input type="text" id="ie_Code"  disabled class="form-control">
                            </div>
                        </div>
                    </div>
                    <div class="margin-top-base">
                        <div class="row">
                            <div class="form-group">
                                <table id="markTable" class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th>RegNO</th>
                                            <th>Name</th>
                                            <th>Mark</th>
                                            <th>Final Mark</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- The dynamic table will be generated here -->
                                    </tbody>
                                </table>
                                
                            </div>
                        </div>
                    </div>
                </form>  
                <div class="row">
                    <div class="col-md-4"></div>
                    <div class="col-md-4">
                        <button id='savemark'class='btn btn-success btn-sm'>Save</button>
                        <button id='Editmark'class='btn btn-warning text-dark btn-sm'>Update</button>
                    </div>
                    <div class="col-md-4"></div>
                </div>            
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {
            $("#grpopertion").hide();
            $("#Editmark").hide();
            $("#savemark").hide();

            $('#ie_EName').change(function() {
                var ExCode = $(this).find(":selected").attr("id");
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
                          
                            $('#ExMmark').val(sdata.Maxmark);
                            $('#ExCmark').val(sdata.Convertmark);
                            $('#ExYear').val(sdata.Year);                        
                        }
                    }
                    });
                }
            });
            var Year="";
            $('#ie_semester').change(function() {
                var departmentId = $('#ie_dept').val();
                Year = $('#ie_year').val();
                var semester = $(this).val();

                if(departmentId == null)
                {
                    swal("Please Select The Department",{ icon: "warning",});
                    $('#ie_semester').val(null)
                }
                else if(Year == null)
                {
                    swal("Please Select The Year",{ icon: "warning",});
                    $('#ie_semester').val(null)
                }
                else if (semester != null) {
                    $.ajax({
                        type: "POST",
                        url: "./data/get_courses.php",
                        data: { 
                            departmentId: departmentId,
                            semester:semester,
                            year:Year,

                        },
                        success: function(response) {
                            if (response.error) 
                            {
                                swal(response,{ icon: "warning",});
                            } 
                            else
                            {
                                $('#ie_Cname').html(response);              
                            }
                        }
                    });
                }
            });
            $('#ie_Cname').change(function() { 
                var CODE = $(this).find(":selected").attr("id");
                $('#ie_Code').val(CODE);
            });
            var MMark=0;
            $('#btnGet').click(function() {
                $("#Editmark").hide();
                var departmentId = $('#ie_dept').val();
                var semester = $('#ie_semester').val();
                var year = $('#ie_year').val();
                $("#grpopertion").show();
                $("#savemark").show();
                $.ajax({
                    url: './data/get_student.php',
                    method: 'POST',
                    data: { 
                        departmentId: departmentId,
                        semester:semester,
                        year:year,
                        
                    },
                    success: function(data) {
                        $('#markTable tbody').html(data);
                        setTimeout(function() {
                            MMark = $('#ExMmark').val();
                            //alert(MMark);
                            $('input[name="mark[]"]').attr('max', MMark);
                        }, 2000);
                        
                    }
                });
            });
            $('#markTable').on('input','input[name="mark[]"]', function() {
                var input = parseInt($(this).val(), 10)
                if (MMark < input) 
                {
                    swal("Please insert the valid Mark",{ icon: "warning",});
                    //$('input[name="mark[]"]').val(0);
                }
                    
            });
            $('#markTable').on('blur', 'input[name="mark[]"]', function() {
                var $row = $(this).closest('tr');
                var mark = ($(this).val());
                var total = ($('#ExMmark').val());
                var convertedMark = ($('#ExCmark').val());
                var finalMark = (mark / total) * convertedMark;

                $row.find('input[name="final_mark[]"]').val( Math.round(finalMark.toFixed(2))); 
            });
            $('input[type=radio][name=ie_Type]').change(function() {
                var Type = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "./data/ExamType.php",
                    data: { 
                        type: Type,
                        year: Year
                    },
                    success: function(response) {
                        if (response.error) 
                        {
                            swal(response,{ icon: "warning",});
                        } 
                        else
                        {
                            $('#ie_EName').html(response);              
                        }
                    }
                });
            });
            

        });
        // Save student marks
        $('#savemark').click(function() {
           
            var departmentId = $('#ie_dept').val();
            var semester = $('#ie_semester').val();
            var year = $('#ie_year').val();
            var CCode = $('#ie_Code').val();
            var ExCode = $('#ie_EName').find(":selected").attr("id");
            var StudentNo = $('input[name="ie_SReg[]"]').map(function() {
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
                    courseCode: CCode,
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
                                case "OK":window.location.href='./mark.php'; break;
                                default:window.location.href='./mark.php';
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
        $('#Edit').click(function(){
            $("#Editmark").show();
            $("#savemark").hide();
            $("#markTable tbody tr").remove();
            var departmentId = $('#ie_dept').val();
            var semester = $('#ie_semester').val();
            var year = $('#ie_year').val();
            var CCode = $('#ie_Code').val();
            var ExCode = $('#ie_EName').find(":selected").attr("id");
            if(CCode == "")
            {
                swal("Please Select The Course",{ icon: "warning",});
            }
            else if(ExCode == "")
            {
                swal("Please Select The Exam",{ icon: "warning",});
            }
            else
            {
                setTimeout(function() {
                    $.ajax({
                        url: './data/get_EditMarklist.php',
                        method: 'POST',
                        data: { 
                            departmentId: departmentId,
                            semester:semester,
                            year:year,
                            CCode:CCode,
                            ExCode:ExCode
                        },
                        success: function(data) {
                           // $('#grpStudent').css('display', 'inline');
                            $('#markTable tbody').html(data);
                            setTimeout(function() {
                            var MMark = $('#ExMmark').val();
                            //alert(MMark);
                            $('input[name="mark[]"]').attr('max', MMark);
                        }, 2000);
                        }
                    });
                }, 1000);
                
            }
        });
        $('#Editmark').click(function() {
            var departmentId = $('#ie_dept').val();
            var semester = $('#ie_semester').val();
            var year = $('#ie_year').val();
            var CCode = $('#ie_Code').val();
            var ExCode = $('#ie_EName').find(":selected").attr("id");
            var StudentNo = $('input[name="ie_SReg[]"]').map(function() {
                return this.value;
            }).get();
            var studentMarks = $('input[name="mark[]"]').map(function() {
                return this.value;
            }).get();
            var finalmark = $('input[name="final_mark[]"]').map(function() {
                return this.value;
            }).get();
            var Id = $('input[name="ie_Id[]"]').map(function() {
                return this.value;
            }).get();
            $.ajax({
                url: './data/editMark.php',
                method: 'POST',
                data: {
                    courseCode: CCode,
                    studentMarks: studentMarks,
                    departmentId:departmentId,
                    semester:semester,
                    year:year,
                    StudentNo:StudentNo,
                    ExCode:ExCode,
                    finalmark:finalmark,
                    Id:Id
                },
                success: function(response) {
                    if(response === "Marks updated successfully!")
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
                                case "OK":window.location.href='./mark.php'; break;
                                default:window.location.href='./mark.php';
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