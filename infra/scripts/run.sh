#!/bin/sh

CONFIG="config.toml"

/usr/bin/hugo server \
  --bind=0.0.0.0 \
  --disableFastRender \
  --config=$CONFIG \
  --baseUrl=https://smerc-blog-xosni.ondigitalocean.app \
  --debug
