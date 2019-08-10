<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="Script/bootstrap.min.css" rel="stylesheet" />
    <script src="Script/jquery-1.9.1.min.js" type="text/javascript"></script>
    <style type="text/css">
        .upload-block {
            width: 300px;
            height: 200px;
            border-style: dotted;
            border-color: #999999;
            text-align: center;
            padding: 20px;
            margin: 20px;
        }

        .dragover {
            border-color: #FF9900;
        }

        .progress {
            text-align: center;
            width: 100%;
        }
    </style>

    <script>
        function drop_file(e) {
            e.preventDefault();
            var upload_image = document.getElementById('drop_block');
            var elProgress = document.getElementById('upload_progress');
            var images_container = document.getElementById('images_container');
            var objXhr = new XMLHttpRequest();
            var files = e.dataTransfer.files;
            var objForm = new FormData();
            var sucess_count = 0;

            objXhr.upload.onprogress = function (e) {
                if (e.lengthComputable) {
                    var intComplete = (e.loaded / e.total) * 100 | 0;

                    elProgress.innerHTML = intComplete + '%';
                    elProgress.style.width = intComplete + '%';

                    elProgress.setAttribute('aria-valuenow', intComplete);
                }
            }

            objXhr.onload = function (e) {
                upload_image.className = upload_image.className.replace(' dragover', '');
                elProgress.className = elProgress.className.replace(' active', '');

                alert(objXhr.responseText); //接收網頁回傳結果
            }

            objXhr.open('POST', 'WebForm2.aspx');
            for (var i = 0; i < files.length; i++) {
                if (!files[i].type.match('image')) {
                    var name = files[i].name;
                    alert(name + '格式不正確，須為圖檔！');
                    continue;
                }
                objForm.append('images[]', files[i]);
                objForm.append('save_file', "Y");
            }

            objXhr.send(objForm);
        }
</script>

    <script>
        function drag_handler(e) {
            var upload_image = document.getElementById('drop_block');
            var elProgress = document.getElementById('upload_progress');
            e.preventDefault();  //防止瀏覽器執行預設動作
            if (!upload_image.className.match('dragover')) {
                upload_image.className = upload_image.className + ' dragover';
            }

            if (upload_progress.style.width != '0%') {
                upload_progress.style.width = '0%';
            }
        }
</script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
            <asp:Label ID="Label1" runat="server" Text="Label" Font-Size="Large" ForeColor="ForestGreen"></asp:Label>
        </div>

        <div>
            <div id="drop_block" ondragover="javascript: drag_handler(event);" ondrop="javascript: drop_file(event);" class="upload-block">
                請將檔案拖曳到此...
            <div class="progress">
                <div id="upload_progress" class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="" aria-valuemin="0" aria-valuemax="100">
                </div>
            </div>
            </div>
        </div>
    </form>
</body>
</html>
