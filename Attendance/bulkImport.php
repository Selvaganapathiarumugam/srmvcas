<?php 
    ob_start();
    session_start();
    error_reporting(0); 
    include('../links.php');
    include('../connect.php');
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    } 
    $Eid=$_SESSION['EmpId'];
    $SQL="SELECT bulkattendance from  tblusersrights where EmpId ='". $Eid."'";
    $result = mysqli_query($conn,$SQL);
    
    while($row = mysqli_fetch_array($result)) 
    {
        $isAddRight = $row['bulkattendance'];
    }
    if($isAddRight == 0) {
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
    // $lstDayOrder = array(
    //     1 => "1",
    //     2 => "2",
    //     3 => "3",
    //     4 => "4",
    //     5 => "5",
    //     6 => "6"
    // );
    // $lsthours = array(
    //     1 => "1",
    //     2 => "2",
    //     3 => "3",
    //     4 => "4",
    //     5 => "5",
    //     6 => "6"
    // );

    $opDept=$deptId;
    $opSem = $Semester;
    $opYear=$year;
    // $opsub=$SubjectId;
    // $opDayOrder=$DayOrder;
    // $opHours=$SubjectHour;
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Day Attendance</title>
</head>
<body class="ovflow-y">
    <div id="header">
        <div class="row">
            <div class="col-md-3">
                <p id="headerUser">Bulk Import </p>
            </div>
            <div class="col-md-6">
                <center><h3 class="">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
            </div>
            <div class="col-md-3">
                <div class="row">
                    <div class="col-md-6">
                    </div>
                    <div class="col-md-6">
                        <div class="margin-top-base" >
                            <a href="./index.php" class="btn btn-primary btn-sm" style="color: #fff;">
                                <i class="fa-solid fa-backward"></i> 
                                <b>BACK</b>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
    </div> 
    <div class="container"style="background-color:#EFEFEE"   >
        <div class="margin-top-base padding-top-base">
            <div class="row">
                <form id="frmAtt" action="./data/bulk_import.php" class="" method="post">
                    <div class="mb-4 bg-white rounded-3 padding-base">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-3">
                                    <label for="input1" class="form-label">Date</label>
                                    <input type='date' id='at_date' name='at_date' class="form-control" 
                                        tabindex="1" value="<?php echo $at_date; ?>" required autocomplete="off"
                                    />
                                </div>
                                <div class="col-md-3">
                                    <label for="input1" class="form-label">Department</label><br />
                                    <select class="form-select" tabindex="2" name="at_dept" id="at_dept" required  autocomplete="off">
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
                                <div class="col-md-2">
                                    <label for="input1" class="form-label">Semester</label><br />
                                    <select class="form-select" name="at_semester" id="at_semester"
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
                                            $("#at_semester").val(selectedValue);
                                        });
                                    </script>
                                </div>
                                <div class="col-md-2">
                                    <label for="input1" class="form-label">Year </label><br />
                                    <select class="form-select" tabindex="4" name="at_year" id="at_year"
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
                                <div class="col-md-2">
                                    <div style="margin-top:31px">
                                        <input type="submit" name="btnbulkimport" value="Bulk Import" class="btn btn-success" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="margin-top-base">
            <div class="row">
                <b id="headerUser">Final Absentees List</b>
                        <div class="col-md-12">
                            <table id="tblDayAttendance" class="table table-responsive table-hover" cellspacing="0">
                                <thead>
                                    <tr>                                    
                                    <th scope="col">Reg No</th>
                                    <th scope="col">Department</th>
                                    <th scope="col">Semester</th>
                                    <th scope="col">Year</th>
                                    <th scope="col">Date</th>
                                    <th scope="col">Status</th>
                                    <!-- <th scope="col">Edit</th>
                                    <th scope="col">Delete</th> -->
                                    </tr>
                                </thead>
                            </table> 
                        </div>
                    </div>
            </div>
        </div>
    </div>


</body>
</html>

    <script type="text/javascript"> 
        $(document).ready(function() {
            $('#tblDayAttendance').dataTable({
                "processing": true,
                "ajax": "./data/dayAttendanceList.php",
                "columns": [
                    {data: 'regno'},
                    {data: 'department'},
                    {data: 'semester'},
                    {data: 'year'},
                    {data: 'date'},
                    {data: 'status'}
                    // { 
                    //     data: '',
                    //     render: (data,type,row) => {
                    //      return `<a href='#.php?id=${row.id}'><i class="fa fa-pencil" style="color: #005eff;"></i></a>`;
                    //     }
                    // },
                    // { 
                    //     data: '',
                    //     render: (data,type,row) => {
                    //         return `<?PHP if ($_SESSION['Role'] == "1") {?><a onClick=\"javascript: return confirm('Please confirm deletion');\" href='index.php?did=${row.id}'><i class="fa fa-trash"></i></a>
                    //         <?php } else{ ?><i class="fa fa-trash"></i><?php } ?>`;
                    //     }
                    // }
                ]
            });
        });
    </script>