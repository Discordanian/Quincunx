#!/bin/sh

BUILD_DIR="../build"
REMOTE_PATH="tangentialcold.com:tangentialcold.com/Quincunx"

if [ ! -d "$BUILD_DIR" ]
then
  echo "$BUILD_DIR build dir doesn't exist"
  exit 1
fi


rsync -avz --progress --delete "$BUILD_DIR/" "$REMOTE_PATH"
