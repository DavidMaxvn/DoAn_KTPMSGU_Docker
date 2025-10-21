using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace AppData.Models
{
    public class AssignmentDbContextFactory : IDesignTimeDbContextFactory<AssignmentDBContext>
    {
        public AssignmentDBContext CreateDbContext(string[] args)
        {
            var connectionString = Environment.GetEnvironmentVariable("ConnectionStrings__DBContext");

            if (string.IsNullOrWhiteSpace(connectionString))
            {
                connectionString = "Server=tcp:db,1433;Database=AppBanQuanAoThoiTrangNam;User Id=sa;Password=S3cure!Pass2025;Encrypt=False;TrustServerCertificate=True;MultipleActiveResultSets=True;TransparentNetworkIPResolution=False;";
            }

            var optionsBuilder = new DbContextOptionsBuilder<AssignmentDBContext>();
            optionsBuilder.UseSqlServer(connectionString);

            return new AssignmentDBContext(optionsBuilder.Options);
        }
    }
}
