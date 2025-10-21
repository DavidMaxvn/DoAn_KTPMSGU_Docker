# SDK image is required because we run Entity Framework Core tooling
FROM mcr.microsoft.com/dotnet/sdk:6.0
WORKDIR /src

# Copy solution and project files first to leverage caching
COPY DuAnTotNghiep.sln ./
COPY AppAPI/AppAPI.csproj AppAPI/
COPY AppData/AppData.csproj AppData/
COPY AppView/AppView.csproj AppView/

# Restore dependencies needed for migrations
RUN dotnet restore DuAnTotNghiep.sln

# Copy the remaining source code
COPY . .

# Ensure the projects build so migrations can run
RUN dotnet build AppAPI/AppAPI.csproj -c Release --no-restore

# Install EF Core CLI tool for running migrations
RUN dotnet tool install --global dotnet-ef --version 6.0.21
ENV PATH="/root/.dotnet/tools:${PATH}"

# Copy the migration entrypoint script
COPY AppData/docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
