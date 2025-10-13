# ----- Build stage -----
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY AppView/*.csproj ./AppView/
COPY AppData/*.csproj ./AppData/
RUN dotnet restore AppView/AppView.csproj
COPY . .
RUN dotnet publish AppView/AppView.csproj -c Release -o /app/publish -p:UseAppHost=false --no-restore

# ----- Runtime stage (Debian bullseye) -----
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app

# ✅ Cài wkhtmltopdf từ Debian repo (đủ phụ thuộc)
RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    xfonts-base \
    xfonts-75dpi \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "AppView.dll"]
