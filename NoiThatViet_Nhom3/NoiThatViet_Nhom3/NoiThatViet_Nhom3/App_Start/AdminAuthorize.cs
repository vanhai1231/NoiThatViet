using NoiThatViet_Nhom3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace NoiThatViet_Nhom3.App_Start
{
    //AuthorizeAttribute thuộc tính được sử dụng để kiểm tra quyền truy cập của người dùng
    public class AdminAuthorize : AuthorizeAttribute
	{
        //được sử dụng để chỉ định mã chức năng mà người dùng cần phải có quyền truy cập.
        public int maChucNang {  get; set; }	
		//kiểm tra quyền truy cập
		public override void OnAuthorization(AuthorizationContext filterContext)
		{
			//kiểm tra session xem đăng nhập hay chưa
			TaiKhoan taikhoan = (TaiKhoan)HttpContext.Current.Session["User"];
			if(taikhoan != null)
			{
				// check admin 
				if (taikhoan.LoaiTK.Trim().ToLower() == "admin")
				{
					return; // admin được quyền truy cập hết
				}
				MyDataDataContext data = new MyDataDataContext();
				var count = data.PhanQuyenNhanViens.Count(m => m.idNhanVien == taikhoan.id.ToString() && m.MaChucNang == maChucNang);
				if (count != 0)
				{
					return;
				}
				else
				{
					var returnurl = filterContext.RequestContext.HttpContext.Request.RawUrl;
					filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new
					{
						controller = "RoleError",
						action = "KhongCoQuyen",
						area = "Admin",
						returnUrl = returnurl.ToString()
					}));
				}
				return;
			}
			else
			{
				var returnurl = filterContext.RequestContext.HttpContext.Request.RawUrl;
				filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new { controller = "AdminHome", 
					action = "DangNhap", 
					area = "Admin",
					returnUrl = returnurl.ToString()
				}));
			}
			
			

		}
	}
}