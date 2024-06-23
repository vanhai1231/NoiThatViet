using NoiThatViet_Nhom3.Resources;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Resources;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.Services.Description;

namespace NoiThatViet_Nhom3.Controllers
{

    public class LanguageController : Controller
    {
        //private static readonly Dictionary<string, ResourceManager> ResourceManagers = new Dictionary<string, ResourceManager>();
        ResourceManager resourceManager = new ResourceManager("NoiThatViet_Nhom3.Resources.Messages", typeof(Messages).Assembly);

        [HandleError]
        public ActionResult ChangeLanguage(string selectedLanguage)
        {
            if (selectedLanguage != null)
            {
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(selectedLanguage);
                Thread.CurrentThread.CurrentUICulture = new CultureInfo(selectedLanguage);
            }

            var cookie = new HttpCookie("Language");
            cookie.Value = selectedLanguage; Response.Cookies.Add(cookie);
            return RedirectToAction("Index", "SanPham");
        }



    }

}