using System;
using Microsoft.EntityFrameworkCore;
using System.Reflection;

namespace AppData.Models
{
    public class AssignmentDBContext : DbContext
    {
        public AssignmentDBContext()
        {
        }
        public AssignmentDBContext(DbContextOptions options) : base(options)
        {
        }
        public DbSet<ChiTietGioHang> ChiTietGioHangs { get; set; }
        public DbSet<ChiTietSanPham> ChiTietSanPhams { get; set; }
        public DbSet<MauSac> MauSacs { get; set; }
        public DbSet<KichCo> KichCos { get; set; }
        public DbSet<ChatLieu> ChatLieus { get; set; }
        public DbSet<ChiTietHoaDon> ChiTietHoaDons { get; set; }
        public DbSet<GioHang> GioHangs { get; set; }
        public DbSet<HoaDon> HoaDons { get; set; }
        public DbSet<KhuyenMai> KhuyenMais { get; set; }
        public DbSet<LichSuTichDiem> LichSuTichDiems { get; set; }
        public DbSet<LoaiSP> LoaiSPs { get; set; }
        public DbSet<KhachHang> KhachHangs { get; set; }
        public DbSet<NhanVien> NhanViens { get; set; }
        public DbSet<DanhGia> DanhGias { get; set; }
        public DbSet<QuyDoiDiem> QuyDoiDiems { get; set; }
        public DbSet<SanPham> SanPhams { get; set; }
        public DbSet<VaiTro> VaiTros { get; set; }
        public DbSet<Voucher> Vouchers { get; set; }
        public DbSet<Anh> Anhs { get; set; }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                var connectionString = Environment.GetEnvironmentVariable("ConnectionStrings__DBContext");

                if (string.IsNullOrWhiteSpace(connectionString))
                {
                    connectionString = "Server=tcp:db,1433;Database=AppBanQuanAoThoiTrangNam;User Id=sa;Password=S3cure!Pass2025;Encrypt=False;TrustServerCertificate=True;MultipleActiveResultSets=True;TransparentNetworkIPResolution=False;";
                }

                optionsBuilder.UseSqlServer(connectionString);
            }
        }
        //THUYNHU\\SQLEXPRESS
        //DESKTOP-UOIH77U\\SQLEXPRESS
        //LAPTOP-A15NGLBG\\SQLEXPRESS
        // lam DESKTOP-S6G7NFV\\SQLEXPRESS // 1AppBanQuanAoThoiTrangNam
        //LAPTOP-G189FU38\\SQLEXPRESS
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());
        }
    }
}
