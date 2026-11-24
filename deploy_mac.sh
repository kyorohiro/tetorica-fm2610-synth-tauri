#!/bin/sh
set -eu
cd "$(dirname "$0")"

: "${APPLE_PASSWORD:?Set APPLE_PASSWORD in your shell before running deploy_mac.sh}"
export CI=true
export APPLE_SIGNING_IDENTITY="${APPLE_SIGNING_IDENTITY:-Developer ID Application: KIYOHIRO KAWAMURA (5H7KW7PC7C)}"
export APPLE_ID="${APPLE_ID:-kyorohiro@gmail.com}"
export APPLE_TEAM_ID="${APPLE_TEAM_ID:-5H7KW7PC7C}"

npm run tauri -- build --target x86_64-apple-darwin --bundles app,dmg -- --locked
npm run tauri -- build --target aarch64-apple-darwin --bundles app,dmg -- --locked
