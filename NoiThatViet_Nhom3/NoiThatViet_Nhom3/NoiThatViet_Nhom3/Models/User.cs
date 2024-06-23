using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace NoiThatViet_Nhom3.Models
{
    public partial class User
    {
        public int idTK {  get; set; }
        public string loaiTK { get; set; }
        public string TaiKhoan { get; set; }
        public string Password { get; set; }
        public string confirmPassword { get; set; }
        public int confirmationCode {  get; set; }
        public string Name {  get; set; }
        public string Email { get; set; }
        public string SDT { get; set; }
        public string Diachi { get; set; }
        
    }
}