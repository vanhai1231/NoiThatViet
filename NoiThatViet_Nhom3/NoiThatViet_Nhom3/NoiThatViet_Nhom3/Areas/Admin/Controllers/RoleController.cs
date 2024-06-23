using Facebook;
using NoiThatViet_Nhom3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NoiThatViet_Nhom3.App_Start;
using System.Net.Mail;
using System.Net;
using System.Diagnostics.Tracing;

namespace NoiThatViet_Nhom3.Areas.Admin.Controllers
{

    public class RoleController : Controller
    {
        MyDataDataContext data = new MyDataDataContext();

        // GET: Admin/Role
        //id 1
        // san Pham ----------------------------------------------------------
        [AdminAuthorize(maChucNang = 1)]
        public ActionResult ThemMoi()
        {

            return View();
        }

        [HttpPost]
        [AdminAuthorize(maChucNang = 1)]
        public ActionResult ThemMoi(FormCollection collection, SanPham sp)
        {
            var ten = collection["TenSanPham"];
            var E_hinh = collection["HinhAnh"];
            if (string.IsNullOrEmpty(ten))
            {
                ViewData["Error"] = "Don't empty!";
            }
            else
            {

                sp.HinhAnh = E_hinh.ToString();
                data.SanPhams.InsertOnSubmit(sp);
                data.SubmitChanges();
                return RedirectToAction("DanhSach");
            }
            return this.ThemMoi();
        }
        //id 2
        [AdminAuthorize(maChucNang = 2)]
        public ActionResult DanhSach()
        {
            var danhsachsp = data.SanPhams.Where(sp => sp.AnHien == "Hiện").ToList();
            return View(danhsachsp);
        }
        [AdminAuthorize(maChucNang = 2)]
        public ActionResult DanhSachSanPhamAn()
        {
            var danhsachspan = data.SanPhams.Where(sp => sp.AnHien == "Ẩn").ToList();
            return View(danhsachspan);
        }

        [AdminAuthorize(maChucNang = 0)]
        public ActionResult Xoa(string id)
        {
            try
            {
                var sp = data.SanPhams.First(m => m.MaSanPham == id);
                return View(sp);
            }
            catch (Exception ex)
            {

                return RedirectToAction("LoiRangBuoc", "RoleError");
            }
        }

        [HttpPost]
        [AdminAuthorize(maChucNang = 0)]
        public ActionResult Xoa(string id, FormCollection collection)
        {
            try
            {
                var sp = data.SanPhams.Where(m => m.MaSanPham == id).First();
                data.SanPhams.DeleteOnSubmit(sp);
                data.SubmitChanges();
                return RedirectToAction("DanhSach");
            }
            catch (Exception ex)
            {

                return RedirectToAction("LoiRangBuoc", "RoleError");
            }
        }
        //id 4
        [AdminAuthorize(maChucNang = 3)]
        public ActionResult Sua(string id)
        {
            var sp = data.SanPhams.First(m => m.MaSanPham == id);

            return View(sp);
        }

        [HttpPost]
        [AdminAuthorize(maChucNang = 3)]
        public ActionResult Sua(string id, FormCollection collection)
        {
            var sp = data.SanPhams.First(m => m.MaSanPham == id);
            var tensp = collection["TenSanPham"];
            var E_hinh = collection["HinhAnh"];


            if (string.IsNullOrEmpty(tensp))
            {
                ViewData["Error"] = "Don't empty!";
            }
            else
            {
                sp.HinhAnh = E_hinh.ToString();
                UpdateModel(sp);
                data.SubmitChanges();
                return RedirectToAction("DanhSach");
            }
            return this.Sua(id);
        }
        public string ProcessUpload(HttpPostedFileBase file)
        {
            if (file == null)
            {
                return "";
            }
            file.SaveAs(Server.MapPath("~/Content/images/" + file.FileName));
            return "/Content/images/" + file.FileName;
        }

        //TAI KHOAN -----------------------------------------------------------------
        [AdminAuthorize(maChucNang = 4)]
        public ActionResult DanhSachTaiKhoan()
        {

            var dstaiKhoan = data.TaiKhoans.ToList();



            return View(dstaiKhoan);
        }
        [AdminAuthorize(maChucNang = 0)]
        public ActionResult ThemMoiUser()
        {

            return View();
        }

        [HttpPost]
        [AdminAuthorize(maChucNang = 0)]
        public ActionResult ThemMoiUser(User user)
        {
            if (ModelState.IsValid)
            {
                // Tạo một đối tượng ThongTinCaNhan mới và lưu thông tin cá nhân
                var newThongTinCaNhan = new ThongTinCaNhan
                {
                    HoTen = user.Name,
                    Email = user.Email,
                    Sdt = user.SDT,
                    DiaChi = user.Diachi,
                    IsEmailConfirmed = true
                };

                data.ThongTinCaNhans.InsertOnSubmit(newThongTinCaNhan);
                data.SubmitChanges();

                int newIdTK = newThongTinCaNhan.idTK;

                var newUser = new TaiKhoan
                {
                    TenDangNhap = user.TaiKhoan,
                    MatKhau = MaHoaPassword.GetMd5Hash(user.Password), // Mã hóa password và lưu vào cơ sở dữ liệu
                    LoaiTK = "User", 
                    idTK = newIdTK
                };

                data.TaiKhoans.InsertOnSubmit(newUser);
                data.SubmitChanges();

                return RedirectToAction("DanhSachTaiKhoan");
            }

            return View(user); 
        }
        [AdminAuthorize(maChucNang = 5)]
        public ActionResult SuaTaiKhoan(int id)
        {
            var taikhoan = data.TaiKhoans.First(m => m.id == id);
            return View(taikhoan);
        }

        [HttpPost]
        [AdminAuthorize(maChucNang = 5)]
        public ActionResult SuaTaiKhoan(int id, FormCollection collection)
        {
            var taikhoan = data.TaiKhoans.First(m => m.id == id);
            var DangNhap = collection["TenDangNhap"];
            var MatKhau = collection["MatKhau"];


            if (string.IsNullOrEmpty(DangNhap))
            {
                ViewData["Error"] = "Don't empty!";
            }
            else
            {
                taikhoan.MatKhau = MatKhau;
                UpdateModel(taikhoan);
                data.SubmitChanges();
                return RedirectToAction("DanhSachTaiKhoan");
            }
            return this.SuaTaiKhoan(id);
        }

        [AdminAuthorize(maChucNang = 0)]
        public ActionResult XoaTaiKhoan(int id)
        {

            var taikhoan = data.TaiKhoans.First(m => m.id == id);
            return View(taikhoan);

        }

        [HttpPost]
        [AdminAuthorize(maChucNang = 0)]
        public ActionResult XoaTaiKhoan(int id, FormCollection collection)
        {
            var tk = data.TaiKhoans.Where(m => m.id == id).First();
            data.TaiKhoans.DeleteOnSubmit(tk);
            data.SubmitChanges();
            return RedirectToAction("DanhSachTaiKhoan");
        }

        [AdminAuthorize(maChucNang = 0)]
        public ActionResult TuyChonTaiKhoan(int id)
        {
            var taikhoan = data.TaiKhoans.First(m => m.id == id);
            return View(taikhoan);
        }

        [HttpPost]
        [AdminAuthorize(maChucNang = 0)]
        public ActionResult TuyChonTaiKhoan(int id, FormCollection collection)
        {
            var taikhoan = data.TaiKhoans.First(m => m.id == id);
            var DangNhap = collection["TenDangNhap"];
            var MatKhau = collection["MatKhau"];


            if (string.IsNullOrEmpty(DangNhap))
            {
                ViewData["Error"] = "Don't empty!";
            }
            else
            {
                taikhoan.MatKhau = MatKhau;
                UpdateModel(taikhoan);
                data.SubmitChanges();
                return RedirectToAction("DanhSachTaiKhoan");
            }
            return this.TuyChonTaiKhoan(id);
        }

        // Hành động controller để hiển thị form nhập ID tài khoản
        [AdminAuthorize(maChucNang = 6)]
        public ActionResult ResetPassword(int id)
        {
            var taikhoan = data.TaiKhoans.First(m => m.id == id);
            return View(taikhoan);

        }
        [HttpPost]
        [AdminAuthorize(maChucNang = 6)]
        public ActionResult ResetPassword(int id, string email)
        {
            var user = data.TaiKhoans.FirstOrDefault(u => u.id == id);

            if (user != null)
            {
                string newPassword = GeneratePassword();

                user.MatKhau = MaHoaPassword.GetMd5Hash(newPassword);
                data.SubmitChanges();

                // Tạo URL chứa địa chỉ email dưới dạng tham số
                string resetLink = Url.Action("DoiMatKhau", "Role", new { email = user.ThongTinCaNhan.Email }, protocol: Request.Url.Scheme);
                var body = $"Vui lòng nhấp vào liên kết sau để đặt lại mật khẩu: {resetLink}";
                SendPasswordResetEmail(user.ThongTinCaNhan.Email, "Đặt lại mật khẩu", $"Mật khẩu mới của bạn là: {newPassword} {body}");
                return RedirectToAction("SuccessSendPassword", "RoleError");


            }
            return this.ResetPassword(id);

        }
        private string GeneratePassword()
        {

            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var random = new Random();
            var newPassword = new string(Enumerable.Repeat(chars, 8).Select(s => s[random.Next(s.Length)]).ToArray());
            return newPassword;
        }

        // Hàm để gửi email chứa mật khẩu mới
        private void SendPasswordResetEmail(string to, string subject, string body)
        {
            var fromAddress = new MailAddress("kikyoutnt33@gmail.com", "Shop Noi That");
            var toAddress = new MailAddress(to);
            const string fromPassword = "a m s j h a p u g c t b v s v a";

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com", // máy chủ gmail
                Port = 587, // cổng mặc định 
                EnableSsl = true, // kích hoạt giao thức mật mã hóa(SSL,TLS) gửi gmail
                DeliveryMethod = SmtpDeliveryMethod.Network, //gửi gmail qua mạng
                UseDefaultCredentials = false,//cho biết thông tin đăng nhập được sử dụng bởi Credentials
                Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
            };

            using (var message = new MailMessage(fromAddress, toAddress)
            {
                Subject = subject,
                Body = body
            })
            {
                smtp.Send(message);
            }
        }

        public ActionResult DoiMatKhau(string email)
        {
            ViewBag.Email = email;

            return View();

        }
        [HttpPost]
        public ActionResult DoiMatKhau(string email, string newPassword, string confirmNewPassword, string returnUrl)
        {
            if (newPassword != confirmNewPassword)
            {
                ViewBag.ChangePasswordSuccess = false;
                ViewBag.ErrorMessage = "Mật khẩu mới và mật khẩu xác nhận không khớp.";
                return View();
            }

            // Tìm tài khoản với địa chỉ email được cung cấp
            var user = data.TaiKhoans.FirstOrDefault(u => u.ThongTinCaNhan.Email == email);

            if (user != null)
            {
                string hashedPassword = MaHoaPassword.GetMd5Hash(newPassword);

                user.MatKhau = hashedPassword;
                data.SubmitChanges();

                ViewBag.ChangePasswordSuccess = true;

                if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
                {
                    return Redirect(returnUrl);
                }
                return View();
            }
            else
            {
                ViewBag.ChangePasswordSuccess = false;
                ViewBag.ErrorMessage = "Không tìm thấy tài khoản với địa chỉ email đã cung cấp.";
                return View();
            }
        }





        //DON HANG---------------------------------------------------------------

        [AdminAuthorize(maChucNang = 7)]
        public ActionResult DanhSachDonHang()
        {
            var dsdonhang = data.DonHangs.ToList();

            return View(dsdonhang);
        }
        [AdminAuthorize(maChucNang = 8)]
        public ActionResult ThemMoiDonHang()
        {

            return View();
        }

        [HttpPost]
        [AdminAuthorize(maChucNang = 8)]
        public ActionResult ThemMoiDonHang(FormCollection collection, DonHang dh)
        {
            var diaChi = collection["DiaChiGiaoHang"];

            if (string.IsNullOrEmpty(diaChi))
            {
                ViewData["Error"] = "Don't empty!";
            }
            else
            {

                dh.DiaChiGiaoHang = diaChi.ToString();
                data.DonHangs.InsertOnSubmit(dh);
                data.SubmitChanges();
                return RedirectToAction("DanhSachDonHang");
            }
            return this.ThemMoi();
        }
        [AdminAuthorize(maChucNang = 0)]
        public ActionResult XoaDonHang(string id)
        {

            var dh = data.DonHangs.First(m => m.MaDH == id);
            return View(dh);

        }
        [HttpPost]
        [AdminAuthorize(maChucNang = 0)]
        public ActionResult XoaDonhang(string id, FormCollection collection)
        {
            var dh = data.DonHangs.Where(m => m.MaDH == id).First();
            data.DonHangs.DeleteOnSubmit(dh);
            data.SubmitChanges();
            return RedirectToAction("DanhSachDonHang");
        }

        [AdminAuthorize(maChucNang = 0)]
        public ActionResult SuaDonHang(string id)
        {
            var dh = data.DonHangs.First(m => m.MaDH == id);
            return View(dh);
        }

        [HttpPost]
        [AdminAuthorize(maChucNang = 0)]
        public ActionResult SuaDonHang(string id, FormCollection collection)
        {
            var dh = data.DonHangs.First(m => m.MaDH == id);
            var maDH = collection["MaDH"];



            if (string.IsNullOrEmpty(maDH))
            {
                ViewData["Error"] = "Don't empty!";
            }
            else
            {
                dh.MaDH = maDH.ToString();
                UpdateModel(dh);
                data.SubmitChanges();
                var chiTietDonHang = data.ChiTietDonHangs.FirstOrDefault(g => g.MaDH == dh.MaDH);
                if (chiTietDonHang != null)
                {
                    var userId = chiTietDonHang.GioHang.id;

                    var user = data.TaiKhoans.FirstOrDefault(u => u.id == userId);
                    if (user != null)
                    {
                        var userEmail = user.ThongTinCaNhan.Email;
                        string subject = "Thông báo: Đơn hàng đã được cập nhật";
                        string body = $"Đơn hàng của bạn (Mã đơn hàng: {dh.MaDH}) đã được cập nhật thành công. Thông Tin Đơn Hàng Hiện Tại Của Bạn Là: {dh.ThongTinDH}";

                        SendPasswordResetEmail(userEmail, subject, body); // Call the method to send email
                    }
                }

                return RedirectToAction("DanhSachDonHang");

            }
            return this.Sua(id);
        }



        [AdminAuthorize(maChucNang = 9)] // Đặt mã chức năng cho khuyến mãi, ví dụ là 9
        public ActionResult KhuyenMai()
        {
            var model = new KhuyenMaiViewModel();

            // Lấy danh sách sản phẩm từ database và đưa vào model
            model.DanhSachSanPham = data.SanPhams.Select(s => new SanPhamViewModel { MaSanPham = s.MaSanPham, TenSanPham = s.TenSanPham }).ToList();

            return View(model);
        }

        [HttpPost]
        [AdminAuthorize(maChucNang = 9)]
        public ActionResult KhuyenMai(KhuyenMaiViewModel model)
        {
            if (ModelState.IsValid)
            {
                // Xử lý lưu thông tin khuyến mãi vào database
                var khuyenMai = new KhuyenMai
                {
                    MaVoucher = GenerateRandomVoucherCode(),
                    TenChuongTrinh = model.TenChuongTrinh,
                    ThoiGianBatDau = model.ThoiGianBatDau,
                    ThoiGianKetThuc = model.ThoiGianKetThuc,
                    GhiChu = model.GhiChu,
                    PhanTramGiam = model.PhanTramGiam
                };

                data.KhuyenMais.InsertOnSubmit(khuyenMai);
                data.SubmitChanges();

                string maKhuyenMai = khuyenMai.MaVoucher;

                if (model.ChonTatCaSanPham)
                {
                    foreach (var sanpham in model.DanhSachSanPham)
                    {
                        data.ChiTietKhuyenMais.InsertOnSubmit(new ChiTietKhuyenMai
                        {
                            MaSanPham = sanpham.MaSanPham,
                            MaVoucher = maKhuyenMai
                        });
                    }
                }
                else
                {
                    foreach (var sanpham in model.DanhSachSanPham)
                    {
                        if (sanpham.Selected)
                        {
                            data.ChiTietKhuyenMais.InsertOnSubmit(new ChiTietKhuyenMai
                            {
                                MaSanPham = sanpham.MaSanPham,
                                MaVoucher = maKhuyenMai
                            });
                        }
                    }
                }

                data.SubmitChanges();
                // Lấy danh sách tài khoản có LoaiTK = "User"
                var users = data.TaiKhoans.Where(tk => tk.LoaiTK == "User").ToList();
                foreach (var user in users)
                {
                    // Tạo nội dung email
                    string mailSubject = "Thông báo khuyến mãi mới";
                    string mailBody = $"Chương trình khuyến mãi: {model.TenChuongTrinh}\n" +
                                      $"Thời gian bắt đầu: {model.ThoiGianBatDau}\n" +
                                      $"Thời gian kết thúc: {model.ThoiGianKetThuc}\n" +
                                      $"Phần trăm giảm giá: {model.PhanTramGiam}%";

                    SendConfirmationEmail(user.ThongTinCaNhan.Email, mailSubject, mailBody);
                }
                return RedirectToAction("Index", "HomeAdmin");
            }
            return View(model);
        }
        private string GenerateRandomVoucherCode()
        {
            var random = new Random();
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, 10)
              .Select(s => s[random.Next(s.Length)]).ToArray());
        }
        private void SendConfirmationEmail(string to, string subject, string body)
        {
            var fromAddress = new MailAddress("kikyoutnt33@gmail.com", "Shop Noi That");
            var toAddress = new MailAddress(to);
            const string fromPassword = "a m s j h a p u g c t b v s v a";

            var smtp = new SmtpClient
            {
                Host = "smtp.gmail.com",
                Port = 587,
                EnableSsl = true,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(fromAddress.Address, fromPassword)
            };

            using (var message = new MailMessage(fromAddress, toAddress)
            {
                Subject = subject,
                Body = body,
                IsBodyHtml = true // Đảm bảo hiển thị nội dung dưới dạng HTML
            })
            {
                smtp.Send(message);
            }
        }
    }
}