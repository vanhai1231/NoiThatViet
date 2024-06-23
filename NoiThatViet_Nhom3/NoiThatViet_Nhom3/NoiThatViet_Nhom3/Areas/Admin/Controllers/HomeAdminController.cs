﻿using Microsoft.Ajax.Utilities;
using NoiThatViet_Nhom3.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics.Tracing;
using System.Linq;
using System.Net.Mail;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
namespace NoiThatViet_Nhom3.Areas.Admin.Controllers
{
	public class HomeAdminController : Controller
	{
		MyDataDataContext data = new MyDataDataContext();
		// GET: Admin/HomeAdmin
		public ActionResult Index()
		{
			if (Session["User"] == null)
			{
				return RedirectToAction("DangNhap");
			}
			return View();
		}
		public ActionResult DangNhap()
		{
			
			return View();
		}

		[HttpPost]
        public ActionResult DangNhap(string taiKhoan, string matKhau)
        {
            matKhau = MaHoaPassword.GetMd5Hash(matKhau);
            var uservar = data.TaiKhoans.SingleOrDefault(s => s.TenDangNhap.ToLower() == taiKhoan.ToLower() && s.MatKhau == matKhau);

            var currentTime = DateTime.Now;
            var thongTinCaNhan = data.ThongTinCaNhans.FirstOrDefault(t => t.idTK == uservar.idTK);
            if (uservar != null)
            {
                if (uservar.LoaiTK.Trim().ToLower() == "user")
                {
                    TempData["error"] = "Người dùng không được phép đăng nhập.";
                    return View();
                }
                if (thongTinCaNhan != null && thongTinCaNhan.TrangThai != "Khóa")
                {
                    Session["User"] = uservar;

                    return RedirectToAction("Index");
                }


                // Đăng nhập thất bại vì tài khoản đang bị khóa
                @TempData["error"] = "Tài khoản đã bị khóa từ " + thongTinCaNhan.NgayBatDau?.ToString("dd/MM/yyyy") + " đến " + thongTinCaNhan.NgayKetThuc?.ToString("dd/MM/yyyy");
                return View("DangNhap");

            }
            else
            {
                @TempData["error"] = "Tài Khoản không đúng";
                return View();
            }
        }


        //Đăng xuất
        public ActionResult DangXuat()
		{
			Session["User"] = null;
			FormsAuthentication.SignOut();
			return RedirectToAction("DangNhap");

		}    
    }
}