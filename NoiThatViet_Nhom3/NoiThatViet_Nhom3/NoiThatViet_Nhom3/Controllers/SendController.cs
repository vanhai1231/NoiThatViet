using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Twilio;
using Twilio.Rest.Api.V2010.Account;

namespace NoiThatViet_Nhom3.Controllers
{
    public class SendController : Controller
    {
        // GET: Send
        [HandleError]
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult SendSMS()
        {
            string sId = "AC4f1bf75d13cea7a05833a8b4f4994073"; // add Account from Twilio
            string authToken = "b921b819cae580f97882c9a8eb4d18be"; //add Auth Token from Twilio
            string fromPhoneNumber = "+18788700248"; //add Twilio phone number

            TwilioClient.Init(sId, authToken);
            var message = MessageResource.Create(
                body: "Khang Lỏ",
                from: new Twilio.Types.PhoneNumber(fromPhoneNumber),
                to: new Twilio.Types.PhoneNumber("+84919575638") //add receiver's phone number
            );

            // Kiểm tra trạng thái gửi tin nhắn
            if (message.ErrorCode.HasValue)
            {
                // Nếu có lỗi, chuyển hướng đến trang thông báo thất bại
                return RedirectToAction("SendFailed");
            }
            else
            {
                // Nếu không có lỗi, chuyển hướng đến trang thông báo thành công
                return RedirectToAction("SendSuccess");
            }
        }

        // Action để hiển thị thông báo gửi thành công
        public ActionResult SendSuccess()
        {
            return View();
        }

        // Action để hiển thị thông báo gửi thất bại
        public ActionResult SendFailed()
        {
            return View();
        }

    }
}
