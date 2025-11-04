using AppData.ViewModels;
using AppView.PhanTrang;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace AppView.Controllers
{
    public class LichSuTichDiemController : Controller
    {
        private readonly HttpClient _httpClient;
        private readonly string _apiBase;
        public LichSuTichDiemController(IConfiguration config)
        {
            _httpClient = new HttpClient();
            var baseUrl = Environment.GetEnvironmentVariable("Api__BaseUrl")
                          ?? config["Api:BaseUrl"]
                          ?? "https://localhost:7000";
            if (!baseUrl.EndsWith("/")) baseUrl += "/";
            _apiBase = baseUrl + "api";
        }
        public int PageSize = 8;
        // get all LSTD
        [HttpGet]
        public async Task<IActionResult> GetAllLSTDByID(int ProductPage = 1)
        {
        //https://localhost:7000/api/LichSuTichDiem/GetLSTDByIdKH?idkh=8ba92174-c33b-4766-aad0-945166e776fc
            string apiURL = $"{_apiBase}/LichSuTichDiem/GetLSTDByIdKH";
            var response = await _httpClient.GetAsync(apiURL);
            var apiData = await response.Content.ReadAsStringAsync();
            var roles = JsonConvert.DeserializeObject<List<LichSuTichDiemView>>(apiData);
            return View(new PhanTrangLSTD
            {
               listLSTDs = roles
                        .Skip((ProductPage - 1) * PageSize).Take(PageSize),
                PagingInfo = new PagingInfo
                {
                    ItemsPerPage = PageSize,
                    CurrentPage = ProductPage,
                    TotalItems = roles.Count()
                }

            }
                );

        }
        // delete 
        public async Task<IActionResult> Delete(Guid id)
        {
            string apiURL = $"{_apiBase}/Voucher/{id}";

            var response = await _httpClient.DeleteAsync(apiURL);
            if (response.IsSuccessStatusCode)
            {
                return RedirectToAction("GetAllLSTDByID");
            }
            return View();
        }
    }
}
