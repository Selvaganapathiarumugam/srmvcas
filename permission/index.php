<?php
    ob_start();
    session_start();
    error_reporting(0); 
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    }

    include('../connect.php');
    include('../links.php');
    if(isset($_REQUEST["btnAtte"]))
    {
        $EmpId=$_REQUEST["std"];
        $addstudent=$_POST["addstudent"];
        $updatestudent=$_REQUEST["updatestudent"];
        $addcourse=$_REQUEST["addcourse"];
        $updatecourse=$_REQUEST["updatecourse"];
        $addtimetable=$_REQUEST["addtimetable"];
        $updatetimetable=$_REQUEST["updatetimetable"];
        $bulkattendance=$_REQUEST["bulkattendance"];
        $attendancereport=$_REQUEST["attendancereport"];
        $permission=$_REQUEST["permission"];

        for($i=0;$i<sizeof($EmpId);$i++)
        {
            print_r($_POST["addstudent"]) ;exit;
            $addS = in_array($EmpId[$i],$addstudent) ? 0 : 1;
            $updS = in_array($EmpId[$i],$updatestudent) ? 0 : 1;
            $addC = in_array($EmpId[$i],$addcourse) ? 0 : 1;
            $updC = in_array($EmpId[$i],$updatecourse) ? 0 : 1;
            $addT = in_array($EmpId[$i],$addtimetable) ? 0 : 1;
            $updT = in_array($EmpId[$i],$updatetimetable) ? 0 : 1;
            $addBI = in_array($EmpId[$i],$bulkattendance) ? 0 : 1;
            $addAR = in_array($EmpId[$i],$attendancereport) ? 0 : 1;
            $addP = in_array($EmpId[$i],$permission) ? 0 : 1;

            $qry="insert into  tblpermission (staffid, addstudent, updatestudent, addcourse,updatecourse, addtimetable,updatetimetable,bulkattendance,attendancereport,permission) values
            ('".$EmpId[$i]."',".$addS.",".$updS.",".$addC.",".$updC.",".$addT.",".$updT.",".$addBI.",".$addAR.",".$addP.");";
            echo $qry."<br>"; die();
            mysqli_query($conn,$qry);
            $_SESSION["msg"]="Data Entry Saved";
        }
        header("location:./absentindex.php");    
            
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Permission</title>
</head>
<body class="ovflow-y">
    <div class="border-1p" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
        <div class="row">
            <div class="col-md-9">
                <center><h3 class="">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science <br /> Coimbatore 641020</h3></center>
            </div>
            <div class="col-md-3">
                <div class="row">
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
    <form id="frmadd" action="index.php" mode="POST">
        <div class="row">
            <div class="col-md-5"></div>
            <div class="col-md-5"></div>
            <div class="col-md-2">
                <input type="submit" value="save" name="btnAtte" class="btn btn-success btn-sm margin-top-base" />
            </div>
        </div>
        <div class="row">
            <div class="col-md-1"></div>
                <div class="col-md-10">
                    <table id="tblStudentList" class="table table-striped margin-top-base" border="1">
                        <thead>
                            <tr>
                                <th>username</th>
                                <th>addstudent</th>
                                <th>updatestudent</th>
                                <th>addcourse</th>
                                <th>updatecourse</th>
                                <th>addtimetable</th>
                                <th>updatetimetable</th>
                                <th>bulkattendance</th>
                                <th>attendancereport</th>
                                <th>permission</th>
                            </tr>   
                        </thead>
                        <tbody>
                        <?php
                            $SQL="SELECT p.id,u.EmpId,u.username,p.addstudent,p.updatestudent,p.addcourse,p.updatecourse,p.addtimetable,p.updatetimetable,p.bulkattendance,p.attendancereport,p.permission 
                            FROM tblpermission p right outer join tblusers u on p.staffid=u.EmpId order by u.username ASC; ";
                            $result = mysqli_query($conn,$SQL);
                            $data = array();
                            while ($row = mysqli_fetch_array($result))
                            {
                                $as=$row['addstudent']==1?'checked':'';
                                $us=$row['updatestudent']==1?'checked':'';
                                $ac=$row['addcourse']==1?'checked':'';
                                $uc=$row['updatecourse']==1?'checked':'';
                                $at=$row['addtimetable']==1?'checked':'';
                                $ut=$row['updatetimetable']==1?'checked':'';
                                $bi=$row['bulkattendance']==1?'checked':'';
                                $ar=$row['attendancereport']==1?'checked':'';
                                $pn=$row['permission']==1?'checked':'';
                        ?>
                            <tr>
                                <!-- FETCHING DATA FROM EACH
                                    ROW OF EVERY COLUMN -->
                                <td>
                                    <input type='hidden'  name='std[]'  value='<?php echo $row['EmpId'];?>'>
                                    <?php echo $row['username'];?>
                                </td>
                                <td>

                                    <input type='checkbox' name='addstudent[]' id='chaddstudent' value=' <?php echo $row['addstudent'];?>' <?php echo $as ?> />                               
                                </td>
                                <td>
                                    <input type='checkbox' name='updatestudent[]' id='chupdatestudent' value=' <?php echo $row['updatestudent'];?>' <?php echo $us ?> />                               
                                </td>
                                <td>
                                    <input type='checkbox' name='addcourse[]' id='chaddcourse' value=' <?php echo $row['addcourse'];?>' <?php echo $ac ?> />                               
                                </td>
                                <td>
                                    <input type='checkbox' name='updatecourse[]' id='chupdatecourse' value=' <?php echo $row['updatecourse'];?>' <?php echo $uc ?> />                               
                                </td>
                                <td>
                                    <input type='checkbox' name='addtimetable[]' id='chaddtimetable' value=' <?php echo $row['addtimetable'];?>' <?php echo $at ?> />                               
                                </td>
                                <td>
                                    <input type='checkbox' name='updatetimetable[]' id='chupdatetimetable' value=' <?php echo $row['updatetimetable'];?>' <?php echo $ut ?> />                               
                                </td>
                                <td>
                                    <input type='checkbox' name='bulkattendance[]' id='chbulkattendance' value=' <?php echo $row['bulkattendance'];?>' <?php echo $bi ?> />                               
                                </td>
                                <td>
                                    <input type='checkbox' name='attendancereport[]' id='chattendancereport' value=' <?php echo $row['attendancereport'];?>' <?php echo $ar ?> />                               
                                </td>
                                <td>
                                    <input type='checkbox' name='permission[]' id='chpermission' value=' <?php echo $row['permission'];?>' <?php echo $pn ?> />                               
                                </td>
                            </tr>
                        <?php
                            }
                        ?>
                        </tbody>
                    </table>
                </div>
            <div class="col-md-1"></div>
        </div>
    </form>
</body>
<script>
    $(document).ready(function() {
        $.ajax({
        url: './data/search.php', 
        datatype:'json',
        method:'GET',
        success: function(data) {
            $("#append_datas").append(data);
        },
        error: function(xhr, status, error) 
        {
            swal(xhr.responseText); 
        }
        });
    });

</script>
</html>