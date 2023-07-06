<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../links.php');
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
    $lstDayOrder = array(
        1 => "1",
        2 => "2",
        3 => "3",
        4 => "4",
        5 => "5",
        6 => "6"
    );
    $lsthours = array(
        1 => "1",
        2 => "2",
        3 => "3",
        4 => "4",
        5 => "5",
        6 => "6"
    );

    $opDept=$deptId;
    $opSem = $Semester;
    $opYear=$year;
    $opsub=$SubjectId;
    $opDayOrder=$DayOrder;
    $opHours=$SubjectHour;
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Attendance</title>
    <link href="../css/toggle.css" rel="stylesheet">
    <script src="../js/toggle.js"></script>
</head>
<body class="ovflow-y">
    <div class="row" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
        <div class="col-md-3">
            <h3 class="padding-base">Attendance</h3>
        </div>
        <div class="col-md-6">
            <center><h3 class="">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
        </div>
        <div class="col-md-3">
            <div class="row">
                <div class="col-md-6"></div>
                    <div class="col-md-6">
                        <div class="margin-top-base">
                            <a href="../index.php" class="btn btn-primary btn-sm">
                                <i class="fa-solid fa-backward " style="color: #fff;"></i>
                                <b>BACK</b>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container" style="background-color:rgb(255, 248, 240)">
        <div class="row " >
            <div class="col-md-12">
                <marquee>Attendance Master</marquee>
            </div>
        </div>
        <div class="row">
            <form id="frmAtt">
                <div class="p-5 mb-4 bg-light rounded-3" style="margin-left:15px;height: 100% !important;">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-3">
                                <label for="input1" class="form-label">Department</label><br />
                                <select class="form-select" tabindex="1" name="at_dept" id="at_dept" required  autocomplete="off">
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
                                        $("#at_dept").val(selectedValue);
                                    });
                                </script>
                            </div>
                            <div class="col-md-3">
                                <label for="input1" class="form-label">Semester</label><br />
                                <select class="form-select" name="at_semester" id="at_semester"
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
                                        $("#at_semester").val(selectedValue);
                                    });
                                </script>
                            </div>
                            <div class="col-md-3">
                                <label for="input1" class="form-label">Year </label><br />
                                <select class="form-select" tabindex="3" name="at_year" id="at_year"
                                    required  autocomplete="off" >
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
                                        $("#at_year").val(selectedValue);
                                    });
                                </script>
                            </div>
                            <div class="col-md-3">
                                <div style="margin-top:31px">
                                    <input type="submit" name="btnsearch" value="Get Students" class="btn btn-outline-info" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="margin-top-base">
            <div class="row">
                <div class="col-md-3"></div>
                <div class="col-md-6">
                    <table id="tblStudentList" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>RegNo</th>
                                <th>Name</th>
                                <th>Present</th>
                            </tr>   
                        </thead>
                        <tbody>
                            <!-- Table rows will be dynamically generated here -->
                        </tbody>
                    </table>
                </div>
                <div class="col-md-3"></div>
            </div>
        </div>
    </div>
</body>
<script>
    $(document).ready(function() {
        $('#frmAtt').submit(function(e) {
            e.preventDefault(); 
            var at_dept = $('#at_dept').val();
            var at_semester = $('#at_semester').val();
            var at_year = $('#at_year').val();
            $.ajax({
            url: './data/search.php', 
            method: 'POST',
            data: {
                at_dept: at_dept,
                at_semester: at_semester,
                at_year: at_year
                },
                success: function(response) {
                    var data = JSON.parse(response);
                    var tableBody = document.getElementById('tblStudentList').getElementsByTagName('tbody')[0];
                    // Generate table rows and cells dynamically
                    for (var i = 0; i < data.length; i++) {
                        var row = tableBody.insertRow();
                        var regnoCell = row.insertCell();
                        var nameCell = row.insertCell();
                        var attendanceCell = row.insertCell();
                        nameCell.textContent = data[i].firstName;
                        regnoCell.textContent = data[i].regNo;
                        attendanceCell.innerHTML = '<input type="checkbox" name="chIspresent" checked >';
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
</html>
<!--  
    id
date
regNo
deptid
subjectHour
isAbsent
                            <div class="col-md-3">
                                <label for="input1" class="form-label">Date</label><br />
                                <input type='date' id='at_date' name='at_date' class="form-control" required 
                                    tabindex="1" value="<?php echo $at_date; ?>" autocomplete="off"
                                />
                            </div>
-->
