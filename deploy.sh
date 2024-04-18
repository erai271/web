#!/bin/bash
set -uex
git pull --ff-only
make
rsync --delete -r build/ /app/web/
