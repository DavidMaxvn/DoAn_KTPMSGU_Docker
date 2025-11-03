# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/mssql/server:2019-latest

ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Express

USER root
RUN mkdir -p /opt/setup
COPY docker/database/init-db.sh /opt/setup/init-db.sh
COPY scriptquanao_new.sql /opt/setup/script.sql
RUN chmod +x /opt/setup/init-db.sh

USER mssql
ENTRYPOINT ["/bin/bash", "/opt/setup/init-db.sh"]
