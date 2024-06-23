using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NoiThatViet_Nhom3.Models
{
    public class CartItemDetail
    {
        public string id { get; set; }
        public string MaGioHang { get; set; }
        public string TenSanPham { get; set; }
        public decimal Gia { get; set; }
        public string HinhAnh { get; set; }
        public int SoLuong { get; set; }
        public decimal ThanhTien { get; set; }
    }
}