FROM ghost:latest AS build-config
RUN ghost config
RUN ls -la
RUN echo $(pwd)
RUN cat config.production.json

FROM scratch AS exporter
COPY --from=build-config /var/lib/ghost/config.production.json ./config/config.production.json
