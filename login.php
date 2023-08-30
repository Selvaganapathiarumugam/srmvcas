<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login</title>
  <link rel="stylesheet" type="text/css" href="./css/main.css">
  <link rel="stylesheet" type="text/css" href="./css/Bootstrap.css">
  <link rel="stylesheet" type="text/css" href="./css/fontawesome.css">
  <script src="./js/popper.js"></script>
  <script src="./js/Bootstrap.js"></script>
  <script src="./js/fontawesome.js"></script>
  <script src="./js/jquery.js"></script>
</head>
<body class="ovflow-y">
  <div class="row">
    <div class="col-md-4"></div>
    <div class="col-md-4">
      <div class="margin-top-base" style="color:#000099;">
        <center><strong><h3>Sri Ramakrishna Mission Vidyalaya</BR > College of Arts and Science</h3></strong></center>
      </div>
    </div>
    <div class="col-md-4"></div>
  </div>
  <div class="row">
    <div class="col-md-4"></div>
    <div class="col-md-4">
      <div class="margin-top-base" style="color:#000099;">
        <center><strong><u>INTERNAL ASSESSMENT SYSTEM</u></strong></center>
      </div>
    </div>
    <div class="col-md-4"></div>
  </div>
  <div class="row">
    <div class="col-md-4"></div>
    <div class="col-md-4">
      <div class="login" style="background-color:#fff">
        <form id="frmlogin">
          <div class="row">
            <div class="col-md-12">
              <div class="log-head">
                <center><h4>Web Control Panel</h3></center>
              </div>
            </div>
          </div>
          <hr>
          <div class="form-group" >
            <div class="row">
              <div class="col-md-4">
                <label class="margin-left-base">Username</label>
              </div>
              <div class="col-md-8">
                <div class="margin-right-base">
                  <input type="text" class="form-control" id="username" required placeholder="Enter username">
                </div>
              </div>
            </div>
          </div>
          <div class="margin-top-base ">
            <div class="form-group">
              <div class="row">
                <div class="col-md-4">
                  <label class="margin-left-base">Password</label>
                </div>
                <div class="col-md-8">
                  <div class="margin-right-base">
                    <input type="password" class="form-control" id="password" required placeholder="Enter password">
                  </div>
                </div>
              </div>
            </div>
          </div>
          <hr>
          <div class="margin-top-base">
            <div class="row">
              <div class="col-md-8">
                <div class="error">
                  <b id="error"></b>
                </div>        
              </div>
              <div class="col-md-4"> 
                <button type="submit" class="btn btn-primary btn-sm">Login</button>
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
    <div class="col-md-4"></div>
  </div>
  <script>
    $(document).ready(function() {
      $('#frmlogin').submit(function(e) {
      e.preventDefault(); 
      var username = $('#username').val();
      var password = $('#password').val();
      $.ajax({
        type: 'POST',
        url: 'login_data.php',
        data: {
          username: username,
          password: password
        },
        success: function(response) {
          if (response === 'success') {
            window.location.href = 'index.php';
          } else {
            $('#error').text('Invalid username or password.');
          }
        }
      });
      });
    });
  </script>
</body>
</html>