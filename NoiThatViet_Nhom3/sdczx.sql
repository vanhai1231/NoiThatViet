USE [master]
GO
/****** Object:  Database [WebCuaNhom3]    Script Date: 19/4/2024 12:31:01 AM ******/
CREATE DATABASE [WebCuaNhom3]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WebCuaNhom3', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DUNGKCR\MSSQL\DATA\WebCuaNhom3.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WebCuaNhom3_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.DUNGKCR\MSSQL\DATA\WebCuaNhom3_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [WebCuaNhom3] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WebCuaNhom3].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WebCuaNhom3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET ARITHABORT OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WebCuaNhom3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WebCuaNhom3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET  ENABLE_BROKER 
GO
ALTER DATABASE [WebCuaNhom3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WebCuaNhom3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET RECOVERY FULL 
GO
ALTER DATABASE [WebCuaNhom3] SET  MULTI_USER 
GO
ALTER DATABASE [WebCuaNhom3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WebCuaNhom3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WebCuaNhom3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WebCuaNhom3] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WebCuaNhom3] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WebCuaNhom3] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'WebCuaNhom3', N'ON'
GO
ALTER DATABASE [WebCuaNhom3] SET QUERY_STORE = OFF
GO
USE [WebCuaNhom3]
GO
/****** Object:  Table [dbo].[ChiTietDanhMucYeuThich]    Script Date: 19/4/2024 12:31:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDanhMucYeuThich](
	[MaSanPham] [nchar](10) NOT NULL,
	[WishlistID] [nchar](10) NOT NULL,
 CONSTRAINT [PK_ChiTietDanhMucYeuThich] PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC,
	[WishlistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonHang](
	[MaDH] [nchar](10) NOT NULL,
	[MaGioHang] [nchar](10) NOT NULL,
	[MaSanPham] [nchar](10) NOT NULL,
 CONSTRAINT [PK_ChiTietDonHang] PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC,
	[MaGioHang] ASC,
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietGioHang]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietGioHang](
	[MaGioHang] [nchar](10) NOT NULL,
	[MaSanPham] [nchar](10) NOT NULL,
	[SoLuong] [int] NULL,
	[ThanhTien] [int] NULL,
 CONSTRAINT [PK_ChiTietGioHang] PRIMARY KEY CLUSTERED 
(
	[MaGioHang] ASC,
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietKhuyenMai]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietKhuyenMai](
	[MaSanPham] [nchar](10) NOT NULL,
	[MaVoucher] [nchar](10) NOT NULL,
 CONSTRAINT [PK_ChiTietKhuyenMai] PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC,
	[MaVoucher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhGiaSP]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhGiaSP](
	[MaDanhGia] [nchar](10) NOT NULL,
	[DanhGia] [float] NOT NULL,
	[BinhLuan] [nvarchar](250) NOT NULL,
	[HinhAnh] [nchar](50) NOT NULL,
	[MaSanPham] [nchar](10) NOT NULL,
	[id] [int] NOT NULL,
 CONSTRAINT [PK_DanhGiaSP] PRIMARY KEY CLUSTERED 
(
	[MaDanhGia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DichVu]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DichVu](
	[id] [nchar](10) NOT NULL,
	[TenDichVu] [nvarchar](100) NOT NULL,
	[MoTaChiTiet] [nvarchar](2000) NULL,
 CONSTRAINT [PK_DichVu] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[MaDH] [nchar](10) NOT NULL,
	[NgayLap] [datetime] NOT NULL,
	[TongTien] [int] NOT NULL,
	[DiaChiGiaoHang] [nvarchar](250) NOT NULL,
	[TrangThaiDH] [nvarchar](150) NOT NULL,
	[ThongTinDH] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_DonHang] PRIMARY KEY CLUSTERED 
(
	[MaDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GioHang]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GioHang](
	[MaGioHang] [nchar](10) NOT NULL,
	[id] [int] NOT NULL,
 CONSTRAINT [PK_GioHang] PRIMARY KEY CLUSTERED 
(
	[MaGioHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HinhAnhSanPham]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HinhAnhSanPham](
	[id] [nchar](10) NOT NULL,
	[MaSanPham] [nchar](10) NOT NULL,
	[HinhAnh] [nvarchar](100) NULL,
 CONSTRAINT [PK_HinhAnhSanPham] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhuyenMai]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuyenMai](
	[MaVoucher] [nchar](10) NOT NULL,
	[TenChuongTrinh] [nvarchar](50) NOT NULL,
	[ThoiGianBatDau] [datetime] NOT NULL,
	[ThoiGianKetThuc] [datetime] NOT NULL,
	[GhiChu] [nvarchar](250) NOT NULL,
	[PhanTramGiam] [int] NOT NULL,
 CONSTRAINT [PK_KhuyenMai] PRIMARY KEY CLUSTERED 
(
	[MaVoucher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoaiSP]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiSP](
	[MaLoaiSP] [nchar](10) NOT NULL,
	[TenLoaiSP] [nvarchar](100) NOT NULL,
	[MaPhong] [nchar](10) NULL,
 CONSTRAINT [PK_LoaiSP] PRIMARY KEY CLUSTERED 
(
	[MaLoaiSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhanQuyenNhanVien]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhanQuyenNhanVien](
	[MaChucNang] [int] IDENTITY(1,1) NOT NULL,
	[TenChucNang] [nvarchar](255) NULL,
	[idNhanVien] [nchar](10) NOT NULL,
 CONSTRAINT [PK_PhanQuyenNhanVien] PRIMARY KEY CLUSTERED 
(
	[MaChucNang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phong]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phong](
	[MaPhong] [nchar](10) NOT NULL,
	[TenPhong] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Phong] PRIMARY KEY CLUSTERED 
(
	[MaPhong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[MaSanPham] [nchar](10) NOT NULL,
	[TenSanPham] [nvarchar](100) NOT NULL,
	[VatLieu] [nvarchar](200) NOT NULL,
	[KichThuoc] [nvarchar](100) NOT NULL,
	[Gia] [int] NOT NULL,
	[HinhAnh] [nvarchar](100) NOT NULL,
	[MoTa] [nvarchar](250) NOT NULL,
	[SoLuongTon] [int] NOT NULL,
	[MaLoaiSP] [nchar](10) NOT NULL,
	[MaPhong] [nchar](10) NOT NULL,
	[AnHien] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SanPham] PRIMARY KEY CLUSTERED 
(
	[MaSanPham] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TenDangNhap] [nvarchar](50) NOT NULL,
	[MatKhau] [nvarchar](50) NOT NULL,
	[LoaiTK] [nchar](20) NOT NULL,
	[idTK] [int] NOT NULL,
 CONSTRAINT [PK_TaiKhoan] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThongTinCaNhan]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThongTinCaNhan](
	[idTK] [int] IDENTITY(1,1) NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Sdt] [nchar](10) NULL,
	[DiaChi] [nvarchar](250) NULL,
	[IsEmailConfirmed] [bit] NULL,
	[ConfirmationCode] [int] NULL,
	[TrangThai] [nvarchar](10) NULL,
 CONSTRAINT [PK_ThongTinCaNhan] PRIMARY KEY CLUSTERED 
(
	[idTK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WishList]    Script Date: 19/4/2024 12:31:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WishList](
	[WishlistID] [nchar](10) NOT NULL,
	[id] [int] NOT NULL,
 CONSTRAINT [PK_WishList] PRIMARY KEY CLUSTERED 
(
	[WishlistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ChiTietDanhMucYeuThich] ([MaSanPham], [WishlistID]) VALUES (N'SP01      ', N'2024041208')
INSERT [dbo].[ChiTietDanhMucYeuThich] ([MaSanPham], [WishlistID]) VALUES (N'SP02      ', N'2024041208')
INSERT [dbo].[ChiTietDanhMucYeuThich] ([MaSanPham], [WishlistID]) VALUES (N'SP08      ', N'123456    ')
GO
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaGioHang], [MaSanPham]) VALUES (N'04mbBRVce4', N'jfaIVBM081', N'SP22      ')
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaGioHang], [MaSanPham]) VALUES (N'FV0AiZu7mI', N'jfaIVBM081', N'SP21      ')
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaGioHang], [MaSanPham]) VALUES (N'FV0AiZu7mI', N'jfaIVBM081', N'SP22      ')
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaGioHang], [MaSanPham]) VALUES (N'ITS1Gkpx7G', N'jfaIVBM081', N'SP21      ')
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaGioHang], [MaSanPham]) VALUES (N'Lv19ZiH77W', N'vbcfqKBSTc', N'SP22      ')
INSERT [dbo].[ChiTietDonHang] ([MaDH], [MaGioHang], [MaSanPham]) VALUES (N'utP38dEhVc', N'vbcfqKBSTc', N'SP22      ')
GO
INSERT [dbo].[ChiTietGioHang] ([MaGioHang], [MaSanPham], [SoLuong], [ThanhTien]) VALUES (N'NsuewEPyVY', N'SP01      ', 1, 12475950)
INSERT [dbo].[ChiTietGioHang] ([MaGioHang], [MaSanPham], [SoLuong], [ThanhTien]) VALUES (N'NsuewEPyVY', N'SP06      ', 1, 9860000)
GO
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP01      ', N'2RVO5UB8EN')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP02      ', N'2RVO5UB8EN')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP03      ', N'2RVO5UB8EN')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP04      ', N'2RVO5UB8EN')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP08      ', N'K2ERWRBYXH')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP10      ', N'K2ERWRBYXH')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP18      ', N'04646D2K6A')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP18      ', N'075OWHNQIA')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP18      ', N'2RVO5UB8EN')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP18      ', N'5KWQ6FQRMF')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP18      ', N'JGS7ZQUPE8')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP20      ', N'CTFUXGAMFE')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP21      ', N'CTFUXGAMFE')
INSERT [dbo].[ChiTietKhuyenMai] ([MaSanPham], [MaVoucher]) VALUES (N'SP22      ', N'CTFUXGAMFE')
GO
INSERT [dbo].[DichVu] ([id], [TenDichVu], [MoTaChiTiet]) VALUES (N'0         ', N'Chính Sách Bán Hàng', N'Nếu quý khách hàng không thanh toán toàn bộ giá trị đơn hàng trước khi giao hàng thì với các đơn hàng có giá trị trên 10,000,000đ; quý khách hàng vui lòng đặt cọc 1,000,000đ. Phần giá trị còn lại của đơn hàng quý khách hàng vui lòng thanh toán ngay lúc nhận hàng. Nếu quý khách hàng hủy đơn hàng, Hãng Nội Thất Việt Đi sẽ không hoàn lại 1,000,000đ đã đặt cọc. -

Trong trường hợp quý khách hàng không thanh toán ngay phần giá trị còn lại của đơn hàng khi nhận hàng, Hãng Nội Thất Việt Đi sẽ thu hồi số sản phẩm tương ứng với số tiền chưa thanh toán và quý khách hàng vui lòng thanh toán phí giao hàng cho Hãng là 300,000đ cho các khu vực miễn phí giao hàng.
 - 
Các loại phí phát sinh theo quy định của ban quản lý tại địa điểm nhận hàng liên quan đến việc giao hàng bằng xe tải, sử dụng thang máy giao hàng,… quý khách hàng vui lòng thanh toán trực tiếp với ban quản lý tại địa điểm nhận hàng của khách hàng. - 

Nếu quý khách hàng có nhu cầu xuất hóa đơn vui lòng thông báo cho Hãng Nội Thất Việt Đi ngay lúc đặt hàng. Hóa đơn đã xuất không thể chỉnh sửa hoặc hủy và xuất lại. Sau thời điểm đặt hàng 24 tiếng Hãng Nội Thất Việt Đi sẽ không nhận xuất hóa đơn. Hóa đơn xuất theo yêu cầu của quý khách hàng sẽ được gửi đến quý khách hàng trong vòng 7 ngày kể từ ngày giao hàng thành công, không tính thứ 7, chủ nhật và các ngày lễ, tết. -
 
Sau 24 tiếng kể từ khi đơn hàng được xác nhận, quý khách hàng không thể thay đổi hoặc hủy đơn hàng sau khi đơn hàng đã được đóng gói và chuyển qua bộ phận vận chuyển.

- Thời gian lưu kho cho 1 đơn hàng tối đa là 30 ngày kể từ ngày đặt hàng. Qúy khách hàng có nhu cầu lưu kho trên 7 ngày vui lòng thanh toán trước 100% giá trị đơn hàng. - Nếu quý khách hàng hủy đơn hàng, quý khách hàng vui lòng thanh toán phí lưu kho cho Hãng là 10% giá trị đơn hàng.

- Quyết định của Hãng Nội Thất Việt Đi là quyết định cuối cùng và có thể thay đổi mà không cần thông báo trước.
 - 
Chính sách này không áp dụng cho các sản phẩm trong danh mục Đồ Trang Trí.')
INSERT [dbo].[DichVu] ([id], [TenDichVu], [MoTaChiTiet]) VALUES (N'1         ', N'Chính Sách Giao Hàng & Lắp Đặt', N'Nội thất việt miễn phí giao hàng & lắp đặt tại tất cả quận huyện thuộc TP. HCM, TP. Thủ Đức, Biên Hòa và một số khu vực tại Bình Dương trong vòng 3 ngày từ 9h00 đến 16h00 từ thứ Hai đến Chủ Nhật. Đối với khu vực Hà Nội trong vòng 3 ngày từ 9h00 đến 16h00 từ thứ Hai đến thứ Bảy (không tính các ngày lễ, tết). - Qúy khách hàng vui lòng sắp xếp thời gian nhận hàng theo lịch nhận hàng đã xác nhận với Nội thất việt. Nếu quý khách hàng có việc bận đột xuất không thể nhận hàng theo lịch nhận hàng đã xác nhận, quý khách hàng vui lòng thông báo cho Nội thất việt ít nhất 24 tiếng trước khi giao hàng. Nội thất việt sẽ sắp xếp lại lịch nhận hàng tối đa là 1 lần, sau đó nếu quý khách hàng tiếp tục dời lịch nhận hàng Nội thất việt sẽ không thể giao hàng và xin phép được hủy đơn hàng của quý khách hàng. -  Nội thất việt chỉ lắp đặt các sản phẩm theo đúng tiêu chuẩn sản phẩm của Nội thất việt. Nội thất việt không lắp đặt theo yêu cầu riêng của quý khách hàng như khoan tường, gắn sản phẩm lên tường,… - Quyết định của Nội Thất Nội thất việt là quyết định cuối cùng và có thể thay đổi mà không cần thông báo trước. - Chính sách này không áp dụng cho các sản phẩm trong danh mục Đồ Trang Trí.')
INSERT [dbo].[DichVu] ([id], [TenDichVu], [MoTaChiTiet]) VALUES (N'2         ', N'Chính Sách Đổi Trả', N' Chính sách đổi hàng: trong vòng 3 ngày tính từ ngày giao hàng thành công, không tính chủ nhật và các ngày lễ, tết; quý khách hàng được đổi sản phẩm miễn phí khi đủ 2 điều kiện:

- Sản phẩm bị hư hỏng do lỗi chất liệu (không bao gồm yếu tố màu sắc do mỗi đợt sản xuất màu gỗ, vân gỗ và mắt gỗ có thể chênh lệch đôi chút vì đặc tính tự nhiên của gỗ), lỗi kỹ thuật và lỗi lắp đặt từ phía Nội thất việt.

- Đổi sang sản phẩm khác bằng giá trị hoặc có giá trị cao hơn sản phẩm đã giao. - Chính sách trả hàng: quý khách hàng chỉ được trả hàng tại thời điểm giao hàng nếu sản phẩm không đúng như thông tin đặt hàng do quý khách hàng đặt nhầm hoặc thay đổi ý kiến, nhưng phải thanh toán phí giao hàng cho MOHO là 300,000đ và chi phí lắp đặt tùy theo sản phẩm cho các khu vực miễn phí giao hàng và lắp đặt.

- Quyết định của Nội Thất Nội thất việt là quyết định cuối cùng và có thể thay đổi mà không cần thông báo trước. 

- Chính sách này không áp dụng cho các sản phẩm trong danh mục Đồ Trang Trí.')
INSERT [dbo].[DichVu] ([id], [TenDichVu], [MoTaChiTiet]) VALUES (N'3         ', N'Chính Sách Bảo Hành & Bảo Trì', N'Thời hạn bảo hành: 2 năm tính từ ngày giao hàng thành công.-  Phạm vi bảo hành:Nội thất việt bảo hành miễn phí cho các sản phẩm bị hư hỏng do lỗi chất liệu (không bao gồm yếu tố màu sắc do mỗi đợt sản xuất màu gỗ, vân gỗ và mắt gỗ có thể chênh lệch đôi chút vì đặc tính tự nhiên của gỗ), lỗi kỹ thuật và lỗi lắp đặt từ phía Nội thất việt.-Nội thất việt không bảo hành cho các trường hợp: - Thiệt hại do thiên tai, cháy nổ,… các trường hợp bất khả kháng.-Qúy khách hàng tự vận chuyển hoặc sử dụng đơn vị vận chuyển ngoài, tự lắp đặt, sửa chữa và thay đổi kết cấu ban đầu của sản phẩm.- Quý khách hàng sử dụng sản phẩm không đúng cách theo hướng dẫn sử dụng: để vật nặng vượt quá khả năng chịu lực của sản phẩm, sử dụng sản phẩm không đúng công năng như nhảy mạnh lên sản phẩm,..., để vật nóng trực tiếp lên sản phẩm, vệ sinh dùng hóa chất,…-Sản phẩm bị gãy, vỡ, trầy xước, biến dạng cơ học do lỗi của người sử dụng hoặc do các tác động ngoại lực, ngoại cảnh; hoặc sản phẩm bị ngập nước gây nở, cong vênh; sản phẩm bị tác động của hơi nước, độ ẩm cao hoặc nhiệt độ cao,...-Những hao mòn trong quá trình sử dụng của quý khách hàng theo thời gian như phai màu tự nhiên, oxy hóa của bề mặt sản phẩm, xù lông vải, xẹp lún,...')
INSERT [dbo].[DichVu] ([id], [TenDichVu], [MoTaChiTiet]) VALUES (N'4         ', N'Khách Hàng Thân Thiết', N'Đối với Nội thất việt, mỗi quý khách hàng đều là “người thân” – “homie” của Nội thất việt, người mà Nội thất việt luôn trân quý.-1. Cách tích điểm:

- 100,000đ tương đương với 1 điểm. Điểm sẽ tự động được tích khi đơn hàng đã thanh toán thành công.

- Khi tích đủ 20 điểm tương đương với 2,000,000đ; quý khách hàng sẽ trở thành Khách Hàng Thân Thiết -2. Hạng khách hàng:

- Hạng Đồng: tích lũy điểm đạt 20 điểm tương đương với 2,000,000đ.

- Hạng Bạc: tích lũy điểm đạt 50 điểm tương đương với 5,000,000đ.

- Hạng Vàng: tích lũy điểm đạt 150 điểm tương đương với 15,000,000đ.

- Hạng Kim Cương: tích lũy điểm đạt 500 điểm tương đương với 50,000,000đ.-3. Ưu đãi:

- Hạng Đồng: hạng khởi tạo, chưa có ưu đãi.

- Hạng Bạc: giảm giá 5% cho tất cả đơn hàng.

- Hạng Vàng: giảm giá 7% cho tất cả đơn hàng.

- Hạng Kim Cương: giảm giá 10% cho tất cả đơn hàng.-4. Lưu ý:

- Ưu đãi giảm giá của hạng khách hàng không áp dụng đồng thời với các chương trình khuyến mại khác.

- Điểm tích lũy sẽ bị xóa sau 365 ngày quý khách hàng không phát sinh đơn hàng mới hoặc có phát sinh đơn hàng mới nhưng không giao hàng thành công đơn hàng đó.

- Quyết định của Nội Thất việt là quyết định cuối cùng và có thể thay đổi mà không cần thông báo trước. 

- Chính sách này không áp dụng cho các sản phẩm trong danh mục Đồ Trang Trí.')
INSERT [dbo].[DichVu] ([id], [TenDichVu], [MoTaChiTiet]) VALUES (N'5         ', N'Chính Sách Đối Tác Bán Hàng', N'ĐỐI TƯỢNG - Áp dụng cho tất cả các loại hình doanh nghiệp trong mọi lĩnh vực, bao gồm nhưng không giới hạn các công ty thiết kế nội thất, thi công xây dựng, chủ cửa hàng, chủ các cơ sở dịch vụ như quán café, quán ăn,...-PHẠM VI- Áp dụng cho tất cả sản phẩm mang thương hiệu Nội thất việt; không bao gồm các sản phẩm đồ trang trí của thương hiệu khác đang được Nội thất việt phân phối
- Áp dụng cho tất cả các khu vực thuộc khu vực bán hàng và giao hàng của Nội thất việt-QUYỀN LỢI- Hưởng mức hoa hồng bán hàng: 15%
- Được nhận giấy chứng nhận là đối tác bán hàng của Nội thất việt
- Được hỗ trợ toàn bộ chính sách giao hàng, lắp đặt, bảo hành và bảo trì theo chính sách của Nội thất việt
- Được hỗ trợ các ấn phẩm truyền thông từ Nội thất việt
- Được hỗ trợ kiến thức sản phẩm và cung cấp các sản phẩm trưng bày tại cửa hàng của đối tác-TRÁCH NHIỆM- Đối tác phải đảm bảo tuân thủ chặt chẽ chính sách giá bán của Nội thất việt, bán đúng giá niêm yết theo website của Nội thất việt, không được bán phá giá sản phẩm

- Không sử dụng các sản phẩm trưng bày và các thông tin của sản phẩm được Nội thất việt cung cấp sai mục đích

- Đối tác có trách nhiệm giữ gìn và đảm bảo chất lượng của sản phẩm trưng bày và ấn phẩm truyền thông do Nội thất việt cung cấp-LƯU Ý - Mức hoa hồng bán hàng 15% không được áp dụng đồng thời với các chương trình khuyến mại khác

- Mức hoa hồng bán hàng 15% được tính dựa trên giá trị đơn hàng đã giao thành công và khách hàng đã thanh toán đầy đủ giá trị đơn hàng

- Mức hoa hồng bán hàng 15% được tính dựa vào giá trị đơn hàng không bao gồm thuế VAT')
GO
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [DiaChiGiaoHang], [TrangThaiDH], [ThongTinDH]) VALUES (N'04mbBRVce4', CAST(N'2024-04-18T20:34:35.533' AS DateTime), 921188, N'Thủ Đức, tp.HCM', N'Đã Thanh Toán', N'Đã Giao')
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [DiaChiGiaoHang], [TrangThaiDH], [ThongTinDH]) VALUES (N'FV0AiZu7mI', CAST(N'2024-04-18T21:02:30.823' AS DateTime), 2721188, N'Thủ Đức, tp.HCM', N'Đã Thanh Toán', N'Đã Giao')
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [DiaChiGiaoHang], [TrangThaiDH], [ThongTinDH]) VALUES (N'ITS1Gkpx7G', CAST(N'2024-04-18T20:53:22.277' AS DateTime), 1800000, N'Thủ Đức, tp.HCM', N'Đã Thanh Toán', N'Đã Giao')
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [DiaChiGiaoHang], [TrangThaiDH], [ThongTinDH]) VALUES (N'Lv19ZiH77W', CAST(N'2024-04-18T22:45:27.840' AS DateTime), 921188, N'VietNam,Phuong nay, duong no', N'Đã Thanh Toán', N'Đang Giao')
INSERT [dbo].[DonHang] ([MaDH], [NgayLap], [TongTien], [DiaChiGiaoHang], [TrangThaiDH], [ThongTinDH]) VALUES (N'utP38dEhVc', CAST(N'2024-04-18T22:58:23.023' AS DateTime), 921188, N'VietNam,Phuong nay, duong no', N'Đã thanh toán', N'Đang Chuẩn Bị')
GO
INSERT [dbo].[GioHang] ([MaGioHang], [id]) VALUES (N'bOKbiDDNqO', 7)
INSERT [dbo].[GioHang] ([MaGioHang], [id]) VALUES (N'jfaIVBM081', 6)
INSERT [dbo].[GioHang] ([MaGioHang], [id]) VALUES (N'NsuewEPyVY', 8)
INSERT [dbo].[GioHang] ([MaGioHang], [id]) VALUES (N'vbcfqKBSTc', 4)
GO
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'01        ', N'SP01      ', N'/Content/images/hung-king-1.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'02        ', N'SP02      ', N'/Content/images/Sofa-Bolero-3-cho-don-M3-vai-MB-40-15-1.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'03        ', N'SP02      ', N'/Content/images/Sofa-Bolero-3-cho-don-M3-vai-MB-40-15-2.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'04        ', N'SP02      ', N'/Content/images/Sofa-Bolero-3-cho-don-M3-vai-MB-40-15-3.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'05        ', N'SP03      ', N'/Content/images/Sofa-Bolero-3-cho-don-M3-vai-MB-40-15-3.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'06        ', N'SP04      ', N'/Content/images/Sofa-Bolero-3-cho-don-M3-vai-MB-40-15-3.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'07        ', N'SP05      ', N'/Content/images/phong-an-coastal-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'08        ', N'SP06      ', N'/Content/images/phong-an-coastal-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'09        ', N'SP07      ', N'/Content/images/Armchair-co-tay-Maxine-da-AB1085-2.png')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'10        ', N'SP08      ', N'/Content/images/armchair-hung-king-2.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'11        ', N'SP08      ', N'/Content/images/armchair-hung-king-3.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'12        ', N'SP08      ', N'/Content/images/armchair-hung-king-4.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'13        ', N'SP10      ', N'/Content/images/don-Atollo-vai-venice-sand-1.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'14        ', N'SP11      ', N'/Content/images/Ghe-dai-Deria-1.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'15        ', N'SP11      ', N'/Content/images/Ghe-dai-Deria-2.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'16        ', N'SP12      ', N'/Content/images/ban-nuoc-dura-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'17        ', N'SP12      ', N'/Content/images/ban-nuoc-dura-2-600x400')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'18        ', N'SP13      ', N'/Content/images/ban-nuoc-hung-king-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'19        ', N'SP13      ', N'/Content/images/hung-king-2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'20        ', N'SP14      ', N'/Content/images/BAN-NUOC-COASTAL-M2-2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'21        ', N'SP15      ', N'/Content/images/CONSOLE-BARBIER-WALNUT-260014Z-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'22        ', N'SP15      ', N'/Content/images/CONSOLE-BARBIER-WALNUT-260014Z-2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'23        ', N'SP16      ', N'/Content/images/ban-console-hung-king-2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'24        ', N'SP17      ', N'/Content/images/hung-king-2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'25        ', N'SP18      ', N'/Content/images/tu-tv-rudo-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'26        ', N'SP18      ', N'/Content/images/tu-tv-rudo-2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'27        ', N'SP19      ', N'/Content/images/ban-an-maxine-9-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'28        ', N'SP20      ', N'/Content/images/Ke-Coastal-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'29        ', N'SP20      ', N'/Content/images/phong-an-coastal-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'30        ', N'SP21      ', N'/Content/images/Tranh-Bong-Sung-1-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'31        ', N'SP22      ', N'/Content/images/Tranh-Cam-tu-cau-1-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'32        ', N'SP23      ', N'/Content/images/phong-an-coastal-1-600x900.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'33        ', N'SP23      ', N'/Content/images/phong-an-coastal-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'34        ', N'SP24      ', N'/Content/images/GHE-HUDSON-BEIGE-80006K-3105860-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'35        ', N'SP24      ', N'/Content/images/GHE-HUDSON-BEIGE-80006K-3105860-2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'36        ', N'SP25      ', N'/Content/images/ghe-bar-3-101653-3-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'37        ', N'SP26      ', N'/Content/images/ghe-boheme2-4.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'38        ', N'SP26      ', N'/Content/images/ghe-bar-boheme-13-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'39        ', N'SP27      ', N'/Content/images/Tu-bep-cao-AA-Gallery-Q9-01-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'40        ', N'SP28      ', N'/Content/images/8._elita_2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'41        ', N'SP29      ', N'/Content/images/Tu-ly-cao-Lake-CS6076-4-mau-smoke-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'42        ', N'SP30      ', N'/Content/images/1000-san-pham-nha-xinh58-3-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'43        ', N'SP30      ', N'/Content/images/tu-ly-jazz-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'44        ', N'SP31      ', N'/Content/images/BST-Coastal-4-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'45        ', N'SP32      ', N'/Content/images/phong-ngu-giuong-hoc-keo-iris-4-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'46        ', N'SP33      ', N'/Content/images/Ban-dau-giuong-Madame-mau-P67W-2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'47        ', N'SP34      ', N'/Content/images/BAN-DAU-GIUONG-CABO-PMA532058-F1-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'48        ', N'SP34      ', N'/Content/images/ban-dau-giuong-cabo-pma532058-f1-2-600x387.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'49        ', N'SP35      ', N'/Content/images/CONSOLE-MIRROR-CURVE-ART-84839K-2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'50        ', N'SP35      ', N'/Content/images/CONSOLE-MIRROR-CURVE-ART-84839K-3-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'51        ', N'SP36      ', N'/Content/images/ban-trang-diem-may-5-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'52        ', N'SP36      ', N'/Content/images/ban-trang-diem-may-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'53        ', N'SP37      ', N'/Content/images/Tu-ao-Acrylic-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'54        ', N'SP37      ', N'/Content/images/Tu-ao-Acrylic-2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'55        ', N'SP38      ', N'/Content/images/3_91000_2-600x401.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'56        ', N'SP40      ', N'/Content/images/tu_am_tuong_kiwi_b_l.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'57        ', N'SP41      ', N'/Content/images/Tu-hoc-keo-Osaka-3101899-2-600x354.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'58        ', N'SP41      ', N'/Content/images/Tu-hoc-keo-Osaka-3101899-1-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'59        ', N'SP42      ', N'/Content/images/TU-HOC-KEO-YORKCERAMIC-2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'60        ', N'SP42      ', N'/Content/images/TU-HOC-KEO-YORKCERAMIC-4-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'61        ', N'SP43      ', N'/Content/images/nem-luxury-golden-black-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'62        ', N'SP43      ', N'/Content/images/nem_eco_ruby-_col_14-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'63        ', N'SP44      ', N'/Content/images/nem-sen-viet-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'64        ', N'SP44      ', N'/Content/images/sen-viet-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'65        ', N'SP45      ', N'/Content/images/Ban-lam-viec-Coastal-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'66        ', N'SP45      ', N'/Content/images/Ban-lam-viec-Coastal-2-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'67        ', N'SP45      ', N'/Content/images/BST-Coastal-4-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'68        ', N'SP46      ', N'/Content/images/3_91313_12-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'69        ', N'SP46      ', N'/Content/images/ban-lam-viec-skagen.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'70        ', N'SP47      ', N'/Content/images/Ghe-Lam-Viec-Check-Out-3105575-1-600x354.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'71        ', N'SP47      ', N'/Content/images/Ghe-Lam-Viec-Check-Out-3105575-3-600x354.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'72        ', N'SP48      ', N'/Content/images/ARMCHAIR-XOAY-ALBERT-KUIP-TAUPE-120233Z-1-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'73        ', N'SP48      ', N'/Content/images/ARMCHAIR-XOAY-ALBERT-KUIP-TAUPE-120233Z-4-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'74        ', N'SP49      ', N'/Content/images/nha-xinh-ke-sach-chio-hinh_lifestyle.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'75        ', N'SP50      ', N'/Content/images/KE-SACH-LINE-MAU-BRONZE-1-600x387.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'76        ', N'SP50      ', N'/Content/images/KE-SACH-LINE-MAU-BRONZE-2-600x387.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'77        ', N'SP51      ', N'/Content/images/ban-ngoai-troi-hien-dai-fermob-sixties-trang-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'78        ', N'SP52      ', N'/Content/images/ghe-ngoai-troi-fermob-opera-1.png')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'79        ', N'SP53      ', N'/Content/images/ghe-ngoai-troi-hien-dai-fermob-facto-xanh-600x400.png')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'80        ', N'SP54      ', N'/Content/images/ghe-ngoai-troi-fermob-plein-air-ko-tay-600x400.png')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'81        ', N'SP55      ', N'/Content/images/Ke-giay-Caruso-5-Doors-3105870-6-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'82        ', N'SP55      ', N'/Content/images/Ke-giay-Caruso-5-Doors-3105870-1-600x400.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'83        ', N'SP56      ', N'/Content/images/TU-GIAY-CARUSO-DBLE-BRZ-75X77-86217K-2-600x387.jpg')
INSERT [dbo].[HinhAnhSanPham] ([id], [MaSanPham], [HinhAnh]) VALUES (N'84        ', N'SP56      ', N'/Content/images/TU-GIAY-CARUSO-DBLE-BRZ-75X77-86217K-3-600x387.jpg')
GO
INSERT [dbo].[KhuyenMai] ([MaVoucher], [TenChuongTrinh], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [PhanTramGiam]) VALUES (N'04646D2K6A', N'123', CAST(N'2024-04-20T00:00:00.000' AS DateTime), CAST(N'2024-04-25T00:00:00.000' AS DateTime), N'1231', 12)
INSERT [dbo].[KhuyenMai] ([MaVoucher], [TenChuongTrinh], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [PhanTramGiam]) VALUES (N'075OWHNQIA', N'123', CAST(N'2024-04-20T00:00:00.000' AS DateTime), CAST(N'2024-04-25T00:00:00.000' AS DateTime), N'1231', 12)
INSERT [dbo].[KhuyenMai] ([MaVoucher], [TenChuongTrinh], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [PhanTramGiam]) VALUES (N'2RVO5UB8EN', N'Quốc tế lao động 1/5', CAST(N'2024-05-01T00:00:00.000' AS DateTime), CAST(N'2024-05-02T00:00:00.000' AS DateTime), N'Giảm các mặt hàng nội thất', 15)
INSERT [dbo].[KhuyenMai] ([MaVoucher], [TenChuongTrinh], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [PhanTramGiam]) VALUES (N'5KWQ6FQRMF', N'123', CAST(N'2024-04-20T00:00:00.000' AS DateTime), CAST(N'2024-04-25T00:00:00.000' AS DateTime), N'1231', 12)
INSERT [dbo].[KhuyenMai] ([MaVoucher], [TenChuongTrinh], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [PhanTramGiam]) VALUES (N'CTFUXGAMFE', N'HaiChicken', CAST(N'2024-04-21T00:00:00.000' AS DateTime), CAST(N'2024-04-24T00:00:00.000' AS DateTime), N'123123123123', 21)
INSERT [dbo].[KhuyenMai] ([MaVoucher], [TenChuongTrinh], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [PhanTramGiam]) VALUES (N'JGS7ZQUPE8', N'123', CAST(N'2024-04-20T00:00:00.000' AS DateTime), CAST(N'2024-04-25T00:00:00.000' AS DateTime), N'1231', 12)
INSERT [dbo].[KhuyenMai] ([MaVoucher], [TenChuongTrinh], [ThoiGianBatDau], [ThoiGianKetThuc], [GhiChu], [PhanTramGiam]) VALUES (N'K2ERWRBYXH', N'Kỷ niệm 30/04', CAST(N'2024-04-18T00:00:00.000' AS DateTime), CAST(N'2024-04-19T00:00:00.000' AS DateTime), N'không', 10)
GO
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'01        ', N'Sofa', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'02        ', N'Bàn ăn', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'03        ', N'Ghế bành', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'04        ', N'Ghế dài&đôn', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'05        ', N'Bàn nước', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'06        ', N'Bàn console', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'07        ', N'Tủ tivi', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'08        ', N'Kệ trưng bày', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'09        ', N'Tranh', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'10        ', N'Ghế ăn', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'11        ', N'Ghế bar', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'12        ', N'Tủ bếp', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'13        ', N'Tủ ly', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'14        ', N'Giường ngủ', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'15        ', N'Bàn đầu giường', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'16        ', N'Bàn trang điểm', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'17        ', N'Tủ áo', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'18        ', N'Tủ âm tường', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'19        ', N'Tủ hộc kéo', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'20        ', N'Nệm', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'21        ', N'Bàn làm việc', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'22        ', N'Ghế làm việc ', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'23        ', N'Kệ sách', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'24        ', N'Bàn ngoài trời ', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'25        ', N'Ghế ngoài trời', NULL)
INSERT [dbo].[LoaiSP] ([MaLoaiSP], [TenLoaiSP], [MaPhong]) VALUES (N'26        ', N'Tủ giày', NULL)
GO
SET IDENTITY_INSERT [dbo].[PhanQuyenNhanVien] ON 

INSERT [dbo].[PhanQuyenNhanVien] ([MaChucNang], [TenChucNang], [idNhanVien]) VALUES (1, N'Thêm Mới', N'4         ')
INSERT [dbo].[PhanQuyenNhanVien] ([MaChucNang], [TenChucNang], [idNhanVien]) VALUES (2, N'Danh Sách', N'4         ')
INSERT [dbo].[PhanQuyenNhanVien] ([MaChucNang], [TenChucNang], [idNhanVien]) VALUES (3, N'Sửa', N'4         ')
SET IDENTITY_INSERT [dbo].[PhanQuyenNhanVien] OFF
GO
INSERT [dbo].[Phong] ([MaPhong], [TenPhong]) VALUES (N'P01       ', N'Phòng khách')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong]) VALUES (N'P02       ', N'Phòng ăn')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong]) VALUES (N'P03       ', N'Phòng ngủ')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong]) VALUES (N'P04       ', N'Phòng làm việc')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong]) VALUES (N'P05       ', N'Phòng bếp')
INSERT [dbo].[Phong] ([MaPhong], [TenPhong]) VALUES (N'P06       ', N'Ngoại thất')
GO
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP01      ', N'Sofa 3 chỗ Hung King', N'Gỗ Beech tự nhiên, mây, bọc vải', N'D1885 - R745 - C755 mm', 12475950, N'/Content/images/sofa-3-cho-hung-king-300x200.jpg', N'trang trí phòng khách', 50, N'01        ', N'P01       ', N'Ẩn')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP02      ', N'Sofa Bolero 3 chỗ + Đôn M3 vải MB 40-15', N'Chân kim loại sơn đen, bọc vải cao cấp, bao gồm sofa băng dài & đôn', N'Sofa: D2250 - R900 - C790, Đôn: D720 - R720 - C420', 22015000, N'/Content/images/Sofa-Bolero-3-cho-Don-M3-vai-MB-40-15.jpg', N'trang trí phòng khách', 50, N'01        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP03      ', N'Sofa Bolero 3 chỗ + Đôn M3 vải xám MB4010', N'Chân kim loại sơn đen, bọc vải cao cấp, bao gồm sofa băng dài & đôn', N'Sofa: D2250 - R900 - C790, Đôn: D720 - R720 - C420', 22000000, N'/Content/images/Sofa-Bolero-3-cho-Don-M3-vai-xam-MB4010.jpg', N'trang trí phòng khách', 56, N'01        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP04      ', N'Sofa Bolero 3 chỗ + Đôn M3 vải xanh MB408', N'Chân kim loại sơn đen, bọc vải cao cấp, bao gồm sofa băng dài & đôn', N'Sofa: D2250 - R900 - C790, Đôn: D720 - R720 - C420', 22000000, N'/Content/images/Sofa-Bolero-3-cho-Don-M3-vai-xanh-MB408.jpg', N'trang trí phòng khách', 67, N'01        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP05      ', N'Bàn ăn 6 chỗ Coastal', N'Gỗ Ash - MDF veneer Ash', N'D1600 - R800 - C755 mm', 8597750, N'/Content/images/Ban-an-6-cho-Coastal.jpg', N'trang trí phòng bếp', 45, N'02        ', N'P02       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP06      ', N'Bàn ăn 8 chỗ Coastal', N'Gỗ Ash - MDF veneer Ash', N'D2000 - R1000 - C750 mm', 9860000, N'/Content/images/ban-an-8-cho-rudo.jpg', N'trang trí phòng bếp', 77, N'02        ', N'P02       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP07      ', N'Armchair có tay Maxine da AB1085', N'Gỗ tràm - Da bò tự nhiên cao cấp', N'D650 - R710 - C800 mm', 11490000, N'/Content/images/Armchair-co-tay-Maxine-da-AB1085-1.jpg', N'Phòng khách', 20, N'03        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP08      ', N'Armchair Hung King', N'Gỗ Beech tự nhiên, mây, bọc vải', N'D700 - R745 - C755 mm', 10000000, N'/Content/images/armchair-hung-king-1.jpg', N'Phòng khách', 23, N'03        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP09      ', N'Armchair Porto bọc vải VACT11303', N'Inox màu gold - Nệm bọc Vải cao cấp', N'D800 - R670 - C690 mm', 11280000, N'/Content/images/armchair-porto-boc-vai-vact11303.jpg', N'Phòng khách', 15, N'03        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP10      ', N'Đôn Atollo vải venice sand', N'Chân kim loại sơn đen, bọc vải cao cấp', N'Ø430 - C430 mm', 9000000, N'/Content/images/don-Atollo-vai-venice-sand.jpg', N'Phòng khách', 29, N'04        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP11      ', N'Ghế dài Deria', N'Chân kim loại - nệm bọc vải', N'D1100 - R350 - C420 mm', 9500000, N'/Content/images/Ghe-dai-Deria.jpg', N'Phòng khách', 10, N'04        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP12      ', N'Bàn nước Dura', N'Gỗ Oak - kính', N'D1100 - R620 - C370 mm', 11200000, N'/Content/images/ban-nuoc-dura-600x400.jpg', N'Phòng khách', 20, N'05        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP13      ', N'Bàn nước Hung King', N'Gỗ Beech, MDF Veneer beech', N'D1150 - R650 - C408 mm', 14000000, N'/Content/images/ban-nuoc-hung-king-600x400.jpg', N'Phòng khách', 17, N'05        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP14      ', N'Bàn nước Coastal M2', N'Gỗ Ash - MDF veneer Ash', N'D1100 - R600 - C380 mm', 5220063, N'/Content/images/BAN-NUOC-COASTAL-M2-600x400.jpg', N'Phòng khách', 18, N'05        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP15      ', N'Bàn Console Barbier Walnut', N'MDF veneer Walnut - gỗ cao su', N'D1200 - R350 - C740 mm', 15450000, N'/Content/images/CONSOLE-BARBIER-WALNUT-260014Z-600x400.jpg', N'Phòng khách', 22, N'06        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP16      ', N'Bàn Console Hung King', N'Gỗ Beech, MDF Veneer beech', N'D1400 - R420 - C800 mm', 13151000, N'/Content/images/ban-console-hung-king-600x400.jpg', N'Phòng khách', 25, N'06        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP17      ', N'Tủ Tivi Hung King', N'Gỗ Beech, MDF Veneer beech', N'D2000 - R550 - C562 mm', 21000000, N'/Content/images/tu-ti-vi-hung-king-600x400.jpg', N'Phòng khách', 21, N'07        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP18      ', N'Tủ TV Rudo', N'Gỗ White ash, MDF veneer White Ash, chân kim loại sơn tĩnh điện', N'D1800 - R420 - C560 mm', 13600000, N'/Content/images/tu-tv-rudo-600x400.jpg', N'Phòng khách', 34, N'07        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP19      ', N'Kệ sách Rap', N'Chân inox màu gold -gỗ ACACIA (tràm ) + mdf veneer tràm', N'D1200 - R400 - C1800 mm', 6500000, N'/Content/images/ke-sach-rap-1-101600-600x400.jpg', N'Phòng khách', 37, N'08        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP20      ', N'Kệ Coastal', N'MDF veneer Ash - khung sắt', N'D960 - R455 - C1820 mm', 13151000, N'/Content/images/Ke-Coastal-600x400.jpg', N'Phòng khách', 34, N'08        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP21      ', N'Tranh bông súng', N'Hàn Quốc - khung gỗ tự nhiên - mica và kính', N'D400 - R400 - C50 (mm)', 1800000, N'/Content/images/Tranh-Bong-Sung-2-600x400.jpg', N'Đồ trang trí', 38, N'09        ', N'P02       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP22      ', N'Tranh Cẩm tú cầu', N'Hàn Quốc - khung gỗ tự nhiên - mica và kính', N'D400 - R300 - C50 (mm)', 921188, N'/Content/images/Tranh-Cam-tu-cau-2-600x400.jpg', N'Đồ trang trí', 43, N'09        ', N'P02       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP23      ', N'Ghế ăn Coastal KD1085-18
', N'Gỗ Ash - nệm bọc vải', N'D435 - R525 - C840 mm', 4000000, N'/Content/images/Ghe-an-Coastal-xanh-600x400.jpg', N'Phòng bếp', 41, N'10        ', N'P02       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP24      ', N'Ghế Hudson Beige 80006K', N'Chân kim loại sơn 2 màu đen, gold - nệm bọc vải', N'D490 - R540 - C840 mm', 7310000, N'/Content/images/GHE-HUDSON-BEIGE-80006K-3105860-600x400.jpg', N'Phòng bếp', 13, N'10        ', N'P02       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP25      ', N'Ghế bar Jenny – 96364J', N'Kim loại không rỉ, da công nghiệp', N'D470- C860 mm', 7700000, N'/Content/images/ghe-bar-3-101653-600x400.jpg', N'Phòng bếp', 15, N'11        ', N'P02       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP26      ', N'Ghế Bar Boheme da taupe', N'Khung kim loại - bọc da tổng hợp cao cấp', N'D400 - R400 - C900 mm', 7800000, N'/Content/images/ghe-bar-boheme-da-taupe-b-l.jpg', N'Phòng bếp', 33, N'11        ', N'P02       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP27      ', N'Tủ bếp cao AA Gallery', N'Laminate - gỗ MDF - Kính', N'D4400 - R600 - C2400mm', 130800000, N'/Content/images/Tu-bep-cao-AA-Gallery-Q9-01-600x400.jpg', N'Phòng bếp', 5, N'12        ', N'P05       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP28      ', N'Tủ bếp Elita', N'Thùng MFC – Cánh Acrylic và sơn bóng', N'Tùy theo không gian nhà bếp thực tế', 150000000, N'/Content/images/4._elita-600x400.jpg', N'Phòng bếp', 3, N'12        ', N'P05       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP29      ', N'Tủ ly cao Lake CS6076-4 màu smoke', N'Chân kim loại sơn đen, tủ MDF Veneer màu smoke, mặt trên tủ ceramic màu bronze', N'D900 - R480 - C1360', 152900000, N'/Content/images/Tu-ly-cao-Lake-CS6076-4-mau-smoke-2-600x400.jpg', N'Phòng bếp', 20, N'13        ', N'P02       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP30      ', N'Tủ Ly Jazz', N'Mặt gỗ sồi tự nhiên ghép - chân sắt sơn tĩnh điện', N'D1600 - R450 - C810mm', 20000000, N'/Content/images/1000-san-pham-nha-xinh58-600x400.jpg', N'Phòng bếp', 17, N'13        ', N'P02       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP31      ', N'Giường Coastal KD1058-18 1m6', N'Khung gỗ Ash - nệm bọc vải', N'D2000 - R1600 - C1080 mm', 24500000, N'/Content/images/Giuong-Coastal-1m6-xanh-600x400.jpg', N'Phòng ngủ', 29, N'14        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP32      ', N'Giường Hộc Kéo Iris 1M6 Vải Belfast 41', N'Khung gỗ MFC, bọc vải - 4 hộc kéo', N'D2000- R1600- C1112 mm', 13000000, N'/Content/images/giuong_iris_1m6_stone3.jpg', N'Phòng ngủ', 14, N'14        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP33      ', N'Bàn đầu giường Madame màu P67W', N'Chân kim loại màu đen nhấn gold, mặt bàn MDF veneer', N'D550 - R460 - C830', 35645000, N'/Content/images/Ban-dau-giuong-Madame-mau-P67W-1-600x400.jpg', N'Phòng ngủ', 60, N'15        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP34      ', N'Bàn đầu giường Cabo PMA532058 F1', N'MDF màu walnut, chân kim loại sơn đen, mặt ngoài hộc kéo màu xanh Olive', N'D500 - R400 - C550 mm', 7735000, N'/Content/images/BAN-DAU-GIUONG-CABO-PMA532058-F1-600x400.jpg', N'Phòng ngủ', 55, N'15        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP35      ', N'Bàn phấn Mirror Curve Art 84839K
', N'Kim loại mạ màu gold-kính thủy', N'D700-R320-C1530 mm', 15650000, N'/Content/images/CONSOLE-MIRROR-CURVE-ART-84839K-1-600x400.jpg', N'Phòng ngủ', 36, N'16        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP36      ', N'Bàn trang điểm Mây', N'Gỗ Acacia (Tràm)- Mây tự nhiên- Chân bọc inox mạ gold', N'Bàn trang điểm Mây', 17100000, N'/Content/images/100582_1000-600x400.jpg', N'Phòng ngủ', 54, N'16        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP37      ', N'Tủ áo Acrylic', N'Thùng MFC chống ẩm - mặt MDF Acrylic Parc50', N'D1600 - R600 - C2000 mm', 27500000, N'/Content/images/Tu-ao-Acrylic-600x400.jpg', N'Phòng ngủ', 20, N'17        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP38      ', N'Tủ áo Maxine', N'Khung gỗ Okumi, MDF veneer recon Walnut, chân inox mạ PVD màu gold', N'D1200 - R600 - C2100mm', 34000000, N'/Content/images/3_91000_1-600x401.jpg', N'Phòng ngủ', 35, N'17        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP39      ', N'Tủ âm Canon', N'Gỗ óc chó (Walnut), gỗ ép và ván lạng Sồi nhân tạo (Oak recon)', N'D3000/2700 - R600 - C2400', 12000000, N'/Content/images/tu_am_tuong_canon_l.jpg', N'Phòng ngủ', 10, N'18        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP40      ', N'Tủ âm Kiwi', N'Gỗ óc chó (Walnut), gỗ ép và ván lạng óc chó nhân tạo (Walnut recon)', N'D2275/4400/2275 - R600 - C2400', 18000000, N'/Content/images/tu_am_tuong_kiwi_a_l.jpg', N'Phòng ngủ', 14, N'18        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP41      ', N'Tủ hộc kéo Osaka', N'Gỗ Oak - MDF veneer Oak - Inox 304 màu gold', N'D900 - R500 - C1100 mm', 1900000, N'/Content/images/Tu-hoc-keo-Osaka-3101899-1-600x400.jpg', N'Phòng ngủ', 6, N'19        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP42      ', N'Tủ Hộc Kéo York Ceramic', N'Chân kim loại sơn -khung gỗ sơn trắng -mặt Ceramic P9C', N'D1235-R470-C780 mm', 7780000, N'/Content/images/TU-HOC-KEO-YORKCERAMIC-3-600x400.jpg', N'Phòng ngủ', 30, N'19        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP43      ', N'Nệm Luxury Golden Black 1m8', N'Khung lò xo túi mousse, vải', N'D2000 - R1800 - C280', 4500000, N'/Content/images/nem-luxury-golden-black4-600x400.jpg', N'Phòng ngủ', 10, N'20        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP44      ', N'Nệm Sen Việt 1m4
', N'Lò xo túi độc lập cao 25cm Mousse đàn hồi tỷ trọng cao Thiết kế 3 viền tinh tế, sang trọng', N'D2000 - R1400 - C250', 8500000, N'/Content/images/nem-lo-xo-tui-senviet-1m4-600x400.jpg', N'Phòng ngủ', 32, N'20        ', N'P03       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP45      ', N'Bàn làm việc Coastal', N'Gỗ Ash - MDF veneer Ash', N'D1300 - R520 - C730 mm', 1230000, N'/Content/images/Ban-lam-viec-Coastal-600x400.jpg', N'Phòng làm việc', 51, N'21        ', N'P04       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP46      ', N'Bàn làm việc Skagen', N'MDF Chống ẩm, Veneer walnut, Chân gỗ Walnut', N'D1200 - R600 - C750 mm', 1100000, N'/Content/images/3_91313_2-600x399.jpg', N'Phòng làm việc', 48, N'21        ', N'P04       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP47      ', N'Ghế làm việc check out 83959K
', N'Chân kim loại có bánh xe xoay, lưng mdf veneer - bọc da công nghiệp', N'D750 - R750 - C1180 mm', 2000000, N'/Content/images/Ghe-Lam-Viec-Check-Out-3105575-600x354.jpg', N'Phòng làm việc', 25, N'22        ', N'P04       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP48      ', N'Armchair xoay Albert Kuip Taupe
', N'chân nhôm - mặt ngồi bằng nhựa', N'D470 - R590 - C840 mm', 1200000, N'/Content/images/ARMCHAIR-XOAY-ALBERT-KUIP-TAUPE-120233Z-8-600x400.jpg', N'Phòng làm việc', 21, N'22        ', N'P04       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP49      ', N'Kệ Sách Artigo', N'Gỗ Sồi kết hợp MDF veneer', N'D850 - R380 - C1980mm', 20000000, N'/Content/images/nha-xinh-ke-sach-cico.jpg', N'Phòng làm việc', 16, N'23        ', N'P04       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP50      ', N'Kệ Sách Line màu bronze', N'Kim loại màu Bronze - kệ chuẩn 3 đợt', N'D300-R300-C1800 mm', 22000000, N'/Content/images/KE-SACH-LINE-MAU-BRONZE-600x387.jpg', N'Phòng làm việc', 33, N'23        ', N'P04       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP51      ', N'Bàn ngoài trời Fermob Sixties', N'Thép sơn tĩnh điện công nghệ cao', N'D755 - R555 - C410', 7000000, N'/Content/images/Ban-ngoai-troi-Fermob-Sixties-600x400.jpg', N'Ngoại thất', 14, N'24        ', N'P06       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP52      ', N'Bàn ngoài trời Fermob Opera Poppy', N'Thép sơn tĩnh điện công nghệ cao', N'Ø670 - C740', 3800000, N'/Content/images/Ban-ngoai-troi-Fermob-Opera-Poppy-600x400.jpg', N'Ngoại thất', 22, N'24        ', N'P06       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP53      ', N'Ghế ngoài trời Fermob Facto Rosemary', N'Thép sơn tĩnh điện', N'D360 - R500 -C830 mm', 3200000, N'/Content/images/ghe-ngoai-troi-Fermob-Facto-Rosemary-600x387.jpg', N'Ngoại thất', 11, N'25        ', N'P06       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP54      ', N'Ghế ngoài trời Fermob Plein air nutmeg', N'Thép sơn tĩnh điện', N'D500 - R400 - C850
', 3500000, N'/Content/images/ghe-ngoai-troi-Fermob-Plein-air-nutmeg-600x387.jpg', N'Ngoại thất', 34, N'25        ', N'P06       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP55      ', N'Kệ giày Caruso 5 Doors', N'Kim loại', N'D500 - R140 - C1700 mm', 8260000, N'/Content/images/Ke-giay-Caruso-5-Doors-3105870-600x400.jpg', N'Phòng khách', 26, N'26        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP56      ', N'Tủ giày Caruso 2 ngăn nâu75X77 86217K', N'Kim loại', N'D750 - R220 - C770 mm
', 11400000, N'/Content/images/TU-GIAY-CARUSO-DBLE-BRZ-75X77-86217K-600x387.jpg', N'Phòng khách', 21, N'26        ', N'P01       ', N'Hiện')
INSERT [dbo].[SanPham] ([MaSanPham], [TenSanPham], [VatLieu], [KichThuoc], [Gia], [HinhAnh], [MoTa], [SoLuongTon], [MaLoaiSP], [MaPhong], [AnHien]) VALUES (N'SP57      ', N'Set Tủ Quần Áo Gỗ MOHO HOBRO 301 4 Cánh', N'Gỗ MFC/ MDF phủ Melamine chuẩn CARB-P2', N'Dài 200cm x Rộng 60cm x Cao 210cm', 12990000, N'/Content/images/tu_quan_ao_hobro_4_canh_2m_.jpg', N'Sản phẩm sử dụng chất liệu gỗ công nghiệp (PB, MDF) đạt chuẩn CARB-P2 an toàn tuyệt đối cho người sức khỏe người dùng và đạt chứng nhận FSC bảo vệ và phát triển rừng.', 20, N'17        ', N'P03       ', N'Hiện')
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([id], [TenDangNhap], [MatKhau], [LoaiTK], [idTK]) VALUES (1, N'Hai                 ', N'202cb962ac59075b964b07152d234b70', N'admin               ', 1)
INSERT [dbo].[TaiKhoan] ([id], [TenDangNhap], [MatKhau], [LoaiTK], [idTK]) VALUES (4, N'Dungkcr123', N'202cb962ac59075b964b07152d234b70', N'User                ', 4)
INSERT [dbo].[TaiKhoan] ([id], [TenDangNhap], [MatKhau], [LoaiTK], [idTK]) VALUES (6, N'HaiAdmin', N'3552966e6fd8bd07bd78c8b08016d72e', N'User                ', 6)
INSERT [dbo].[TaiKhoan] ([id], [TenDangNhap], [MatKhau], [LoaiTK], [idTK]) VALUES (7, N'Haiha', N'9dedb66baf88d2771ac089e695fce958', N'User                ', 7)
INSERT [dbo].[TaiKhoan] ([id], [TenDangNhap], [MatKhau], [LoaiTK], [idTK]) VALUES (8, N'nguyenhuukhai22052003@gmail.com', N'202cb962ac59075b964b07152d234b70', N'User                ', 8)
INSERT [dbo].[TaiKhoan] ([id], [TenDangNhap], [MatKhau], [LoaiTK], [idTK]) VALUES (9, N'Dung', N'202cb962ac59075b964b07152d234b70', N'Nhân Viên           ', 9)
INSERT [dbo].[TaiKhoan] ([id], [TenDangNhap], [MatKhau], [LoaiTK], [idTK]) VALUES (10, N'Khang', N'cd15757582c2d12e4d50fe6663b13957', N'User                ', 10)
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[ThongTinCaNhan] ON 

INSERT [dbo].[ThongTinCaNhan] ([idTK], [HoTen], [Email], [Sdt], [DiaChi], [IsEmailConfirmed], [ConfirmationCode], [TrangThai]) VALUES (1, N'hai', N'vanhahai196@gmail.com', N'123       ', N'HCM', 1, NULL, NULL)
INSERT [dbo].[ThongTinCaNhan] ([idTK], [HoTen], [Email], [Sdt], [DiaChi], [IsEmailConfirmed], [ConfirmationCode], [TrangThai]) VALUES (4, N'Dung', N'dungkcr17@gmail.com', N'862255781 ', N'VietNam,Phuong nay, duong no', 1, 231473, NULL)
INSERT [dbo].[ThongTinCaNhan] ([idTK], [HoTen], [Email], [Sdt], [DiaChi], [IsEmailConfirmed], [ConfirmationCode], [TrangThai]) VALUES (6, N'Hà Văn Hải', N'vanhai11203@gmail.com', N'357608667 ', N'Thủ Đức, tp.HCM', 1, 403772, NULL)
INSERT [dbo].[ThongTinCaNhan] ([idTK], [HoTen], [Email], [Sdt], [DiaChi], [IsEmailConfirmed], [ConfirmationCode], [TrangThai]) VALUES (7, N'Hà Hải', N'vanhaiha792@gmail.com', N'123456789 ', N'Thủ Đức, tp.HCM', 1, 528729, NULL)
INSERT [dbo].[ThongTinCaNhan] ([idTK], [HoTen], [Email], [Sdt], [DiaChi], [IsEmailConfirmed], [ConfirmationCode], [TrangThai]) VALUES (8, N'KhảiHữuNguyễn', N'nguyenhuukhai22052003@gmail.com', NULL, NULL, 1, NULL, NULL)
INSERT [dbo].[ThongTinCaNhan] ([idTK], [HoTen], [Email], [Sdt], [DiaChi], [IsEmailConfirmed], [ConfirmationCode], [TrangThai]) VALUES (9, N'Khua Dung', N'dungkcr177@gmail.com', N'0123456789', N'tp.Thủ Đức', 1, NULL, NULL)
INSERT [dbo].[ThongTinCaNhan] ([idTK], [HoTen], [Email], [Sdt], [DiaChi], [IsEmailConfirmed], [ConfirmationCode], [TrangThai]) VALUES (10, N'Trọng Khang', N'Khang@gmail.com', N'0123456777', N'tp.Thủ Đức', 0, 425234, N'Mở')
SET IDENTITY_INSERT [dbo].[ThongTinCaNhan] OFF
GO
INSERT [dbo].[WishList] ([WishlistID], [id]) VALUES (N'123456    ', 6)
INSERT [dbo].[WishList] ([WishlistID], [id]) VALUES (N'2024040520', 7)
INSERT [dbo].[WishList] ([WishlistID], [id]) VALUES (N'2024041208', 8)
GO
ALTER TABLE [dbo].[ChiTietDanhMucYeuThich]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDanhMucYeuThich_SanPham] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[ChiTietDanhMucYeuThich] CHECK CONSTRAINT [FK_ChiTietDanhMucYeuThich_SanPham]
GO
ALTER TABLE [dbo].[ChiTietDanhMucYeuThich]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDanhMucYeuThich_WishList] FOREIGN KEY([WishlistID])
REFERENCES [dbo].[WishList] ([WishlistID])
GO
ALTER TABLE [dbo].[ChiTietDanhMucYeuThich] CHECK CONSTRAINT [FK_ChiTietDanhMucYeuThich_WishList]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDonHang_DonHang] FOREIGN KEY([MaDH])
REFERENCES [dbo].[DonHang] ([MaDH])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_ChiTietDonHang_DonHang]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietDonHang_GioHang] FOREIGN KEY([MaGioHang])
REFERENCES [dbo].[GioHang] ([MaGioHang])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_ChiTietDonHang_GioHang]
GO
ALTER TABLE [dbo].[ChiTietGioHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietGioHang_GioHang] FOREIGN KEY([MaGioHang])
REFERENCES [dbo].[GioHang] ([MaGioHang])
GO
ALTER TABLE [dbo].[ChiTietGioHang] CHECK CONSTRAINT [FK_ChiTietGioHang_GioHang]
GO
ALTER TABLE [dbo].[ChiTietGioHang]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietGioHang_SanPham] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[ChiTietGioHang] CHECK CONSTRAINT [FK_ChiTietGioHang_SanPham]
GO
ALTER TABLE [dbo].[ChiTietKhuyenMai]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietKhuyenMai_KhuyenMai] FOREIGN KEY([MaVoucher])
REFERENCES [dbo].[KhuyenMai] ([MaVoucher])
GO
ALTER TABLE [dbo].[ChiTietKhuyenMai] CHECK CONSTRAINT [FK_ChiTietKhuyenMai_KhuyenMai]
GO
ALTER TABLE [dbo].[ChiTietKhuyenMai]  WITH CHECK ADD  CONSTRAINT [FK_ChiTietKhuyenMai_SanPham] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[ChiTietKhuyenMai] CHECK CONSTRAINT [FK_ChiTietKhuyenMai_SanPham]
GO
ALTER TABLE [dbo].[DanhGiaSP]  WITH CHECK ADD  CONSTRAINT [FK_DanhGiaSP_SanPham] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[DanhGiaSP] CHECK CONSTRAINT [FK_DanhGiaSP_SanPham]
GO
ALTER TABLE [dbo].[DanhGiaSP]  WITH CHECK ADD  CONSTRAINT [FK_DanhGiaSP_TaiKhoan] FOREIGN KEY([id])
REFERENCES [dbo].[TaiKhoan] ([id])
GO
ALTER TABLE [dbo].[DanhGiaSP] CHECK CONSTRAINT [FK_DanhGiaSP_TaiKhoan]
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD  CONSTRAINT [FK_GioHang_TaiKhoan] FOREIGN KEY([id])
REFERENCES [dbo].[TaiKhoan] ([id])
GO
ALTER TABLE [dbo].[GioHang] CHECK CONSTRAINT [FK_GioHang_TaiKhoan]
GO
ALTER TABLE [dbo].[HinhAnhSanPham]  WITH CHECK ADD  CONSTRAINT [FK_HinhAnhSanPham_SanPham] FOREIGN KEY([MaSanPham])
REFERENCES [dbo].[SanPham] ([MaSanPham])
GO
ALTER TABLE [dbo].[HinhAnhSanPham] CHECK CONSTRAINT [FK_HinhAnhSanPham_SanPham]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_LoaiSP] FOREIGN KEY([MaLoaiSP])
REFERENCES [dbo].[LoaiSP] ([MaLoaiSP])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_LoaiSP]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_Phong] FOREIGN KEY([MaPhong])
REFERENCES [dbo].[Phong] ([MaPhong])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_Phong]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [FK_TaiKhoan_ThongTinCaNhan] FOREIGN KEY([idTK])
REFERENCES [dbo].[ThongTinCaNhan] ([idTK])
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [FK_TaiKhoan_ThongTinCaNhan]
GO
ALTER TABLE [dbo].[WishList]  WITH CHECK ADD  CONSTRAINT [FK_WishList_TaiKhoan] FOREIGN KEY([id])
REFERENCES [dbo].[TaiKhoan] ([id])
GO
ALTER TABLE [dbo].[WishList] CHECK CONSTRAINT [FK_WishList_TaiKhoan]
GO
USE [master]
GO
ALTER DATABASE [WebCuaNhom3] SET  READ_WRITE 
GO
