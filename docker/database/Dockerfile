FROM mcr.microsoft.com/mssql/server:2022-latest

# Default environment values (can be overridden at runtime)
ENV ACCEPT_EULA=Y \
    MSSQL_PID=Developer \
    SA_PASSWORD=S3cure!Pass2025

# Copy initialization assets
COPY scriptquanao_new.sql /docker-entrypoint-initdb.d/init.sql
COPY docker/database/entrypoint.sh /usr/src/entrypoint.sh

RUN chmod +x /usr/src/entrypoint.sh

EXPOSE 1433

CMD ["/usr/src/entrypoint.sh"]
