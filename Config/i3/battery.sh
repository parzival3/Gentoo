#!/bin/bash

BAT=$(cat /sys/class/power_supply/BAT0/capacity)
STA=$(cat /sys/class/power_supply/BAT0/status)

if [ $BAT -gt 100 ]; then
	BAT=100
fi

if [ $STA == "Charging" ]; then
	echo " $BAT"
	echo "#8ADE49"
	exit 0

fi

if [ $BAT -gt 90 ]; then
	echo "   $BAT "
	echo "#8ADE49"
elif [ $BAT -lt 80 -a $BAT -gt 50 ]; then
	echo "   $BAT "
	echo "#F0EE5F"
elif [ $BAT -lt 50 -a $BAT -gt 30 ]; then
	echo "   $BAT "
	echo "#F0B05F"
elif [ $BAT -lt 30 -a $BAT -gt 10 ]; then
	echo "   $BAT "
	echo "#EE7A39"
elif [ $BAT -lt 10 ]; then
	echo "   $BAT "
	echo "#EE5239"
fi

