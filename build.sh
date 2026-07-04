#!/bin/bash
# Cloudflare Pages 自定义 Hugo 版本
curl -sL https://github.com/gohugoio/hugo/releases/download/v0.158.0/hugo_extended_0.158.0_linux-amd64.tar.gz | tar xz
./hugo --minify