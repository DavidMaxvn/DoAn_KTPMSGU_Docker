<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <title>Admin - Thế giới tai nghe</title>
    <link rel="shortcut icon" href="img/myicon.ico" />

    <!-- Load font awesome icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" crossorigin="anonymous">

    <!-- Chart JS -->
    <!-- Import lib -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap" rel="stylesheet">
    <!-- End import lib -->

    <!-- Sweet Alert -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@8"></script>

    <!-- Jquery -->
    <script src="lib/Jquery/Jquery.min.js"></script>

    <!-- Our CSS files -->
    <link rel="stylesheet" href="css/admin/style.css">
    <link rel="stylesheet" href="css/admin/progress.css">
    <link rel="stylesheet" href="css/admin/tuchoitruycap.css">
    <link rel="stylesheet" href="css/admin/Thongke.css">

    <!-- <script src="data/products.js"></script>
    <script src="js/classes.js"></script> -->
    <script src="js/dungchung.js?v=<?php echo time(); ?>"></script>
    <script src="js/admin.js?v=<?php echo time(); ?>"></script>
    <script src="js/thongke.js?v=<?php echo time(); ?>"></script>
</head>

<body>
    <header>
        <h2>Cửa hàng Tai Nghe QHQ - Admin Dashboard</h2>
    </header>

    <!-- Menu -->
    <aside class="sidebar">
        <ul class="nav">
            <li class="nav-title">MENU</li>
            <!-- <li class="nav-item"><a class="nav-link active"><i class="fa fa-home"></i> Home</a></li> -->
            <li class="nav-item" onclick="refreshTableSanPham()">
                <a class="nav-link">
                    <i class="fa fa-th-large"></i>
                    <span>Sản Phẩm</span>
                </a>
            </li>
            <li class="nav-item" onclick="refreshTableDonHang()">
                <a class="nav-link">
                    <i class="fa fa-file-text-o"></i>
                    <span>Đơn Hàng</span>
                </a>
            </li>
            <li class="nav-item" onclick="refreshTableKhachHang()">
                <a class="nav-link">
                    <i class="fa fa-address-book-o"></i>
                    <span>Khách Hàng</span>
                </a>
            </li>
            <li class="nav-item" onclick="refreshTableThongKe()">
                <a class="nav-link">
                    <i class="fa fa-bar-chart-o"></i>
                    <span>Thống Kê</span>
                </a>
            </li>
            <!-- <hr> -->
            <li class="nav-item">
                <a class="nav-link" id="btnDangXuat">
                    <i class="fa fa-arrow-left"></i>
                    <span>Đăng xuất</span>
                </a>
            </li>
        </ul>
    </aside>

    <!-- Khung hiển thị chính -->
    <div class="main">
        <div class="home"></div>

        <!-- Sản Phẩm -->
        <div class="sanpham">
            <table class="table-header">
                <tr>
                    <!-- Theo độ rộng của table content -->
                    <th title="Sắp xếp" style="width: 5%" onclick="sortProductsTable('stt')">Stt <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" style="width: 10%" onclick="sortProductsTable('masp')">Mã <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" style="width: 40%" onclick="sortProductsTable('ten')">Tên <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" style="width: 15%" onclick="sortProductsTable('gia')">Giá <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" style="width: 10%" onclick="sortProductsTable('khuyenmai')">Khuyến mãi <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" style="width: 10%" onclick="sortProductsTable('gia')">Trạng thái <i class="fa fa-sort"></i></th>
                    <th style="width: 10%">Hành động</th>
                </tr>
            </table>

            <div class="table-content">
            </div>

            <div class="table-footer">
                <select name="kieuTimSanPham">
                    <option value="ma">Tìm theo mã</option>
                    <option value="ten">Tìm theo tên</option>
                </select>
                <input type="text" placeholder="Tìm kiếm..." onkeyup="timKiemSanPham(this)">
                <button onclick="document.getElementById('khungThemSanPham').style.transform = 'scale(1)'; autoMaSanPham()">
                    <i class="fa fa-plus-square"></i>
                    Thêm sản phẩm
                </button>
                <button onclick="refreshTableSanPham()">
                    <i class="fa fa-refresh"></i>
                    Làm mới
                </button>
            </div>

            <div id="khungThemSanPham" class="overlay">
                <span class="close" onclick="this.parentElement.style.transform = 'scale(0)';">&times;</span>
                <form method="post" enctype="multipart/form-data" onsubmit="return themSanPham();">
                    <table class="overlayTable table-outline table-content table-header">
                        <tr>
                            <th colspan="2">Thêm Sản Phẩm</th>
                        </tr>
                        <tr>
                            <td>Mã sản phẩm:</td>
                            <td><input disabled="disabled" type="text" id="maspThem" name="maspThem"></td>
                        </tr>
                        <tr>
                            <td>Tên sản phẩm:</td>
                            <td><input type="text"></td>
                        </tr>
                        <tr>
                            <td>Hãng:</td>
                            <td>
                                <select name="chonCompany" onchange="autoMaSanPham(this.value)">
                                    <script>
                                        ajaxLoaiSanPham();
                                    </script>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Hình:</td>
                            <td>
                                <img class="hinhDaiDien" id="anhDaiDienSanPhamThem" src="">
                                <input type="file" name="hinhanh" onchange="previewImage(this, 'anhDaiDienSanPhamThem')">
                                <input style="display: none;" type="text" id="hinhanh" name="hinhanh" value="">
                            </td>
                        </tr>
                        <tr>
                            <td>Giá tiền:</td>
                            <td><input type="number"></td>
                        </tr>
                        <tr>
                            <td>Số lượng:</td>
                            <td><input type="number" value="0"></td>
                        </tr>
                        <tr>
                            <td>Số sao:</td>
                            <td><input disabled="disabled" value="0" type="number"></td>
                        </tr>
                        <tr>
                            <td>Đánh giá:</td>
                            <td><input disabled="disabled" value="0" type="number"></td>
                        </tr>
                        <tr>
                            <td>Khuyến mãi:</td>
                            <td>
                                <select name="chonKhuyenMai" onchange="showGTKM()">
                                    <script type="text/javascript">
                                        ajaxKhuyenMai();
                                    </script>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Giá trị khuyến mãi:</td>
                            <td><input id="giatrikm" type="text"></td>
                        </tr>
                        <tr>
                            <th colspan="2">Thông số kĩ thuật</th>
                        </tr>
                        <tr>
                            <td>Thời lượng pin:</td>
                            <td><input type="text"></td>
                        </tr>
                        <tr>
                            <td>Cổng sạc:</td>
                            <td><input type="text"></td>
                        </tr>
                        <tr>
                            <td>Tương thích:</td>
                            <td><input type="text"></td>
                        </tr>
                        <tr>
                            <td>Kết nối cùng lúc:</td>
                            <td><input type="text"></td>
                        </tr>
                        <tr>
                            <td>Cổng nghe kết nối:</td>
                            <td><input type="text"></td>
                        </tr>
                        <tr>
                            <td>Điều khiển:</td>
                            <td><input type="text"></td>
                        </tr>
                        <tr>
                            <td>Kích thước:</td>
                            <td><input type="text"></td>
                        </tr>
                        <tr>
                            <td>Khối lượng:</td>
                            <td><input type="text"></td>
                        </tr>
                        <tr>
                            <td>Sản xuất tại:</td>
                            <td><input type="text"></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="table-footer"> <button name="submit">THÊM</button> </td>
                        </tr>
                    </table>
                </form>
                <div style="display: none;" id="hinhanh"></div>
            </div>
            <div id="khungSuaSanPham" class="overlay"></div>
        </div> <!-- // sanpham -->

        <!-- Đơn Hàng -->
        <div class="donhang">
            <table class="table-header">
                <tr>
                    <!-- Theo độ rộng của table content -->
                    <th title="Sắp xếp" style="width: 5%" onclick="sortDonHangTable('stt')">Stt <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" style="width: 7%" onclick="sortDonHangTable('madon')">Mã đơn <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" style="width: 13%" onclick="sortDonHangTable('khach')">Khách hàng<i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" style="width: 20%" onclick="sortDonHangTable('sanpham')">Sản phẩm <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" style="width: 15%" onclick="sortDonHangTable('tongtien')">Tổng tiền <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" style="width: 10%" onclick="sortDonHangTable('ngaygio')">Ngày giờ <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" style="width: 10%" onclick="sortDonHangTable('trangthai')">Trạng thái <i class="fa fa-sort"></i></th>
                    <th style="width: 10%">Hành động</th>
                </tr>
            </table>

            <div class="table-content">
            </div>

            <div class="table-footer">
                <div class="timTheoNgay">
                    Từ ngày: <input type="date" id="fromDate">
                    Đến ngày: <input type="date" id="toDate">
                    <button onclick="locDonHangTheoKhoangNgay()"><i class="fa fa-search"></i> Tìm</button>
                </div>

                <select name="kieuTimDonHang">
                    <option value="ma">Tìm theo mã đơn</option>
                    <option value="khachhang">Tìm theo tên khách hàng</option>
                    <option value="trangThai">Tìm theo trạng thái</option>
                </select>
                <input type="text" placeholder="Tìm kiếm..." onkeyup="timKiemDonHang(this)">
            </div>

        </div> <!-- // don hang -->


        <!-- Khách hàng -->
        <div class="khachhang">
            <table class="table-header">
                <tr>
                    <!-- Theo độ rộng của table content -->
                    <th title="Sắp xếp" onclick="sortKhachHangTable('stt')" style="width: 7.5%;">Stt <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" onclick="sortKhachHangTable('hoten')" style="width: 13.5%;">Họ tên <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" onclick="sortKhachHangTable('email')" style="width: 36%;">Email <i class="fa fa-sort"></i></th>
                    <th title="Sắp xếp" onclick="sortKhachHangTable('taikhoan')" style="width: 22%;">Tài khoản <i class="fa fa-sort"></i></th>
                    <th style="width: 9%;">Hành động</th>
                </tr>
            </table>

            <div class="table-content">
            </div>

            <div class="table-footer">
                <select name="kieuTimKhachHang">
                    <option value="ten">Tìm theo họ tên</option>
                    <option value="email">Tìm theo email</option>
                    <option value="taikhoan">Tìm theo tài khoản</option>
                </select>
                <input type="text" placeholder="Tìm kiếm..." onkeyup="timKiemNguoiDung(this)">
                <button onclick="openThemNguoiDung()"><i class="fa fa-plus-square"></i> Thêm người dùng</button>
            </div>
        </div> <!-- // khach hang -->

        <!-- Thống kê -->
        <div class="thongke" id="thongKeSideBar">
            <div class="row">
                <div class="col-3 col-m-6 col-sm-6">
                    <div class="counter bg-primary">
                        <p>
                            <i class='bx bx-gift'></i>
                        </p>
                        <h3 id="sosanpham">173.650</h3>
                        <p>Sản phẩm</p>
                    </div>
                </div>
                <div class="col-3 col-m-6 col-sm-6">
                    <div class="counter bg-warning">
                        <p>
                            <i class='bx bx-task'></i>
                        </p>
                        <h3 id="sodonhang">10</h3>
                        <p>Hóa đơn</p>
                    </div>
                </div>
                <div class="col-3 col-m-6 col-sm-6">
                    <div class="counter bg-success">
                        <p>
                            <i class='bx bxs-user'></i>
                        </p>
                        <h3 id="souser">6</h3>
                        <p>Khách hàng</p>
                    </div>
                </div>
                <div class="col-3 col-m-6 col-sm-6">
                    <div class="counter bg-purple3">
                        <p>
                            <i class='bx bx-money'></i>
                        </p>
                        <h3 id="tongchi">150.000.000.000 vnđ</h3>
                        <p>Doanh thu</p>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-8 col-m-12 col-sm-12">
                    <div class="card">
                        <div class="card-header">
                            <h3>
                                DANH SÁCH 5 KHÁCH HÀNG CÓ MỨC MUA CAO NHẤT
                            </h3>
                            <i class="fas fa-ellipsis-h"></i>
                        </div>
                        <div class="card-content">
                            <div class="timTheoNgay" id="datetextfilter">
                                Từ ngày: <input type="date" id="fromDate1">
                                Đến ngày: <input type="date" id="toDate1">

                                <button onclick="locThongKeTheoKhoangNgay()"><i class="fa fa-search"></i> Tìm</button>
                            </div>
                            <!-- <input type="text" placeholder="Tìm kiếm..." onkeyup="timKiemDonHang(this)"> -->
                        </div>
                        <div class="donhang">
                            <table id="table-header">
                                <thead>
                                    <tr>
                                        <th title="Sắp xếp" style="width: 8%" onclick="sortThongKeTable('stt')">Stt <i class="fa fa-sort"></i></th>
                                        <th title="Sắp xếp" style="width: 15%" onclick="sortThongKeTable('khach')">Khách hàng<i class="fa fa-sort"></i></th>
                                        <th title="Sắp xếp" style="width: 20%" onclick="sortThongKeTable('sanpham')">Sản phẩm <i class="fa fa-sort"></i></th>
                                        <th title="Sắp xếp" style="width: 15%" onclick="sortThongKeTable('tongtien')">Tổng tiền <i class="fa fa-sort"></i></th>
                                        <th title="Sắp xếp" style="width: 10%" onclick="sortThongKeTable('ngaygio')">Ngày giờ <i class="fa fa-sort"></i></th>
                                        <th title="Sắp xếp" style="width: 10%" onclick="sortThongKeTable('trangthai')">Trạng thái <i class="fa fa-sort"></i></th>
                                    </tr>
                                </thead>
                            </table>
                            <div class="table-content2">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4 col-m-12 col-sm-12">
                    <div class="card">
                        <div class="card-header">
                            <h3>
                                TỔNG DOANH THU
                            </h3>
                            <i class="fas fa-ellipsis-h"></i>
                        </div>
                        <div class="card-content">
                            <table id="table-header">
                                <thead>
                                    <tr>
                                        <th>Thương hiệu</th>
                                        <th>Đã bán</th>
                                        <th>Lợi nhuận</th>
                                    </tr>
                                </thead>
                                <tbody id="brand-stats-body">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--END TNONg KE-->

    </div>
    </div>


    <footer>

    </footer>

</body>

</html>