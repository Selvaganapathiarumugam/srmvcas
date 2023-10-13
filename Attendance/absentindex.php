<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../connect.php'); 
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    }
    if(isset($_REQUEST["did"]))
    {
        $id=$_REQUEST['did'];
        $SQL="delete from  tblattendance where Id='". $id."'";
        try {
            $result = mysqli_query($conn,$SQL);
            echo "<script> deletemsg(); </script>";
        } catch (\Throwable $th) {
            throw $th;
        }
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
    $opSem = $semester;
    $opYear=$year;
    $opDept=$deptid;
    function getDataFromDatabase($sdate,$sdept,$ssemester,$syear) {
        global $conn;
        $query = "SELECT regno,date, SubjectHour, isAbsent FROM tblAttendance
                   where date='$sdate'";
        if($sdept != 0)
        {
            $query = "SELECT a.regno,a.date, a.SubjectHour, a.isAbsent FROM tblAttendance a
                      inner join tblstudent s on a.regno = s.regno
                   where a.date='$sdate' and s.deptid =$sdept ";
        }
        if($ssemester != null)
        {
            $query = "SELECT a.regno,a.date, a.SubjectHour, a.isAbsent FROM tblAttendance a
                      inner join tblstudent s on a.regno = s.regno
                   where a.date='$sdate' and s.deptid =$sdept and s.semester='$ssemester' ";
        }
        if($syear != null)
        {
            $query = "SELECT a.regno,a.date, a.SubjectHour, a.isAbsent FROM tblAttendance a
                      inner join tblstudent s on a.regno = s.regno
                   where a.date='$sdate' and s.deptid =$sdept and s.semester='$ssemester' 
                   and s.year='$syear'";
        }
         //echo $query;die();
        $result = mysqli_query($conn, $query);
       // print_r($result);die();
        $data = array();
        while ($row = mysqli_fetch_assoc($result)) {
            $data[] = $row;
        }
        //print_r($data);die();
        return $data;
        
    }

    function organizeData($data) {
        $organizedData = array();
       
        foreach ($data as $row) {
            $regno = $row['regno'];
            $hour = $row['SubjectHour'];
            $isAbsent = $row['isAbsent'];
            $date=$row['date'];
            $organizedData[$regno][$hour] = $isAbsent;
        }
       // print_r($organizedData);die();
        return $organizedData;
    }
    if(isset($_POST['save']))
    {
        
        $fdate=$_POST['date'];
        $dept=$_POST['st_dept'];
        $st_semester=$_POST['st_semester'];
        $st_year = $_POST['st_year'];
        $data = getDataFromDatabase($fdate,0,"","");
        if ($dept != null) {
            $data = getDataFromDatabase($fdate,$dept,"","");
        }
        if ($st_semester != null) {
            $data = getDataFromDatabase($fdate,$dept,$st_semester,"");
        }
        if ($st_semester != null) {
            $data = getDataFromDatabase($fdate,$dept,$st_semester,$st_year);
        }
    }
    
    $organizedData = organizeData($data);

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <?php include('../links.php'); ?>
    <title>Attendance</title>
</head>
<body class="ovflow-y">
    <div id="header">
        <div class="row">
            <div class="col-md-3">
                <p id="headerUser">Attendance View</p>
            </div>
            <div class="col-md-6 col-sm-6">
                <center><h3 id="clgname">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
            </div>
            <div class="col-md-3 col-sm-3">
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
    <div class="container" style="background-color:#EFEFEE">
        <div class="margin-top-base">
            <div class="row">
                <div class="col-md-9">
                    <p class=" padding-base">
                        Staffs ensure that the attendance record they have created is correct on this page.
                    </p>
                </div>
                <div class="col-md-3">
                <a href="./attendance.php" class="btn btn-primary btn-sm margin-bottom-base margin-top-base" style="color: #fff;float:right;">
                    <i class="fa fa-plus" ></i>
                    <b>Go To Attendance</b>
                </a>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="margin-top-base">
                    <form action="absentindex.php" method="POST" >
                        <div class="row">
                            <div class="col-md-2">
                                <div class="form-group">
                                    Date<br />
                                    <input type='date' id='date' name='date' class="form-control" required 
                                        tabindex="1"  autocomplete="off"/>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    Department<br />
                                    <select class="form-select" tabindex="2" name="st_dept" id="st_dept"   autocomplete="off">
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
                                            $("#st_dept").val(selectedValue);
                                        });
                                    </script>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    Semester<br />
                                    <select class="form-select" name="st_semester" id="st_semester"
                                         placeholder="Select the Semester" tabindex="3"   autocomplete="off">
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
                                           $("#st_semester").val(selectedValue);
                                        });
                                    </script>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    Year<br />
                                    <select class="form-select" tabindex="4" name="st_year" id="st_year"
                                        placeholder="Select the Year"   autocomplete="off" >
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
                                           $("#st_year").val(selectedValue);
                                        });
                                    </script>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <input type="submit" tabindex="5" class="btn btn-primary btn-sm" name="save" value="Get Data" 
                                    style="margin-top: 20px;"
                                    />
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2">
                <div style="padding: 20px;border: 1px solid #faec66; margin-top:10px;
                            border-radius: 10%;background-color:#fff;" id="timedash">
                    <?php
                        if($fdate == null)
                        {
                            echo "Current Date <br />";
                            echo date("d/m/Y h:i");
                        }
                        else{
                            echo "Report Date <br />";
                            echo date("d/m/Y",strtotime($fdate));
                        }
                    ?>
                </div>
            </div>
            <div class="col-md-8">
                <table style="margin-top:10px" class="table table-striped table-hover bg-white" >
                    <tr>
                        <th>Reg NO</th>
                        <th>1</th>
                        <th>2</th>
                        <th>3</th>
                        <th>4</th>
                        <th>5</th>
                        <th>Edit</th>
                    </tr>
                    <?php
                        foreach ($organizedData as $regno => $hours) {
                            echo "<tr>";
                            echo "<td>" . $regno . "</td>"; 
                            for ($hour = 1; $hour <= 5; $hour++) {
                                $isAbsent = isset($hours[$hour]) && $hours[$hour] == 0 ? '<i class="fa-regular fa-square-check"></i>' : '<i class="fa-regular fa-square">';
                                echo "<td class='isAbsent'>" . $isAbsent . "</td>";
                                
                            }
                            echo "<td><a href='attverify.php?id=$regno &date=$fdate'><i class='fa fa-pencil'></i></a></td>";
                            echo "</tr>";
                        }
                    ?>
                </table>
            </div>
            <div class="col-md-2">

            </div>
        </div>
    </div>
</body>
</html>