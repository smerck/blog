#!/bin/sh

CONFIG="config.toml"
hugo server \
  --bind=0.0.0.0 \
  --disableFastRender \
  --config=$CONFIG \
