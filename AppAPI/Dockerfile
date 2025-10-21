# Build the ASP.NET Core Web API
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy solution and project files to take advantage of Docker layer caching
COPY DuAnTotNghiep.sln ./
COPY AppAPI/AppAPI.csproj AppAPI/
COPY AppData/AppData.csproj AppData/
COPY AppView/AppView.csproj AppView/

# Restore dependencies for the API project
RUN dotnet restore AppAPI/AppAPI.csproj

# Copy the full source tree and publish the application
COPY . .
RUN dotnet publish AppAPI/AppAPI.csproj \
    -c Release \
    -o /app/publish \
    -p:UseAppHost=false \
    --no-restore

# Final runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app

ENV ASPNETCORE_URLS=http://+:80

COPY --from=build /app/publish .
EXPOSE 80

ENTRYPOINT ["dotnet", "AppAPI.dll"]
