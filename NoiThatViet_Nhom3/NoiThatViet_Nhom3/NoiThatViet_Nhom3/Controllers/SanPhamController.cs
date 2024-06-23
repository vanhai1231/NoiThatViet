using System;
using System.Collections.Generic;
using System.Data.SqlClient;
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
        [HandleError]
        public ActionResult Index()
        {
            var all_SanPham = from tt in Data.SanPhams where tt.AnHien == "Hiện" select tt;

            foreach (var sanPham in all_SanPham)
            {
                var khuyenMai = Data.ChiTietKhuyenMais
                                    .Where(ct => ct.MaSanPham == sanPham.MaSanPham)
                                    .Join(Data.KhuyenMais,
                                        ct => ct.MaVoucher,
                                        km => km.MaVoucher,
                                        (ct, km) => new
                                        {
                                            KhuyenMai = km,
                                            ChiTietKhuyenMai = ct
                                        })
                                    .FirstOrDefault();

                if (khuyenMai != null && KiemTraKhuyenMai(khuyenMai.KhuyenMai))
                {
                    sanPham.GiamGia = sanPham.Gia - (sanPham.Gia * khuyenMai.KhuyenMai.PhanTramGiam) / 100;
                    sanPham.PhanTramGiam = khuyenMai.KhuyenMai.PhanTramGiam;
                }
            }

            return View(all_SanPham);
        }

        private bool KiemTraKhuyenMai(KhuyenMai khuyenMai)
        {
            DateTime now = DateTime.Now;
            return now >= khuyenMai.ThoiGianBatDau && now <= khuyenMai.ThoiGianKetThuc;
        }

        public ActionResult Detail(string id)
        {
            var product = Data.SanPhams.FirstOrDefault(p => p.MaSanPham == id);
            if (product == null)
            {
                return HttpNotFound();
            }

            var images = Data.HinhAnhSanPhams.Where(h => h.MaSanPham == id).ToList();

            var maxQuantity = Data.SanPhams.Where(p => p.MaSanPham == id).Select(p => p.SoLuongTon).FirstOrDefault();

            var discount = GetProductDiscount(id);
            if (discount != null)
            {
                ViewBag.Discount = discount;
            }
            ViewBag.Product = product;
            ViewBag.Images = images;
            ViewBag.MaxQuantity = maxQuantity;

            return View();
        }

        // GET: Home/Wishlist
        public ActionResult Wishlist(string userId)
        {
            var currentAccount = (TaiKhoan)Session["TaiKhoan"];
            if (currentAccount == null)
            {
                return RedirectToAction("DangNhap", "Home");
            }
            if (userId != null)
            {
                // Truy vấn mã WishListID tương ứng với id của tài khoản
                var wishlistId = Data.WishLists.FirstOrDefault(w => w.id == int.Parse(userId))?.WishlistID;

                if (!string.IsNullOrEmpty(wishlistId))
                {
                    // Truy vấn danh sách sản phẩm từ ChiTietDanhMucYeuThich dựa trên WishListID
                    var wishlistProducts = Data.ChiTietDanhMucYeuThiches
                                             .Where(ct => ct.WishlistID == wishlistId && ct.SanPham.AnHien == "Hiện")
                                             .Select(ct => ct.SanPham);

                    return View(wishlistProducts);
                }
            }

            // Nếu không có userId hoặc không tìm thấy Wishlist, trả về danh sách rỗng
            return View(Enumerable.Empty<SanPham>());
        }


        public ActionResult AddToWishList(string id)
        {
            var currentAccount = (TaiKhoan)Session["TaiKhoan"];

            if (currentAccount == null)
            {
                return Json(new { success = false, message = "Bạn cần đăng nhập để thêm sản phẩm vào danh sách yêu thích. Vui lòng đăng nhập và thử lại." });
            }

            int userId = currentAccount.id;

            id = id.Trim().Replace("%20", "");

            // Truy vấn mã WishListID tương ứng với id của tài khoản
            var wishlistId = Data.WishLists.FirstOrDefault(w => w.id == userId)?.WishlistID;

            if (string.IsNullOrEmpty(wishlistId))
            {
                DateTime now = DateTime.Now;
                // Nếu không có WishListID tương ứng, tạo mới
                string newWishlistID = DateTime.Now.ToString("yyyyMMddHHmmss").Substring(0, 10);
                var newWishList = new WishList
                {
                    WishlistID = newWishlistID,
                    id = userId
                };

                Data.WishLists.InsertOnSubmit(newWishList);
                Data.SubmitChanges();

                wishlistId = newWishlistID;
            }

            var existingChiTiet = Data.ChiTietDanhMucYeuThiches.FirstOrDefault(c => c.WishlistID == wishlistId && c.MaSanPham == id);

            if (existingChiTiet == null)
            {
                var chiTiet = new ChiTietDanhMucYeuThich
                {
                    WishlistID = wishlistId,
                    MaSanPham = id
                };

                Data.ChiTietDanhMucYeuThiches.InsertOnSubmit(chiTiet);
                Data.SubmitChanges();

                var updatedCount = Data.ChiTietDanhMucYeuThiches.Where(ct => ct.WishlistID == wishlistId).Count();

                return Json(new { success = true, message = "Thêm sản phẩm vào danh sách yêu thích thành công.", wishlistCount = updatedCount });
            }

            return Json(new { success = false, message = "Sản phẩm đã có trong danh sách yêu thích." });
        }


        [HttpPost]
        public ActionResult DeleteFromWishlist(string id)
        {
            try
            {
                var currentAccount = (TaiKhoan)Session["TaiKhoan"];

                var userId = currentAccount.id;

                // Truy vấn mã WishListID tương ứng với id của tài khoản
                string wishlistId = Data.WishLists.FirstOrDefault(w => w.id == userId)?.WishlistID;

                // Tìm sản phẩm trong danh sách yêu thích để xóa
                var chiTiet = Data.ChiTietDanhMucYeuThiches.FirstOrDefault(c => c.WishlistID == wishlistId && c.MaSanPham == id);

                if (chiTiet != null)
                {
                    Data.ChiTietDanhMucYeuThiches.DeleteOnSubmit(chiTiet);
                    Data.SubmitChanges();

                    return Json(new { success = true, message = "Xóa sản phẩm khỏi Wishlist thành công." });
                }
                else
                {
                    return Json(new { success = false, message = "Không tìm thấy sản phẩm trong danh sách yêu thích." });
                }
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Đã có lỗi khi xóa sản phẩm. "});
            }
        }

        // GET: SanPham/Menu
        public ActionResult Menu()
        {
            var sanPhams = Data.LoaiSPs.ToList();
            return PartialView("_ProductMenu", sanPhams);
        }
        public ActionResult Phong()
        {
            var phongs = Data.Phongs.ToList();
            return PartialView("Phong", phongs);
        }
        public ActionResult DichVu()
        {
            var Dichvus = Data.DichVus.ToList();
            return PartialView("DichVu", Dichvus);
        }
        public ActionResult TimKiemSanPham(string q)
        {
            var Data = new MyDataDataContext();
            var danhSachSanPham = Data.SanPhams
                             .Where(sp => sp.TenSanPham.StartsWith(q) || sp.TenSanPham.Contains(q))
                             .Select(sp => sp.TenSanPham)
                             .Distinct()
                             .Take(6) 
                             .ToList();


            return Json(danhSachSanPham, JsonRequestBehavior.AllowGet);
        }
        public ActionResult Cart()
        {
            var gioHangItems = Data.GioHangs.ToList();
            return View(gioHangItems);
        }
        public ActionResult SanPhamTheoLoai(string id)
        {
            id = id.Trim();

            var products = Data.SanPhams.Where(p => p.MaLoaiSP == id && p.AnHien == "Hiện").ToList();
            foreach (var product in products)
            {
                var discount = GetProductDiscount(product.MaSanPham);
                if (discount != null)
                {
                    // Có giảm giá, cập nhật giá mới
                    product.Gia -= (product.Gia * discount.PhanTramGiam) / 100;
                }
            }

            return View(products);
        }

      public ActionResult SanPhamTheoPhong(string id)
       {
            id = id.Trim();

            var products = Data.SanPhams.Where(p => p.MaPhong == id && p.AnHien == "Hiện").ToList();

            foreach (var product in products)
            {
                var discount = GetProductDiscount(product.MaSanPham);
                if (discount != null)
                {
                    // Có giảm giá, cập nhật giá mới
                    product.Gia -= (product.Gia * discount.PhanTramGiam) / 100;
                }
            }

            return View(products);
       }

        public ActionResult Search(string searchString)
        {
            if (string.IsNullOrWhiteSpace(searchString))
            {
                searchString = "";
            }
            else
            {
                searchString = searchString.Trim();
            }


            var products = Data.SanPhams
                            .Where(p => p.TenSanPham.Contains(searchString) && p.AnHien == "Hiện")
                            .ToList();

            return View(products);
        }
        public ActionResult LoadMoreProducts(int skip)
        {
            var moreProducts = Data.SanPhams
                                 .Skip(skip)
                                 .Take(12)
                                 .ToList();

            foreach (var product in moreProducts)
            {
                var discount = GetProductDiscount(product.MaSanPham);
                if (discount != null)
                {
                    // Có giảm giá, cập nhật giá mới
                    product.Gia = product.Gia - (product.Gia * discount.PhanTramGiam / 100);
                }
            }

            return PartialView("_ProductPartial", moreProducts);
        }

        private KhuyenMai GetProductDiscount(string maSanPham)
        {
            // Kiểm tra trong bảng ChiTietKhuyenMai xem sản phẩm có giảm giá không
            var discount = Data.ChiTietKhuyenMais
                              .Where(ct => ct.MaSanPham == maSanPham && ct.SanPham.AnHien == "Hiện")
                              .Join(Data.KhuyenMais,
                                    ct => ct.MaVoucher,
                                    km => km.MaVoucher,
                                    (ct, km) => km)
                              .Where(km => DateTime.Now >= km.ThoiGianBatDau && DateTime.Now <= km.ThoiGianKetThuc)
                              .FirstOrDefault();

            return discount;
        }

        public ActionResult Links()
        {
            var Links = Data.DichVus.ToList();
            return PartialView("Links", Links);
        }
    }
}
