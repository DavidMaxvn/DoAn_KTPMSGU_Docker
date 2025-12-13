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
    public class SanPhamServiceTests
    {
        private AssignmentDBContext GetInMemoryDbContext()
        {
            var options = new DbContextOptionsBuilder<AssignmentDBContext>()
                .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
                .Options;
            return new AssignmentDBContext(options);
        }

        [Fact]
        public async Task UpdateSanPham_ShouldReturnTrue_WhenValidRequest()
        {
            // Arrange
            var context = GetInMemoryDbContext();
            var service = new SanPhamService(context);

            var loaiSPCha = new LoaiSP { ID = Guid.NewGuid(), Ten = "Ao", TrangThai = 1 };
            var loaiSPCon = new LoaiSP { ID = Guid.NewGuid(), Ten = "Ao Thun", IDLoaiSPCha = loaiSPCha.ID, TrangThai = 1 };
            var chatLieu = new ChatLieu { ID = Guid.NewGuid(), Ten = "Cotton", TrangThai = 1 };
            var sanPham = new SanPham { ID = Guid.NewGuid(), Ten = "Ao Thun Cu", MoTa = "Cu", IDLoaiSP = loaiSPCon.ID, IDChatLieu = chatLieu.ID, TrangThai = 1 };

            await context.LoaiSPs.AddRangeAsync(loaiSPCha, loaiSPCon);
            await context.ChatLieus.AddAsync(chatLieu);
            await context.SanPhams.AddAsync(sanPham);
            await context.SaveChangesAsync();

            var request = new SanPhamUpdateRequest
            {
                ID = sanPham.ID,
                Ten = "Ao Thun Moi",
                MoTa = "Moi",
                TenChatLieu = "Cotton",
                TenLoaiSPCha = "Ao",
                TenLoaiSPCon = "Ao Thun"
            };

            // Act
            var result = await service.UpdateSanPham(request);

            // Assert
            Assert.True(result);
            var updatedSanPham = await context.SanPhams.FindAsync(sanPham.ID);
            Assert.Equal("Ao Thun Moi", updatedSanPham.Ten);
            Assert.Equal("Moi", updatedSanPham.MoTa);
        }

        [Fact]
        public async Task UpdateSanPham_ShouldCreateNewCategoriesAndMaterial_WhenTheyDoNotExist()
        {
            // Arrange
            var context = GetInMemoryDbContext();
            var service = new SanPhamService(context);

            var sanPham = new SanPham { ID = Guid.NewGuid(), Ten = "Ao Thun Cu", MoTa = "Cu", IDLoaiSP = Guid.NewGuid(), IDChatLieu = Guid.NewGuid(), TrangThai = 1 };
            await context.SanPhams.AddAsync(sanPham);
            await context.SaveChangesAsync();

            var request = new SanPhamUpdateRequest
            {
                ID = sanPham.ID,
                Ten = "Ao Thun Moi",
                MoTa = "Moi",
                TenChatLieu = "Lua",
                TenLoaiSPCha = "Quan",
                TenLoaiSPCon = "Quan Dai"
            };

            // Act
            var result = await service.UpdateSanPham(request);

            // Assert
            Assert.True(result);
            var updatedSanPham = await context.SanPhams.FindAsync(sanPham.ID);
            Assert.Equal("Ao Thun Moi", updatedSanPham.Ten);

            var newChatLieu = await context.ChatLieus.FirstOrDefaultAsync(x => x.Ten == "Lua");
            Assert.NotNull(newChatLieu);
            Assert.Equal(newChatLieu.ID, updatedSanPham.IDChatLieu);

            var newLoaiSPCha = await context.LoaiSPs.FirstOrDefaultAsync(x => x.Ten == "Quan");
            Assert.NotNull(newLoaiSPCha);

            var newLoaiSPCon = await context.LoaiSPs.FirstOrDefaultAsync(x => x.Ten == "Quan Dai");
            Assert.NotNull(newLoaiSPCon);
            Assert.Equal(newLoaiSPCha.ID, newLoaiSPCon.IDLoaiSPCha);
            Assert.Equal(newLoaiSPCon.ID, updatedSanPham.IDLoaiSP);
        }

        [Fact]
        public async Task UpdateSanPham_ShouldReturnFalse_WhenSanPhamDoesNotExist()
        {
            // Arrange
            var context = GetInMemoryDbContext();
            var service = new SanPhamService(context);

            var request = new SanPhamUpdateRequest
            {
                ID = Guid.NewGuid(),
                Ten = "Ao Thun Moi",
                MoTa = "Moi",
                TenChatLieu = "Cotton",
                TenLoaiSPCha = "Ao",
                TenLoaiSPCon = "Ao Thun"
            };

            // Act
            var result = await service.UpdateSanPham(request);

            // Assert
            Assert.False(result);
        }

        [Fact]
        public async Task GetSanPhamById_ShouldReturnCorrectData_WhenExists()
        {
            // Arrange
            var context = GetInMemoryDbContext();
            var service = new SanPhamService(context);

            var loaiSPCha = new LoaiSP { ID = Guid.NewGuid(), Ten = "Ao", TrangThai = 1 };
            var loaiSPCon = new LoaiSP { ID = Guid.NewGuid(), Ten = "Ao Thun", IDLoaiSPCha = loaiSPCha.ID, TrangThai = 1 };
            var chatLieu = new ChatLieu { ID = Guid.NewGuid(), Ten = "Cotton", TrangThai = 1 };
            var sanPham = new SanPham { ID = Guid.NewGuid(), Ten = "Ao Thun Test", MoTa = "Mo ta test", IDLoaiSP = loaiSPCon.ID, IDChatLieu = chatLieu.ID, TrangThai = 1 };

            await context.LoaiSPs.AddRangeAsync(loaiSPCha, loaiSPCon);
            await context.ChatLieus.AddAsync(chatLieu);
            await context.SanPhams.AddAsync(sanPham);
            await context.SaveChangesAsync();

            // Act
            var result = await service.GetSanPhamById(sanPham.ID);

            // Assert
            Assert.NotNull(result);
            Assert.Equal(sanPham.ID, result.ID);
            Assert.Equal("Ao Thun Test", result.Ten);
            Assert.Equal("Mo ta test", result.MoTa);
            Assert.Equal("Cotton", result.TenChatLieu);
            Assert.Equal("Ao", result.TenLoaiSPCha);
            Assert.Equal("Ao Thun", result.TenLoaiSPCon);
        }

        [Fact]
        public async Task GetSanPhamById_ShouldReturnEmptyObject_WhenDoesNotExist()
        {
            // Arrange
            var context = GetInMemoryDbContext();
            var service = new SanPhamService(context);

            // Act
            var result = await service.GetSanPhamById(Guid.NewGuid());

            // Assert
            Assert.NotNull(result);
            Assert.Equal(Guid.Empty, result.ID);
            Assert.Null(result.Ten);
        }

        [Fact]
        public void GetAllSanPhamAdmin_ShouldReturnCorrectData()
        {
            // Arrange
            var context = GetInMemoryDbContext();
            var service = new SanPhamService(context);

            var loaiSPCha = new LoaiSP { ID = Guid.NewGuid(), Ten = "Ao", TrangThai = 1 };
            var loaiSPCon = new LoaiSP { ID = Guid.NewGuid(), Ten = "Ao Thun", IDLoaiSPCha = loaiSPCha.ID, TrangThai = 1 };
            var chatLieu = new ChatLieu { ID = Guid.NewGuid(), Ten = "Cotton", TrangThai = 1 };
            var sanPham = new SanPham { ID = Guid.NewGuid(), Ten = "Ao Thun Test", Ma = "SP001", IDLoaiSP = loaiSPCon.ID, IDChatLieu = chatLieu.ID, TrangThai = 1 };
            
            var mauSac = new MauSac { ID = Guid.NewGuid(), Ten = "Do", TrangThai = 1 };
            var kichCo = new KichCo { ID = Guid.NewGuid(), Ten = "L", TrangThai = 1 };
            
            var chiTietSanPham = new ChiTietSanPham 
            { 
                IDSanPham = (Guid)sanPham.ID, 
                IDMauSac = (Guid)mauSac.ID, 
                IDKichCo = (Guid)kichCo.ID, 
                GiaBan = 100000, 
                SoLuong = 10, 
                TrangThai = 1 
            };
            chiTietSanPham.ID = Guid.NewGuid();

            var anh = new Anh { ID = Guid.NewGuid(), IDSanPham = sanPham.ID, IDMauSac = mauSac.ID, DuongDan = "image.jpg", TrangThai = 1 };

            context.LoaiSPs.AddRange(loaiSPCha, loaiSPCon);
            context.ChatLieus.Add(chatLieu);
            context.SanPhams.Add(sanPham);
            context.MauSacs.Add(mauSac);
            context.KichCos.Add(kichCo);
            context.ChiTietSanPhams.Add(chiTietSanPham);
            context.Anhs.Add(anh);
            context.SaveChanges();

            // Act
            var result = service.GetAllSanPhamAdmin();

            // Assert
            Assert.NotNull(result);
            Assert.NotEmpty(result);
            var spViewModel = result.First();
            Assert.Equal(sanPham.ID, spViewModel.ID);
            Assert.Equal("Ao Thun Test", spViewModel.Ten);
            Assert.Equal("SP001", spViewModel.Ma);
            Assert.Equal("Ao", spViewModel.LoaiSPCha);
            Assert.Equal("Ao Thun", spViewModel.LoaiSPCon);
            Assert.Equal("Cotton", spViewModel.ChatLieu);
            Assert.Equal("image.jpg", spViewModel.Anh);
            Assert.Equal(100000, spViewModel.GiaGoc);
            Assert.Equal(100000, spViewModel.GiaBan); // No promotion
        }

        [Fact]
        public void GetKhuyenMai_ShouldCalculateCorrectly_WhenDiscountByValue()
        {
            // Arrange
            var context = GetInMemoryDbContext();
            var service = new SanPhamService(context);
            int giaTri = 10000;
            int giaSP = 100000;
            int trangThai = 0; // Value discount

            // Act
            var result = service.GetKhuyenMai(giaTri, giaSP, trangThai);

            // Assert
            Assert.Equal(90000, result);
        }

        [Fact]
        public void GetKhuyenMai_ShouldCalculateCorrectly_WhenDiscountByPercentage()
        {
            // Arrange
            var context = GetInMemoryDbContext();
            var service = new SanPhamService(context);
            int giaTri = 20; // 20%
            int giaSP = 100000;
            int trangThai = 1; // Percentage discount

            // Act
            var result = service.GetKhuyenMai(giaTri, giaSP, trangThai);

            // Assert
            Assert.Equal(80000, result);
        }

        [Fact]
        public async Task AddSanPham_ShouldAddProductAndDetails_WhenRequestIsValid()
        {
            // Arrange
            using var context = GetInMemoryDbContext();
            var service = new SanPhamService(context);
            
            // Seed required data
            var chatLieu = new ChatLieu { ID = Guid.NewGuid(), Ten = "Cotton", TrangThai = 1 };
            var loaiSP = new LoaiSP { ID = Guid.NewGuid(), Ten = "Ao Thun", TrangThai = 1 };
            context.ChatLieus.Add(chatLieu);
            context.LoaiSPs.Add(loaiSP);
            context.SaveChanges();

            var request = new SanPhamRequest
            {
                Ten = "Ao Thun Test",
                TenChatLieu = "Cotton",
                TenLoaiSPCha = "Ao Thun",
                TenLoaiSPCon = "Ao Thun Con",
                MoTa = "Mo ta test",
                MauSacs = new List<MauSac> 
                { 
                    new MauSac { Ten = "Red", Ma = "#ff0000" }, 
                    new MauSac { Ten = "Blue", Ma = "#0000ff" } 
                },
                KichCos = new List<string> { "M", "L" }
            };

            // Act
            var result = await service.AddSanPham(request);

            // Assert
            Assert.NotNull(result);
            Assert.NotEqual(Guid.Empty, result.IDSanPham);
            
            // Verify SanPham created
            var sanPham = context.SanPhams.FirstOrDefault(sp => sp.Ten == "Ao Thun Test");
            Assert.NotNull(sanPham);
            Assert.Equal(chatLieu.ID, sanPham.IDChatLieu);
            // Assert.Equal(loaiSP.ID, sanPham.IDLoaiSP); // IDLoaiSP will be the ID of LoaiSPCon, not LoaiSPCha

            // Verify ChiTietSanPham created
            // The AddSanPham method does NOT create ChiTietSanPham entries in the database!
            // It returns a list of ChiTietSanPhamRequest in the result, which are then presumably sent to another endpoint or saved later?
            // Let's check AddSanPham logic again.
            // It calls CreateChiTietSanPhamFromSanPham which returns a request object, but does NOT save ChiTietSanPham to DB.
            // It only saves MauSac and KichCo to DB.
            
            // So we should verify that MauSac and KichCo are created.
            Assert.Equal(2, context.MauSacs.Count());
            Assert.Equal(2, context.KichCos.Count());
            
            // And verify the result contains the combinations
            Assert.Equal(4, result.ChiTietSanPhams.Count);
        }

        [Fact]
        public async Task AddAnhToSanPham_ShouldAddImages_WhenRequestIsValid()
        {
            // Arrange
            using var context = GetInMemoryDbContext();
            var service = new SanPhamService(context);

            var sanPhamId = Guid.NewGuid();
            var mauSac = new MauSac { ID = Guid.NewGuid(), Ten = "Red", Ma = "#FF0000", TrangThai = 1 };
            context.MauSacs.Add(mauSac);
            context.SaveChanges();

            var request = new List<AnhRequest>
            {
                new AnhRequest { IDSanPham = sanPhamId, MaMau = "#FF0000", DuongDan = "image1.jpg" },
                new AnhRequest { IDSanPham = sanPhamId, MaMau = "#FF0000", DuongDan = "image2.jpg" }
            };

            // Act
            var result = await service.AddAnhToSanPham(request);

            // Assert
            Assert.True(result);
            Assert.Equal(2, context.Anhs.Count());
            Assert.Contains(context.Anhs, a => a.DuongDan == "image1.jpg" && a.IDSanPham == sanPhamId && a.IDMauSac == mauSac.ID);
        }

        [Fact]
        public void GetAllAnhSanPham_ShouldReturnImages_WhenExists()
        {
            // Arrange
            using var context = GetInMemoryDbContext();
            var service = new SanPhamService(context);

            var sanPhamId = Guid.NewGuid();
            var mauSac = new MauSac { ID = Guid.NewGuid(), Ten = "Red", Ma = "#FF0000", TrangThai = 1 };
            context.MauSacs.Add(mauSac);

            var anh1 = new Anh { ID = Guid.NewGuid(), IDSanPham = sanPhamId, IDMauSac = mauSac.ID, DuongDan = "img1.jpg", TrangThai = 1 };
            var anh2 = new Anh { ID = Guid.NewGuid(), IDSanPham = sanPhamId, IDMauSac = mauSac.ID, DuongDan = "img2.jpg", TrangThai = 1 };
            context.Anhs.AddRange(anh1, anh2);
            context.SaveChanges();

            // Act
            var result = service.GetAllAnhSanPham(sanPhamId);

            // Assert
            Assert.Equal(2, result.Count);
            Assert.Contains(result, a => a.DuongDan == "img1.jpg" && a.TenMau == "Red");
            Assert.Contains(result, a => a.DuongDan == "img2.jpg" && a.TenMau == "Red");
        }
    }
}
