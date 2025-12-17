#!/usr/bin/env bash

if pgrep -f -x waybar; then
	pkill -f waybar
else
	waybar &
fi
