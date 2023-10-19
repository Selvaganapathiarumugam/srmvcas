<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../connect.php');
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    }

    $all_query = mysqli_query($conn,"SELECT * from tbldepartment ORDER BY id asc");
    $lstDepartment=array();
    while ($row = mysqli_fetch_array($all_query)) 
    {
        $lstDepartment[] = $row;
    }
    $all_query = mysqli_query($conn,"SELECT * from tblinternalexam ORDER BY Code asc");
    $lstExam=array();
    while ($row = mysqli_fetch_array($all_query)) 
    {
        $lstExam[] = $row;
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
    $EmpId=$_SESSION["EmpId"];
    $all_query = mysqli_query($conn,"SELECT courseCode,courseName from tblcourse 
     where StaffId='$EmpId'ORDER BY id asc");
    $lstCourse=array();
    while ($row = mysqli_fetch_array($all_query)) 
    {
        $lstCourse[] = $row;
    }
    $opDept="";
    $opSem="";
    $opYear="";
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <?php include('../links.php'); ?>
    <title>Internal Marks</title>
</head>
<body class="ovflow-y">
    <div  id="header">
        <div class="row">
            <div class="col-md-3">
                <p id="headerUser">Internal Mark Report</p>
            </div>
            <div class="col-md-6">
                <center><h3 id="clgname">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
            </div>
            <div class="col-md-3">
                <div class="row ">
                    <div class="col-md-6">

                    </div>
                    <div class="col-md-6">
                        <div class="margin-top-base" >
                            <a href="../index.php" class="btn btn-primary btn-sm" style="color: #fff;">
                                <i class="fa-solid fa-backward"></i> 
                                <b>BACK</b>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
    </div> 
    <div class="margin-top-base" >
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2">
                    <label for="input1" class="form-label">Department</label>
                    <select class="form-select" name="ri_dept" id="ri_dept"
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
                            $("#ri_dept").val(selectedValue);
                        });
                    </script>
                </div>
                <div class="col-md-2">
                <label for="input1" class="form-label">Course</label>
                <select class="form-select" name="ri_course" id="ri_course"
                    placeholder="Select the Degree" required  autocomplete="off">
                    <?php
                        foreach ($lstCourse as $value => $label) 
                        {
                            $selected = ($opDept == $label['courseCode']) ? "selected" : "";
                            echo "<option value=\"{$label['courseCode']}\" $selected>{$label['courseName']}</option>";
                        }
                    ?>
                </select>
                <script>
                    $(document).ready(function() {
                        var selectedValue = "<?php echo $opDept; ?>";
                        $("#ri_course").val(selectedValue);
                    });
                </script>
                </div>
                <div class="col-md-2">
                <label for="input1" class="form-label">Exam</label>
                <select class="form-select" name="ri_exam" id="ri_exam"
                    placeholder="Select the Exam" required  autocomplete="off">
                
                </select>
                </div>
                <div class="col-md-2">
               <label for="input1" class="form-label">Semester </label>
                <select class="form-select" name="ri_semester" id="ri_semester"
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
                       $("#ri_semester").val(selectedValue);
                    });
                </script>
                </div>
                <div class="col-md-2">
                <label for="input1" class="form-label">Year</label>
                <select class="form-select" name="ri_year" id="ri_year"
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
                        $("#ri_year").val(selectedValue);
                    });
                </script>
                </div>
                <div class="col-md-2 col-lg-2">
                <div class="form-group">
                    <input type="submit" class="btn btn-primary btn-sm"  tabindex="5"  id="btnGet" value="Get Report" 
                            style=" margin-top: 31px;"/>
                </div>
                </div>
        </div>
        <div id="rpInternal">
            <div class="container" > 
                <div class="row">
                    <div class="col-md-12">
                        <div style="float:right;">
                            <button id="printButton" class="btn btn-success btn-sm"><i class="fa fa-print"  aria-hidden="true"></i></button>
                        </div>
                    </div>
                </div>
                <div id="printAre">
                    <div class="row" style="margin-top:10px;" >
                        <div class="col-md-1">
                            <img src="../images/favicon/192x192.png" width="60px" height="60px" alt="logo" />
                        </div>
                        <div class="col-md-10">
                            <center><b> Sri Ramakirshna Mission Vidyalaya College of Arts And Science</b></center>
                            <center><span>(Autonomous) Coimbatore - 641 020</span></center>
                        </div>
                        <div class="col-md-1"></div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-4"></div>
                                <div class="col-md-4">
                                    <center><u><b id="lblExamName"></b></u></center>
                                </div>
                                <div class="col-md-4"></div>
                            </div>
                            <div class="row">
                                <div class="col-md-1"></div>
                                <div class="col-md-10">
                                    <div class="row">
                                        <div class="col-md-7" style=" padding-right: 0px; ">
                                            <center><p style="float: right;font-size: 13PX;">MONTH & YEAR OF EXAMINATION:</p></center>
                                        </div>
                                        <div class="col-md-4" style=" padding-left: 0px; ">
                                            <input type="text" id="txtMonth" required style="height:23px" />
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-md-12">
                                    <label>PROGRAMME & DEPARTMENRT</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12" >
                                    <div id="lblDepartment" style="border-bottom:1px solid #000;">
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <label>COURSE TITLE WITH CODE</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div id="lblCourseName" style="border-bottom:1px solid #000;">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="row">
                                <div class="col-md-6">
                                    <label>YEAR</label>
                                </div>
                                <div class="col-md-6" >
                                    <div  id="lblYear"></div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label>SEMESTER</label>
                                </div>
                                <div class="col-md-6" >
                                    <div  id="lblSemester" style="border-bottom:1px solid #000;"></div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <label>MAX.MARKS </label>
                                </div>
                                <div class="col-md-6" >
                                    <div  id="lblMaxMarks" style="border-bottom:1px solid #000;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4"></div>
                        <div class="col-md-4">
                            <center>
                                <div style="border:3px double #000; margin:10px;0px;10px;0px;">
                                    <b>STATEMENT OF MARKS</b>
                                </div>
                            </center>
                        </div>
                        <div class="col-md-4"></div>
                    </div>
                    <div class="row border">
                        <div class="col-md-6">
                            <table id="tblMark1" class="table table-bordered " >
                                <thead>
                                    <tr>
                                        <td>S.No</td>
                                        <td>Register Number</td>
                                        <td>Marks</td>
                                        <td>Signature of the Student</td>
                                    </tr>
                                </thead>
                                <tbody style=" line-height: 5px; font-size: 12px; ">

                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-6" >
                            <table id="tblMark2" class="table table-bordered " >
                                <thead>
                                    <tr>
                                        <td>S.No</td>
                                        <td>Register Number</td>
                                        <td>Marks</td>
                                        <td>Signature of the Student</td>
                                    </tr>
                                </thead>
                                <tbody style=" line-height: 5px; font-size: 12px; ">

                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div style="margin-top:55px">
                        <div class="row">
                            <div class="col-md-4">
                                    <i>Date:</i>
                            </div>
                            <div class="col-md-4">
                                <i>Signature of the Staff <br /> Name in </i><b>BLOCK LETTERS</b>
                            </div>
                            <div class="col-md-4">
                                <i>Signature of the HOD with date</i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script type="text/javascript">
    $(document).ready(function() {
        $('#tblMark2').hide();
        $('#rpInternal').hide();
        $('#btnGet').click(function(e) 
        {
            $('#rpInternal').show();
            e.preventDefault(); 
            var departmentId = $('#ri_dept').val();
            var semester = $('#ri_semester').val();
            var year = $('#ri_year').val();
            var exam = $('#ri_exam').find(":selected").attr("id");
            var course = $('#ri_course').val();
            $.ajax({
                url: './data/internel.php',
                method: 'POST',
                data: { 
                    departmentId: departmentId,
                    semester:semester,
                    year:year,
                    exam:exam,
                    course:course
                },
                success: function(data) {
                    $('#lblExamName').text(data.data[0].Name);
                    $('#lblDepartment').text(data.data[0].dname);
                    $('#lblCourseName').text(data.data[0].courseName+" - "+data.data[0].courseCode);
                    $('#lblYear').text(data.data[0].year);
                    $('#lblSemester').text(data.data[0].semester);
                    $('#lblMaxMarks').text(data.data[0].Maxmark);
                   // $('#grpStudent').css('display', 'inline');
                    //$('#tblMark1 tbody').html(data);
                    var content="";
                    if(data.totalrecords > 30)
                    {
                        for(var i=0;i<30;i++)
                        {
                           
                            contentM="<tr>"+
                                        "<td  STYLE='text-align:center;' >"+ (i+1) +"</td>"+
                                        "<td>"+ data.data[i].RegNo +"</td>"+
                                        "<td  STYLE='text-align:center;'>"+ data.data[i].CurrentMark +"</td>"+
                                        "<td></td>"+
                                        "</tr>";
                           content=content+contentM;
                           
                        }
                        $('#tblMark1 tbody').html(content);
                        content="";
                        var flag=false;
                        for(var i=30;i<data.totalrecords;i++)
                        {
                            flag=true;
                            contentM="<tr >"+
                                        "<td STYLE='text-align:center;'>"+(i+1)+"</td>"+
                                        "<td>"+data.data[i].RegNo+"</td>"+
                                        "<td STYLE='text-align:center;'>"+data.data[i].CurrentMark+"</td>"+
                                        "<td></td>"+
                                        "</tr>";
                           content=content+contentM;
                           
                        }
                        
                        $('#tblMark2 tbody').html(content);
                        
                        if(flag)
                        {
                            $('#tblMark2').show();
                        }
                    }
                    else{
                        for(var i=0;i<data.totalrecords;i++)
                        {
                           
                            contentM="<tr>"+
                                        "<td STYLE='text-align:center;'>"+ (i+1) +"</td>"+
                                        "<td>"+ data.data[i].RegNo +"</td>"+
                                        "<td STYLE='text-align:center;'>"+ data.data[i].CurrentMark +"</td>"+
                                        "<td></td>"+
                                        "</tr>";
                           content=content+contentM;
                           
                        }
                        $('#tblMark1 tbody').html(content);

                    }

                }
            });
       });
       $('#printButton').click(function(e) {
            var printContent = document.getElementById("printAre").innerHTML;

            // Create an HTML string with the content
            var htmlContent = `<html lang='en'><head>
                <link rel='stylesheet' type='text/css' href='../css/main.css'>
                <link rel='stylesheet' type='text/css' href='../css/Bootstrap.css'>
                <title>Internal Report</title>
                <style type='text/css' media='print'> @page { size: auto; margin: 0mm; }</style>
            </head>
            <body onload='window.print();'><div class='container'>${printContent}</div></body></html>`;

            // Log the HTML content for debugging
            console.log(htmlContent);
            var tableWindow = window.open("", "Table Print");
            tableWindow.document.write(htmlContent);
            tableWindow.document.close();
            setTimeout(function() {
                tableWindow.close();
            }, 1000);

        });

    });
    $('#txtMonth').on('blur', function() {
        var newValue = $(this).val();
        $(this).attr('value', newValue);
    });
    $('#ri_dept').change(function(){
        var dept=$(this).val();
        //alert(dept);
        $.ajax({
            type: "POST",
            url: "./data/get_Exam.php",
            data: { 
                departmentId: dept
                
            },
            success: function(response) {
                if (response.error) 
                {
                    swal(response,{ icon: "warning",});
                } 
                else
                {
                    $('#ri_exam').html(response);              
                }
            }
        });
    });
</script>        
</html>
