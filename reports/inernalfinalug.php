<?php
    include('../connect.php');

    $all_query = mysqli_query($conn,"SELECT * from tbldepartment ORDER BY id asc");
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
    $all_query = mysqli_query($conn,"SELECT courseCode from tblcourse ORDER BY id asc");
    $lstCourse=array();
    while ($row = mysqli_fetch_array($all_query)) 
    {
        $lstCourse[] = $row;
    }
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <?php include('../links.php'); ?>
    <title>Internal Marks</title>
</head>
<body>
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
                                echo "<option value=\"{$label['courseCode']}\" $selected>{$label['courseCode']}</option>";
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
                        <div class="row" >
                            <div class="col-md-5"></div>
                            <div class="col-md-1">
                                <img src="../images/favicon/192x192.png" width="60px" height="60px" alt="logo" />
                            </div>
                            <div class="col-md-5"></div>
                        </div>
                        <div class="row">
                            <div class="col md-1"></div>
                            <div class="col-md-10">
                                 <P style="margin-bottom:0px"> SRI RAMAKRISHNA MISSION VIDYALAYA COLLEGE OF ARTS AND SCIENCE</P>
                                 <center><span>(AUTONOMOUS) COIMBATORE - 641 020</span></center>
                            </div>
                            <div class="col-md-1"></div>
                        </div>
                        <div class="row">
                            <div class="col-md-1"></div>
                            <div class="col-md-10">
                                <center>
                                    <b>CONTINUOUS INTERNAL ASSESSMENT MARKS(U.G.DEGREES)</b>
                                </center>
                                <div class="row">
                                    <div class="col-md-4"></div>
                                    <div class="col-md-2">
                                        <p style="float: right;">COURSE : </p>
                                    </div>
                                    <div class="col-md-4">
                                        <div id="lblDepartment" style="float:left;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="table-responsive">
                                    <table class="table">
                                        <tr>
                                            <td>Year</td>
                                            <td colspan="6">
                                                <div id="lblYear"></div>
                                            </td>
                                            <td>SEMESTER</td>
                                            <td colspan="2">
                                                <div id="lblSemester"></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Title of the Paper</td>
                                            <td colspan="6">
                                                <div id="lblCourseName"></div>
                                            </td>
                                            <td>Code</td>
                                            <td colspan="2">
                                                <div id="lblCourseCode"></div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <div class="row border">
                            <div class="col-md-12">
                                <table id="tblMark" class="table table-bordered " style="font-size:9px;font-weight:600;">
                                    <thead>
                                        <tr>
                                            <td rowspan='2'>S.NO</td>
                                            <td rowspan='2'>Register Number</td>
                                            <td colspan="2">CIA</td>
                                            <td colspan="2">Model </td>
                                            <td>Assignment</td>
                                            <td>Attendance</td>
                                            <td rowspan='2'>Marks For 50 </td>
                                        </tr>
                                        <tr>
                                            <td>45</td>
                                            <td>15</td>
                                            <td>75</td>
                                            <td>20</td>
                                            <td>10</td>
                                            <td>5</td>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div style="margin-top:55px">
                            <div class="row">
                                <div class="col-md-4">
                                    <i>Signature of the Staff <br /> Name in </i><b>BLOCK LETTERS</b>
                                </div>
                                <div class="col-md-4">
                                    <i>Signature of the HOD with date</i>
                                </div>
                                <div class="col-md-4">
                                    <i style="float:right;">Principal</i>
                                </div>
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
        $('#rpInternal').hide();
        $('#btnGet').click(function(e) {
            $('#rpInternal').show();
            e.preventDefault(); 
            var departmentId = $('#ri_dept').val();
            var semester = $('#ri_semester').val();
            var year = $('#ri_year').val();
            var course = $('#ri_course').val();
            $.ajax({
                url: './data/internal_PG.php',
                method: 'POST',
                data: { 
                    departmentId: departmentId,
                    semester:semester,
                    year:year,
                    course:course
                },
                success: function(data) {
                    $('#lblDepartment').text(data.data[0].dname);
                    $('#lblCourseName').text(data.data[0].courseName);
                    $('#lblYear').text(data.data[0].Year);
                    $('#lblSemester').text(data.data[0].Semester);
                    $('#lblCourseCode').text(data.data[0].CourseCode);
                    var content="";
                    for(var i=0;i<data.totalrecords;i++)
                        {
                            var CIA = data.data[i].EX01==null?0:data.data[i].C;
                            var CIAT = data.data[i].EX01==null?0:data.data[i].T;
                            var MODEL = data.data[i].EX03==null?0:data.data[i].C;
                            var MODELT = data.data[i].EX03==null?0:data.data[i].T;
                            var Assignment=data.data[i].EX04==null?0:data.data[i].C;
                            var attendance=data.data[i].EX05==null?0:data.data[i].T;
                            var total=parseInt(CIAT, 10)+parseInt(MODELT, 10)+parseInt(Assignment, 10)+parseInt(attendance, 10);
                            contentM="<tr>"+
                                        "<td>"+ (i+1) +"</td>"+
                                        "<td>"+ data.data[i].RegNo +"</td>"+
                                        "<td>"+ CIA +"</td>"+
                                        "<td>"+ CIAT +"</td>"+
                                        "<td>"+ MODEL +"</td>"+
                                        "<td>"+ MODELT +"</td>"+
                                        "<td>"+ Assignment +"</td>"+
                                        "<td>"+ attendance +"</td>"+
                                        "<td>"+ total +"</td>"+
                                        "</tr>";
                           content=content+contentM;
                           
                        }
                        $('#tblMark1 tbody').html(content);
                   
                    $('#tblMark tbody').html(content);


                }
            });
       });
       $('#printButton').click(function(e) {
            var printContent = document.getElementById("printAre").innerHTML;

            var htmlContent = `<html lang='en'><head>
                <link rel='stylesheet' type='text/css' href='../css/main.css'>
                <link rel='stylesheet' type='text/css' href='../css/Bootstrap.css'>
                <title>Internal Report</title>
                <style type='text/css' media='print'> @page { size: auto; margin: 0mm; }</style>
            </head>
            <body onload='window.print();'><div class='container'>${printContent}</div></body></html>`;

            console.log(htmlContent);
            var tableWindow = window.open("", "Table Print");
            tableWindow.document.write(htmlContent);
            tableWindow.document.close();
            setTimeout(function() {
                tableWindow.close();
            }, 1000);

        });

    });
</script>        
</html>
