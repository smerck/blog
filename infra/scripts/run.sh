#!/bin/sh

hugo server \
  --bind=0.0.0.0
  --hostname=http://blog.smerc.io
  --disableFastRender
  --config=config.toml
