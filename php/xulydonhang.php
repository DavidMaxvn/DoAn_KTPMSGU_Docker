<?php
		require_once('../BackEnd/ConnectionDB/DB_classes.php');
		
		session_start();

    if(!isset($_POST['request']) && !isset($_GET['request'])) die(null);

    switch ($_POST['request']) {
    	case 'getall':
			$dsdh = (new HoaDonBUS())->select_all();
			$spBUS = new SanPhamBUS();
			$cthdBUS = new ChiTietHoaDonBUS();
			$ndBUS = new NguoiDungBUS();

			for($i = 0; $i < sizeof($dsdh); $i++) {
				// Thêm thông tin người dùng
				$dsdh[$i]["ND"] = $ndBUS->select_by_id("*", $dsdh[$i]["MaND"]);

				// Thêm thông tin chi tiết sản phẩm
				$dsdh[$i]["CTDH"] = $cthdBUS->select_all_in_hoadon($dsdh[$i]["MaHD"]);

				for($j = 0; $j < sizeof($dsdh[$i]["CTDH"]); $j++) {
					$dsdh[$i]["CTDH"][$j]["SP"] = $spBUS->select_by_id("*", $dsdh[$i]["CTDH"][$j]["MaSP"]);
				}

			}
			
			die (json_encode($dsdh));
			break;
				
		case 'getCurrentUser':
			if (isset($_SESSION['currentUser'])) {
				$manguoidung = $_SESSION['currentUser']['MaND'];
			
				$sql="SELECT * FROM hoadon WHERE MaND=$manguoidung";
				$dsdh=(new DB_driver())->get_list($sql);
		
				die(json_encode($dsdh));

			} else {
				die(null);
			}
			break;

		case 'capNhatTrangThai':
			$madonhang = $_POST['maDonHang'];
			$trangThai = $_POST['trangThai'];
			$ketqua = (new HoaDonBUS())->capNhapTrangThai($trangThai, $madonhang);

			die(json_encode($ketqua));
			break;

		case 'getTopKhachHang':
			$db = new DB_driver();
			$sql = "SELECT hoadon.MaND, 
						   SUM(hoadon.TongTien) AS tongtien,
						   nguoidung.TaiKhoan, nguoidung.Ho, nguoidung.Ten
					FROM hoadon
					JOIN nguoidung ON hoadon.MaND = nguoidung.MaND
					WHERE hoadon.TrangThai = 4 -- chỉ lấy đơn đã giao, nếu đúng mã trạng thái của bạn
					GROUP BY hoadon.MaND
					ORDER BY tongtien DESC
					LIMIT 5";
			$result = $db->get_list($sql);
			die(json_encode($result));
			break;

		default:
			die('Request không đúng định dạng');
	    	break;

		case 'getDashboardStats':
			$db = new DB_driver();
			$sosanpham = $db->get_row("SELECT COUNT(*) as c FROM sanpham")['c'];
			$sodonhang = $db->get_row("SELECT COUNT(*) as c FROM hoadon")['c'];
			$souser = $db->get_row("SELECT COUNT(*) as c FROM nguoidung")['c'];
			$tongchi = $db->get_row("SELECT SUM(TongTien) as s FROM hoadon WHERE TrangThai=4")['s']; // chỉ tính đơn đã giao
			die(json_encode([
				'sosanpham' => $sosanpham,
				'sodonhang' => $sodonhang,
				'souser' => $souser,
				'tongchi' => number_format($tongchi, 0, ',', '.')
			]));
			break;

		case 'getBrandStats':
			$db = new DB_driver();
			$sql = "SELECT lsp.TenLSP, 
						   SUM(ct.SoLuong) as da_ban, 
						   SUM(ct.SoLuong * ct.DonGia) as loinhuan
					FROM chitiethoadon ct
					JOIN sanpham sp ON ct.MaSP = sp.MaSP
					JOIN loaisanpham lsp ON sp.MaLSP = lsp.MaLSP
					JOIN hoadon hd ON ct.MaHD = hd.MaHD
					WHERE hd.TrangThai = 4 -- chỉ tính đơn đã giao
					GROUP BY lsp.TenLSP
					ORDER BY loinhuan DESC";
			$result = $db->get_list($sql);
			die(json_encode($result));
			break;
    }
?>