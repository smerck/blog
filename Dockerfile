FROM amd64/alpine:latest 

ARG TARGETPLATFORM
ARG HUGO_VERSION="0.89.1"
ARG HUGO_THEME="terminal"
ENV HUGO_THEME=$HUGO_THEME

RUN apk add --update wget 
RUN wget --quiet "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz" && \
    tar xzf hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    rm -r hugo_${HUGO_VERSION}_Linux-64bit.tar.gz && \
    mv hugo /usr/bin && \
    export PATH=$PATH:/usr/bin

COPY ./hugo /site
COPY ./infra/scripts/run.sh /run.sh
RUN chmod +x /run.sh
WORKDIR /site

ENTRYPOINT [ "/run.sh" ]
