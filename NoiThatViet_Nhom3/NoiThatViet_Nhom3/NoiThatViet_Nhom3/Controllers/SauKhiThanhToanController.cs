using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.Mvc;

namespace NoiThatViet_Nhom3.Controllers
{
    public class SauKhiThanhToanController : Controller
    {
        // GET: SauKhiThanhToan/ThanhToanThanhCong
        public ActionResult ThanhToanThanhCong()
        {
            return View();
        }

        // GET: SauKhiThanhToan/ThanhToanThatBai
        public ActionResult ThanhToanThatBai()
        {
            return View();
        }

    }
}