#!/usr/bin/env bash
# Download all files from a GitHub repo path
# Usage: ./download_github_repo.sh <user> <repo> <branch> <output_dir>

set -euo pipefail

USER="$1"
REPO="$2"
BRANCH="$3"
OUTDIR="$4"

mkdir -p "$OUTDIR"

echo "Listing repository contents..."
# List all file paths via GitHub API
file_list=$(curl -s "https://api.github.com/repos/${USER}/${REPO}/git/trees/${BRANCH}?recursive=1" \
  | jq -r '.tree[] | select(.type=="blob") | .path')

echo "Found files:"
echo "$file_list"

for path in $file_list; do
  # Create local directory tree
  dir=$(dirname "$path")
  mkdir -p "$OUTDIR/$dir"

  # Construct raw URL for file
  raw_url="https://raw.githubusercontent.com/${USER}/${REPO}/${BRANCH}/${path}"

  echo "Downloading $path"
  curl -sL "$raw_url" -o "$OUTDIR/$path"
done

echo "Done. Files are in $OUTDIR"
