using AppAPI.Services;
using AppData.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xunit;

namespace AppAPI.Tests
{
    public class VaiTroServiceTests
    {
        private AssignmentDBContext GetInMemoryDbContext()
        {
            var options = new DbContextOptionsBuilder<AssignmentDBContext>()
                .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
                .Options;
            return new AssignmentDBContext(options);
        }

        [Fact]
        public void CreateVaiTro_ShouldAddRole_WhenValid()
        {
            // Arrange
            using var context = GetInMemoryDbContext();
            var service = new VaiTroSevice(context);

            // Act
            var result = service.CreateVaiTro("Admin", 1);

            // Assert
            Assert.True(result);
            Assert.NotNull(context.VaiTros.FirstOrDefault(v => v.Ten == "Admin"));
        }

        [Fact]
        public void DeleteVaiTro_ShouldRemoveRole_WhenExists()
        {
            // Arrange
            using var context = GetInMemoryDbContext();
            var service = new VaiTroSevice(context);
            var role = new VaiTro { ID = Guid.NewGuid(), Ten = "User", TrangThai = 1 };
            context.VaiTros.Add(role);
            context.SaveChanges();

            // Act
            var result = service.DeleteVaiTro(role.ID);

            // Assert
            Assert.True(result);
            Assert.Null(context.VaiTros.FirstOrDefault(v => v.ID == role.ID));
        }
    }
}
