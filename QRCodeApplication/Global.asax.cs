using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using QRCodeApplication.App_Start;
using System.Web.Http;

namespace QRCodeApplication
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {

            WebApiConfig.Register(GlobalConfiguration.Configuration);

        }
    }
}