<?php 
    session_start();
?>
<div class="row" id="header">
    <div id="headerUser" class="col-md-2 col-sm-1 ">
        <span class="">Welcome  <?php echo $_SESSION['Username']; ?></span>
    </div>
    <div class="col-md-8  col-sm-10">
        <center><h3 id="clgname">Sri Ramakirshna Mission Vidyalaya College Of Arts And Science - Coimbatore 641020</h3></center>
    </div>
    <div class="col-md-2 col-sm-1">
        <div class="row">
            <div class="col-md-6">  
            </div>
            <div class="col-md-6 col-sm-12">
                <div class="margin-top-base" id="btnlog">
                    <a href="./logout.php" style="text-decoration:none">
                        <i class="fa-solid fa-power-off" style="color: #fff;"></i><br />
                        <p style=" color:#fff;font-size: 11px;font-weight: 700;">Logout</p>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>