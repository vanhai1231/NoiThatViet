using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace NoiThatViet_Nhom3
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");
            //Đăng nhập
            routes.MapRoute(
                name: "CustomDangNhapRoute",
                url: "Đăng-nhập", // URL pattern
                defaults: new { controller = "Home", action = "DangNhap" }
            );
            // Đăng ký
            routes.MapRoute(
                name: "CustomDangKyRoute",
                url: "Đăng-ký", // URL pattern
                defaults: new { controller = "Home", action = "DangKy" }
            );
            routes.MapRoute(
                name: "CustomSanPhamTheoLoai",
                url: "Sản-phẩm-theo-loại", // URL pattern
                defaults: new { controller = "SanPham", action = "SanPhamTheoLoai" }
            );
            routes.MapRoute(
                name: "CustomSanPhamTheoPhong",
                url: "Sản-phẩm-theo-phòng", // URL pattern
                defaults: new { controller = "SanPham", action = "SanPhamTheoPhong" }
            );
            routes.MapRoute(
                name: "CustomTrangSanPham",
                url: "Trang-chi-tiết-sản-phẩm", // URL pattern
                defaults: new { controller = "SanPham", action = "Detail" }
            );
            routes.MapRoute(
                name: "CustomChiTietDichVu",
                url: "Trang-chi-tiết-dịch-vụ", // URL pattern
                defaults: new { controller = "DichVu", action = "ChiTiet" }
            );
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "SanPham", action = "Index", id = UrlParameter.Optional }
            );

            routes.MapRoute(
            name: "GoogleCallback",
            url: "Google/GoogleCallback",
            defaults: new { controller = "Google", action = "GoogleCallback" }
            );
            routes.MapRoute(
                name: "CustomTrangThongTinTK",
                url: "Thông-tin-tài-khoản", // URL pattern
                defaults: new { controller = "Home", action = "ThongTinTK" }
            );
            routes.MapRoute(
                name: "CustomDonMua",
                url: "Đơn-mua", // URL pattern
                defaults: new { controller = "DonHang", action = "DonMua" }
            );
            routes.MapRoute(
                name: "CustomDangXuat",
                url: "Đăng-xuất",
                defaults: new { controller = "Home", action = "DangXuat", id = UrlParameter.Optional }
            );
        }
    }
}