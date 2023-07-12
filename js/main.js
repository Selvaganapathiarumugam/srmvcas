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