#!/bin/sh

CONFIG=""

if [ -z "uname -a|grep 'Darwin'" ]; then
  CONFIG="config.dev.toml"
else 
  CONFIG="config.toml"
fi


hugo server \
  --bind=0.0.0.0 \
  --hostname=http://blog.smerc.io \
  --disableFastRender \
  --config=$CONFIG \
