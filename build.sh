#!/bin/sh
# process the source frames to create the animation frames
# first, the script is passed to snow.lua to create snowflakes, then the
# placeholder characters are removed.

loops=16
outDir=frames
srcDir="frames-src"

mkdir -p $outDir
rm -f $outDir/* frames.tar.xz

for frame in $(seq 0 $(($loops*4))); do
    if [ $(($frame%4)) -ge 2 ]; then # use frame 0
        ./snow.lua $srcDir/0 | sed "s/X/ /g" > $outDir/$frame
    else # use frame 1
        ./snow.lua $srcDir/1 | sed "s/X/ /g" > $outDir/$frame
    fi
done

tar -zcf frames.tar.gz frames
