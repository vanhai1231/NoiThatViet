using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NoiThatViet_Nhom3.Models
{
    public class DonHangViewModel
    {
        public string MaDH { get; set; }
        public DateTime NgayLap { get; set; }
        public int TongTien { get; set; }
        public string TrangThaiDH { get; set; }
        public string TenSanPham { get; set; }
        public string ThongTinDH { get; set; }
    }
}
