#!/bin/bash
set -ue
if [ $# -ne 1 ]; then
  echo "Usage: ./deploy.sh <host>"
  exit 1
fi
case "$1" in
localhost) target="" ;;
*) target="$1:" ;;
esac
git pull --verify-signatures --ff-only origin main
if [ "$(git show -s --pretty='%G?')" != 'G' ]; then
  echo "Failed to verify signature" >&2
  exit 1
fi
make
rsync --delete -vr build/ "${target}/app/web/"
