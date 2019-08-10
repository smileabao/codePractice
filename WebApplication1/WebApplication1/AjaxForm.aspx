<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AjaxForm.aspx.cs" Inherits="WebApplication1.AjaxForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <style>
        body {
            padding: 30px;
        }

        form {
            display: block;
            margin: 20px auto;
            background: #eee;
            border-radius: 10px;
            padding: 15px;
        }

        .progress {
            position: relative;
            width: 400px;
            border: 1px solid #ddd;
            padding: 1px;
            border-radius: 3px;
        }

        .bar {
            background-color: #B4F5B4;
            width: 0%;
            height: 20px;
            border-radius: 3px;
        }

        .percent {
            position: absolute;
            display: inline-block;
            top: 3px;
            left: 48%;
        }
    </style>

    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
    <script src="http://malsup.github.com/jquery.form.js"></script>
    <script>
        $(function () {

            var bar = $('.bar');
            var percent = $('.percent');
            var status = $('#status');

            $('#form1').ajaxForm({
                beforeSend: function () {
                    status.empty();
                    var percentVal = '0%';
                    bar.width(percentVal)
                    percent.html(percentVal);
                },
                uploadProgress: function (event, position, total, percentComplete) {
                    var percentVal = percentComplete + '%';
                    bar.width(percentVal)
                    percent.html(percentVal);
                    //console.log(percentVal, position, total);
                },
                success: function () {
                    var percentVal = '100%';
                    bar.width(percentVal)
                    percent.html(percentVal);
                },
                complete: function (xhr) {
                    status.html(xhr.responseText);
                }
            });

        });
    </script>
    <script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>
    <script type="text/javascript">
        _uacct = "UA-850242-2";
        urchinTracker();
    </script>

</head>
<body>
    <form id="form2" >

    </form>
    <form id="form1" runat="server" action="WebForm2.aspx" method="post" enctype="multipart/form-data">
        <h1>File Upload Progress Demo #3</h1>
        <input type="file" name="myfile[]" /><br />
        <input type="file" name="myfile[]" /><br />
        <input type="file" name="myfile[]" /><br />

        <input type="submit" value="Upload File to Server" />
        <div class="progress">
            <div class="bar"></div>
            <div class="percent">0%</div>
        </div>

        <div id="status"></div>
    </form>
</body>
</html>
