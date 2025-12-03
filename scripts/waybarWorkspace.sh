#!/usr/bin/env bash
# waybarWorkspace: prints current workspace number and labels

out=$(niri msg focused-window 2>/dev/null | sed -n 's/.*Workspace ID: \([0-9]\+\).*/\1/p')
if [ -z "$out" ]; then
	echo "WS -"
else
	echo "WS $out"
fi
