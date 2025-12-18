using AppAPI.Services;
using AppData.Models;
using AppData.ViewModels;
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
    public class HoaDonServiceTests
    {
        private AssignmentDBContext GetInMemoryDbContext()
        {
            var options = new DbContextOptionsBuilder<AssignmentDBContext>()
                .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
                .Options;
            return new AssignmentDBContext(options);
        }

        [Fact]
        public void CheckVoucher_ShouldReduceAmount_WhenVoucherIsValid()
        {
            // Arrange
            using var context = GetInMemoryDbContext();
            var sanPhamService = new SanPhamService(context);
            var gioHangService = new GioHangServices(context, sanPhamService);
            var service = new HoaDonService(context, gioHangService);

            var voucher = new Voucher 
            { 
                ID = Guid.NewGuid(), 
                Ten = "TEST10", 
                GiaTri = 10000, 
                HinhThucGiamGia = 1, // Fixed amount
                SoTienCan = 50000, 
                NgayApDung = DateTime.Now.AddDays(-1), 
                NgayKetThuc = DateTime.Now.AddDays(1), 
                SoLuong = 10, 
                TrangThai = 1 
            };
            context.Vouchers.Add(voucher);
            context.SaveChanges();

            // Act
            var result = service.CheckVoucher("TEST10", 100000);

            // Assert
            Assert.Equal(90000, result);
        }

        [Fact]
        public void CheckVoucher_ShouldNotReduce_WhenAmountNotEnough()
        {
            // Arrange
            using var context = GetInMemoryDbContext();
            var sanPhamService = new SanPhamService(context);
            var gioHangService = new GioHangServices(context, sanPhamService);
            var service = new HoaDonService(context, gioHangService);

            var voucher = new Voucher 
            { 
                ID = Guid.NewGuid(), 
                Ten = "TEST10", 
                GiaTri = 10000, 
                HinhThucGiamGia = 1, 
                SoTienCan = 200000, 
                NgayApDung = DateTime.Now.AddDays(-1), 
                NgayKetThuc = DateTime.Now.AddDays(1), 
                SoLuong = 10, 
                TrangThai = 1 
            };
            context.Vouchers.Add(voucher);
            context.SaveChanges();

            // Act
            var result = service.CheckVoucher("TEST10", 100000);

            // Assert
            Assert.Equal(100000, result);
        }
    }
}
