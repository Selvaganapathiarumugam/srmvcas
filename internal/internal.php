<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../connect.php');
    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    }
    $lstYear = array(
        "I" => "I",
        "II" => "II",
        "III" => "III"
    );
   //--------------------------------Update-------------------------------
   if(isset($_REQUEST["id"]))
   {
       $id=$_REQUEST['id'];
       $SQL="SELECT Code,Name,Type,Maxmark,Year,Convertmark from tblinternalexam
               WHERE Code='".$_REQUEST["id"]."'";
       $result = mysqli_query($conn,$SQL);
       while($row = mysqli_fetch_array($result)) 
       {
           $ie_code = $row['Code'];
           $ie_name = $row['Name'];
           $Type = $row['Type'];
           //echo $Type;die();
           $typeug = $Type == "UG" ? 'checked' : " ";
           $typepg = $Type == "PG" ? 'checked' : " ";
           //echo $typepg;die();

           $ie_mmark = $row['Maxmark'];

           $opYear = $row['Year'];
           $ie_cmark = $row['Convertmark'];
        
           $id=$row['Code'];
       }
    }
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
                <p id="headerUser">Internal Exam</p>
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
                            <a href="./index.php" class="btn btn-primary btn-sm"><i class="fa-solid fa-backward" style="color: #fff;"></i> Back</a>
                        </div>
                    </div>
                </div>
            </div>
        </div> 
    </div>
    <div class="container" style="background-color:#EFEFEE">
        <div class="row " >
            <div class="col-md-12">
                <marquee>Internal Exam Master</marquee>
            </div>
        </div>
        <div class="row">
            <div class="col-md-2"></div>
            <div class="col-md-8">
                <form method="POST" class="form-horizontal" id="frmIE" >
                    <div class="p-5 mb-4 bg-white rounded-3" style="margin-left:15px;height: 100% !important;">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-6 col-lg-4">
                                    <label for="input1" class="form-label">Exam Code</label>
                                </div>
                                <div class=" col-md-6 col-lg-4">
                                    <input type='text' id='ie_code' name='ie_code' class="form-control" required 
                                        tabindex="1" value="<?php echo $ie_code; ?>" autocomplete="off"
                                    />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class="form-label">Exam Name</label>
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <input type='text' id='ie_name' name='ie_name' class="form-control" required 
                                            tabindex="2" value="<?php echo $ie_name; ?>" autocomplete="off"
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6 col-lg-4">
                                        <label for="input1" class="form-label">Type </label>
                                    </div>
                                    <div class=" col-md-6 col-lg-8">
                                        <div class="row">
                                            <div class="col-md-3">
                                                <input type="radio" name="ie_type" tabindex="3" value="UG" <?php echo $typeug; ?>  />
                                                <label>UG</label><br>
                                            </div>
                                            <div class="col-md-3">
                                                <input type="radio" name="ie_type" tabindex="3" value="PG" <?php echo $typepg; ?>  />
                                                <label>PG</label><br>
                                            </div>
                                            <div class="col-md-6"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>  
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-4 col-lg-4">
                                        <label for="input1" class=" form-label">Year</label>
                                    </div> 
                                    <div class="col-md-8 col-lg-8">
                                        <select class="form-select" tabindex="4" name="ie_year" id="ie_year"
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
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-4 col-lg-4">
                                        <label for="input1" class=" form-label"> Max Mark</label>
                                    </div> 
                                    <div class="col-md-8 col-lg-8">
                                        <input type="number" id="ie_mmark" name="ie_mmark" class="form-control" required
                                        tabindex="5" value="<?php echo $ie_mmark; ?>" autocomplete="off" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-4 col-lg-4">
                                        <label for="input1" class=" form-label"> Convert Mark</label>
                                    </div> 
                                    <div class="col-md-8 col-lg-8">
                                        <input type="number" id="ie_cmark" name="ie_cmark" class="form-control" required
                                        tabindex="6" value="<?php echo $ie_cmark; ?>" autocomplete="off" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="margin-top-base">
                                <div class="row">
                                    <div class="col-md-6"></div>
                                    <div class="col-md-6">
                                        <input type="hidden" name='la_Internal' id='la_Internal' value="<?php echo $id; ?>" />
                                        <?php 
                                            if(isset($_REQUEST["id"])){
                                                $btnName="Edit";
                                            }else{
                                                $btnName="Add";
                                            }
                                        ?>
                                        <input type="submit" class="btn btn-primary"  tabindex="9"  id="btnsave" value="<?php echo $btnName; ?>" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>   
            </div>
            <div class="col-md-2"></div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function() {
            $('#frmIE').submit(function(e) {
                e.preventDefault(); 
                var formData = $(this).serialize();
                var value = $("#la_Internal").val();
                //console.log(value);
                if(value != "")
                {
                    $.ajax({
                        url: './data/edit.php', 
                        method: 'POST',
                        data: formData,
                        success: function(response) 
                        {
                            if(response == "Data Updated successfully!")
                            {
                                swal(response, {
                                    buttons: {
                                        OK: {
                                        text: "OK",
                                        value: "OK",
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
                                swal("Error :-"+response);
                            }
                        },
                        error: function(xhr, status, error) {
                            swal(xhr.responseText); 
                        }
                    });
                }
                else
                {
                    $.ajax({
                        url: './data/insert.php', 
                        method: 'POST',
                        data:formData,
                        success: function(response) 
                        {
                            if(response =='Data inserted successfully!')
                            {
                                swal(response, {
                                    icon: "success",
                                    buttons: {
                                        OK: {
                                            text: "OK",
                                            value: "OK",
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
                        },
                        error: function(xhr, status, error) 
                        {
                            swal(xhr.responseText); 
                        }
                    });
                }
            });
        });
    </script>
</body>
</html>