#!/usr/bin/env bash
set -euo pipefail

uid=$(id -u)
# allow override via env or first arg
target="${WAYLAND_DISPLAY:-${1:-}}"

tries=12
i=0
while [ $i -lt $tries ]; do
	if [ -n "$target" ] && [ -e "/run/user/$uid/$target" ]; then
		exit 0
	fi
	for s in /run/user/$uid/wayland-* /run/user/$uid/*wayland-* /run/user/$uid/niri.wayland-*; do
		[ -e "$s" ] && exit 0 || true
	done
	sleep 0.5
	i=$((i + 1))
done

echo "wait-for-wayland: timeout waiting for Wayland socket (continuing)" >&2
exit 0
