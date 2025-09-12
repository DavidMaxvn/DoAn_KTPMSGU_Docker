// ========================= Đơn Hàng ===========================
function getAlllBill(callback) {
    $.ajax({
      type: "POST",
      url: "php/xulydonhang.php",
      dataType: "json",
      // timeout: 1500, // sau 1.5 giây mà không phản hồi thì dừng => hiện lỗi
      data: {
        request: "getall",
      },
      success: function (data, status, xhr) {
        callback(data);
      },
      error: function (e) {
        Swal.fire({
          type: "error",
          title: "Lỗi lấy dữ liệu đơn Hàng (admin.js > refreshTableDonHang)",
          html: e.responseText,
        });
        callback([]);
      },
    });
  }

  // Vẽ bảng
  function refreshTableThongKe() {
    getAlllBill((data) => {
      addTableThongKe(data);
      TATCA_DONHANG = data;
      console.log(data);
    });
  }
  function addTableThongKe(data) {
  var tc = document
    .getElementsByClassName("donhang")[1]
    .getElementsByClassName("table-content2")[0];
  var s = `<table class="table-outline hideImg"><tbody>`;

  // Gộp đơn hàng theo khách hàng
  var khachMap = {};
  for (var i = 0; i < data.length; i++) {
    var d = data[i];
    if(getTenTrangThaiDonHang(d.TrangThai)!="Đã giao") continue;

    var key = d.ND.TaiKhoan; // hoặc d.MaND nếu muốn gộp theo mã người dùng
    if (!khachMap[key]) {
      khachMap[key] = {
        nguoiDung: `${d.ND.TaiKhoan}<br/>(${d.ND.Ho} ${d.ND.Ten})<br/>Mã: ${d.MaND}`,
        tongTien: 0,
        sanPham: [],
        ngayGio: [],
        trangThai: []
      };
    }
    khachMap[key].tongTien += Number(d.TongTien);
    // Gộp sản phẩm
    for (var ct of d.CTDH) {
      khachMap[key].sanPham.push(
        `<a target="blank" href="chitietsanpham.php?${ct.SP.MaSP}">
          <p>${ct.SP.TenSP} [<span style="color: #000">${ct.SoLuong}</span>]</p>
        </a>`
      );
    }
    // Lưu ngày giờ và trạng thái cuối cùng (nếu muốn)
    khachMap[key].ngayGio.push(new Date(d.NgayLap).toLocaleString());
    khachMap[key].trangThai.push(getTenTrangThaiDonHang(d.TrangThai));
  }

  // Chuyển sang mảng và sắp xếp giảm dần theo tổng tiền
  var khachArr = Object.values(khachMap);
  khachArr.sort((a, b) => b.tongTien - a.tongTien);

  // Lấy 5 khách hàng đầu tiên
  for (var i = 0; i < Math.min(5, khachArr.length); i++) {
    var kh = khachArr[i];
    s += `<tr>
      <td style="width: 8%">${i + 1}</td>
      <td style="width: 15%">${kh.nguoiDung}</td>
      <td style="width: 20%; text-align: left;">${kh.sanPham.join("")}</td>
      <td style="width: 15%">${numToString(kh.tongTien)}</td>
      <td style="width: 10%">${kh.ngayGio[kh.ngayGio.length-1]}</td>
      <td style="width: 10%">${kh.trangThai[kh.trangThai.length-1]}</td>
    </tr>`;
  }

  s += `</tbody></table>`;
  tc.innerHTML = s;
}

  // Duyệt
  function capNhatThongKe(maDonHang, trangThai) {
    let donhang = TATCA_DONHANG.find((_) => _.MaHD === maDonHang);
    if (!donhang) {
      Swal.fire({
        type: "error",
        title:
          "Không tìm thấy đơn hàng #" + maDonHang + ". Vui lòng tải lại trang.",
        html: e.responseText,
      });
      return;
    }
    if (trangThai == "-1") {
      Swal.fire({
        type: "warning",
        title: "Bạn có chắc muốn Hủy đơn hàng #" + maDonHang + "?",
        text: "Việc này không thể hoàn tác!",
        showDenyButton: true,
        showCancelButton: true,
        confirmButtonText: "Hủy đơn",
        cancelButtonText: "Giữ lại",
      }).then((result) => {
        if (result.value) {
          capNhatDonHangAjax(maDonHang, trangThai);
        }
      });
    } else {
      Swal.fire({
        type: "info",
        title:
          "Cập nhật đơn hàng #" +
          maDonHang +
          " thành " +
          getTenTrangThaiDonHang(trangThai) +
          "?",
        showDenyButton: true,
        showCancelButton: true,
        confirmButtonText: "Đồng ý",
        cancelButtonText: "Hủy",
      }).then((result) => {
        if (result.value) {
          capNhatDonHangAjax(maDonHang, trangThai);
        }
      });
    }
  }

  function capNhatThongKeAjax(maDonHang, trangThai) {
    $.ajax({
      type: "POST",
      url: "php/xulydonhang.php",
      dataType: "json",
      data: {
        request: "capNhatTrangThai",
        maDonHang: maDonHang,
        trangThai: trangThai,
      },
      beforeSend: function () {
        Swal.showLoading();
      },
      success: function (data, status, xhr) {
        console.log(data);
        Swal.fire({
          type: "success",
          title: "Cập nhật trạng thái đơn hàng #" + maDonHang + " thành công",
        });
        refreshTableDonHang();
      },
      error: function (e) {
        console.log(e);
        Swal.fire({
          type: "error",
          title:
            "Lỗi cập nhật trạng thái đơn hàng (admin.js > capNhatDonHangAjax)",
          html: e.responseText,
        });
      },
    });
  }

  function locThongKeTheoKhoangNgay() {
    var fromDate = new Date(document.getElementById("fromDate1").value);
    var toDate = new Date(document.getElementById("toDate1").value);

    var rows = document.querySelectorAll(".table-content2 table tbody tr");

    rows.forEach(function(row) {
        var ngayGioText = row.querySelector("td:nth-child(5)").textContent;
        var ngayGio = new Date(ngayGioText);

        // Đặt giờ, phút, giây của ngày tháng được chọn về 0 để so sánh ngày bắt đầu của fromDate và ngày kết thúc của toDate.
        fromDate.setHours(0, 0, 0, 0);
        toDate.setHours(23, 59, 59, 999);

        if (ngayGio >= fromDate && ngayGio <= toDate) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }
    });
}

  function timKiemThongKe(inp) {
    var kieuTim = document.getElementsByName("kieuTimThongKe")[0].value;
    var text = inp.value;

    // Lọc
    var vitriKieuTim = {
      ma: 1,
      khachhang: 2,
      trangThai: 6,
    };

    var listTr_table = document
      .getElementsByClassName("donhang")[0]
      .getElementsByClassName("table-content2")[0]
      .getElementsByTagName("tr");
    for (var tr of listTr_table) {
      var td = tr
        .getElementsByTagName("td")
      [vitriKieuTim[kieuTim]].innerHTML.toLowerCase();

      if (td.indexOf(text.toLowerCase()) < 0) {
        tr.style.display = "none";
      } else {
        tr.style.display = "";
      }
    }
  }

  // Sắp xếp
  function sortThongKeTable(loai) {
    var list = document
      .getElementsByClassName("donhang")[1]
      .getElementsByClassName("table-content2")[0];
    var tr = list.getElementsByTagName("tr");

    quickSort(tr, 0, tr.length - 1, loai, getValueOfTypeInTable_ThongKe);
    decrease = !decrease;
  }

  // Lấy giá trị của loại(cột) dữ liệu nào đó trong bảng
  function getValueOfTypeInTable_ThongKe(tr, loai) {
    var td = tr.getElementsByTagName("td");
    switch (loai) {
      case "stt":
        return Number(td[0].innerHTML);
      case "ma":
        return new Date(td[1].innerHTML); // chuyển về dạng ngày để so sánh ngày
      case "khach":
        return td[2].innerHTML.toLowerCase(); // lấy tên khách
      case "sanpham":
        return td[3].children.length; // lấy số lượng hàng trong đơn này, length ở đây là số lượng <p>
      case "tongtien":
        return stringToNum(td[4].innerHTML); // trả về dạng giá tiền
      case "ngaygio":
        return new Date(td[5].innerHTML); // chuyển về ngày
      case "trangthai":
        return td[6].innerHTML.toLowerCase(); //
    }
    return false;
  }

  $.post('php/xulydonhang.php', { request: 'getTopKhachHang' }, function(data) {
    // render bảng top 5 khách hàng
}, 'json');
  $.post('php/xulydonhang.php', { request: 'getDashboardStats' }, function(data) {
      $('#sosanpham').text(data.sosanpham);
      $('#sodonhang').text(data.sodonhang);
      $('#souser').text(data.souser);
      $('#tongchi').text(data.tongchi + ' vnđ');
}, 'json');

  $.post('php/xulydonhang.php', { request: 'getBrandStats' }, function(data) {
      let html = '';
      data.forEach(row => {
        html += `<tr>
          <td>${row.TenLSP}</td>
          <td>${row.da_ban}</td>
          <td>${Number(row.loinhuan).toLocaleString()} vnđ</td>
        </tr>`;
      });
      // Đảm bảo selector đúng với tbody của bảng doanh thu
      $('#brand-stats-body').html(html);
}, 'json');