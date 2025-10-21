# syntax=docker/dockerfile:1

FROM mcr.microsoft.com/mssql/server:2022-latest

ENV MSSQL_PID=Developer \
    ACCEPT_EULA=Y

# Default SA password can be overridden from docker-compose
ENV SA_PASSWORD="S3cure!Pass2025"

USER root

RUN mkdir -p /usr/config
COPY docker/database/entrypoint.sh /usr/config/entrypoint.sh
COPY scriptquanao_new.sql /usr/config/init.sql
RUN chmod 755 /usr/config/entrypoint.sh \
    && chown mssql:mssql /usr/config/entrypoint.sh /usr/config/init.sql

EXPOSE 1433

HEALTHCHECK --interval=10s --timeout=5s --retries=15 \
    CMD /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P "$SA_PASSWORD" -Q "SELECT 1" || exit 1

USER mssql

ENTRYPOINT ["/usr/config/entrypoint.sh"]
