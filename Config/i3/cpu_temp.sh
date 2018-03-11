#!/bin/bash
PROC="$(cat /proc/cpuinfo | grep Intel | head -n 1 | tr -d " \t")"
if [ "$PROC" ]; then
	echo "$(sensors  | grep CPU | sed -e "s/CPU: *\([0-9]*\)/\1/g")"
else
	echo "$(sensors -u | grep "temp1_input" | tail -n 1 | sed "s/temp1_input: \([0-9]*\)/\1/g")"
fi

exit 0
