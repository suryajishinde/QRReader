using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;

namespace QRCodeApplication
{
    /// <summary>
    /// Summary description for Handler1
    /// </summary>
    public class Handler1 : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string fname = string.Empty;
            if (context.Request.Files.Count > 0)
            {
                HttpFileCollection files = context.Request.Files;
                for (int i = 0; i < files.Count; i++)
                {
                    HttpPostedFile file = files[i];
                    fname = context.Server.MapPath("~/UploadFiles/" + file.FileName);
                    FileInfo filedelete = new FileInfo(fname);
                    if (filedelete.Exists)
                    {
                        var image = Image.FromFile(fname);

                        image.Dispose(); 
                       
                        File.Delete(fname);
                    }
                    file.SaveAs(fname);
                }
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write(fname);
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}