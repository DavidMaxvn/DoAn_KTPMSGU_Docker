# Build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Xoá sạch bin/obj (nếu lỡ bị copy vào)
RUN find . -type d \( -name bin -o -name obj \) -prune -exec rm -rf {} +

# (Tùy chọn) cấu hình mặc định
ARG CONFIGURATION=Release

# copy csproj và restore để tối ưu cache
COPY AppAPI/*.csproj ./AppAPI/
COPY AppData/*.csproj ./AppData/
RUN dotnet restore "AppAPI/AppAPI.csproj"

# copy toàn bộ source
COPY . .

# publish
RUN dotnet publish "AppAPI/AppAPI.csproj" \
    -c "$CONFIGURATION" \
    -o /app/publish \
    -p:UseAppHost=false \
    --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "AppAPI.dll"]
