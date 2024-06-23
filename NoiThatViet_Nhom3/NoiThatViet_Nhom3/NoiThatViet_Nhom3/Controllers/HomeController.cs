using Facebook;
using NoiThatViet_Nhom3.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Diagnostics.Tracing;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Threading;
using System.Web.Mvc;
using Google.Apis.Auth.OAuth2.Flows;
using Google.Apis.Auth.OAuth2;
using Google.Apis.Services;
using Google.Apis.Util.Store;
using Google.Apis.Oauth2.v2;
using System.Web.UI.WebControls;
using TweetSharp;
using System.Security.Cryptography;
using System.Text;
using Tweetinvi.Core.Events;
using Tweetinvi.Core.Models.Properties;

namespace NoiThatViet_Nhom3.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        MyDataDataContext data = new MyDataDataContext();
        [HandleError]
        private bool IsNumeric(string value)
        {
            return double.TryParse(value, out _);
        }
        // Hàm kiểm tra xem một chuỗi có chứa ký tự đặc biệt hay không
        private bool ContainsSpecialCharacters(string str)
        {
            if (string.IsNullOrEmpty(str))
            {
                return false; // hoặc true tùy thuộc vào yêu cầu
            }

            return Regex.IsMatch(str, @"[^a-zA-Z0-9@!~#$%^&*()_++-]+");
        }
        //kiểm tra định dạng email
        public bool IsValidEmail(string email)
        {
            // Kiểm tra định dạng của địa chỉ email bằng regular expression
            // Đây là một regular expression đơn giản, bạn có thể cải thiện nó để phù hợp với các yêu cầu cụ thể của bạn
            string pattern = @"^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$";
            Regex regex = new Regex(pattern);
            return regex.IsMatch(email);
        }
        // Hàm kiểm tra mật khẩu có mức độ trung bình trở lên
        public bool IsPasswordStrong(string password)
        {
            // Kiểm tra có ít nhất một chữ hoa, một chữ thường, một số và một ký tự đặc biệt
            if (Regex.IsMatch(password, @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+])[A-Za-z\d!@#$%^&*()_+]+$"))
            {
                return true;
            }
            return false;
        }

        //Hàm đăng ký
        public ActionResult DangKy()
        {
            // Kiểm tra xem người dùng đã đăng nhập chưa
            if (Session["TaiKhoan"] != null || Session["TaiKhoanFB"] != null)
            {
                // Nếu đã đăng nhập, chuyển hướng đến trang chính
                return RedirectToAction("Index", "SanPham");
            }
            return View();
        }
        [HttpPost]
        public ActionResult DangKy(User user)
        {

            List<string> errorMessages = new List<string>();
            // kiểm tra tài khoản không bỏ trống , 2->50 kí tự và không chứa kí tự đặc biệt
            if (!string.IsNullOrWhiteSpace(user.TaiKhoan))
            {
                if (ContainsSpecialCharacters(user.TaiKhoan))
                {
                    errorMessages.Add("Tài khoản không được chứa ký tự đặc biệt.");
                }
                if (user.TaiKhoan.Length < 2 || user.TaiKhoan.Length > 50)
                {
                    errorMessages.Add("Tài khoản phải có từ 2 đến 50 ký tự.");
                }
            }
            else
            {
                errorMessages.Add("Tài khoản không được bỏ trống.");
            }
            // Kiểm tra xem mật khẩu có rỗng không
            if (string.IsNullOrWhiteSpace(user.Password))
            {
                errorMessages.Add("Mật khẩu không được để trống.");
            }
            // Kiểm tra xem mật khẩu có chứa ký tự tiếng việt có dấu hay không
            if (ContainsSpecialCharacters(user.Password))
            {
                errorMessages.Add("Mật khẩu không được chứa ký tự đặc biệt(Có dấu).");
            }

            // Kiểm tra mật khẩu có đạt mức trung bình trở lên không
            if (!IsPasswordStrong(user.Password))
            {
                errorMessages.Add("Mật khẩu phải có mức độ trung bình trở lên.");
            }

            // Kiểm tra xem họ tên có rỗng không, 2 -> 100
            if (string.IsNullOrWhiteSpace(user.Name))
            {
                errorMessages.Add("Họ tên không được để trống.");
            }
            else if (user.Name.Length < 2 || user.Name.Length > 100)
            {
                errorMessages.Add("Họ tên phải có từ 2 đến 100 ký tự.");
            }

            // địa chỉ không được bỏ trống,10->250
            if (string.IsNullOrWhiteSpace(user.Diachi))
            {
                errorMessages.Add("Địa chỉ không được để trống.");
            }
            else if (user.Diachi.Length < 10 || user.Diachi.Length > 250)
            {
                errorMessages.Add("Địa chỉ phải có từ 10 đến 100 ký tự.");
            }

            //Email
            if (string.IsNullOrWhiteSpace(user.Email))
            {
                errorMessages.Add("Địa chỉ email không được để trống.");
            }
            else if (!IsValidEmail(user.Email))
            {
                errorMessages.Add("Địa chỉ email không hợp lệ.");
            }

            // Kiểm tra xem số điện thoại có chứa ký tự không phải số hay không
            if (string.IsNullOrWhiteSpace(user.SDT))
            {
                errorMessages.Add("Số điện thoại không được bỏ trống.");
            }
            else if (!IsNumeric(user.SDT))
            {
                errorMessages.Add("Số điện thoại phải là số.");
            }
            else if (user.SDT.Length != 10 && user.SDT.Length != 11)
            {
                errorMessages.Add("Số điện thoại phải có đúng 10 hoặc 11 chữ số.");
            }

            //Kiểm tra xem có lỗi nào không
            if (errorMessages.Count > 0)
            {
                ViewBag.ErrorMessages = errorMessages;
                return View();
            }

            // Tạo mã OTP
            var otp = GenerateOTP();

            user.loaiTK = "User";
            // Tạo một đối tượng ThongTinCaNhan mới và lưu thông tin cá nhân
            var newThongTinCaNhan = new ThongTinCaNhan
            {
                idTK = user.idTK,
                HoTen = user.Name,
                Email = user.Email,
                Sdt = user.SDT,
                DiaChi = user.Diachi,
                IsEmailConfirmed = false,
                TrangThai = "Mở",
                ConfirmationCode = int.Parse(otp) // Lưu mã OTP vào tài khoản mới
            };
            // Lưu ConfirmationCode vào thuộc tính của user trước khi lưu vào cơ sở dữ liệu
            user.confirmationCode = int.Parse(otp);

            // Kiểm tra xem địa chỉ email đã tồn tại trong cơ sở dữ liệu chưa
            var existingUser = data.ThongTinCaNhans.FirstOrDefault(t => t.Email == user.Email);
            if (existingUser != null)
            {
                // Hiển thị thông báo lỗi nếu địa chỉ email đã được đăng ký
                ViewBag.EmailExists = true;
                return View();
            }

            // Kiểm tra xem tên đăng nhập đã tồn tại trong cơ sở dữ liệu chưa
            var existingUserName = data.TaiKhoans.FirstOrDefault(t => t.TenDangNhap == user.TaiKhoan);
            if (existingUserName != null)
            {
                // Hiển thị thông báo lỗi nếu tên đăng nhập đã được sử dụng
                ViewBag.UserNameExists = true;
                return View();
            }

            // Kiểm tra xem số điện thoại đã tồn tại trong cơ sở dữ liệu chưa
            var existingPhone = data.ThongTinCaNhans.FirstOrDefault(t => t.Sdt == user.SDT);
            if (existingPhone != null)
            {
                // Hiển thị thông báo lỗi nếu địa chỉ email đã được đăng ký
                ViewBag.PhoneExists = true;
                return View();
            }

            

            // Thêm thông tin cá nhân mới vào cơ sở dữ liệu
            data.ThongTinCaNhans.InsertOnSubmit(newThongTinCaNhan);
            data.SubmitChanges();

            // Lấy idTK của thông tin cá nhân mới được tạo
            int newIdTK = newThongTinCaNhan.idTK;

            // Tạo một đối tượng TaiKhoan mới và gán thông tin cần thiết
            var newUser = new TaiKhoan
            {
                TenDangNhap = user.TaiKhoan,
                //Mã hóa password và lưu vào cơ sở dữ liệu
                MatKhau = MaHoaPassword.GetMd5Hash(user.Password),
                LoaiTK = user.loaiTK,
                idTK = newIdTK // Gán idTK của thông tin cá nhân cho tài khoản
            };
            data.TaiKhoans.InsertOnSubmit(newUser);
            data.SubmitChanges();
            // Gửi mã OTP đến email của người dùng
            string confirmationLink = Url.Action("XacNhanEmail", "Home", new { confirmationCode = otp }, protocol: Request.Url.Scheme);
            string emailContent = $"Xin chào {user.Name}, Vui lòng xác nhận đăng ký bằng cách nhấp vào {confirmationLink}'.Mã OTP của bạn là: {otp}";
            SendPasswordResetEmail(user.Email, "Xác nhận đăng ký", emailContent);

            // Chuyển hướng sang trang xác nhận email
            return RedirectToAction("XacNhanEmail");
        }

        //xác nhận email
        public ActionResult XacNhanEmail()
        {
            // Kiểm tra xem người dùng đã đăng nhập chưa
            if (Session["TaiKhoan"] != null || Session["TaiKhoanFB"] != null)
            {
                // Nếu đã đăng nhập, chuyển hướng đến trang chính
                return RedirectToAction("Index", "SanPham");
            }
            return View();
        }
        [HttpPost]
        public ActionResult XacNhanEmail(int confirmationCode)
        {
            // Tìm thông tin cá nhân dựa trên mã xác nhận
            var thongTinCaNhan = data.ThongTinCaNhans.FirstOrDefault(t => t.ConfirmationCode == confirmationCode);

            if (thongTinCaNhan != null)
            {
                // Cập nhật trạng thái xác nhận email thành true
                thongTinCaNhan.IsEmailConfirmed = true;
                data.SubmitChanges();

                // Hiển thị thông báo xác nhận thành công và chuyển hướng đến trang đăng nhập
                return RedirectToAction("DangNhap", "Home");
            }
            else
            {
                // Hiển thị thông báo xác nhận thất bại
                ViewBag.ConfirmationSuccess = false;
                return View();
            }
        }
        //đăng nhập
        public ActionResult DangNhap()
        {
           // Kiểm tra xem người dùng đã đăng nhập chưa
            if (Session["TaiKhoan"] != null || Session["TaiKhoanFB"] != null)
            {
                    // Nếu đã đăng nhập, chuyển hướng đến trang chính
                    return RedirectToAction("Index", "SanPham");
                
            }
               
                
            return View();
        }

        [HttpPost]
        public ActionResult DangNhap(TaiKhoan user)
        {
            var taikhoanForm = user.TenDangNhap;
            var matkhauForm = MaHoaPassword.GetMd5Hash(user.MatKhau);// Mã hóa mật khẩu nhập vào

            // Kiểm tra thông tin đăng nhập
            var UserCheck = data.TaiKhoans.SingleOrDefault(u => u.TenDangNhap.Equals(taikhoanForm) && u.MatKhau.Equals(matkhauForm));
            if (UserCheck != null)
            {

                if (UserCheck.LoaiTK.Trim().ToLower() == "admin")
                {
                    TempData["error"] = "admin k duoc dang nhap.";
                    return View();
                }
                // Kiểm tra xem tài khoản đã xác nhận email chưa
                var currentTime = DateTime.Now;
                var thongTinCaNhan = data.ThongTinCaNhans.FirstOrDefault(t => t.idTK == UserCheck.idTK);
                if (thongTinCaNhan != null && thongTinCaNhan.IsEmailConfirmed == true && thongTinCaNhan.TrangThai != "Khóa")
                {
                    // Lưu thông tin tài khoản vào Session
                    Session["TaiKhoan"] = UserCheck;
                    Session["UserId"] = UserCheck.id;
                    return RedirectToAction("Index", "SanPham");
                }

                else if (currentTime >= thongTinCaNhan.NgayBatDau && currentTime <= thongTinCaNhan.NgayKetThuc && thongTinCaNhan != null && thongTinCaNhan.TrangThai == "Khóa")
                {
                    // Đăng nhập thất bại vì tài khoản đang bị khóa
                    ViewBag.LoginFail = "Tài khoản đã bị khóa từ " + thongTinCaNhan.NgayBatDau?.ToString("dd/MM/yyyy") + " đến " + thongTinCaNhan.NgayKetThuc?.ToString("dd/MM/yyyy");
                    return View("DangNhap");
                }
                else
                {
                    // Đăng nhập thất bại vì email chưa được xác nhận hoặc thông tin cá nhân không tồn tại
                    ViewBag.LoginFail = "Tài khoản chưa được xác nhận qua email hoặc không tồn tại.";
                    return View("DangNhap");
                }
            }
            else
            {
                // Đăng nhập thất bại, bạn có thể xử lý thông báo lỗi ở đây hoặc chuyển hướng người dùng đến trang đăng nhập lại.
                ViewBag.LoginFail = "Tài khoản hoặc mật khẩu không chính xác.";
                return View("DangNhap");
            }
        }

        //Đăng xuất
        public ActionResult DangXuat()
        {
            Session["TaiKhoan"] = null;
            Session["TaiKhoanFB"] = null;
            return RedirectToAction("Index", "SanPham");
        }

        //Lấy lại mật khẩu 
        [NonEvent]
        public ActionResult LayLaiMatKhau()
        {
            // Kiểm tra xem người dùng đã đăng nhập chưa
            if (Session["TaiKhoan"] != null || Session["TaiKhoanFB"] != null)
            {
                // Nếu đã đăng nhập, chuyển hướng đến trang chính
                return RedirectToAction("Index", "SanPham");
            }
            return View();
        }
        [HttpPost]
        public ActionResult LayLaiMatKhau(string email)
        {
            // Tìm tài khoản với địa chỉ email được cung cấp
            var user = data.TaiKhoans.FirstOrDefault(u => u.ThongTinCaNhan.Email == email);

            if (user != null)
            {
                // Tạo mật khẩu mới
                var newPassword = GeneratePassword(); // Viết hàm GeneratePassword để tạo mật khẩu mới
                string MaHoaMatKhauMoi = MaHoaPassword.GetMd5Hash(newPassword);
                // Cập nhật mật khẩu mới cho tài khoản
                user.MatKhau = MaHoaMatKhauMoi;
                data.SubmitChanges();

                // Tạo URL chứa địa chỉ email dưới dạng tham số
                string resetLink = Url.Action("DoiMatKhau", "Home", new { email = email }, protocol: Request.Url.Scheme);
                var body = $"Vui lòng nhấp vào liên kết sau để đặt lại mật khẩu: {resetLink}";
                SendPasswordResetEmail(email, "Đặt lại mật khẩu", $"Mật khẩu mới của bạn là: {newPassword} {body}");

                // Thông báo cho người dùng rằng mật khẩu đã được gửi lại qua email
                ViewBag.ResetPasswordSuccess = true;
            }

            else
            {
                // Thông báo cho người dùng rằng địa chỉ email không tồn tại trong hệ thống
                ViewBag.ResetPasswordSuccess = false;
            }

            return View();
        }

        public ActionResult DoiMatKhau(string email)
        {
            // Truyền địa chỉ email qua ViewBag để sử dụng trong view
            ViewBag.Email = email;
            // Kiểm tra xem người dùng đã đăng nhập chưa
            if (Session["TaiKhoan"] != null || Session["TaiKhoanFB"] != null)
            {
                // Nếu đã đăng nhập, chuyển hướng đến trang chính
                return RedirectToAction("Index", "SanPham");
            }
            return View();

        }
        [HttpPost]
        public ActionResult DoiMatKhau(string email, string newPassword, string confirmNewPassword, string returnUrl)
        {
            // Kiểm tra mật khẩu mới và mật khẩu được xác nhận
            if (newPassword != confirmNewPassword)
            {
                // Nếu không khớp, thông báo lỗi và trả về view
                ViewBag.ChangePasswordSuccess = false;
                ViewBag.ErrorMessage = "Mật khẩu mới và mật khẩu xác nhận không khớp.";
                return View();
            }

            // Tìm tài khoản với địa chỉ email được cung cấp
            var user = data.TaiKhoans.FirstOrDefault(u => u.ThongTinCaNhan.Email == email);

            if (user != null)
            {
                // Mã hóa mật khẩu mới
                string hashedPassword = MaHoaPassword.GetMd5Hash(newPassword);

                // Cập nhật mật khẩu mới cho tài khoản
                user.MatKhau = hashedPassword;
                data.SubmitChanges();

                // Thông báo cho người dùng rằng mật khẩu đã được đổi thành công
                ViewBag.ChangePasswordSuccess = true;

                // Kiểm tra và chuyển hướng nếu có đường dẫn trả về hợp lệ và IsLocalUrl có phải là đường dẫn cục bộ hay ko
                if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
                {
                    return Redirect(returnUrl);
                }

                // Nếu không có đường dẫn trả về hoặc đường dẫn không hợp lệ, trả về view
                return View();
            }
            else
            {
                // Thông báo cho người dùng rằng không tìm thấy tài khoản với địa chỉ email cung cấp
                ViewBag.ChangePasswordSuccess = false;
                ViewBag.ErrorMessage = "Không tìm thấy tài khoản với địa chỉ email đã cung cấp.";
                return View();
            }
        }


        // Hàm để tạo otp
        private string GenerateOTP()
        {
            Random random = new Random();
            int otp = random.Next(100000, 1000000); // Sinh số ngẫu nhiên từ 100000 đến 999999
            return otp.ToString();
        }

        // Hàm để tạo mật khẩu ngẫu nhiên
        private string GeneratePassword()
        {
            // Viết logic để tạo mật khẩu ngẫu nhiên, có thể sử dụng thư viện hoặc tạo ngẫu nhiên dựa trên các ký tự được chọn
            // Ví dụ:
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


        //Đăng nhập Facebook
        //URI sử dụng để chuyển hướng người dùng sau khi đăng nhập
        private Uri RedirectUri
        {
            get
            {
                var uriBuilder = new UriBuilder(Request.Url);
                uriBuilder.Query = null; // xóa tham số khỏi uri
                uriBuilder.Fragment = null; // xóa nhận dạng trong các liên kết nhảy
                uriBuilder.Path = Url.Action("FacebookCallback");
                return uriBuilder.Uri;
            }
        }

        public ActionResult DangNhapFacebook()
        {
            
            var fb = new FacebookClient();
            var loginUrl = fb.GetLoginUrl(new
            {
                client_id = ConfigurationManager.AppSettings["FacebookAppId"],
                client_secret = ConfigurationManager.AppSettings["FacebookAppSecret"],
                redirect_uri = RedirectUri.AbsoluteUri, // facebook sẽ gửi mã xác thực khi người dùng đăng nhập hay từ chối truy cập
                response_type = "code",//nhận mã xác thực từ fb để xác thực quá trình tiếp theo
                scope = "email", // quyền yêu cầu truy cập
            });
            return Redirect(loginUrl.AbsoluteUri);
        }

        

        public ActionResult FacebookCallback(string Code)
        {

            var fb = new FacebookClient();
            dynamic result = fb.Post("oauth/access_token", new
            {
                client_id = ConfigurationManager.AppSettings["FacebookAppId"],
                client_secret = ConfigurationManager.AppSettings["FacebookAppSecret"],
                redirect_uri = RedirectUri.AbsoluteUri,
                scope = "email",
                code = Code,//mã xác thực Facebook trả về sau khi người dùng truy cập thành công
            });
            //accessToken sau khi đăng nhập thành công được facebook cấp quyền cho ứng dụng
            var accessToken = result.access_token;
            if (!string.IsNullOrEmpty(accessToken))
            {
                fb.AccessToken = accessToken;
                dynamic me = fb.Get("me?fields=first_name,middle_name,last_name,id,email");
                string email = me.email;
                string userName = me.email;
                string firstname = me.first_name;
                string middlename = me.middle_name;
                string lastname = me.last_name;

                // Kiểm tra xem thông tin từ Facebook đã tồn tại trong CSDL hay không
                var existingUser = data.ThongTinCaNhans.FirstOrDefault(u => u.Email == email);
                if (existingUser != null)
                {
                    // Tài khoản đã tồn tại trong CSDL, đăng nhập và chuyển hướng đến trang chính
                    // Kiểm tra trạng thái tài khoản
                    if (existingUser.TrangThai == "Khóa")
                    {
                        // Nếu tài khoản đã bị khóa, thông báo và chuyển hướng người dùng đến trang thông báo
                        TempData["ErrorMessage"] = "Tài khoản của bạn đã bị khóa.";
                        return RedirectToAction("Index", "Error");
                    }
                    // Tài khoản đã tồn tại trong CSDL, đăng nhập và chuyển hướng đến trang chính
                    Session["TaiKhoanFB"] = existingUser;
                    return RedirectToAction("Index", "SanPham");
                }
                
                else
                {
                    User user = new User();
                    var newThongTinCaNhan = new ThongTinCaNhan
                    {
                        idTK = user.idTK,
                        HoTen = firstname + middlename + lastname,
                        Email = email,
                        Sdt = null, // Số điện thoại từ Facebook
                        DiaChi = null,
                        TrangThai = "Mở",
                        IsEmailConfirmed = true,
                    };
                    data.ThongTinCaNhans.InsertOnSubmit(newThongTinCaNhan);
                    data.SubmitChanges();
                    int newIdTK = newThongTinCaNhan.idTK;
                    string inputPassword = "sa"; // Mật khẩu cần mã hóa
                    string hashedPassword = MaHoaPassword.GetMd5Hash(inputPassword); // Mã hóa mật khẩu
                    var newTaiKhoan = new TaiKhoan
                    {
                        TenDangNhap = userName,
                        MatKhau = hashedPassword,
                        LoaiTK = "User",
                        idTK = newIdTK
                    };
                    data.TaiKhoans.InsertOnSubmit(newTaiKhoan);
                    data.SubmitChanges();
                    // Lưu thông tin tài khoản vào Session
                    Session["TaiKhoan"] = newTaiKhoan;
                    // Chuyển hướng đến trang Index hoặc SanPham
                    return RedirectToAction("Index", "SanPham");
                }
            }
            return Redirect("/");
        }
        private string[] Scopes = { "email", "profile", "openid" };

        // Action này chuyển hướng người dùng đến trang xác thực Google
        public ActionResult DangNhapGoogle()
        {
            //url chuyển hướng khi người dùng đăng nhập thành công hoặc từ chối truy cập
            string redirectUri = Url.Action("GoogleCallback", "Home", null, Request.Url.Scheme);
            //xác thực và trao đổi mã xác thực từ Google
            var flow = new GoogleAuthorizationCodeFlow(new GoogleAuthorizationCodeFlow.Initializer
            {
                ClientSecrets = new ClientSecrets
                {
                    ClientId = ConfigurationManager.AppSettings["GoogleApi"],
                    ClientSecret = ConfigurationManager.AppSettings["GoogleAppSecret"],
                },
                Scopes = Scopes
            });
            //chứa các thông tin cần thiết để người dùng đăng nhập vào tài khoản Google của họ và cấp quyền truy cập cho ứng dụng.
            var uri = flow.CreateAuthorizationCodeRequest(redirectUri);
            //cấu hình xác thực mong muốn từ gg
            uri.ResponseType = "code";
            return Redirect(uri.Build().ToString());
        }

        // Action này xử lý mã trả về từ Google và lấy thông tin người dùng
        public async Task<ActionResult> GoogleCallback(string code)
        {
            string redirectUri = Url.Action("GoogleCallback", "Home", null, Request.Url.Scheme);
            var flow = new GoogleAuthorizationCodeFlow(new GoogleAuthorizationCodeFlow.Initializer
            {
                ClientSecrets = new ClientSecrets
                {
                    ClientId = ConfigurationManager.AppSettings["GoogleApi"],
                    ClientSecret = ConfigurationManager.AppSettings["GoogleAppSecret"],
                },
                Scopes = Scopes,
                DataStore = new FileDataStore("Google.Apis.Auth")
            });
            // mã xác thực nhận được từ Google được trao đổi để nhận token truy cập
            var token = await flow.ExchangeCodeForTokenAsync("user", code, redirectUri, CancellationToken.None);
            // credential được tạo ra và sử dụng để khởi tạo dịch vụ
            var credential = new UserCredential(flow, "user", token);

            var service = new Oauth2Service(new BaseClientService.Initializer
            {
                HttpClientInitializer = credential
            });

            var userinfo = await service.Userinfo.Get().ExecuteAsync();

            string email = userinfo.Email;
            string firstName = userinfo.GivenName;
            string lastName = userinfo.FamilyName;
            
            // Kiểm tra xem thông tin từ Google đã tồn tại trong CSDL hay không
            var existingUser = data.ThongTinCaNhans.FirstOrDefault(u => u.Email == email);
            if (existingUser != null)
            {
                // Tài khoản đã tồn tại trong CSDL, đăng nhập và chuyển hướng đến trang chính
                // Kiểm tra trạng thái tài khoản
                if (existingUser.TrangThai == "Khóa")
                {
                    // Nếu tài khoản đã bị khóa, thông báo và chuyển hướng người dùng đến trang thông báo
                    TempData["ErrorMessage"] = "Tài khoản của bạn đã bị khóa.";
                    return RedirectToAction("Index", "Error");
                }
                // Tài khoản đã tồn tại trong CSDL, đăng nhập và chuyển hướng đến trang chính
                Session["TaiKhoanFB"] = existingUser;
                return RedirectToAction("Index", "SanPham");
               
            }
            else
            {
                User user = new User();
                var newThongTinCaNhan = new ThongTinCaNhan
                {
                    idTK = user.idTK,
                    HoTen = firstName + " " + lastName,
                    Email = email,
                    Sdt = null, // Bạn có thể sử dụng thông tin điện thoại từ Google nếu cần
                    DiaChi = null, // Bạn có thể thêm thông tin địa chỉ từ Google nếu cần
                    TrangThai = "Mở",
                    IsEmailConfirmed = true,
                };
                data.ThongTinCaNhans.InsertOnSubmit(newThongTinCaNhan);
                data.SubmitChanges();
                int newIdTK = newThongTinCaNhan.idTK;

                string inputPassword = "sa"; // Mật khẩu cần mã hóa
                string hashedPassword = MaHoaPassword.GetMd5Hash(inputPassword); // Mã hóa mật khẩu
                var newTaiKhoan = new TaiKhoan
                {
                    TenDangNhap = email, // Bạn có thể sử dụng email làm tên đăng nhập
                    MatKhau = hashedPassword, // Không cần mật khẩu khi sử dụng OAuth
                    LoaiTK = "User",
                    idTK = newIdTK
                };
                data.TaiKhoans.InsertOnSubmit(newTaiKhoan);
                data.SubmitChanges();
                // Lưu thông tin tài khoản vào Session
                Session["TaiKhoan"] = newTaiKhoan;
                // Chuyển hướng đến trang Index hoặc SanPham
                return RedirectToAction("Index", "SanPham");
            }
        }
        //ĐĂNG NHẬP TWITTER

        private string ConsumerKey = "IToFWheWPD5RrQGPYr4yjhzNP";
        private string ConsumerSecret = "piNXnsTqCVAw6Q7wyOdQKqy9gtn3VTSmPENy28zdAgowvTecCS";
        private string CallbackUrl = "https://localhost:44327/Home/TwitterCallBack";

        public ActionResult DangNhapTwitter()
        {
            var service = new TwitterService(ConsumerKey, ConsumerSecret);
            var requestToken = service.GetRequestToken(CallbackUrl);

            var uri = service.GetAuthorizationUri(requestToken);
            return Redirect(uri.ToString());
        }

        public ActionResult TwitterCallback(string oauth_token, string oauth_verifier)
        {
            var service = new TwitterService(ConsumerKey, ConsumerSecret);

            //sử dụng mã oauth_token để khởi tạo đối tượng OAuthRequestToken
            OAuthRequestToken requestToken = new OAuthRequestToken { Token = oauth_token };

            // AccessToken này được sử dụng để xác thực yêu cầu đến API của Twitter dưới danh tính của người dùng
            OAuthAccessToken accessToken = service.GetAccessToken(requestToken, oauth_verifier);

            //sau khi xác thực -> gửi yêu cầu để xác minh danh tính
            service.AuthenticateWith(accessToken.Token, accessToken.TokenSecret);

            // Lấy thông tin người dùng từ Twitter
            TwitterUser TU = service.VerifyCredentials(new VerifyCredentialsOptions());

            // Xử lý thông tin người dùng ở đây, ví dụ:
            string screenName = TU.ScreenName;
            string fullName = TU.Name;
            

            // Kiểm tra xem thông tin từ Twitter đã tồn tại trong CSDL hay không
            var existingUser = data.ThongTinCaNhans.FirstOrDefault(u => u.Email == screenName);
            if (existingUser != null)
            {
                // Tài khoản đã tồn tại trong CSDL, đăng nhập và chuyển hướng đến trang chính
                // Kiểm tra trạng thái tài khoản
                if (existingUser.TrangThai == "Khóa")
                {
                    // Nếu tài khoản đã bị khóa, thông báo và chuyển hướng người dùng đến trang thông báo
                    TempData["ErrorMessage"] = "Tài khoản của bạn đã bị khóa.";
                    return RedirectToAction("Index", "Error");
                }
                // Tài khoản đã tồn tại trong CSDL, đăng nhập và chuyển hướng đến trang chính
                Session["TaiKhoanFB"] = existingUser;
                return RedirectToAction("Index", "SanPham");
            }
            else
            {
                User user = new User();
                var newThongTinCaNhan = new ThongTinCaNhan
                {
                    idTK = user.idTK,
                    TrangThai = "Mở",
                    HoTen = fullName,
                    Email = screenName, // Sử dụng screenName của Twitter làm email
                    IsEmailConfirmed = true,
                                        
                };
                data.ThongTinCaNhans.InsertOnSubmit(newThongTinCaNhan);
                data.SubmitChanges();
                int newIdTK = newThongTinCaNhan.idTK;

                string inputPassword = "sa"; // Mật khẩu cần mã hóa
                string hashedPassword = MaHoaPassword.GetMd5Hash(inputPassword); // Mã hóa mật khẩu
                var newTaiKhoan = new TaiKhoan
                {
                    TenDangNhap = screenName, // Sử dụng screenName của Twitter làm tên đăng nhập
                    MatKhau = hashedPassword, // Không cần mật khẩu khi sử dụng OAuth
                    LoaiTK = "User",
                    idTK = newIdTK
                };
                data.TaiKhoans.InsertOnSubmit(newTaiKhoan);
                data.SubmitChanges();
                // Lưu thông tin tài khoản vào Session
                Session["TaiKhoan"] = newTaiKhoan;
                // Chuyển hướng đến trang Index hoặc SanPham
                return RedirectToAction("Index", "SanPham");
            }
        }
        public ActionResult ThongTinTK()
        {
            if (Session["TaiKhoan"] == null && Session["TaiKhoanFB"] == null)
            {
                return RedirectToAction("DangNhap", "Home");
            }

            // Retrieve account information from the database
            var userId = Convert.ToInt32(Session["UserId"]);
            var user = data.TaiKhoans.FirstOrDefault(u => u.idTK == userId);

            
            // Map the user information to the view model
            var viewModel = new User
            {
                Name = user.ThongTinCaNhan.HoTen,
                Email = user.ThongTinCaNhan.Email,
                Diachi = user.ThongTinCaNhan.DiaChi,
                SDT = user.ThongTinCaNhan.Sdt != null ? user.ThongTinCaNhan.Sdt.ToString() : null
            };

            // Pass the view model to the view
            return View(viewModel);
        }
    }
}