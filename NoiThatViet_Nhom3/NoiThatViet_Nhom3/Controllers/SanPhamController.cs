using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NoiThatViet_Nhom3.Models;

namespace NoiThatViet.Controllers
{
    public class SanPhamController : Controller
    {
        MyDataDataContext Data = new MyDataDataContext();
        // GET: SanPham
        public ActionResult Index()
        {
            var all_SanPham = from tt in Data.SanPhams select tt;
            return View(all_SanPham);
        }
    }
}