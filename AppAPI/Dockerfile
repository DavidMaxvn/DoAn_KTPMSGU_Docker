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
    -c $CONFIGURATION \
    -o /app/publish \
    -p:UseAppHost=false \
    --no-restore

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
# Copy UI static files from the build stage into wwwroot so the API can serve them
# (we copied the whole repo into /src during the build stage, so use --from=build)
COPY --from=build /src/AppView/wwwroot /app/wwwroot
COPY --from=build /src/img /app/wwwroot/img
COPY --from=build /src/js /app/wwwroot/js
ENTRYPOINT ["dotnet", "AppAPI.dll"]
