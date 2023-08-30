<?php 
    session_start();
?>
<div class="row" style="border:1px solid #ffb9b9;">
    <div class="col-md-4 col-sm-1 ">
        <b class="padding-base margin-top-base">Welcome  <?php echo $_SESSION['Username']; ?> !!! </b>
    </div>
    <div class="col-md-6  col-sm-10">
        <center><h3 id="clgname">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
    </div>
    <div class="col-md-2 col-sm-1">
        <div class="row">
            <div class="col-md-6">  
            </div>
            <div class="col-md-6 col-sm-12">
                <div class="margin-top-base" id="btnlog">
                    <a href="./logout.php" style="text-decoration:none">
                        <i class="fa-solid fa-power-off fa-2xl" style="color: #4287ff;"></i><br />
                        <b>Logout</b>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>