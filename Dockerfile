FROM nginx:alpine as build

RUN apk add --update \
    wget
    
ARG HUGO_VERSION="0.89.1"
RUN wget --quiet "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-ARM64.tar.gz" && \
    tar xzf hugo_${HUGO_VERSION}_Linux-ARM64.tar.gz && \
    rm -r hugo_${HUGO_VERSION}_Linux-ARM64.tar.gz && \
    mv hugo /usr/bin

COPY ./hugo /site
WORKDIR /site
RUN ls -la
RUN hugo -c "content" -t "terminal"
ENTRYPOINT ["hugo", "server", "--watch=true", "--theme=terminal",  "--bind=0.0.0.0", "$@" ]
