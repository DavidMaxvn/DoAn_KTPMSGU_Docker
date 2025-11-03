using System;
using System.IO;
using System.Net.Http;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;

namespace AppView.Services
{
    public static class ApiClientFactory
    {
        internal const string LegacyBaseUrl = "https://localhost:7095/api/";
        private static readonly Lazy<string> _baseUrl = new Lazy<string>(ResolveBaseUrl);

        public static HttpClient CreateClient()
        {
            var baseUrl = _baseUrl.Value;
            var handler = new ApiBaseUrlHandler(baseUrl)
            {
                InnerHandler = new HttpClientHandler
                {
                    ServerCertificateCustomValidationCallback = HttpClientHandler.DangerousAcceptAnyServerCertificateValidator
                }
            };

            return new HttpClient(handler)
            {
                BaseAddress = new Uri(baseUrl)
            };
        }

        public static string BaseUrl => _baseUrl.Value;

        public static string NormalizeUrl(string url)
        {
            if (string.IsNullOrWhiteSpace(url))
            {
                return BaseUrl;
            }

            if (Uri.TryCreate(url, UriKind.Absolute, out _))
            {
                return url.Replace(LegacyBaseUrl, BaseUrl, StringComparison.OrdinalIgnoreCase);
            }

            return Combine(BaseUrl, url);
        }

        private static string ResolveBaseUrl()
        {
            var environmentOverride = Environment.GetEnvironmentVariable("API_BASE_URL");
            if (!string.IsNullOrWhiteSpace(environmentOverride))
            {
                return EnsureTrailingSlash(environmentOverride);
            }

            var config = BuildConfiguration();
            var configured = config["ApiSettings:BaseUrl"];
            if (!string.IsNullOrWhiteSpace(configured))
            {
                return EnsureTrailingSlash(configured);
            }

            return LegacyBaseUrl;
        }

        private static IConfigurationRoot BuildConfiguration()
        {
            var environment = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Production";

            return new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: false)
                .AddJsonFile($"appsettings.{environment}.json", optional: true, reloadOnChange: false)
                .AddEnvironmentVariables()
                .Build();
        }

        private static string EnsureTrailingSlash(string baseUrl)
        {
            if (string.IsNullOrWhiteSpace(baseUrl))
            {
                return LegacyBaseUrl;
            }

            if (!baseUrl.EndsWith('/'))
            {
                baseUrl += "/";
            }

            return baseUrl;
        }

        private static string Combine(string baseUrl, string relative)
        {
            if (string.IsNullOrWhiteSpace(relative))
            {
                return EnsureTrailingSlash(baseUrl);
            }

            return EnsureTrailingSlash(baseUrl).TrimEnd('/') + "/" + relative.TrimStart('/');
        }
    }

    internal sealed class ApiBaseUrlHandler : DelegatingHandler
    {
        private readonly string _baseUrl;

        public ApiBaseUrlHandler(string baseUrl)
        {
            _baseUrl = baseUrl;
        }

        protected override Task<HttpResponseMessage> SendAsync(HttpRequestMessage request, CancellationToken cancellationToken)
        {
            if (request.RequestUri != null)
            {
                var updated = request.RequestUri.IsAbsoluteUri
                    ? request.RequestUri.ToString().Replace(ApiClientFactory.LegacyBaseUrl, _baseUrl, StringComparison.OrdinalIgnoreCase)
                    : ApiClientFactory.NormalizeUrl(request.RequestUri.OriginalString);

                request.RequestUri = new Uri(updated);
            }

            return base.SendAsync(request, cancellationToken);
        }
    }
}
