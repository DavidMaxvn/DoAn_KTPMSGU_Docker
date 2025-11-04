FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 9000

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src
COPY ["AppAPI/AppAPI.csproj", "AppAPI/"]
COPY ["AppData/AppData.csproj", "AppData/"]
RUN dotnet restore "./AppAPI/AppAPI.csproj"
COPY . .
WORKDIR "/src/AppAPI"
RUN dotnet build "./AppAPI.csproj" -c %BUILD_CONFIGURATION% -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./AppAPI.csproj" -c %BUILD_CONFIGURATION% -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
ENV ASPNETCORE_URLS=http://0.0.0.0:9000
COPY --from=publish /app/publish .
COPY AppAPI/entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
