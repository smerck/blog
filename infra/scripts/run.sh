#!/bin/sh

CONFIG="config.toml"
echo $PATH
ls -la /usr/bin/hugo
ls /site

/usr/bin/hugo server \
  --bind=0.0.0.0 \
  --disableFastRender \
  --config=$CONFIG \
