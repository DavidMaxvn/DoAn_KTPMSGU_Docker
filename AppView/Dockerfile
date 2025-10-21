# syntax=docker/dockerfile:1

# ---------------------------------------
# Build the ASP.NET Core MVC project
# ---------------------------------------
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy csproj files first to leverage Docker layer caching
COPY *.sln ./
COPY AppView/*.csproj AppView/
COPY AppAPI/*.csproj AppAPI/
COPY AppData/*.csproj AppData/

RUN dotnet restore AppView/AppView.csproj

# Copy the remaining source and publish the project
COPY . .

ARG BUILD_CONFIGURATION=Release
RUN dotnet publish AppView/AppView.csproj \
    -c ${BUILD_CONFIGURATION} \
    -o /app/publish \
    --no-restore \
    -p:UseAppHost=false

# ---------------------------------------
# Runtime image
# ---------------------------------------
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app

# Install wkhtmltopdf and required fonts for Rotativa
RUN apt-get update && apt-get install -y --no-install-recommends \
        wkhtmltopdf \
        xfonts-base \
        xfonts-75dpi \
    && rm -rf /var/lib/apt/lists/*

ENV ASPNETCORE_URLS=http://+:80

COPY --from=build /app/publish .

EXPOSE 80

ENTRYPOINT ["dotnet", "AppView.dll"]
