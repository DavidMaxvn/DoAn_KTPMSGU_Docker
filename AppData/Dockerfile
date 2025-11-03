# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

COPY DuAnTotNghiep.sln ./
COPY AppData/AppData.csproj AppData/
RUN dotnet restore AppData/AppData.csproj

COPY . .
RUN dotnet build AppData/AppData.csproj -c Release

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS final
WORKDIR /workspace/AppData
COPY --from=build /src/AppData ./
ENTRYPOINT ["dotnet", "build", "AppData.csproj", "-c", "Release"]
