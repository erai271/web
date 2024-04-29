#!/bin/bash
set -uex
git pull --ff-only
if [ git show -s --pretty='%G?' != 'G' ]; then
  echo "Failed to verify signature" >&2
  exit 1
fi
make
rsync --delete -r build/ /app/web/
