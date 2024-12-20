#!/bin/bash
#
# Copyright (C) 2023 saadelasfur

echo ""
echo "Making zip..."

[ -d "out" ] && rm -rf out
mkdir out

SRC=$(pwd)
OUT_DIR=$SRC/out
INSTALLER_ZIP="$SRC/Installer/Installer.zip"

read -p "version: " VERSION
DIRS="SM-M526B SM-M526BR SM-A528B SM-A528N SM-A736B"
for dir in $DIRS; do
    cp -a --preserve=all "$SRC/$dir" "$OUT_DIR/"
done
7z x "$INSTALLER_ZIP" -o"$OUT_DIR/"
cat "$SRC/Installer/updater-script" > "$OUT_DIR/META-INF/com/google/android/updater-script"
cd "$OUT_DIR"
find . -type f -name "current" -exec rm -f {} +
find . -exec touch -a -c -m -t 200812311700.00 {} +
7z a -tzip -mx=5 "WiFi-Fix_v$VERSION-sm7325.zip" .
cd $SRC

sleep 1 && exit 0
