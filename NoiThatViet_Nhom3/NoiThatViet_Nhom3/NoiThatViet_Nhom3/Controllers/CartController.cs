using Newtonsoft.Json.Linq;
using System;
using MoMo;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using NoiThatViet_Nhom3.Others;
using NoiThatViet_Nhom3.Models;
using System.IO;
using System.Net.Mail;
using System.Net;
using System.Threading.Tasks;
using MailKit.Search;

namespace NoiThatViet_Nhom3.Controllers
{
    public class CartController : Controller
    {
        // GET: Cart
        [HandleError]
        public ActionResult Index()
        {
            MyDataDataContext Data = new MyDataDataContext();

            var currentAccount = (TaiKhoan)Session["TaiKhoan"];
            if (currentAccount == null)
            {
                return RedirectToAction("DangNhap", "Home");
            }

            int userId = currentAccount.id;

            var gioHang = Data.GioHangs.FirstOrDefault(g => g.id == userId);
            if (gioHang == null)
            {
                ViewBag.Message = "Giỏ hàng của bạn hiện đang trống.";
                return View();
            }

            string cartId = gioHang.MaGioHang;
            var cartItems = Data.ChiTietGioHangs.Where(c => c.MaGioHang == cartId).ToList();
            var cartDetails = new List<CartItemDetail>();

            int tongTien = 0; 

            foreach (var item in cartItems)
            {
                // Lấy thông tin sản phẩm từ bảng SanPham
                var product = Data.SanPhams.FirstOrDefault(p => p.MaSanPham == item.MaSanPham && p.AnHien == "Hiện");

                if (item != null && product != null)
                {
                    // Thêm thông tin chi tiết vào danh sách
                    cartDetails.Add(new CartItemDetail
                    {
                        id = item.MaSanPham,
                        MaGioHang = item.MaGioHang,
                        TenSanPham = product.TenSanPham,
                        Gia = product.Gia,
                        HinhAnh = product.HinhAnh,
                        SoLuong = (int)item.SoLuong,
                        ThanhTien = (decimal)item.ThanhTien
                    });

                    tongTien += (int)item.ThanhTien;
                }
                else
                {
                    continue;
                }
            }


            ViewBag.ChiTietDonHang = cartDetails;
            ViewBag.TongTien = tongTien;

            return View();
        }
        private bool KiemTraKhuyenMai(KhuyenMai khuyenMai)
        {
            DateTime now = DateTime.Now;
            return now >= khuyenMai.ThoiGianBatDau && now <= khuyenMai.ThoiGianKetThuc;
        }
        public ActionResult AddToCart(string id)
        {
            var currentAccount = (TaiKhoan)Session["TaiKhoan"];
            id = id.Trim().Replace("%20", "");
            if (currentAccount == null)
            {
                return Json(new { success = false, message = "Bạn cần đăng nhập để thêm sản phẩm vào giỏ hàng. Vui lòng đăng nhập và thử lại." });
            }

            int accountId = currentAccount.id;
            MyDataDataContext Data = new MyDataDataContext();

            // Xử lý thêm sản phẩm vào giỏ hàng
            var existingCart = Data.GioHangs.FirstOrDefault(g => g.id == accountId);

            string cartId = "";

            if (existingCart == null)
            {
                cartId = GenerateRandomCartId();
                var newCart = new GioHang
                {
                    MaGioHang = cartId,
                    id = accountId

                };
                Data.GioHangs.InsertOnSubmit(newCart);
                Data.SubmitChanges();
            }
            else
            {
                cartId = existingCart.MaGioHang;
            }

            string strId = id.ToString();
            var existingCartItem = Data.ChiTietGioHangs.FirstOrDefault(c => c.MaGioHang == cartId && c.MaSanPham == strId);

            if (existingCartItem == null)
            {
                var product = Data.SanPhams.FirstOrDefault(p => p.MaSanPham == id);

                if (product != null)
                {
                    var khuyenMai = Data.ChiTietKhuyenMais
                                 .Where(ct => ct.MaSanPham == product.MaSanPham)
                                 .Join(Data.KhuyenMais,
                                       ct => ct.MaVoucher,
                                       km => km.MaVoucher,
                                       (ct, km) => new
                                       {
                                           KhuyenMai = km,
                                           ChiTietKhuyenMai = ct
                                       })
                                 .FirstOrDefault();

                    int productPrice = product.Gia; 
                    if (khuyenMai != null && KiemTraKhuyenMai(khuyenMai.KhuyenMai))
                    {
                        // Nếu có khuyến mãi, giảm giá
                        productPrice -= (productPrice * khuyenMai.KhuyenMai.PhanTramGiam) / 100;
                    }

                    var newCartItem = new ChiTietGioHang
                    {
                        MaGioHang = cartId,
                        MaSanPham = strId,
                        SoLuong = 1, 
                        ThanhTien = productPrice 
                    };

                    Data.ChiTietGioHangs.InsertOnSubmit(newCartItem);
                    Data.SubmitChanges();
                    var cartItems = Data.ChiTietGioHangs.Where(c => c.MaGioHang == cartId);
                    int updatedCartItemCount = cartItems.Select(c => c.MaSanPham).Distinct().Count();


                    return Json(new { success = true, message = "Thêm sản phẩm vào giỏ hàng thành công!", cartItemCount = updatedCartItemCount });
                }
                else
                {
                    return Json(new { success = false, message = "Không tìm thấy sản phẩm." });
                }
            }
            else
            {
                existingCartItem.SoLuong++;
                existingCartItem.ThanhTien = existingCartItem.SanPham.Gia * existingCartItem.SoLuong; // Cập nhật thành tiền
                Data.SubmitChanges();

                // Cập nhật tổng số lượng sản phẩm trong giỏ hàng
                var cartItems = Data.ChiTietGioHangs.Where(c => c.MaGioHang == cartId);
                int updatedCartItemCount = cartItems.Count();

                return Json(new { success = true, message = "Thêm sản phẩm vào giỏ hàng thành công!", cartItemCount = updatedCartItemCount });
            }
        }




        [HttpPost]
        public ActionResult AddToCart2(string id, int quantity)
        {
            var currentAccount = (TaiKhoan)Session["TaiKhoan"];
            id = id.Trim().Replace("%20", "");
            if (currentAccount == null)
            {
                return Json(new { success = false, message = "Bạn cần đăng nhập để thêm sản phẩm vào giỏ hàng. Vui lòng đăng nhập và thử lại." });
            }

            int accountId = currentAccount.id;
            MyDataDataContext Data = new MyDataDataContext();
            var existingCart = Data.GioHangs.FirstOrDefault(g => g.id == accountId);

            string cartId = "";

            if (existingCart == null)
            {
                cartId = GenerateRandomCartId();
                var newCart = new GioHang
                {
                    MaGioHang = cartId,
                    id = accountId
                };
                Data.GioHangs.InsertOnSubmit(newCart);
                Data.SubmitChanges();
            }
            else
            {
                cartId = existingCart.MaGioHang;
            }

            string strId = id.ToString();
            var existingCartItem = Data.ChiTietGioHangs.FirstOrDefault(c => c.MaGioHang == cartId && c.MaSanPham == strId);

            if (existingCartItem == null)
            {
                var product = Data.SanPhams.FirstOrDefault(p => p.MaSanPham == id);
                var khuyenMai = Data.ChiTietKhuyenMais
                                .Where(ct => ct.MaSanPham == product.MaSanPham)
                                .Join(Data.KhuyenMais,
                                      ct => ct.MaVoucher,
                                      km => km.MaVoucher,
                                      (ct, km) => new
                                      {
                                          KhuyenMai = km,
                                          ChiTietKhuyenMai = ct
                                      })
                                .FirstOrDefault();


                int productPrice = product.Gia;
                if (khuyenMai != null && KiemTraKhuyenMai(khuyenMai.KhuyenMai))
                {
                    // Nếu có khuyến mãi, giảm giá
                    productPrice -= (productPrice * khuyenMai.KhuyenMai.PhanTramGiam) / 100;
                }
                if (product != null)
                {
                    var newCartItem = new ChiTietGioHang
                    {
                        MaGioHang = cartId,
                        MaSanPham = strId,
                        SoLuong = quantity, 
                        ThanhTien = productPrice * quantity 
                    };

                    Data.ChiTietGioHangs.InsertOnSubmit(newCartItem);
                    Data.SubmitChanges();

                    // Cập nhật tổng số lượng sản phẩm trong giỏ hàng
                    var cartItems = Data.ChiTietGioHangs.Where(c => c.MaGioHang == cartId);
                    int updatedCartItemCount = cartItems.Select(c => c.MaSanPham).Distinct().Count();


                    return Json(new { success = true, message = "Đã thêm sản phẩm vào giỏ hàng!", cartItemCount = updatedCartItemCount });
                }
                else
                {
                    return Json(new { success = false, message = "Không tìm thấy sản phẩm." });
                }
            }
            else
            {
                existingCartItem.SoLuong += quantity;
                existingCartItem.ThanhTien = existingCartItem.SanPham.Gia * existingCartItem.SoLuong; // Tính lại thành tiền
                Data.SubmitChanges();

                var cartItems = Data.ChiTietGioHangs.Where(c => c.MaGioHang == cartId);
                int updatedCartItemCount = cartItems.Sum(c => c.SoLuong ?? 0);


                return Json(new { success = true, message = "Đã cập nhật giỏ hàng!", cartItemCount = updatedCartItemCount });
            }
        }

        private string GenerateRandomCartId()
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var random = new Random();
            var cartId = new string(Enumerable.Repeat(chars, 10)
                .Select(s => s[random.Next(s.Length)]).ToArray());
            return cartId;
        }

        [HttpPost]
        [ValidateAntiForgeryToken] // Bảo vệ chống CSRF
        public ActionResult RemoveFromCart(string id)
        {
            var currentAccount = (TaiKhoan)Session["TaiKhoan"];

            int accountId = currentAccount.id;

            MyDataDataContext Data = new MyDataDataContext();
            var existingCart = Data.GioHangs.FirstOrDefault(g => g.id == accountId);

            if (existingCart != null)
            {
                string cartId = existingCart.MaGioHang;
                var existingCartItem = Data.ChiTietGioHangs.FirstOrDefault(c => c.MaGioHang == cartId && c.MaSanPham == id);

                if (existingCartItem != null)
                {
                    Data.ChiTietGioHangs.DeleteOnSubmit(existingCartItem);
                    Data.SubmitChanges();
                    return RedirectToAction("Index", "Cart");
                }
            }

            return RedirectToAction("Index", "Cart"); 
        }
        public ActionResult Payment(int tongTien)
        {

            MyDataDataContext Data = new MyDataDataContext();
            // Thông số yêu cầu cần gửi tới hệ thống MoMo
            string endpoint = "https://test-payment.momo.vn/gw_payment/transactionProcessor";
            // string endpoint = "https://localhost:44327";
            string partnerCode = "MOMOOJOI20210710";
            string accessKey = "iPXneGmrJH0G8FOP";
            string serectkey = "sFcbSGRSJjwGxwhhcEktCHWYUuTuPNDB";
            string orderInfo = "Thanh toán online";
            string returnUrl = "https://localhost:44327/Cart/ReturnUrl";
            string notifyUrl = "https://localhost:44327/Cart/PaymentNotification";
            string amount = tongTien.ToString();
            string orderid = GenerateOrderCode(); // Mã đơn hàng
            string requestId = DateTime.Now.Ticks.ToString();
            string extraData = "";

            string rawHash = "partnerCode=" +
                partnerCode + "&accessKey=" +
                accessKey + "&requestId=" +
                requestId + "&amount=" +
                amount + "&orderId=" +
                orderid + "&orderInfo=" +
                orderInfo + "&returnUrl=" +
                returnUrl + "&notifyUrl=" +
                notifyUrl + "&extraData=" +
                extraData;

            MoMoSecurity crypto = new MoMoSecurity();
            string signature = crypto.signSHA256(rawHash, serectkey);
            TempData["OrderId"] = orderid;
            // Build body json request
            JObject message = new JObject
          {
              { "partnerCode", partnerCode },
              { "accessKey", accessKey },
              { "requestId", requestId },
              { "amount",amount },
              { "orderId", orderid },
              { "orderInfo", orderInfo },
              { "returnUrl", returnUrl },
              { "notifyUrl", notifyUrl },
              { "extraData", extraData },
              { "requestType", "captureMoMoWallet" },
              { "signature", signature }
          };

            string responseFromMomo = PaymentRequest.sendPaymentRequest(endpoint, message.ToString());
            JObject jmessage = JObject.Parse(responseFromMomo);

            // Truy cập các trường trong JObject
            requestId = jmessage["requestId"].ToString();
            int errorCode = int.Parse(jmessage["errorCode"].ToString());
            string orderId = jmessage["orderId"].ToString();
            string localMessage = jmessage["localMessage"].ToString();
            Session["amount"] = amount;
            Session["orderid"] = orderid;

            return Redirect(jmessage.GetValue("payUrl").ToString());
        }
        public ActionResult ReturnUrl()
        {

            MyDataDataContext Data = new MyDataDataContext();
            string amount = Session["amount"].ToString();
            string orderid = Session["orderid"].ToString();

            string param = Request.QueryString.ToString().Substring(0, Request.QueryString.ToString().IndexOf("signature") - 1);
            param =WebUtility.UrlDecode(param);
            if (param.Contains("Bad request"))
            {
                var currentAccount = (TaiKhoan)Session["TaiKhoan"];
                int accountId = currentAccount.id;
                var taiKhoan = Data.TaiKhoans.FirstOrDefault(tk => tk.id == accountId);
                string shippingAddress = "";
                if (taiKhoan != null)
                {
                    int idTK = taiKhoan.idTK;
                    shippingAddress = GetShippingAddress(idTK);
                }

                if (int.TryParse(amount, out int parsedAmount))
                {
                    var orderCode = orderid;

                    // Tạo đơn hàng mới và lưu vào cơ sở dữ liệu với TrangThaiDH là "Thanh toán không thành công" do lỗi Bad request
                    var order = new DonHang
                    {
                        MaDH = orderCode,
                        NgayLap = DateTime.Now,
                        TongTien = parsedAmount,
                        DiaChiGiaoHang = shippingAddress,
                        TrangThaiDH = "Thanh toán không thành công."
                    };

                    Data.DonHangs.InsertOnSubmit(order);

                    var gioHang = Data.GioHangs.FirstOrDefault(g => g.id == accountId);
                    string maGioHang = gioHang != null ? gioHang.MaGioHang : null;

                    var orderDetail = new ChiTietDonHang
                    {
                        MaDH = orderCode,
                        MaGioHang = maGioHang,
                    };

                    Data.ChiTietDonHangs.InsertOnSubmit(orderDetail);

                    try
                    {
                        Data.SubmitChanges();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Đã có lỗi xảy ra khi lưu đơn hàng: " + ex.Message);
                    }
                }
                return RedirectToAction("ThanhToanThatBai", "SauKhiThanhToan");
            }
            else
            {
                // Thông tin khách hàng và địa chỉ giao hàng
                var currentAccount = (TaiKhoan)Session["TaiKhoan"];
                int accountId = currentAccount.id;
                var taiKhoan = Data.TaiKhoans.FirstOrDefault(tk => tk.id == accountId);
                string shippingAddress = "";
                if (taiKhoan != null)
                {
                    int idTK = taiKhoan.idTK;
                    shippingAddress = GetShippingAddress(idTK);
                }

                if (int.TryParse(amount, out int parsedAmount))
                {
                    var orderCode = orderid;

                    // Tạo đơn hàng mới và lưu vào cơ sở dữ liệu
                    var order = new DonHang
                    {
                        MaDH = orderCode,
                        NgayLap = DateTime.Now,
                        TongTien = parsedAmount,
                        DiaChiGiaoHang = shippingAddress,
                        TrangThaiDH = "Đã thanh toán",
                        ThongTinDH = "Đang Chuẩn Bị"
                    };

                    Data.DonHangs.InsertOnSubmit(order);

                    var gioHang = Data.GioHangs.FirstOrDefault(g => g.id == accountId);
                    string maGioHang = gioHang != null ? gioHang.MaGioHang : null;
                    var cartItems = Data.ChiTietGioHangs.Where(c => c.MaGioHang == maGioHang);
                    foreach (var item in cartItems)
                    {
                        var orderDetail = new ChiTietDonHang
                        {
                            MaDH = orderCode,
                            MaGioHang = maGioHang,
                            MaSanPham = item.MaSanPham
                        };
                        Data.ChiTietDonHangs.InsertOnSubmit(orderDetail);
                    }
                   
                    
                    try
                    {
                        // Lưu đơn hàng vào cơ sở dữ liệu
                        Data.SubmitChanges();

                        // Lấy chi tiết giỏ hàng để trừ số lượng sản phẩm từ bảng SanPham
                        cartItems = Data.ChiTietGioHangs.Where(c => c.MaGioHang == maGioHang);

                        foreach (var item in cartItems)
                        {
                            var product = Data.SanPhams.FirstOrDefault(p => p.MaSanPham == item.MaSanPham);
                            if (product != null)
                            {
                                if (item.SoLuong.HasValue)
                                {
                                    product.SoLuongTon -= item.SoLuong.Value; 
                                }
                            }
                        }
                        foreach (var item in cartItems)
                        {
                            Data.ChiTietGioHangs.DeleteOnSubmit(item); 
                        }
                        Data.SubmitChanges();
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Đã có lỗi xảy ra khi lưu đơn hàng: " + ex.Message);
                    }
                }
                // Gửi email xác nhận đơn hàng
                currentAccount = (TaiKhoan)Session["TaiKhoan"];
                int idTK1 = currentAccount.idTK;
                string toEmail = ""; 
                var thongTinCaNhan = Data.ThongTinCaNhans.FirstOrDefault(t => t.idTK == idTK1);
                if (thongTinCaNhan != null)
                {
                    toEmail = thongTinCaNhan.Email;
                }

                string orderCode1 = orderid; 
                SendOrderConfirmationEmail(toEmail, orderCode1, "Xác nhận đơn hàng", $"Xin chào,<br /><br />Đơn hàng của bạn đã được xác nhận.<br />Mã đơn hàng của bạn là: {orderCode1}<br /><br />Cảm ơn bạn đã mua hàng.");
                NotifyEmployeesAndAdmin(orderCode1);
                return RedirectToAction("ThanhToanThanhCong", "SauKhiThanhToan");
            }
        }


        private void SendOrderConfirmationEmail(string to, string orderCode,string subject,string body)
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
        private string GenerateOrderCode()
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var random = new Random();
            var cartId = new string(Enumerable.Repeat(chars, 10)
                .Select(s => s[random.Next(s.Length)]).ToArray());
            return cartId;
        }

        private string GetShippingAddress(int idTK)
        {
            MyDataDataContext Data = new MyDataDataContext();
            var thongTinCaNhan = Data.ThongTinCaNhans.FirstOrDefault(ttcn => ttcn.idTK == idTK);
            if (thongTinCaNhan != null)
            {
                string diaChi = thongTinCaNhan.DiaChi;
                return diaChi;
            }
            else
            {
                return "Địa chỉ không khả dụng";
            }
        }
        private KhuyenMai GetProductDiscount(string maSanPham)
        {
            MyDataDataContext Data = new MyDataDataContext();

            // Lấy thông tin khuyến mãi đang áp dụng cho sản phẩm có mã là maSanPham
            var discount = Data.ChiTietKhuyenMais
                            .Where(ct => ct.MaSanPham == maSanPham)
                            .Join(Data.KhuyenMais,
                                  ct => ct.MaVoucher,
                                  km => km.MaVoucher,
                                  (ct, km) => km)
                            .Where(km => DateTime.Now >= km.ThoiGianBatDau && DateTime.Now <= km.ThoiGianKetThuc)
                            .FirstOrDefault();

            return discount;
        }
        private void NotifyEmployeesAndAdmin(string orderCode)
        {
            MyDataDataContext Data = new MyDataDataContext();

            // Lấy danh sách các tài khoản có LoaiTK là Nhân Viên hoặc Admin
            var accounts = Data.TaiKhoans.Where(tk => tk.LoaiTK == "Nhân Viên" || tk.LoaiTK == "admin").ToList();
            string subject = "Thông báo đơn hàng mới";
            string body = $"Xin chào,<br /><br />Có đơn hàng mới được tạo trên hệ thống.<br />Mã đơn hàng: {orderCode}<br /><br />Vui lòng kiểm tra và xử lý đơn hàng.";
            foreach (var account in accounts)
            {
                string toEmail = ""; 

                var thongTinCaNhan = Data.ThongTinCaNhans.FirstOrDefault(t => t.idTK == account.idTK);
                if (thongTinCaNhan != null)
                {
                    toEmail = thongTinCaNhan.Email;
                }
                SendOrderConfirmationEmail(toEmail, orderCode, subject,body);
            }
        }
    }
}