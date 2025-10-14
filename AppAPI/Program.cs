using AppAPI.IServices;
using AppAPI.Services;
using AppData.Models;
using AppData.ViewModels.Mail;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// ===== CORS =====
const string AllowSpecificOrigins = "_allowSpecificOrigins";
builder.Services.AddCors(options =>
{
    options.AddPolicy(name: AllowSpecificOrigins, policy =>
    {
        policy
            .WithOrigins(
                "http://localhost:8080",   // khi bạn mở UI từ host
                "https://localhost:8443",  // khi bạn mở UI qua HTTPS
                "http://appview"           // khi UI gọi API trong Docker
            )
            .AllowAnyHeader()
            .AllowAnyMethod();
    });
});

// ===== Controllers & Swagger =====
builder.Services.AddControllers();
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
            Name = "Example Contact",
            Email = "example@example.com",
            Url = new Uri("https://example.com/contact")
        }
    });
});

// ===== DB Context =====
builder.Services.AddDbContext<AssignmentDBContext>(options =>
{
    options.UseSqlServer(builder.Configuration.GetConnectionString("DBContext"));
});

// ===== DI các service =====
// builder.Services.AddScoped<IChiTietKhuyenMaiServices,ChiTietKhuyenMaiServices>();
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

// ===== Mail settings =====
builder.Services.Configure<MailSettings>(builder.Configuration.GetSection("MailSettings"));
builder.Services.AddTransient<IMailServices, MailServices>();

// (tuỳ chọn) JSON loop ignore
builder.Services
    .AddControllersWithViews()
    .AddNewtonsoftJson(o =>
        o.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore);

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// CHỈ bật HTTPS redirect ở Production
if (app.Environment.IsProduction())
{
    app.UseHttpsRedirection();
}

app.UseCors(AllowSpecificOrigins);
app.UseAuthorization();

app.MapControllers();

app.Run();

// ===== Swagger (bật mọi môi trường cho container) =====
app.UseSwagger();
app.UseSwaggerUI(opt =>
{
    opt.SwaggerEndpoint("/swagger/v1/swagger.json", "v1");
});

// !!! API container không phục vụ static UI: bỏ UseDefaultFiles/UseStaticFiles ở đây
// Nếu trước đó bạn có UseHttpsRedirection mà không có cert dev -> có thể comment dòng dưới:
app.UseHttpsRedirection();

app.UseCors(AllowSpecificOrigins);
app.UseAuthorization();

app.MapControllers();

// Trang gốc chuyển sang Swagger cho dễ kiểm tra
app.MapGet("/", () => Results.Redirect("/swagger", false));

// ===== Migrate DB có retry để tránh container tắt ngay khi DB chưa sẵn sàng =====
using (var scope = app.Services.CreateScope())
{
    var logger = scope.ServiceProvider.GetRequiredService<ILogger<Program>>();
    var db = scope.ServiceProvider.GetRequiredService<AssignmentDBContext>();

    const int maxRetry = 10;
    for (int i = 1; i <= maxRetry; i++)
    {
        try
        {
            db.Database.Migrate();
            logger.LogInformation("Database migrate OK.");
            break;
        }
        catch (Exception ex)
        {
            logger.LogWarning(ex, "DB chưa sẵn sàng (attempt {i}/{max})", i, maxRetry);
            await Task.Delay(3000);
            if (i == maxRetry)
            {
                logger.LogError(ex, "Database migrate FAILED after retries.");
                // Không throw để container không crash; API vẫn chạy, bạn có thể seed DB thủ công.
            }
        }
    }
}

app.Run();