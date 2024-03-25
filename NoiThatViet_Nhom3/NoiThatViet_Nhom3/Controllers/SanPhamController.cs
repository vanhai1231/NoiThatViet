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
        //Them vat pham vao danh sach yeu thich
        public ActionResult AddToWishlist(string id)
        {
            var product = Data.SanPhams.FirstOrDefault(p => p.MaSanPham == id);
            if (product != null)
            {   
                // Toggle wishlist status
               // product.IsInWishlist = true;
                Data.SubmitChanges(); // Luu thong tin vao database
            }
            return RedirectToAction("Index");
        }

        // 
        public ActionResult RemoveFromWishlist(string id)
        {
            // Retrieve the product
            var product = Data.SanPhams.FirstOrDefault(p => p.MaSanPham == id);
            if (product != null)
            {
                // Toggle wishlist status
                //product.IsInWishlist = false;
                Data.SubmitChanges(); // Luu thong tin vao database
            }
            return RedirectToAction("Index");
        }
    }
}