#!/usr/bin/env bash

PLAYER=omxplayer
OPTIONS='-rb --no-osd -o hdmi'

#Hier leigen die Videos
VIDEOPATH=/home/pi/video/
LOG='video.log'

PAUSENVIDEO=/home/pi/video/SNR_Pausenstueck_1min.mp4
#Extra Zeit zur Videolaenge
EXTRATIME=3

setterm -blank off -powerdown off > /dev/tty0
clear > /dev/tty0
setterm -cursor off > /dev/tty0

#Funktion zum Abspielen der Videos
playvideo() {
	#Laenge Video ermitteln
	string=$($PLAYER --info $VIDEO 2>&1 | sed -nr 's/.*(Duration:) ([0123456789:]+).*/\1\2/p')
var=$(echo $string | awk -F":" '{print $1,$2,$3,$4}')
set -- $var
	#Sekunden für das Video berechnen	
	waittime=`expr $2 \* 3600 + $3 \* 60 + $4 + $EXTRATIME`  
	#echo $waittime
	#Video starten
	$PLAYER $OPTIONS $VIDEO &
	#echo $!
	sleep $waittime
	#Checken ob noch ein omxplayer prozess laeuft
	if ps ax | grep -v grep | grep omxplayer > /dev/null
			then	
				#omxplayer killen
				echo 'running' >> video.log
				killall $PLAYER > /dev/null
				killall omxplayer.bin > /dev/null
			else
				echo 'ok' >> video.log
	fi
	clear > /dev/tty0
}

#Tu Videos abspielen
while :
do
	for file in $VIDEOPATH*1.mp4; do
		
		VIDEO=$file
		playvideo
		
		
		VIDEO=$PAUSENVIDEO
		playvideo
		
	done
done
