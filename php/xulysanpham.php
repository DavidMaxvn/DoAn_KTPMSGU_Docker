<?php
require_once('../BackEnd/ConnectionDB/DB_classes.php');

if (!isset($_POST['request']) && !isset($_GET['request'])) die(null);

switch ($_POST['request']) {
        // lấy tất cả sản phẩm
    case 'getall':
        $dssp = (new SanPhamBUS())->select_all();
        for ($i = 0; $i < sizeof($dssp); $i++) {
            // thêm thông tin khuyến mãi
            $dssp[$i]["KM"] = (new KhuyenMaiBUS())->select_by_id('*', $dssp[$i]['MaKM']);
            // thêm thông tin hãng
            $dssp[$i]["LSP"] = (new LoaiSanPhamBUS())->select_by_id('*', $dssp[$i]['MaLSP']);
        }
        die(json_encode($dssp));
        break;

    case 'getbyid':
        $sp = (new SanPhamBUS())->select_by_id("*", $_POST['id']);
        // thêm thông tin khuyến mãi và hãng
        $sp["KM"] = (new KhuyenMaiBUS())->select_by_id('*', $sp['MaKM']);
        $sp["LSP"] = (new LoaiSanPhamBUS())->select_by_id('*', $sp['MaLSP']);

        die(json_encode($sp));
        break;

    case 'getlistbyids':
        $listID = $_POST['listID'];
        $sql = "SELECT * FROM SanPham WHERE ";

        foreach ($listID as $id) {
            $sql .= "MaSP=" . $id . " OR ";
        }
        $sql .= " 1=0";

        $result = (new DB_driver())->get_list($sql);

        for ($i = 0; $i < sizeof($result); $i++) {
            // thêm thông tin khuyến mãi
            $result[$i]["KM"] = (new KhuyenMaiBUS())->select_by_id('*', $result[$i]['MaKM']);
            // thêm thông tin hãng
            $result[$i]["LSP"] = (new LoaiSanPhamBUS())->select_by_id('*', $result[$i]['MaLSP']);
        }

        die(json_encode($result));
        break;

    case 'phanTich_Filters':
        phanTich_Filters();
        break;

    case 'addFromWeb1':
        addFromWeb1();
        break;

        //thêm
    case 'add':
    $data = $_POST['dataAdd'] ?? [];

    // ===== Parse ảnh base64 an toàn =====
    $imgRelPath = null; // đường dẫn lưu vào DB (tương đối)
    if (!empty($data['img'])) {
        $base64_string = $data['img'];

        // Bóc tách data URI: data:image/<ext>;base64,<payload>
        $matched = preg_match('#^data:image/([a-zA-Z0-9]+);base64,(.+)$#', $base64_string, $m);
        if ($matched === 1) {
            $ext = strtolower($m[1]);
            $payload = $m[2];

            // Chuẩn hóa phần mở rộng
            $map = [
                'jpg' => 'jpg',
                'jpeg' => 'jpg',
                'png' => 'png',
                'gif' => 'gif',
                'webp' => 'webp',
            ];
            if (!isset($map[$ext])) {
                die(json_encode(['success' => false, 'msg' => 'Định dạng ảnh không hợp lệ (chỉ jpg, jpeg, png, gif, webp)']));
            }
            $ext = $map[$ext];

            // Tạo tên file an toàn: image_<MaSP>.<ext>
            $masp = preg_replace('/[^A-Za-z0-9_-]/', '', (string)$data['masp']);
            if ($masp === '') {
                die(json_encode(['success' => false, 'msg' => 'Mã sản phẩm không hợp lệ']));
            }

            $imgFileName = "image_{$masp}.{$ext}";
            $imgRelPath  = "img/products/{$imgFileName}";

            // Thư mục đích (tuyệt đối)
            $destDir = __DIR__ . '/../img/products/';
            if (!is_dir($destDir)) {
                // 0775 trên *nix; Windows dùng NTFS permission—OK
                @mkdir($destDir, 0775, true);
            }

            $absPath = $destDir . $imgFileName;

            // Xoá file cũ nếu tồn tại
            if (file_exists($absPath)) {
                @unlink($absPath);
            }

            // Ghi file
            $binary = base64_decode($payload, true);
            if ($binary === false) {
                die(json_encode(['success' => false, 'msg' => 'Base64 không hợp lệ']));
            }

            if (file_put_contents($absPath, $binary) === false) {
                die(json_encode(['success' => false, 'msg' => 'Không thể lưu ảnh (kiểm tra quyền thư mục img/products)']));
            }
        } else {
            // data URI không đúng chuẩn
            die(json_encode(['success' => false, 'msg' => 'Chuỗi ảnh không đúng định dạng data:image/...;base64,...']));
        }
    }

    // ===== Chuẩn bị dữ liệu thêm sản phẩm =====
    $spAddArr = array(
        'MaSP'            => $data['masp'],
        'MaLSP'           => $data['company'],
        'TenSP'           => $data['name'],
        'DonGia'          => $data['price'],
        'SoLuong'         => $data['amount'],
        'HinhAnh'         => $imgRelPath ?? null, // có thể null nếu không gửi ảnh
        'MaKM'            => $data['promo']['name'] ?? null,
        'ThoiLuongPin'    => $data['detail']['pin'] ?? null,
        'CongSac'         => $data['detail']['port'] ?? null,
        'TuongThich'      => $data['detail']['compatible'] ?? null,
        'KetNoiCungLuc'   => $data['detail']['connect'] ?? null,
        'CongNgheKetNoi'  => $data['detail']['technology'] ?? null,
        'DieuKhien'       => $data['detail']['conduct'] ?? null,
        'KichThuoc'       => $data['detail']['size'] ?? null,
        'KhoiLuong'       => $data['detail']['volume'] ?? null,
        'SanXuatTai'      => $data['detail']['produce'] ?? null,
        'SoSao'           => $data['star'] ?? 0,
        'SoDanhGia'       => $data['rateCount'] ?? 0,
        'TrangThai'       => $data['TrangThai'] ?? 1
    );

    $spBUS = new SanPhamBUS();
    die(json_encode($spBUS->add_new($spAddArr)));
    break;


        // sua
    case 'change':
        $data = $_POST['dataChange'];

        $spChangeArr = array(
            'MaLSP' => $data['company'],
            'TenSP' => $data['name'],
            'DonGia' => $data['price'],
            'SoLuong' => $data['amount'],
            'MaKM' => $data['promo']['name'],
            'ThoiLuongPin' => $data['detail']['pin'],
            'CongSac' => $data['detail']['port'],
            'TuongThich' => $data['detail']['compatible'],
            'KetNoiCungLuc' => $data['detail']['connect'],
            'CongNgheKetNoi' => $data['detail']['technology'],
            'DieuKhien' => $data['detail']['conduct'],
            'KichThuoc' => $data['detail']['size'],
            'KhoiLuong' => $data['detail']['volume'],
            'SanXuatTai' => $data['detail']['produce'],
            'SoSao' => $data['star'],
            'SoDanhGia' => $data['rateCount'],
            'TrangThai' => $data['TrangThai']
        );
        $id = $data['masp'];
        $base64_string = $data['HinhAnh'];
        if ($base64_string=="") {
            $img_data = explode(',', $base64_string);
            $file_type = str_replace("data:image/", "", $img_data[0]);
            $file_type = str_replace(";base64", "", $file_type);
            $image_path = "img/products/image_" . $id . ".$file_type";
            if (file_exists("../" . $image_path)) unlink("../$image_path");
            $ifp = fopen("../$image_path", 'wb');
            fwrite($ifp, base64_decode($img_data[1]));
            fclose($ifp);
            $spChangeArr['HinhAnh' ] = $image_path;
        }

        $spBUS = new SanPhamBUS();
        die(json_encode($spBUS->suaSanPham($spChangeArr, $id)));
        break;
        
        // xóa
    case 'delete':
        $spBUS = new SanPhamBUS();
        $maSPDel = $_POST['maspdelete'];
        die(json_encode($spBUS->delete_by_id($maSPDel)));
        break;

    case 'hide':
        $id = $_POST["id"];
        $trangthai = $_POST["trangthai"];
        die(json_encode((new SanPhamBUS())->capNhapTrangThai($trangthai, $id)));
        break;

    default:
        # code...
        break;
}

function phanTich_Filters()
{
    $filters = $_POST['filters'];
    $ori = "SELECT * FROM SanPham WHERE TrangThai=1 AND SoLuong>0 AND ";
    $sql = $ori;
    $db = new DB_driver();
    $db->connect();

    // $page = null;
    $tenThanhPhanCanSort = null;
    $typeSort = null;

    foreach ($filters as $filter) {
        $dauBang = explode("=", $filter);
        switch ($dauBang[0]) {
            case 'search':
                $dauBang[1] = explode("+", $dauBang[1]);
                $dauBang[1] = join(" ", $dauBang[1]);
                $dauBang[1] = mysqli_escape_string($db->__conn, $dauBang[1]);
                $sql .= ($sql == $ori ? "" : " AND ") . " TenSP LIKE '%$dauBang[1]%' ";
                break;

            case 'price':
                $prices = explode("-", $dauBang[1]);
                $giaTu = (int)$prices[0];
                $giaDen = (int)$prices[1];

                // nếu giá đến = 0 thì cho giá đến = 100 triệu
                if ($giaDen == 0) $giaDen = 1000000000;

                $sql .= ($sql == $ori ? "" : " AND ") . " DonGia >= $giaTu AND DonGia <= $giaDen";
                break;

            case 'company':
                $companyID = $dauBang[1];
                $sql .= ($sql == $ori ? "" : " AND ") . " MaLSP='$companyID'";
                break;

            case 'star':
                $soSao = (int)$dauBang[1];
                $sql .= ($sql == $ori ? "" : " AND ") . " SoSao >= $soSao";
                break;

            case 'promo':
                // lấy id khuyến mãi
                $loaikm = $dauBang[1];
                $khuyenmai = (new DB_driver())->get_row("SELECT * FROM KhuyenMai WHERE LoaiKM='$loaikm'");
                $khuyenmaiID = $khuyenmai["MaKM"];

                $sql .= ($sql == $ori ? "" : " AND ") . " MaKM='$khuyenmaiID'";
                break;

            case 'sort':
                $s = explode("-", $dauBang[1]);
                $tenThanhPhanCanSort = $s[0];
                $typeSort = ($s[1] == "asc" ? "ASC" : "DESC");
                break;

                // case 'page':
                //     $page = $dauBang[1];
                //     break;

            default:
                # code...
                break;
        }
    }

    // sort phải để cuối
    if ($tenThanhPhanCanSort != null && $typeSort != null) {
        $sql .= ($sql == $ori ? " 1=1 " : ""); // fix lỗi dư chữ AND 
        $sql .= " ORDER BY $tenThanhPhanCanSort $typeSort";
    }

    // Phân trang
    // if($page != 0 || $page == null) { // nếu == 0 thì trả về hết
    //     if($page == null) $page = 1; // mặc định là trang 1 (nếu không ghi gì hết)
    //     $productsPerPage = 10; // số lượng sản phẩm trong 1 trang
    //     $startIndex = ($page-1)*$productsPerPage;
    //     $sql .= ($sql==$ori?" 1=1 ":""); // fix lỗi dư chữ where
    //     $sql .= " LIMIT $startIndex,$productsPerPage";
    // }

    // chạy sql
    $result = $db->get_list($sql);
    $db->dis_connect();

    for ($i = 0; $i < sizeof($result); $i++) {
        // thêm thông tin khuyến mãi
        $result[$i]["KM"] = (new KhuyenMaiBUS())->select_by_id('*', $result[$i]['MaKM']);
        // thêm thông tin hãng
        $result[$i]["LSP"] = (new LoaiSanPhamBUS())->select_by_id('*', $result[$i]['MaLSP']);
    }
    die(json_encode($result));
}

function addFromWeb1()
{
    $spBUS = new SanPhamBUS();

    $sp = $_POST['sanpham'];
    $loaisanpham = (new DB_driver())->get_row("SELECT * FROM LoaiSanPham WHERE TenLSP='" . $sp["company"] . "'");

    $sanphamArr = array(
        'MaSP' => "",
        'MaLSP' => $loaisanpham['MaLSP'],
        'TenSP' => $sp['name'],
        'DonGia' => $sp['price'],
        'SoLuong' => 10,
        'HinhAnh' => $sp['img'],
        'MaKM' => $sp['MaKM'],
        'ThoiLuongPin' => $sp['detail']['pin'],
        'CongSac' => $sp['detail']['port'],
        'TuongThich' => $sp['detail']['compatible'],
        'KetNoiCungLuc' => $sp['detail']['connect'],
        'CongNgheKetNoi' => $sp['detail']['technology'],
        'DieuKhien' => $sp['detail']['conduct'],
        'KichThuoc' => $sp['detail']['size'],
        'KhoiLuong' => $sp['detail']['volume'],
        'SanXuatTai' => $sp['detail']['produce'],
        'SoSao' => 0,
        'SoDanhGia' => 0,
        'TrangThai' => 1
    );

    die(json_encode($spBUS->add_new($sanphamArr)));
}
