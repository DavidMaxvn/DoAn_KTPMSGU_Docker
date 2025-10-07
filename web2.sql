-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1:3306
-- Thời gian đã tạo: Th9 29, 2025 lúc 05:50 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `web2`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chitiethoadon`
--

CREATE TABLE `chitiethoadon` (
  `MaHD` int(11) NOT NULL,
  `MaSP` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL,
  `DonGia` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `chitiethoadon`
--

INSERT INTO `chitiethoadon` (`MaHD`, `MaSP`, `SoLuong`, `DonGia`) VALUES
(1, 46, 1, 24990000),
(1, 4, 10, 31990000),
(2, 46, 1, 350000),
(2, 1, 2, 1500000),
(2, 7, 2, 1100000),
(2, 8, 1, 100000),
(2, 18, 1, 200000),
(2, 6, 1, 400000),
(3, 3, 1, 230000),
(3, 10, 1, 1900000),
(3, 13, 1, 90000),
(3, 47, 1, 550000),
(3, 48, 1, 200000),
(4, 15, 2, 380000),
(4, 1, 1, 1500000),
(4, 7, 1, 1100000),
(4, 8, 1, 100000),
(4, 9, 2, 4400000),
(4, 12, 1, 100000),
(4, 6, 1, 400000),
(4, 18, 1, 200000),
(4, 14, 1, 90000),
(4, 23, 1, 250000),
(5, 9, 3, 4400000),
(5, 5, 2, 3450000),
(6, 3, 1, 230000),
(6, 12, 1, 100000),
(6, 10, 1, 1900000),
(6, 6, 1, 400000),
(6, 48, 1, 200000),
(6, 2, 1, 640000),
(6, 7, 1, 1100000),
(6, 17, 1, 250000),
(6, 15, 1, 380000),
(6, 14, 1, 90000),
(7, 11, 1, 6100000),
(7, 47, 1, 550000),
(7, 17, 1, 250000),
(7, 5, 1, 3450000),
(7, 10, 1, 1900000),
(8, 19, 1, 2200000),
(8, 18, 2, 200000),
(8, 16, 1, 250000),
(8, 15, 2, 380000),
(8, 46, 1, 350000),
(8, 2, 1, 640000),
(8, 23, 1, 250000),
(8, 1, 1, 1500000),
(8, 8, 2, 100000),
(9, 13, 2, 90000),
(9, 14, 2, 90000),
(9, 6, 1, 400000),
(9, 3, 1, 230000),
(9, 12, 2, 100000),
(10, 4, 1, 2500000),
(10, 15, 1, 380000),
(10, 16, 2, 250000),
(10, 8, 1, 100000),
(11, 15, 1, 380000),
(11, 14, 1, 90000),
(11, 7, 1, 1100000),
(11, 12, 1, 100000),
(12, 4, 1, 2500000),
(12, 2, 1, 640000),
(13, 1, 1, 1500000),
(13, 7, 1, 1100000),
(14, 6, 1, 400000),
(14, 2, 1, 640000),
(14, 18, 1, 200000),
(14, 23, 1, 250000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `danhgia`
--

CREATE TABLE `danhgia` (
  `MaSP` int(11) NOT NULL,
  `MaND` varchar(10) NOT NULL,
  `SoSao` int(11) NOT NULL,
  `BinhLuan` varchar(255) NOT NULL,
  `NgayLap` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `danhgia`
--

INSERT INTO `danhgia` (`MaSP`, `MaND`, `SoSao`, `BinhLuan`, `NgayLap`) VALUES
(8, '7', 5, 'Tai nghe này âm thanh cực kỳ sống động và bass mạnh mẽ!', '2024-02-15 08:45:00'),
(8, '12', 3, 'Chất lượng âm thanh tạm ổn, nhưng kiểu dáng hơi cồng kềnh.', '2023-09-28 14:20:00'),
(8, '5', 4, 'Giá cả hợp lý với chất lượng, rất đáng đồng tiền!', '2024-04-10 10:30:00'),
(8, '18', 2, 'Sai lầm khi mua sản phẩm này, âm thanh không đạt mong đợi.', '2023-11-05 17:15:00'),
(8, '9', 5, 'Không gì tuyệt vời hơn khi nghe nhạc với tai nghe này!', '2024-01-20 21:05:00'),
(8, '14', 4, 'Rất thoải mái khi đeo, không gây đau tai sau thời gian dài sử dụng.', '2023-12-30 12:40:00'),
(8, '22', 3, 'Thiết kế không quá ấn tượng nhưng âm thanh khá tốt.', '2024-03-18 16:55:00'),
(8, '11', 4, 'Đã mua lần thứ 2, vẫn không hối hận về chất lượng.', '2023-10-10 09:10:00'),
(8, '17', 2, 'Sản phẩm này không đáng tiền với chất lượng hiện tại.', '2024-02-05 13:20:00'),
(8, '8', 5, 'Tai nghe này là một sự lựa chọn hoàn hảo cho mọi hoạt động giải trí!', '2023-08-22 19:00:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hoadon`
--

CREATE TABLE `hoadon` (
  `MaHD` int(11) NOT NULL,
  `MaND` int(11) NOT NULL,
  `NgayLap` datetime NOT NULL,
  `NguoiNhan` varchar(50) NOT NULL,
  `SDT` varchar(20) NOT NULL,
  `DiaChi` varchar(100) NOT NULL,
  `PhuongThucTT` varchar(20) NOT NULL,
  `TongTien` float NOT NULL,
  `TrangThai` varchar(70) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `hoadon`
--

INSERT INTO `hoadon` (`MaHD`, `MaND`, `NgayLap`, `NguoiNhan`, `SDT`, `DiaChi`, `PhuongThucTT`, `TongTien`, `TrangThai`) VALUES
(1, 2, '2024-05-01 15:19:56', 'Nguyễn Ngọc Huyền', '0993246149', 'Hà Nội', 'Trực tiếp khi nhận h', 34990000, '4'),
(2, 5, '2024-05-13 14:15:08', 'Lê Song Nhật Quyền', '0362631410', '23/2 Nhật Tảo P.4 Q.10', 'Trực tiếp khi nhận h', 6250000, '4'),
(3, 5, '2024-05-13 14:17:06', 'Lê Song Nhật Quyền', '0362631410', '23/2 Nhật Tảo P.4 Q.10', 'Trực tiếp khi nhận h', 2970000, '-1'),
(4, 6, '2024-05-13 14:22:15', 'Phan Thị Kim Loan', '0915107907', '273 An Dương Vương P.3 Q.5', 'Qua thẻ ngân hàng', 13300000, '4'),
(5, 6, '2024-05-13 14:34:35', 'Phan Thị Kim Loan', '0915107907', '273 An Dương Vương P.3 Q.5', 'Qua thẻ ngân hàng', 20100000, '-1'),
(6, 7, '2024-05-13 14:38:24', 'Vũ Thị Thu Hà', '0943216789', '456 Nguyễn Duy Trinh, Bình Trưng Tây, Q.2', 'Trực tiếp khi nhận h', 5290000, '4'),
(7, 8, '2024-05-13 14:42:42', 'Đặng Hồng Phúc', '0965437890', '123 Lê Văn Quới, Bình Khánh, Q.7', 'Qua thẻ ngân hàng', 12250000, '4'),
(8, 9, '2024-05-13 14:46:44', 'Hoàng Minh Tuấn', '0956781234', '484 Nguyễn Văn Linh, Tân Phú, Q.7', 'Trực tiếp khi nhận h', 6550000, '4'),
(9, 10, '2024-05-13 14:50:14', 'Lê Minh Đức', '0978123456', '376 Huỳnh Tấn Phát, Bình Thuận, Q.7', 'Qua thẻ ngân hàng', 1190000, '-1'),
(10, 11, '2025-09-12 16:02:45', 'Huỳnh Phúc Hưng', '0796864189', '23/9E lô C CC Hòa Bình, phường Khánh Hội, tp.hcm ', 'Trực tiếp khi nhận h', 3480000, '4'),
(11, 11, '2025-09-12 16:03:09', 'Huỳnh Phúc Hưng', '0796864189', '23/9E lô C CC Hòa Bình, phường Khánh Hội, tp.hcm ', 'Qua thẻ ngân hàng', 1670000, '-1'),
(12, 2, '2025-09-18 01:47:12', 'Nguyễn Ngọc Huyền', '0123456789', '273 An Dương Vương P.3, Q.5', 'Trực tiếp khi nhận h', 3140000, '4'),
(13, 4, '2025-09-18 01:48:54', 'Lương Thị Thùy Quyên', '01207764668', '28 Nguyễn Thông, Q.3', 'Trực tiếp khi nhận h', 2600000, '3'),
(14, 13, '2025-09-18 01:54:36', 'Lê Song Nhật Quyền', '0362631410', '325 Nguyễn Duy Dương P.4, Q.10', 'Trực tiếp khi nhận h', 1490000, '2');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `khuyenmai`
--

CREATE TABLE `khuyenmai` (
  `MaKM` int(11) NOT NULL,
  `TenKM` varchar(100) NOT NULL,
  `LoaiKM` varchar(20) NOT NULL,
  `GiaTriKM` float NOT NULL,
  `NgayBD` datetime NOT NULL,
  `NgayKT` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `khuyenmai`
--

INSERT INTO `khuyenmai` (`MaKM`, `TenKM`, `LoaiKM`, `GiaTriKM`, `NgayBD`, `NgayKT`) VALUES
(1, 'Không', 'Nothing', 0, '2024-05-08 00:00:00', '2024-05-17 00:00:00'),
(2, 'Giảm giá', 'GiamGia', 500000, '2024-05-01 00:00:00', '2024-05-05 00:00:00'),
(3, 'Giá rẻ online', 'GiaReOnline', 650000, '2024-05-25 00:00:00', '2024-05-30 00:00:00'),
(4, 'Trả góp', 'TraGop', 0, '2024-05-01 00:00:00', '2024-05-31 00:00:00'),
(5, 'Mới ra mắt', 'MoiRaMat', 0, '2024-05-01 00:00:00', '2024-05-31 00:00:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `loaisanpham`
--

CREATE TABLE `loaisanpham` (
  `MaLSP` int(11) NOT NULL,
  `TenLSP` varchar(70) NOT NULL,
  `HinhAnh` varchar(200) NOT NULL,
  `Mota` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `loaisanpham`
--

INSERT INTO `loaisanpham` (`MaLSP`, `TenLSP`, `HinhAnh`, `Mota`) VALUES
(1, 'Apple', 'Apple.jpg', 'Các sản phẩm của Apple'),
(2, 'Sony', 'Sony.jpg', 'Các sản phẩm của Sony'),
(3, 'Awei', 'Awei.jpg', 'Các sản phẩm đến từ Awei'),
(4, 'Havit', 'Havit.jpg', 'Các sản phẩm của Havit'),
(5, 'Monster', 'Monster.jpg', 'Các sản phẩm của Monster'),
(6, 'Vivo', 'Vivo.jpg', 'Các sản phẩm của Vivo'),
(7, 'Oppo', 'Oppo.jpg', 'Các sản phẩm của Oppo'),
(8, 'SamSung', 'Samsung.jpg', 'Khuyen mai lon tu SamSung'),
(9, 'Ava+', 'Ava+.jpg', 'Cac san pham cua Ava+'),
(10, ' Xiaomi', 'Xiaomi.jpg', 'Các sản phẩm đến từ Xiaomi');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nguoidung`
--

CREATE TABLE `nguoidung` (
  `MaND` int(11) NOT NULL,
  `Ho` varchar(20) NOT NULL,
  `Ten` varchar(20) NOT NULL,
  `GioiTinh` varchar(10) NOT NULL,
  `SDT` varchar(20) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `DiaChi` varchar(200) NOT NULL,
  `TaiKhoan` varchar(100) NOT NULL,
  `MatKhau` varchar(100) NOT NULL,
  `MaQuyen` int(11) NOT NULL,
  `TrangThai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `nguoidung`
--

INSERT INTO `nguoidung` (`MaND`, `Ho`, `Ten`, `GioiTinh`, `SDT`, `Email`, `DiaChi`, `TaiKhoan`, `MatKhau`, `MaQuyen`, `TrangThai`) VALUES
(1, 'Lê Song', 'Nhật Quyền', '', '0993246149', 'lesongnhatquyen@gmail.com', '273 An Dương Vương P.3, Q.5, TP.HCM', 'admin', '202cb962ac59075b964b07152d234b70', 2, 1),
(2, 'Nguyễn', 'Ngọc Huyền', 'Nữ', '0123456789', '3121411090@sv.sgu.edu.vn', '273 An Dương Vương P.3, Q.5', 'HuyenNguyen', '202cb962ac59075b964b07152d234b70', 1, 1),
(4, 'Lương Thị', 'Thùy Quyên', 'Nữ', '01207764668', '3122411172@sv.sgu.edu.vn', '28 Nguyễn Thông, Q.3', 'thuyquyen', '202cb962ac59075b964b07152d234b70', 1, 1),
(5, 'Nguyễn Lê', 'Nhật Minh', '', '0719235566', 'minhnhat019@gmail.com', '218A/39', 'NhatMinhDev', '827ccb0eea8a706c4c34a16891f84e7b', 1, 1),
(6, 'Phan Thị', 'Kim Loan', '', '0915107907', 'kimloanpt@gmail.com', '273 An Dương Vương P.3 Q.5', 'LoanPhanpt', 'f43df3f122fc4eb0f119f46d11b0c7d0', 1, 1),
(7, 'Vũ Thị', 'Thu Hà', '', '0943216789', 'thuthuha@yahoo.com', '456 Nguyễn Duy Trinh, Bình Trưng Tây, Q.2', 'thuthuha444', '003c875f99b07229cff54d355c925a1f', 1, 1),
(8, 'Đặng', 'Hồng Phúc', '', '0965437890', 'hongphuc@outlook.com.vn', '123 Lê Văn Quới, Bình Khánh, Q.7', 'hongphuc333', '17eb29cb2cdb4e5e30f125cc7ff0d57e', 1, 1),
(9, 'Hoàng', 'Minh Tuấn', '', '0956781234', 'minhtuan@hotmail.com', '484 Nguyễn Văn Linh, Tân Phú, Q.7', 'minhtuan222', '93753dd37ea268111ca8d061554cdd0e', 1, 1),
(10, 'Lê', 'Minh Đức', '', '0978123456', 'minhduc@outlook.com', '376 Huỳnh Tấn Phát, Bình Thuận, Q.7', 'minhduc789', 'f610f781e3d8e3863df3986d0b373b0e', 1, 1),
(11, 'Huỳnh', 'Phúc Hưng', '', '0796864189', 'phuchung2004@gmail.com', '23/9E lô C CC Hòa Bình, phường Khánh Hội, tp.hcm ', 'HungRollRoy', '202cb962ac59075b964b07152d234b70', 1, 1),
(13, 'Lê Song', 'Nhật Quyền', '', '0362631410', 'nhatquyendev@outlook.com.vn', '325 Nguyễn Duy Dương P.4, Q.10', 'NhatQuyenDev', 'e10adc3949ba59abbe56e057f20f883e', 1, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `phanquyen`
--

CREATE TABLE `phanquyen` (
  `MaQuyen` int(11) NOT NULL,
  `TenQuyen` varchar(20) NOT NULL,
  `ChiTietQuyen` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `phanquyen`
--

INSERT INTO `phanquyen` (`MaQuyen`, `TenQuyen`, `ChiTietQuyen`) VALUES
(1, 'Customer', 'Khách hàng có tài khoản'),
(2, 'Admin', 'Admin');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sanpham`
--

CREATE TABLE `sanpham` (
  `MaSP` int(11) NOT NULL,
  `MaLSP` int(11) NOT NULL,
  `TenSP` varchar(70) NOT NULL,
  `DonGia` int(11) NOT NULL,
  `SoLuong` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `HinhAnh` varchar(200) NOT NULL,
  `MaKM` int(11) NOT NULL,
  `ThoiLuongPin` varchar(50) NOT NULL,
  `CongSac` varchar(50) NOT NULL,
  `TuongThich` varchar(50) NOT NULL,
  `KetNoiCungLuc` varchar(50) NOT NULL,
  `CongNgheKetNoi` varchar(50) NOT NULL,
  `DieuKhien` varchar(50) NOT NULL,
  `KichThuoc` varchar(50) NOT NULL,
  `KhoiLuong` varchar(50) NOT NULL,
  `SanXuatTai` varchar(50) NOT NULL,
  `SoSao` int(11) NOT NULL,
  `SoDanhGia` int(11) NOT NULL,
  `TrangThai` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `sanpham`
--

INSERT INTO `sanpham` (`MaSP`, `MaLSP`, `TenSP`, `DonGia`, `SoLuong`, `HinhAnh`, `MaKM`, `ThoiLuongPin`, `CongSac`, `TuongThich`, `KetNoiCungLuc`, `CongNgheKetNoi`, `DieuKhien`, `KichThuoc`, `KhoiLuong`, `SanXuatTai`, `SoSao`, `SoDanhGia`, `TrangThai`) VALUES
(1, 8, 'Tai nghe Bluetooth Samsung Galaxy Buds FE R400N ', 1500000, 10, 'img/products/samsung-galaxy-buds-fe-r400n-290224-051438-600x600.jpg', 4, 'Dùng Khoảng 8.5 giờ (khi tắt ANC)', 'Type-C', 'Thiết bị Android phiên bản 8.0 trở lên', '1  thiết bị', 'Bluetooth 5.2', 'Cảm ứng chạm', 'Dài 2.22 cm - Rộng 1.71 cm - Cao 1.92 cm', '5.6 g', 'Việt Nam', 3, 0, 1),
(2, 7, 'Tai nghe Bluetooth OPPO ENCO Buds 2 ETE41', 690000, 10, 'img/products/oppo-enco-buds-2-ete41-trang-thumb1-1-600x600.jpeg', 2, 'Dùng 7 giờ', 'Type-C', 'Android, iOS(iPhone)', '1 thiết bị', 'Bluetooth 5.2', 'Cảm ứng chạm', 'Dài 2.1 cm - Rộng 2.2 cm - Cao 3.4 cm', '4 g', 'Trung Quốc', 4, 2, 1),
(3, 9, 'Tai nghe Bluetooth AVA+ FreeGo W26', 230000, 10, 'img/products/ava-freego-w26-thumb-5-600x600.jpg', 5, 'Dùng 3-4 giờ', 'Type-C', 'macOS,Android,iOS(iPhone),Windows', '1 thiết bị', 'Bluetooth 5.3', 'Cảm ứng chạm', 'Dài 3.2 cm - Rộng 2.3 cm - Cao 2.4 cm', '3.6 g', 'Trung Quốc', 4, 2, 1),
(4, 1, 'Tai nghe Bluetooth AirPods 2 Lightning Charge Apple MV7N2', 2600000, 10, 'img/products/airpods-2-apple-mv7n2-trang-200923-112201-600x600.jpg', 3, 'Dùng 5 giờ', 'Lightning', 'Android,iOS(iPhone),Windows', '1 thiết bị', 'Bluetooth 5.3', 'Cảm ứng chạm', 'Dài 4.05 cm - Rộng 1.65 cm - Cao 1.8 cm', '4 g', 'Việt Nam / Trung Quốc (tùy lô hàng)', 3, 3, 1),
(5, 8, 'Tai nghe Bluetooth Samsung Galaxy Buds 2 Pro R510N ', 3500000, 10, 'img/products/samsung-galaxy-buds2-pro-trang-040923-055806-600x600.jpg', 2, 'Dùng 5 giờ', 'Type-C Sạc không dây', 'Android,iOS(iPhone),Windows', '1 thiết bị', 'Bluetooth 5.3', 'Cảm ứng ', 'Dài 2.4 cm - Rộng 2.1 cm - Cao 1.7 cm', '5.5 g', 'Việt Nam', 0, 0, 1),
(6, 6, 'Tai nghe Bluetooth vivo Air XEW25', 450000, 10, 'img/products/vivo-air-xew25-thumb1-600x600 (1).jpeg', 2, 'Dùng 4.5 giờ', 'Type-C', 'macOS,Android, iOS, Windows,iPadOS(iPad)', '1 thiết bị ', 'Bluetooth 5.2', 'Cảm ứng ', 'Dài 3 cm - Rộng 1.7 cm - Cao 1.6 cm', '3.5 g', 'Trung Quốc', 0, 0, 1),
(7, 7, 'Tai nghe Bluetooth OPPO Enco Buds 2 Pro E510A', 1100000, 10, 'img/products/oppo-enco-buds-2-pro-e510a-trang-600x600.jpg', 4, 'Dùng 8 giờ', 'Type-C', 'macOS,Android,iOS(iPhone),Windows', '1 thiết bị ', 'Bluetooth 5.3', 'Cảm ứng ', 'Dài 2.85 cm - Rộng 2.02 cm - Cao 2.3 cm', '4.3 g ± 0.1 g', 'Trung Quốc', 0, 0, 1),
(8, 10, 'Tai nghe Bluetooth Xiaomi Redmi Buds 5', 100000, 10, 'img/products/xiaomi-redmi-buds-5-150124-083125-600x600.jpg', 4, 'Dùng 40 giờ', 'Type-', 'macOSAndroid, iOS, Windows', '2 thiết bị', 'Bluetooth 5.3', 'Cảm ứng chạm', 'Dài 2.95 cm - Rộng 2.35 cm - Cao 2.14 cm', '3.5 g', 'Trung Quốc', 0, 0, 1),
(9, 1, 'Tai nghe Bluetooth AirPods 3 Lightning Charge Apple MPNY3', 4400000, 10, 'img/products/airpods-3-lightning-charge-apple-mpny3-trang-thumb1-600x6001.-600x600.jpeg', 4, 'Dùng 6 giờ', 'Lightning', 'Android,iOS(iPhone),iPadOS(iPad),macOS(Macbook, iM', '1 thiết bị', 'Bluetooth 5.0', 'Cảm ứng lực ', 'Dài 3.1 cm - Rộng 1.8 cm - Cao 1.6 cm', '4.28 ', 'Việt Nam / Trung Quốc (tùy lô hàng)', 0, 0, 1),
(10, 10, 'Tai nghe Bluetooth Xiaomi Redmi Buds 5 Pro', 1900000, 10, 'img/products/xiaomi-redmi-buds-5-pro-150124-082538-600x600.jpg', 1, 'Dùng 38 giờ ', 'Type-C', 'macOS,Android, iOS, Windows', '1 thiết bị ', 'Bluetooth 5.3', 'Cảm ứng chạm', 'Dài 3 cm - Rộng 2 cm - Cao 2.2 cm', '5.1 g', 'Trung Quốc ', 0, 0, 1),
(11, 1, 'Tai nghe Bluetooth AirPods Pro Gen 2(USB-C) Apple MTJV3', 6200000, 10, 'img/products/airpods-pro-2nd-gen-usb-c-charge-apple-thumb-1-600x600.jpg', 3, 'Dùng 6 giờ', 'Sạc MagSafe,Type-C,Sạc không dây Qi', 'Android, iOS, Windows', '1  thiết bị ', 'Bluetooth 5.3 ', 'Cảm ứng chạm', 'Dài 3.09 cm - Rộng 2.18 cm - Cao 2.17 cm', '5.3 g', 'Việt Nam / Trung Quốc (tùy lô hàng)', 0, 0, 1),
(12, 9, 'Tai nghe Chụp Tai Trẻ em AVA+ KD-662', 100000, 10, 'img/products/ava-kd-662-hong-thumb-600x600.jpg', 4, 'Không ', 'Jack cắm 3.5 mm', 'Android, iOS, Windows', '1  thiết bị ', 'Phím nhấn ', 'Không ', '134 cm', '100 g', 'Trung Quốc ', 0, 0, 1),
(13, 3, 'Tai nghe Có Dây Awei Q29Hi', 90000, 10, 'img/products/awei-q29hi-den-hong-thumbnew-600x600.jpg', 1, 'Không ', 'Jack cắm 3.5 mm', 'Windows Phone,AndroidiOS(iPhone),Windows', '1 thiết bị   ', 'Không ', 'Phím nhấn ', 'Dài 5.7 cm - Rộng 5.7 cm - Cao 2.8 cm', '93 g', 'Trung Quốc ', 0, 0, 1),
(14, 3, 'Tai nghe Có Dây Awei Q50Hi', 90000, 10, 'img/products/awei-q50hi-bac-9-600x600.jpg', 5, 'Không ', 'Jack cắm 3.5 mm', 'Windows Phone,AndroidiOS(iPhone),Windows', '1 thiết bị ', 'Không ', 'Phím nhấn ', '134 cm ', '100 g', 'Trung Quốc', 0, 0, 1),
(15, 4, 'Tai nghe Bluetooth Chụp Tai HAVIT H667BT ', 380000, 10, 'img/products/havit-h667bt-xanh-tn-600x600.jpg', 5, 'Dùng 20 giờ ', 'Type-C ', 'macOS,Android, iOS, Windows', '1 thiết bị  ', 'Bluetooth 5.3', 'Phím nhấn ', 'dài 18.63 cm - Rộng 17.5 cm - Cao 8.53 cm', '211 g ', 'Trung Quốc ', 4, 1, 1),
(16, 4, 'Tai nghe HAVIT TW976', 250000, 10, 'img/products/havit-tw976-tim-600x600.jpg', 5, 'Dùng 5 giờ ', 'Type-C ', 'macOS,Android, iOS, Windows', '1 thiết bị   ', 'Bluetooth 5.3 ', 'Cảm ứng chạm', 'Dài 3.177 cm - Rộng 1.702 cm - Cao 1.679 cm', '3.4 g', 'Trung Quốc ', 0, 0, 1),
(17, 5, 'Tai nghe Bluetooth Monster MH22163 N-Lite 203 AirLinks', 250000, 10, 'img/products/monster-mh22163-n-lite-203-airlinks-thumb-1-600x600.jpg', 1, 'Dùng 8 giờ', 'Type-C ', 'macOS,Android, iOS, Windows', '1 thiết bị   ', 'Bluetooth 5.3 ', 'Cảm ứng chạm ', 'Dài 4 cm - Rộng 1.8 cm - Cao 2 cm', '8 g ', 'Trung Quốc ', 0, 0, 1),
(18, 2, 'Tai nghe Chụp Tai Sony MDR - ZX110AP ', 250000, 10, 'img/products/sony-mdr-zx110ap-thumbnew-600x600.jpg', 2, 'Dynamic Neodymium 30 mm', 'Jack cắm 3.5 mm ', 'Android,iOS (iPhone),Windows,Windows Phone', '1 thiết bị  ', 'Không ', 'Phím nhấn ', 'dài 1.2m', '120 g', 'Trung Quốc ', 0, 0, 1),
(19, 2, 'Tai nghe Bluetooth Sony WF-C700N', 2200000, 10, 'img/products/sony-wf-c700n-den-thumb-600x600.jpg', 4, 'Dùng 10 giờ', 'Type-C  ', 'macOS,Android, iOS, Windows,iPadOS(iPad)', ' 2 thiết bị ', 'Bluetooth 5.2', 'Phím nhấn ', 'Không', '4.6 g ', 'Việt Nam  ', 0, 0, 1),
(23, 8, 'Tai nghe Có Dây Samsung IA500', 300000, 10, 'https://cdn.tgdd.vn/Products/Images/54/264068/nhet-tai-samsung-ia500-den-thumb-600x600.jpg', 2, 'Không ', 'Jack cắm 3.5 mm', 'macOS,iOS(iPhone),Android', '1  thiết bị  ', 'Không', 'Phím nhấn ', 'Dài 125 cm', '14.76 g', 'Việt Nam', 0, 0, 1),
(46, 4, 'Tai nghe Bluetooth Chụp Tai HAVIT H663BT', 450000, 10, 'https://cdn.tgdd.vn/Products/Images/54/320249/tai-nghe-bluetooth-chup-tai-havit-h663bt-tb-600x600.jpg', 3, 'Dùng 26 giờ', 'Type-C ', 'macOS,Android, iOS, Windows', '1 thiết bị ', 'Bluetooth 5.3  ', 'Phím  nhấn', 'Dài 17.5 cm - Rộng 18.5 cm - Cao 8.2 cm', '215 g', 'Trung Quốc ', 3, 2, 1),
(47, 1, 'Tai nghe Có Dây Apple MTJY3', 550000, 10, 'https://cdn.tgdd.vn/Products/Images/54/315072/tai-nghe-co-day-apple-mtjy3-thumb-1-600x600.jpg', 1, 'Không ', 'Type-C', 'macOS(Macbook,iMac),iOS(iPhone),iPadOS(iPad)', '1  thiết bị  ', 'Không ', 'Tăng/giảm âm lượng, Nhận/Ngắt cuộc gọi', 'Dài 1.2 m ', 'Không', 'Việt Nam / Trung Quốc (tùy lô hàng)', 0, 0, 1),
(48, 7, 'Tai nghe Có Dây OPPO MH320', 300000, 10, 'https://cdn.tgdd.vn/Products/Images/54/236050/co-day-ep-oppo-mh320-11-600x600.jpg', 3, 'Không ', 'Jack cắm 3.5 mm', 'Android, Windows ', '1 thiết bị  ', 'Không', 'Phím nhấn ', 'Dài 1.2 m', '12.3 g', 'Trung Quốc ', 0, 0, 1),
(49, 8, 'Tai nghe TWS Samsung Galaxy Buds3 Pro R630N', 3990000, 100, 'img/products/image_49.jpg', 4, '5000 mAh', 'Type C', 'macOS Android, iOS, Windows', '1 thiết bị', 'Bluetooth 5.4', 'Cảm ứng chạm/vuốt Giọng nói (Tiếng Anh, Hàn)', 'Dài 3.2 cm - Rộng 2.02 cm - Cao 1.8 cm', '5.4 g', 'Việt Nam', 0, 0, 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `chitiethoadon`
--
ALTER TABLE `chitiethoadon`
  ADD KEY `MaHD` (`MaHD`),
  ADD KEY `MaSP` (`MaSP`);

--
-- Chỉ mục cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  ADD KEY `MaSP` (`MaSP`);

--
-- Chỉ mục cho bảng `hoadon`
--
ALTER TABLE `hoadon`
  ADD PRIMARY KEY (`MaHD`),
  ADD KEY `MaKH` (`MaND`);

--
-- Chỉ mục cho bảng `khuyenmai`
--
ALTER TABLE `khuyenmai`
  ADD PRIMARY KEY (`MaKM`);

--
-- Chỉ mục cho bảng `loaisanpham`
--
ALTER TABLE `loaisanpham`
  ADD PRIMARY KEY (`MaLSP`);

--
-- Chỉ mục cho bảng `nguoidung`
--
ALTER TABLE `nguoidung`
  ADD PRIMARY KEY (`MaND`),
  ADD KEY `MaQuyen` (`MaQuyen`);

--
-- Chỉ mục cho bảng `phanquyen`
--
ALTER TABLE `phanquyen`
  ADD PRIMARY KEY (`MaQuyen`);

--
-- Chỉ mục cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD PRIMARY KEY (`MaSP`),
  ADD KEY `LoaiSP` (`MaLSP`),
  ADD KEY `MaKM` (`MaKM`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `hoadon`
--
ALTER TABLE `hoadon`
  MODIFY `MaHD` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `khuyenmai`
--
ALTER TABLE `khuyenmai`
  MODIFY `MaKM` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `loaisanpham`
--
ALTER TABLE `loaisanpham`
  MODIFY `MaLSP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT cho bảng `nguoidung`
--
ALTER TABLE `nguoidung`
  MODIFY `MaND` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT cho bảng `phanquyen`
--
ALTER TABLE `phanquyen`
  MODIFY `MaQuyen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  MODIFY `MaSP` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `chitiethoadon`
--
ALTER TABLE `chitiethoadon`
  ADD CONSTRAINT `chitiethoadon_ibfk_1` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`),
  ADD CONSTRAINT `chitiethoadon_ibfk_2` FOREIGN KEY (`MaHD`) REFERENCES `hoadon` (`MaHD`);

--
-- Các ràng buộc cho bảng `danhgia`
--
ALTER TABLE `danhgia`
  ADD CONSTRAINT `danhgia_ibfk_1` FOREIGN KEY (`MaSP`) REFERENCES `sanpham` (`MaSP`);

--
-- Các ràng buộc cho bảng `hoadon`
--
ALTER TABLE `hoadon`
  ADD CONSTRAINT `hoadon_ibfk_1` FOREIGN KEY (`MaND`) REFERENCES `nguoidung` (`MaND`);

--
-- Các ràng buộc cho bảng `nguoidung`
--
ALTER TABLE `nguoidung`
  ADD CONSTRAINT `nguoidung_ibfk_1` FOREIGN KEY (`MaQuyen`) REFERENCES `phanquyen` (`MaQuyen`);

--
-- Các ràng buộc cho bảng `sanpham`
--
ALTER TABLE `sanpham`
  ADD CONSTRAINT `sanpham_ibfk_1` FOREIGN KEY (`MaLSP`) REFERENCES `loaisanpham` (`MaLSP`),
  ADD CONSTRAINT `sanpham_ibfk_2` FOREIGN KEY (`MaKM`) REFERENCES `khuyenmai` (`MaKM`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
