
<?php 
    ob_start();
    session_start();
    error_reporting(0); 
    include('../../connect.php');
    header('Content-Type: application/json');

    $at_dept =  trim($_POST['at_dept']);
    $at_semester =  trim($_POST['at_semester']);
    $at_year =  trim($_POST['at_year']);
    $SQL="SELECT id,regNo,firstName FROM tblstudent where deptid=".$at_dept." and
                semester='". $at_semester ."' and year='".$at_year ."' order by regno ASC; ";
    $result = mysqli_query($conn,$SQL);

    while ($row = mysqli_fetch_array($result))
    {
        $response[]=$row;
    }
    if (!empty($response)) {
        $data = array();
        foreach ($response as $size_row) {
            $data[] = "<tr class='col-md-4'>
                          <td><input type='text' class='regNo' name='regNo[]' value='{$size_row['regNo']}'><input type='hidden' class='p_size' name='id[]' value='{$size_row['id']}'>
                          </td>
                          <td><input type='text' class='firstName' name='firstName[]' value='{$size_row['firstName']}'>
                          </td>
                          <td><input type='checkbox' class='check_stu' name='chIspresent' value='1' checked>
                          </td>
                        </tr>";
        }
        echo json_encode($data);
    } else {
        echo json_encode($data);
    }
?>
