#!/usr/bin/env bash
# Cycle to the next workspace on the focused output (monitor).
# Uses `niri msg -j workspaces` and `niri msg -j focused-output`.
# Requires `jq` to parse JSON.

set -euo pipefail

focused_output=$(niri msg -j focused-output 2>/dev/null | jq -r '.name // empty')

# if we couldn't get focused output, fall back to global workspaces
if [ -z "$focused_output" ]; then
	workspaces_json=$(niri msg -j workspaces)
else
	workspaces_json=$(niri msg -j workspaces)
fi

# Build an array of workspace indices for the focused output (or all if none)
if [ -n "$focused_output" ]; then
	mapfile -t idxs < <(echo "$workspaces_json" | jq --arg out "$focused_output" -r '.[] | select(.output == $out) | .idx' | sort -n)
else
	mapfile -t idxs < <(echo "$workspaces_json" | jq -r '.[].idx' | sort -n)
fi

# If no workspaces found, default to focusing workspace 1
if [ "${#idxs[@]}" -eq 0 ]; then
	niri msg action focus-workspace 1
	exit 0
fi

# Get currently focused workspace index (its .idx)
current_idx=$(echo "$workspaces_json" | jq -r '.[] | select(.is_focused) | .idx' | head -n1)

# If nothing focused, focus first in list
if [ -z "$current_idx" ]; then
	target=${idxs[0]}
	niri msg action focus-workspace "$target"
	exit 0
fi

# Find position of current_idx inside idxs array
pos=-1
for i in "${!idxs[@]}"; do
	if [ "${idxs[$i]}" = "$current_idx" ]; then
		pos=$i
		break
	fi
done

# If current not in list (weird), focus first
if [ "$pos" -lt 0 ]; then
	target=${idxs[0]}
	niri msg action focus-workspace "$target"
	exit 0
fi

# compute next position (wrap)
next_pos=$(((pos + 1) % ${#idxs[@]}))
target=${idxs[$next_pos]}

# focus it
niri msg action focus-workspace "$target"
