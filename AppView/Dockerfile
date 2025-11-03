# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

COPY DuAnTotNghiep.sln ./
COPY AppView/AppView.csproj AppView/
COPY AppAPI/AppAPI.csproj AppAPI/
COPY AppData/AppData.csproj AppData/
RUN dotnet restore AppView/AppView.csproj

COPY . .
RUN dotnet publish AppView/AppView.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "AppView.dll"]
