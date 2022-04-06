#!/bin/sh

CONFIG=""

if [ -z "uname -a|grep 'Darwin'" ]; then
  CONFIG="config.dev.toml"
else 
fi


CONFIG="config.toml"
hugo server \
  --bind=0.0.0.0 \
  --disableFastRender \
  --config=$CONFIG \
