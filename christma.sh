#!/usr/bin/env bash
# inspired by https://github.com/keroserene/rickrollrc

tmpdir=$(mktemp -d /tmp/christma.sh-XXXXX)

audio=$tmpdir/faithnoel.ogg # nonexistant file to be downloaded later
audioUrl="https://drive.google.com/uc?id=0B2wzVJ8L65DfV250ZGN6aHREZWs&export=download"
audioPid=0

frames=$tmpdir/frames # nonexistant directory to be created and filled later
framesUrl="https://drive.google.com/uc?id=0B2wzVJ8L65DfckI1LWsydE51MEU&export=download"
currentFrame=0
totalFrames=0

########## functions

function quit() {
    kill -9 $audioPid 2> /dev/null
    rm -rf $tmpdir
    tput cnorm
    clear
    ! [ -z "$1" ] && echo "$1"
    echo "Hope you have a Merry Christmas and a Happy New Year!"
    exit 0
}

function checkcmd() {
    command -v $1 > /dev/null
}
function grab() {
    # grab /path/to/output http://path/to/source
    if checkcmd wget; then
        wget -qO "$2" $1
    elif checkcmd curl; then
        curl -so "$2" $1
    else
        quit "curl and wget are not available; cannot download resources."
    fi
}

########## play

trap quit SIGINT SIGTERM

# setup
tput civis
mkdir -p $frames

echo "Downloading audio..."
grab "$audioUrl" $audio
echo "Downloading frames..."
grab "$framesUrl" $tmpdir/framesArchive

echo "Decompressing frames..."
tar -xJf $tmpdir/framesArchive -C $frames
rm $tmpdir/framesArchive
find $frames -type f -exec mv {} $frames \; 2> /dev/null
totalFrames=$(find $frames -type f | wc -l)

# play music
if checkcmd ffplay; then
    ffplay -autoexit -nodisp -loglevel 8 $audio &
elif checkcmd play; then
    play -q $audio &
elif checkcmd mpv; then
    mpv --really-quiet $audio &
elif checkcmd mplayer; then
    mplayer -really-quiet -noconsolecontrols $audio 2> /dev/null &
else
    echo "No suitable audio player found."
fi
audioPid=$!

# main animation loop
while true :; do
    if ! [ $audioPid -eq 0 ] && ! [ -z "$audioPid" ] && ! [ $(ps -p $audioPid | wc -l) -gt 1 ]; then
        quit
    fi
    clear
    currentFrame=$(($currentFrame+1))
    #echo -e "audioPid: $audioPid | currentFrame: $currentFrame | currentFrame mod total: $(($currentFrame%$totalFrames))"
    cat $frames/$(($currentFrame%$totalFrames))
    sleep 0.5
done
