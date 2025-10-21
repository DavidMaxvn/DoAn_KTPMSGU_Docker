# syntax=docker/dockerfile:1

# This image packages the shared data layer and dotnet-ef tooling
# so that database migrations can be executed inside Docker.

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

COPY *.sln ./
COPY AppData/*.csproj AppData/
COPY AppAPI/*.csproj AppAPI/
COPY AppView/*.csproj AppView/

RUN dotnet restore AppAPI/AppAPI.csproj

COPY . .

ARG BUILD_CONFIGURATION=Release
# Build the shared library to ensure the sources compile
RUN dotnet build AppData/AppData.csproj -c ${BUILD_CONFIGURATION} --no-restore

# Install dotnet-ef globally so the container can run migrations
RUN dotnet tool install --global dotnet-ef --version 6.*
ENV PATH="${PATH}:/root/.dotnet/tools"

RUN chmod 755 AppData/docker-entrypoint.sh
WORKDIR /src

ENTRYPOINT ["/bin/bash", "AppData/docker-entrypoint.sh"]
CMD []
