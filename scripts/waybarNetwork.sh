#!/usr/bin/env bash
# prints connected SSID or "offline"
if command -v nmcli >/dev/null 2>&1; then
	ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2; exit}')
	if [ -n "$ssid" ]; then
		signal=$(nmcli -t -f IN-USE,SIGNAL dev wifi | sed -n 's/^\*:\([0-9]*\)/\1/p')
		echo "$ssid ${signal:-0}%"
	else
		# try connection via general nmcli
		con=$(nmcli -t -f NAME,STATE connection show --active | awk -F: 'NR==1{print $1}')
		if [ -n "$con" ]; then
			echo "$con"
		else
			echo "Offline"
		fi
	fi
else
	echo "No nmcli"
fi
