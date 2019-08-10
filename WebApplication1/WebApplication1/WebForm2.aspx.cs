using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace WebApplication1
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Request["save_file"] != null)
            //{
            MyUpload();
            Response.Write("上傳完成");
            Response.End();
            //}
        }

        protected void MyUpload()
        {
            for (int i = 0; i < Request.Files.Count; i++)
            {
                HttpPostedFile postedFile = Request.Files[i];

                if (postedFile.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(postedFile.FileName);
                    postedFile.SaveAs(Server.MapPath("~/Uploads/") + fileName);
                }
            }
        }
    }
}