using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Drawing;
using System.Drawing.Imaging;
using ZXing.Common;
using ZXing;
using System.IO;
using System.Web;

namespace QRCodeApplication.QRCodeWebAPI
{
    public class QRCodeController : ApiController
    {



        // GET api/<controller>/Welcome

        [HttpGet]
        public string GetQRCode(string id)
        {


            string QRCodeResult = CreateQRCode(id);

            return QRCodeResult;

        }

        [HttpGet]
        public string READQRCode(string id)
        {
            string QRReadResult = ReadQRCode(id);

            return QRReadResult;
        }


        public static string ReadQRCode(string URL)
        {
                string ReadQRCode = string.Empty;
                var QCreader = new BarcodeReader();
                string QCfilename = URL;
                var QCresult = QCreader.Decode(new Bitmap(QCfilename));
                if (QCresult != null)
                {
                    ReadQRCode= "QR Code is: " + QCresult.Text;
                }

            return ReadQRCode;    
        }
        


        public static string CreateQRCode(string QRText)
        {
            var QCwriter = new BarcodeWriter();
            QCwriter.Format = BarcodeFormat.QR_CODE;
            var result = QCwriter.Write(QRText);

            string Folderpath = System.Web.HttpContext.Current.Server.MapPath("~/images");

            int FileTotalCount = Directory.EnumerateFiles(Folderpath).Count();

            int FileCount = FileTotalCount + 1;
            string Fileimgname = "QRCode" + FileCount + ".jpg";
            string path = System.Web.HttpContext.Current.Server.MapPath("~/images/" + Fileimgname.Trim() + "");

            var barcodeBitmap = new Bitmap(result);

            using (MemoryStream memory = new MemoryStream())
            {
                using (FileStream fs = new FileStream(path, FileMode.Create, FileAccess.ReadWrite))
                {
                    barcodeBitmap.Save(memory, ImageFormat.Jpeg);
                    byte[] bytes = memory.ToArray();
                    fs.Write(bytes, 0, bytes.Length);
                    return Convert.ToBase64String(bytes, 0, bytes.Length);
                }
            }


        }


    }
}