# syntax=docker/dockerfile:1

# ---------------------------------------
# Build the Web API project
# ---------------------------------------
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

COPY *.sln ./
COPY AppAPI/*.csproj AppAPI/
COPY AppData/*.csproj AppData/
COPY AppView/*.csproj AppView/

RUN dotnet restore AppAPI/AppAPI.csproj

COPY . .

ARG BUILD_CONFIGURATION=Release
RUN dotnet publish AppAPI/AppAPI.csproj \
    -c ${BUILD_CONFIGURATION} \
    -o /app/publish \
    --no-restore \
    -p:UseAppHost=false

# ---------------------------------------
# Runtime image
# ---------------------------------------
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app

ENV ASPNETCORE_URLS=http://+:80

COPY --from=build /app/publish .

EXPOSE 80

ENTRYPOINT ["dotnet", "AppAPI.dll"]
