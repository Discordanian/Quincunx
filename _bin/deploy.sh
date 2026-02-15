#!/bin/sh
set -x

BUILD_DIR="../build"
REMOTE_PATH="tangentialcold.com:tangentialcold.com/Quincunx"

if [ ! -d "$BUILD_DIR" ]
then
  echo "$BUILD_DIR build dir doesn't exist"
  exit 1
fi

# rm "$BUILD_DIR/*"

# /Applications/Godot v4.6.app/Contents/MacOS/Godot --headless --export-release Quincunx ./build/index.html


rsync -avz --progress --delete "$BUILD_DIR/" "$REMOTE_PATH"
