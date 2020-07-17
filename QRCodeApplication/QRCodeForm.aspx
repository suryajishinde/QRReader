<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QRCodeForm.aspx.cs" Inherits="QRCodeApplication.QRCodeForm" %>

<!DOCTYPE html>

<%--<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>--%>

<%--<html>
<form enctype="multipart/form-data" action="http://api.qrserver.com/v1/read-qr-code/" method="POST">
<!-- MAX_FILE_SIZE (maximum file size in bytes) must precede the file input field used to upload the QR code image -->
<input type="hidden" name="MAX_FILE_SIZE" value="1048576" />
<!-- The "name" of the input field has to be "file" as it is the name of the POST parameter -->
Choose QR code image to read/scan: <input name="file" type="file" />
<input type="submit" value="Read QR code" />
</form>
</html>--%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>QR code reader application</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {


            $("#btnQRCodeGenerate").on("click", function () {

                var txtQRCodeTextval = jQuery.trim($("#txtQRCodeText").val());
                if ((txtQRCodeTextval.length == 0)) {
                    alert("Enter value for QR Code");
                }
                else {
                    $.ajax({
                        type: "GET",
                        url: "http://localhost:50141/QRCodeWebAPI/QRCode/GetQRCode", //It calls our web API  
                        data: {
                            id: txtQRCodeTextval
                        },
                        ContentType: "json",
                        dataType: "json",
                        success: function (data) {

                            $("#divimg").empty();
                            var image = new Image();
                            image.src = 'data:image/jpg;base64,' + data;
                            image.width = 200;
                            image.height = 200;
                            $("#divimg").append(image);
                        },
                        error: function (d) {
                        }
                    });


                }
            });


            $("#btnQCRead").on("click", function (evt) {

                var txtQRFileval = jQuery.trim($("#QRFile").val());
                if ((txtQRFileval.length == 0)) {
                    alert("Please Upload file");
                }
                else {
                    var fileUpload = $("#QRFile").get(0);
                    var files = fileUpload.files;

                    var data = new FormData();

                    for (var i = 0; i < files.length; i++) {
                        data.append(files[i].name, files[i]);
                    }

                    var options = {};
                    options.url = "Handler1.ashx";
                    options.type = "POST";
                    options.data = data;
                    options.contentType = false;
                    options.processData = false;
                    options.success = function (result) {
                        ReadQCCode(result);

                    };
                    options.error = function (err) { alert(err.statusText); };

                    $.ajax(options);

                    evt.preventDefault();
                }

            });


            function ReadQCCode(result)
            {
                
                $.ajax({
                    type: "GET",
                    url: "http://localhost:50141/QRCodeWebAPI/QRCode/READQRCode", //It calls our web API  
                    data: {
                        id: result
                    },
                    ContentType: "json",
                    dataType: "json",
                    success: function (data) {

                        $("#lblQRCodetxt").empty();
                        $("#lblQRCodetxt").text(data);
                        $("#QRFile").val(null);

                    },
                    error: function (d) {
                    }
                });

            }
           

           
        });
    </script>


</head>
<body>
    <form id="QRCodeFrom" runat="server">
        <div>
            <br />
            <br />
            <br />

            <asp:TextBox ID="txtQRCodeText" runat="server">
            </asp:TextBox>
            <input type="button" id='btnQRCodeGenerate' value="Click Me to Create QR Code" />

            <hr />
            <div id="divimg">
            </div>

            
            <br />
            <hr />

            <br />
            <asp:Label ID="Label1" runat="server" Font-Bold="true" Font-Size="Large" Text="First create QR code image and right click save as .JPG,, then Upload QR Code image and decode QRCode ">
            </asp:Label>
            <br />
            <br />

            <br />
            Choose QR code image to read/scan:
            <asp:FileUpload ID="QRFile" runat="server" />

            <asp:Button ID="btnQCRead" runat="server" Text="Read QR Code" />

            <br />
            <br />
            <br />
            <hr />

            <asp:Label ID="lblQRCodetxt" runat="server" Font-Bold="true" Font-Underline="true" ForeColor="#ff3300">
            </asp:Label>
        </div>
    </form>
</body>


</html>
