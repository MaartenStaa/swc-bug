#!/usr/bin/env bash

set -ex

VERSION="v1.3.102"

# Clean up previous ones
rm -f swc-darwin-arm64
wget https://github.com/swc-project/swc/releases/download/$VERSION/swc-darwin-arm64
chmod +x swc-darwin-arm64

./swc-darwin-arm64 --version

# Works
echo "Compiling input.ts without source maps"
RUST_BACKTRACE=full ./swc-darwin-arm64 compile \
    --source-file-name input.ts \
    --config-file .swcrc \
    --out-file dist/input.js \
    src/input.ts

# Crashes
echo "Compiling input.ts with source maps"
RUST_BACKTRACE=full ./swc-darwin-arm64 compile \
    --source-maps true \
    --source-file-name input.ts \
    --config-file .swcrc \
    --out-file dist/input.js \
    src/input.ts

echo "Done."
