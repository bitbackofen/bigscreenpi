#!/bin/bash
while :
do
	setterm -blank off -powerdown off > /dev/tty0
	clear > /dev/tty0
	setterm -cursor off > /dev/tty0
	omxplayer -rb --loop --no-osd -o both /var/videos/dgzrs.mp4 > /dev/null 2> /var/log/video.log
	clear > /dev/tty0
done
