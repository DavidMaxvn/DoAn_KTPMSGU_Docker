# Build the ASP.NET Core MVC site
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy solution and project files for better layer caching
COPY DuAnTotNghiep.sln ./
COPY AppView/AppView.csproj AppView/
COPY AppData/AppData.csproj AppData/

# Restore dependencies for the view project
RUN dotnet restore AppView/AppView.csproj

# Copy the rest of the source and publish the website
COPY . .
RUN dotnet publish AppView/AppView.csproj \
    -c Release \
    -o /app/publish \
    -p:UseAppHost=false \
    --no-restore

# Runtime image with wkhtmltopdf for Rotativa
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app

RUN apt-get update && apt-get install -y \
    wkhtmltopdf \
    xfonts-base \
    xfonts-75dpi \
    && rm -rf /var/lib/apt/lists/*

ENV ASPNETCORE_URLS=http://+:80

COPY --from=build /app/publish .
EXPOSE 80

ENTRYPOINT ["dotnet", "AppView.dll"]
