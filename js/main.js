function deletemsg() {
    swal("Successfully deleted", {
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
function updatemsg() {
    swal("Successfully Updated", {
        icon: "success",
        buttons: {
            OK: {
            text: "OK",
            value: "OK",
        },
    },
    }).then((value) => {
        switch (value) {
            case "OK":window.location.reload();; break;
            default:window.location.reload();
        }
    });
}
function confirmbox()
{
    var result;
    swal({
        title: "Are you sure?",
        text: "Once deleted, you will not be able to recover this row!",
        icon: "warning",
        buttons: true,
        dangerMode: true,
    }).then((willDelete) =>
    {
        if (willDelete) {
            result=true;
        } else {
            result=false;
        }
    });
    return result;
}
function AttMsg() {
    swal("Attendance Saved Success", {
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

var inactivityTimer = setTimeout(function() {
    window.location.href = '../logout.php'; 
}, 300000); 

// Listen for any user activity
document.addEventListener('mousemove', resetTimer);
document.addEventListener('keydown', resetTimer);

// Reset the timer when user is active
function resetTimer() {
    clearTimeout(inactivityTimer);
    inactivityTimer = setTimeout(function() {
        window.location.href = '../logout.php'; 
    }, 300000);
}

