<!DOCTYPE html>
<html lang="vi">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <title>Tin tức - Thế giới - Tai nghe</title>
  <link rel="shortcut icon" href="img/Logo.ico" />

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
  <link rel="stylesheet" href="css/tintuc.css">

  <!-- js -->
  <script src="data/products.js?v=<?php echo time();?>"></script>
  <script src="js/dungchung.js?v=<?php echo time();?>"></script>

  <?php require_once "php/echoHTML.php"; ?>

</head>

<body>
  <?php addTopNav(); ?>

  <section style="min-height: 85vh">
    <?php addHeader(); ?>

    <div class="body-tintuc">

      <script>
        let tintuc = [{
          title: 'Khám phá dòng sản phẩm Samsung Galaxy Buds',
          a: "https://www.samsung.com/vn/audio-sound/?product1=sm-r510nlvaxxv&product2=sm-r177nzkaxxv&product3=sm-r400nzaaxxv",
          img: "img/tintuc/tintuc1.jpg",
          source: "Samsung",
          time: "3 giờ"
        }, {
          title: 'AirPods (thế hệ thứ 3) với Hộp Sạc Lightning',
          a: "https://www.apple.com/vn/shop/product/MPNY3ZP/A/airpods-3rd-generation-with-lightning-charging-case",
          img: "img/tintuc/tintuc2.jpg",
          source: "Apple",
          time: "6 giờ"
        }, {
          title: 'Dòng 1000X viết lại các quy tắc về trải nghiệm nghe không gián đoạn.',
          a: "https://www.sony.com.vn/headphones",
          img: "img/tintuc/tintuc3.jpg",
          source: "Sony",
          time: "6 giờ"
        }, {
          title: 'Tai nghe Sennheiser MOMENTUM 4 Wireless ra mắt, giá 9,490,000 VND',
          a: "https://congngheviet.com/tai-nghe-sennheiser-momentum-4-wireless-ra-mat-gia-9490000-vnd/",
          img: "img/tintuc/tintuc4.jpg",
          source: "Congngheviet",
          time: "13 giờ"
        }, {
          title: 'Jabra’s New Elite 4 Earbuds Finally Get ANC',
          a: "https://techgit.net/jabras-new-elite-4-earbuds-finally-get-anc/",
          img: "img/tintuc/tintuc5.jpg",
          source: "techgit",
          time: "9 giờ"
        }, {
          title: 'Dòng 1000X viết lại các quy tắc về trải nghiệm nghe không gián đoạn.',
          a: "https://www.sony.com.vn/headphones",
          img: "img/tintuc/tintuc3.jpg",
          source: "Sony",
          time: "6 giờ"
        }, {
          title: 'Tai nghe Sennheiser MOMENTUM 4 Wireless ra mắt, giá 9,490,000 VND',
          a: "https://congngheviet.com/tai-nghe-sennheiser-momentum-4-wireless-ra-mat-gia-9490000-vnd/",
          img: "img/tintuc/tintuc4.jpg",
          source: "Congngheviet",
          time: "13 giờ"
        }, {
          title: 'Khám phá dòng sản phẩm Samsung Galaxy Buds',
          a: "https://www.samsung.com/vn/audio-sound/?product1=sm-r510nlvaxxv&product2=sm-r177nzkaxxv&product3=sm-r400nzaaxxv",
          img: "img/tintuc/tintuc1.jpg",
          source: "Samsung",
          time: "3 giờ"
        }, ]

        for (let t of tintuc) {
          document.write(`
          <div class="card">
            <img src="${t.img}" alt="Avatar" style="width:100%">
            <div class="container">
              <h4><a href="${t.a}" target="_blank">${t.title}</></h4> 
              <p>${t.source} &emsp;${t.time}</p> 
            </div>
          </div>
          `)
        }
      </script>

    </div>

  </section>

  <?php addContainTaiKhoan(); ?>

  <div class="footer">
    <?php addPlc(); addFooter(); ?>

  </div>

  <i class="fa fa-arrow-up" id="goto-top-page" onclick="gotoTop()"></i>

</body>

</html>