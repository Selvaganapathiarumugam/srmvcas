
<?php 
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');
    header('Content-Type: application/json');

   
    $SQL="SELECT p.id,u.username,p.addstudent,p.updatestudent,p.addcourse,p.updatecourse,p.addtimetable,p.updatetimetable,p.bulkattendance,p.attendancereport,p.permission 
    FROM tblpermission p right outer join tblusers u on p.staffid=u.EmpId order by u.username ASC; ";
    $result = mysqli_query($conn,$SQL);

    while ($row = mysqli_fetch_array($result))
    {
        $response[]=$row;
    }
    if (!empty($response)) {
        $data = array();
        foreach ($response as $size_row) {
            // $as=$size_row['addstudent']==1?'checked':'';
            // $us=$size_row['updatestudent']==1?'checked':'';
            // $ac=$size_row['addcourse']==1?'checked':'';
            // $uc=$size_row['updatecourse']==1?'checked':'';
            // $at=$size_row['addtimetable']==1?'checked':'';
            // $ut=$size_row['updatetimetable']==1?'checked':'';
            // $bi=$size_row['bulkattendance']==1?'checked':'';
            // $ar=$size_row['attendancereport']==1?'checked':'';
            // $pn=$size_row['permission']==1?'checked':'';
            // print_r($size_row);exit;
            // $data[] = "<tr class='col-md-4'>
            //                 <td>
            //                     <input type='hidden'  name='username[]'  value='{$size_row['username']}'>
            //                     <input type='hidden' class='p_size' name='id' value='{$size_row['id']}'>
            //                     {$size_row['username']}
            //                 </td>
            //                 <td>
            //                     <input type='hidden' class='addstudent' id='addstudent' name='addstudent' value='{$size_row['addstudent']}'>
            //                     <input type='checkbox' name='addstudent[]' id='chaddstudent' value='{$size_row['addstudent']}' $as>
            //                 </td>
            //                 <td>
            //                     <input type='hidden' class='updatestudent' id='updatestudent' name='updatestudent' value='{$size_row['updatestudent']}'>
            //                     <input type='checkbox' name='updatestudent[]' id='chupdatestudent' value='{$size_row['updatestudent']}' $us>
            //                 </td>
            //                 <td>
            //                     <input type='hidden' class='addcourse' id='addcourse' name='addcourse' value='{$size_row['addcourse']}'>
            //                     <input type='checkbox' name='addcourse[]' id='chaddcourse' value='{$size_row['addcourse']}' $ac>
            //                 </td>
            //                 <td>
            //                     <input type='hidden' class='updatecourse' id='updatecourse' name='updatecourse' value='{$size_row['updatecourse']}'>
            //                     <input type='checkbox' name='updatecourse[]' id='chupdatecourse' value='{$size_row['updatecourse']}' $uc>
            //                 </td>
            //                 <td>
            //                     <input type='hidden' class='addtimetable' id='addtimetable' name='addtimetable' value='{$size_row['addtimetable']}'>
            //                     <input type='checkbox' name='addtimetable[]' id='chaddtimetable' value='{$size_row['addtimetable']}' $at>
            //                 </td>
            //                 <td>
            //                     <input type='hidden' class='updatetimetable' id='updatetimetable' name='updatetimetable' value='{$size_row['updatetimetable']}'>
            //                     <input type='checkbox' name='updatetimetable[]' id='chupdatetimetable' value='{$size_row['updatetimetable']}' $ut>
            //                 </td>
            //                 <td>
            //                     <input type='hidden' class='bulkattendance' id='bulkattendance' name='bulkattendance' value='{$size_row['bulkattendance']}'>
            //                     <input type='checkbox' name='bulkattendance[]' id='chbulkattendance' value='{$size_row['bulkattendance']}' $bi>
            //                 </td>
            //                 <td>
            //                     <input type='hidden' class='attendancereport' id='attendancereport' name='attendancereport' value='{$size_row['attendancereport']}'>
            //                     <input type='checkbox' name='attendancereport[]' id='chattendancereport' value='{$size_row['attendancereport']}' $ar>
            //                 </td>
            //                 <td>
            //                     <input type='hidden' class='permission' id='permission' name='permission' value='{$size_row['permission']}'>
            //                     <input type='checkbox' name='permission[]' id='chpermission' value='{$size_row['permission']}' $pn>
            //                 </td>
            //                 <td>
            //                     <input type='submit' class='btn btn-secondary btn-sm' onclick='btnClick();' id='btnsubmit' value='add' />
            //                 </td>
            //             </tr>";
            $data[] = $size_row;
        }
        echo json_encode($data);
    } else {
        echo json_encode($data);
    }
?>
