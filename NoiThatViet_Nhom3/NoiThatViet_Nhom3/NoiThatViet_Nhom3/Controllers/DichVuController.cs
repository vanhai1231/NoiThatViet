using NoiThatViet_Nhom3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NoiThatViet_Nhom3.Controllers
{
    public class DichVuController : Controller
    {
        MyDataDataContext Data = new MyDataDataContext();
        // GET: DichVu
        [HandleError]
        public ActionResult ChiTiet(string id)
        {
            id = id.Trim();
            var dichVu = Data.DichVus.FirstOrDefault(d => d.id == id);
            if (dichVu == null)
            {
                return HttpNotFound();
            }
            return View(dichVu);
        }
    }
}