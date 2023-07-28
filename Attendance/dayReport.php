<?php
    ob_start();
    session_start();
    error_reporting(0); 
    include('../links.php');
    include('../connect.php'); 

    if(!isset($_SESSION['Username'])) {
        header("Location:../login.php");
    }
    // if(isset($_REQUEST["did"]))
    // {
    //     $id=$_REQUEST['did'];
    //     $SQL="delete from  tblattendance where Id='". $id."'";
    //     try {
    //         $result = mysqli_query($conn,$SQL);
    //         echo "<script> deletemsg(); </script>";
    //     } catch (\Throwable $th) {
    //         throw $th;
    //     }
    // }
?> 

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Day Report</title>
</head>
<body class="ovflow-y">
    <div class="border-1p" style="border:1px solid #ffb9b9;background-color: rgb(255, 193, 132);color:#3d0dfd">
        <div class="row">
            <div class="col-md-3">
                <h3 class=" padding-base">Absent List</h3>
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
    <div class="container">
        <div class="margin-top-base">
            <form id="frmAtt"  method="post">
                <div class="mb-4 bg-light rounded-3" style="margin-left:15px;padding-top:20px;height: 100% !important;">
                    <div class="row">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="input1" class="form-label">Start Date</label>
                                <input type='date' id='at_sdate' name='at_sdate' class="form-control" 
                                    tabindex="2"  autocomplete="off"
                                />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <label for="input1" class="form-label"> End Date</label>
                                <input type='date' id='at_ldate' name='at_ldate' class="form-control" 
                                    tabindex="2"  autocomplete="off"
                                />
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <input type='submit' id='btnsubmit' name='btnsubmit' class="btn btn-primary"
                                        tabindex="3"  autocomplete="off" value="Get Record"
                                    style="margin-top:30px;"
                                />    
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-group">
                                <input type='button' id='btnprint' name='btnsprint' class="btn btn-success"
                                    tabindex="4"  autocomplete="off" value="Print"  style="margin-top:30px;"
                                />
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <div class="margin-top-base">
            <div id="tableContainer" > <!-- style="display: none;" -->
                <table id="dynamicTable">
                </table>
            </div>
        </div>
    </div>
</body>
<script>
    $(document).ready(function() {
        $("#frmAtt").submit(function(event) {
            event.preventDefault();
            var formData = $(this).serialize();

            $.ajax({
                url: "./data/dayReport.php",
                datatype:'json',
                type: "GET",
                data: formData,
                success: function(response) {
                    var data = JSON.parse(response);
                    generateTable(data);
                    $("#tableContainer").show();
                },
                error: function(error) {
                    console.error(error);
                }
            });
        });

        function generateTable(data) {
            var table = $("#dynamicTable");
            table.empty();
            var headerRow = $("<tr>");
            headerRow.append("<th>Regno</th>");

            var at_sdate = new Date(data.startDate);
            var at_ldate = new Date(data.endDate);

            while (at_sdate <= at_ldate) {
                var dateString = formatDate(at_sdate);
                headerRow.append("<th>" + dateString + "</th>");
                at_sdate.setDate(at_sdate.getDate() + 1);
            }

            table.append(headerRow);
            data.forEach(function(row) {
                var dataRow = $("<tr>");
                dataRow.append("<td>" + row.Regno + "</td>");

                var currentDate = new Date(data.startDate);
                while (currentDate <= at_ldate) {
                    var dateString = formatDate(currentDate);
                    var status = row.Status[dateString] || "N/A";
                    dataRow.append("<td>" + dateString + " = " + status + "</td>");
                    currentDate.setDate(currentDate.getDate() + 1);
                }

                table.append(dataRow);
            });
        }

        function formatDate(date) {
            var year = date.getFullYear();
            var month = (date.getMonth() + 1).toString().padStart(2, "0");
            var day = date.getDate().toString().padStart(2, "0");
            return year + "-" + month + "-" + day;
        }
    });
</script>
</html>