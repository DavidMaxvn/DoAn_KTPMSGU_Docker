using System;
using AppAPI.IServices;
using AppAPI.Services;
using AppData.Models;
using AppData.ViewModels.Mail;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// ---------- CORS (cho WebUI gọi API) ----------
var AllowSpecificOrigins = "_allowSpecificOrigins";
var allowedOrigins = new[]
{
    "http://localhost:8080",  // nếu UI chạy cổng này
    "https://localhost:8443", // nếu UI chạy HTTPS cổng này
    "http://localhost:8081",  // nếu bạn tách UI sang 8081
    "https://localhost:8444"  // nếu bạn tách UI sang 8444
};
builder.Services.AddCors(options =>
{
    options.AddPolicy(name: AllowSpecificOrigins, policy =>
    {
        policy.WithOrigins(allowedOrigins)
              .AllowAnyHeader()
              .AllowAnyMethod();
        // Nếu dùng cookie/credentials: thêm .AllowCredentials() và giữ origins cụ thể (không dùng *)
    });
});

// ---------- MVC / Controllers ----------
builder.Services.AddControllers()
    .AddNewtonsoftJson(options =>
        options.SerializerSettings.ReferenceLoopHandling =
            Newtonsoft.Json.ReferenceLoopHandling.Ignore);

// ---------- Swagger ----------
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "Example API",
        Version = "v1",
        Description = "An example of an ASP.NET Core Web API",
        Contact = new OpenApiContact
        {
            Name  = "Example Contact",
            Email = "example@example.com",
            Url   = new Uri("https://example.com/contact"),
        },
    });
});

// ---------- EF Core ----------
builder.Services.AddDbContext<AssignmentDBContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DBContext")));

// ---------- DI các service ----------
builder.Services.AddScoped<IChiTietGioHangServices, ChiTietGioHangServices>();
builder.Services.AddScoped<IGioHangServices, GioHangServices>();
builder.Services.AddScoped<IQuyDoiDiemServices, QuyDoiDiemServices>();
builder.Services.AddScoped<IKhuyenMaiServices, KhuyenMaiServices>();
builder.Services.AddScoped<IHoaDonService, HoaDonService>();
builder.Services.AddScoped<IKhachHangService, KhachHangService>();
builder.Services.AddScoped<ILishSuTichDiemServices, LishSuTichDiemServices>();
builder.Services.AddScoped<ILoaiSPService, LoaiSPService>();
builder.Services.AddScoped<INhanVienService, NhanVienService>();
builder.Services.AddScoped<IQuanLyNguoiDungService, QuanLyNguoiDungService>();
builder.Services.AddScoped<ISanPhamService, SanPhamService>();
builder.Services.AddScoped<IVoucherServices, VoucherServices>();
builder.Services.AddScoped<IThongKeService, ThongKeService>();
builder.Services.AddScoped<IVaiTroService, VaiTroSevice>();

builder.Services.Configure<MailSettings>(builder.Configuration.GetSection("MailSettings"));
builder.Services.AddTransient<IMailServices, MailServices>();

var app = builder.Build();

// ---------- Middleware pipeline ----------
app.UseSwagger();
app.UseSwaggerUI(opt =>
{
    opt.SwaggerEndpoint("/swagger/v1/swagger.json", "v1");
});

app.UseHttpsRedirection();

app.UseRouting();

app.UseCors(AllowSpecificOrigins);

app.UseAuthorization();

app.MapControllers();

// Redirect "/" sang Swagger cho tiện truy cập
app.MapGet("/", () => Results.Redirect("/swagger", permanent: false));

app.Run();
