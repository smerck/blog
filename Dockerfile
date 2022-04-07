FROM amd64/alpine:latest

ENV PATH=$PATH:/usr/bin
ARG HUGO_THEME=terminal

RUN apk add --update wget
RUN wget --quiet https://github.com/gohugoio/hugo/releases/download/v0.96.0/hugo_0.96.0_Linux-64bit.tar.gz && \
    tar xzf hugo_0.96.0_Linux-64bit.tar.gz -C /usr/bin && \
    rm -r hugo_0.96.0_Linux-64bit.tar.gz

COPY ./hugo /site
COPY ./infra/scripts/run.sh /run.sh
RUN chmod +x /run.sh
WORKDIR /site

ENTRYPOINT [ "/run.sh" ]
