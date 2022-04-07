#!/bin/sh

CONFIG="config.toml"

/usr/bin/hugo server \
  --bind=0.0.0.0 \
  --disableFastRender \
  --config=$CONFIG \
  --baseUrl=https://ondigitalocean.app \
  --appendPort=false \
  --debug
