<!DOCTYPE html>
<html lang="vi">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Giới thiệu - Tai nghe</title>
  <link rel="shortcut icon" href="img/myicon.ico" />

  <!-- Load font awesome icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
    crossorigin="anonymous">

  <!-- our files -->
  <!-- css -->
  <link rel="stylesheet" href="css/MyStyle.css">
  <link rel="stylesheet" href="css/topnav.css">
  <link rel="stylesheet" href="css/header.css">
  <link rel="stylesheet" href="css/TaiKhoan.css">
  <link rel="stylesheet" href="css/footer.css">
  <link rel="stylesheet" href="css/gioithieu.css">

  <!-- js -->
  <script src="data/products.js?v=<?php echo time();?>"></script>
  <script src="js/dungchung.js?v=<?php echo time();?>"></script>

  <?php require_once "php/echoHTML.php"; ?>

</head>

<body>
  <?php addTopNav(); ?>

  <section style="min-height: 85vh">
    <?php addHeader(); ?>

    <div class="page-gt">
      <h4 class="page-header">
        Giới thiệu
      </h4>
      <div class="page-info">
        <img src="https://genk.mediacdn.vn/139269124445442048/2022/12/7/photo-3-16703042041441018509108-1670392802079-1670392802346217721331.png">

        <ol class="gradient-list">
          <li>Thời gian phục vụ khách hàng là từ 08h00 sáng đến 21h30 tất cả các ngày trong tuần và 24/7</li>
          <li>Chúng tôi cam kết luôn luôn ưu tiên lợi ích của khách hàng, sản phẩm chất lượng luôn được cập nhật phù hợp
            với nhu cầu của tất cả khách hàng.</li>
          <li>Tất cả các sản phẩm Tai nghe là thế mạnh chính và cung cấp ra thị trường được đảm bảo 100% nguyên hộp,
            trùng IMEI với phụ kiện nguyên SEAL. Đây là điều rất ít cửa hàng bán lẻ nào có thể làm được ở VN theo cách
            duy
            trì.</li>
          <li>Chúng tôi là cửa hàng uy tín đã được khảng định với tất cả các khách hàng. Cám ơn tất cả các khách hàng đã
            mua và ủng hộ chúng tôi trong suốt thời gian qua. </li>
        </ol>
      </div>
    </div>
  </section>

  <?php addContainTaiKhoan(); ?>

  <div class="footer">
    <?php addPlc(); addFooter(); ?>

  </div>

  <i class="fa fa-arrow-up" id="goto-top-page" onclick="gotoTop()"></i>
</body>

</html>