FROM amd64/alpine:latest

ENV PATH=$PATH:/usr/bin
ARG HUGO_VERSION=0.96.0
ARG HUGO_THEME=terminal
ARG HUGO_URL="https://github.com/gohugoio/hugo/releases/download/v$HUGO_VERSION/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz"

RUN echo "$HUGO_URL"
RUN echo "$HUGO_VERSION"

RUN apk add --update wget
RUN wget --quiet $HUGO_URL && \
    tar xzf hugo_$HUGO_VERSION_Linux-64bit.tar.gz -C /usr/bin && \
    rm -r hugo_$HUGO_VERSION_Linux-64bit.tar.gz

COPY ./hugo /site
COPY ./infra/scripts/run.sh /run.sh
RUN chmod +x /run.sh
WORKDIR /site

ENTRYPOINT [ "/run.sh" ]
