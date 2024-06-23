using NoiThatViet_Nhom3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NoiThatViet_Nhom3.Controllers
{
    public class DonHangController : Controller
    {
        // GET: DonHang
        [HandleError]
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult DonMua()
        {
            MyDataDataContext Data = new MyDataDataContext();

            var currentAccount = (TaiKhoan)Session["TaiKhoan"];
            int accountId = currentAccount.id;

            // Truy vấn để lấy MaGioHang từ TaiKhoanId
            var maGioHang = Data.GioHangs
                                .Where(gh => gh.id == accountId)
                                .Select(gh => gh.MaGioHang)
                                .FirstOrDefault();

            if (maGioHang != null)
            {
                // Truy vấn để lấy MaDH từ MaGioHang
                var maDHs = Data.ChiTietDonHangs
                                .Where(ct => ct.MaGioHang == maGioHang)
                                .Select(ct => ct.MaDH)
                                .ToList();

                var donHangs = Data.DonHangs
                                .Where(dh => maDHs.Contains(dh.MaDH))
                                .Select(dh => new DonHangViewModel
                                {
                                    MaDH = dh.MaDH,
                                    NgayLap = dh.NgayLap,
                                    TongTien = dh.TongTien,
                                    TrangThaiDH = dh.TrangThaiDH,
                                    TenSanPham = string.Join(", ", Data.ChiTietDonHangs
                                                                .Where(ct => ct.MaDH == dh.MaDH)
                                                                .Join(Data.SanPhams, ct => ct.MaSanPham, sp => sp.MaSanPham, (ct, sp) => sp.TenSanPham)
                                                                .ToList()),
                                    ThongTinDH = dh.ThongTinDH
                                })
                                .ToList();


                return View(donHangs);
            }
            return View(new List<DonHangViewModel>());
        }
    }
}