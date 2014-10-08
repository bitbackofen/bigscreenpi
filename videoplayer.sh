#!/bin/bash

PLAYER='omxplayer'
OPTIONS='-rb --no-osd -o both'

PATH='/var/videos'
PREFIX='movie_'
LOG='/var/log/video.log'
PAUSENVIDEO='/var/video/SNR_Pausenstueck.mp4'

setterm -blank off -powerdown off > /dev/tty0
clear > /dev/tty0
setterm -cursor off > /dev/tty0

while :
do
	for file in $PATH/$PREFIX*; do
		$PLAYER $OPTIONS "$PATH/$file" > /dev/null 2> $LOG
		clear > /dev/tty0
		$PLAYER $OPTIONS "$PAUSENVIDEO" > /dev/null 2> $LOG
		clear > /dev/tty0
	done
done
