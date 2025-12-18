using AppAPI.Services;
using AppData.Models;
using AppData.ViewModels.SanPham;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xunit;

namespace AppAPI.Tests
{
    public class GioHangServicesTests
    {
        private AssignmentDBContext GetInMemoryDbContext()
        {
            var options = new DbContextOptionsBuilder<AssignmentDBContext>()
                .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
                .Options;
            return new AssignmentDBContext(options);
        }

        [Fact]
        public void Add_ShouldCreateGioHang_WhenValid()
        {
            // Arrange
            using var context = GetInMemoryDbContext();
            var sanPhamService = new SanPhamService(context);
            var service = new GioHangServices(context, sanPhamService);
            var userId = Guid.NewGuid();

            // Act
            var result = service.Add(userId, DateTime.Now);

            // Assert
            Assert.True(result);
            Assert.NotNull(context.GioHangs.FirstOrDefault(g => g.IDKhachHang == userId));
        }

        [Fact]
        public void GetCart_ShouldCalculateTotal_WhenItemsExist()
        {
            // Arrange
            using var context = GetInMemoryDbContext();
            var sanPhamService = new SanPhamService(context);
            var service = new GioHangServices(context, sanPhamService);

            // Seed Product
            var chatLieu = new ChatLieu { ID = Guid.NewGuid(), Ten = "Cotton", TrangThai = 1 };
            var loaiSP = new LoaiSP { ID = Guid.NewGuid(), Ten = "Ao Thun", TrangThai = 1 };
            var mauSac = new MauSac { ID = Guid.NewGuid(), Ten = "Red", Ma = "#FF0000", TrangThai = 1 };
            var kichCo = new KichCo { ID = Guid.NewGuid(), Ten = "L", TrangThai = 1 };
            
            context.ChatLieus.Add(chatLieu);
            context.LoaiSPs.Add(loaiSP);
            context.MauSacs.Add(mauSac);
            context.KichCos.Add(kichCo);
            
            var sanPham = new SanPham { ID = Guid.NewGuid(), Ten = "Ao Thun Test", Ma = "SP001", TrangThai = 1, IDChatLieu = chatLieu.ID, IDLoaiSP = loaiSP.ID };
            context.SanPhams.Add(sanPham);

            var ctsp = new ChiTietSanPham 
            { 
                ID = Guid.NewGuid(), 
                IDSanPham = sanPham.ID, 
                IDMauSac = mauSac.ID.Value, 
                IDKichCo = kichCo.ID, 
                GiaBan = 100000, 
                SoLuong = 10, 
                TrangThai = 1 
            };
            context.ChiTietSanPhams.Add(ctsp);
            context.SaveChanges();

            var request = new List<GioHangRequest>
            {
                new GioHangRequest { IDChiTietSanPham = ctsp.ID, SoLuong = 2 }
            };

            // Act
            var result = service.GetCart(request);

            // Assert
            Assert.Equal(200000, result.TongTien);
            Assert.Equal("Ao Thun Test", result.GioHangs[0].Ten);
        }
    }
}
