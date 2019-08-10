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
            //todo:上傳檔案的介面在這裡處理
            //todo:可以先搬到一個佔存的資料夾，之後真的儲存再放到指定的資料夾
            //if (Request["save_file"] != null)
            //{
            if (MyUpload())
                Response.Write("上傳完成");
            else
                Response.Write("檔案中有超過" + maxFile + "MB");
            Response.End();
            //}
        }
        private const int maxFile = 2;
        private const int MegaBytes = maxFile * 1024 * 1024;
        protected bool MyUpload()
        {
            for (int i = 0; i < Request.Files.Count; i++)
            {
                HttpPostedFile postedFile = Request.Files[i];
                if (postedFile.ContentLength > MegaBytes)
                {
                    return false;
                }
            }

            for (int i = 0; i < Request.Files.Count; i++)
            {
                HttpPostedFile postedFile = Request.Files[i];

                if (postedFile.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(postedFile.FileName);
                    postedFile.SaveAs(Server.MapPath("~/Uploads/") + fileName);
                }
            }
            return true;
        }
    }
}