#!/usr/bin/env bash
# Extract all .zip files from a GitHub repo into /palisade/os/framework

set -euo pipefail

USER="gabrielaraujobarros2018-star"
REPO="framework_resX_Palisade"
BRANCH="main"

TARGET_DIR="/palisade/os/framework"
TMP_DIR="/tmp/palisade_framework_zips"

mkdir -p "$TARGET_DIR"
mkdir -p "$TMP_DIR"

echo "[+] Fetching repository tree..."

curl -s "https://api.github.com/repos/${USER}/${REPO}/git/trees/${BRANCH}?recursive=1" \
| jq -r '.tree[] | select(.type=="blob") | select(.path | endswith(".zip")) | .path' \
| while read -r zip_path; do
    echo "[+] Processing $zip_path"

    ZIP_NAME="$(basename "$zip_path")"
    ZIP_LOCAL="$TMP_DIR/$ZIP_NAME"

    RAW_URL="https://raw.githubusercontent.com/${USER}/${REPO}/${BRANCH}/${zip_path}"

    curl -sL "$RAW_URL" -o "$ZIP_LOCAL"

    unzip -o "$ZIP_LOCAL" -d "$TARGET_DIR"

    rm -f "$ZIP_LOCAL"
done

rm -rf "$TMP_DIR"

echo "[✓] All ZIP files extracted into $TARGET_DIR"
