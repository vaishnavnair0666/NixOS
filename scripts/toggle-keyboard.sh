#!/usr/bin/env bash
set -euo pipefail
MODULE="atkbd"
ACTION="${1:-toggle}"
SUDO=sudo

command -v modprobe >/dev/null 2>&1 || true
MODPROBE="$(command -v modprobe || true)"
RMMOD="$(command -v rmmod || true)"

# Helper: attempt module removal via modprobe -r / rmmod
try_unload_module() {
	if [ -n "$MODPROBE" ]; then
		$SUDO "$MODPROBE" -r "$MODULE" 2>/dev/null && {
			echo "removed via modprobe -r"
			return 0
		} || true
	fi
	if [ -n "$RMMOD" ]; then
		$SUDO "$RMMOD" "$MODULE" 2>/dev/null && {
			echo "removed via rmmod"
			return 0
		} || true
	fi
	return 1
}

# Find serio device id for builtin keyboard (based on /proc/bus/input/devices)
find_serio_dev() {
	awk -vRS= '
    /Name="AT Translated Set 2 keyboard"/ {
      for (i=1;i<=NF;i++) if ($i ~ /^P: Phys=/) {
        match($i, /serio[0-9]+/); if (RSTART) { print substr($i, RSTART, RLENGTH); exit }
      }
    }
  ' /proc/bus/input/devices 2>/dev/null || true
}

# Find a candidate serio driver directory
find_serio_driver_dir() {
	# list all serio drivers and pick one that has unbind file
	for d in /sys/bus/serio/drivers/*; do
		[ -d "$d" ] || continue
		[ -w "$d/unbind" ] && echo "$d" && return 0
	done
	return 1
}

do_unbind() {
	serio_dev="$(find_serio_dev)"
	driver_dir="$(find_serio_driver_dir || true)"
	if [ -z "$serio_dev" ]; then
		echo "Cannot locate serio device for internal keyboard (serio dev not found)."
		return 2
	fi
	if [ -z "$driver_dir" ]; then
		echo "No serio driver unbind found under /sys/bus/serio/drivers. Aborting unbind."
		return 3
	fi
	echo "Unbinding $serio_dev via $driver_dir/unbind"
	echo -n "${serio_dev}" | $SUDO tee "${driver_dir}/unbind"
	return $?
}

do_bind() {
	serio_dev="$(find_serio_dev)"
	driver_dir="$(find_serio_driver_dir || true)"
	if [ -z "$serio_dev" ] || [ -z "$driver_dir" ]; then
		echo "Cannot rebind: serio_dev or driver_dir missing."
		return 2
	fi
	echo "Binding $serio_dev via $driver_dir/bind"
	echo -n "${serio_dev}" | $SUDO tee "${driver_dir}/bind"
	return $?
}

case "$ACTION" in
disable)
	if try_unload_module; then exit 0; fi
	if do_unbind; then
		echo "Disabled internal keyboard (unbound)."
		exit 0
	fi
	echo "All automated attempts failed; try the NixOS blacklist (boot.blacklistedKernelModules)."
	exit 1
	;;
enable)
	# prefer module load if available
	if [ -n "$MODPROBE" ]; then
		$SUDO "$MODPROBE" "$MODULE" && {
			echo "Loaded $MODULE"
			exit 0
		} || true
	fi
	if do_bind; then
		echo "Rebound internal keyboard."
		exit 0
	fi
	echo "Failed to enable built-in keyboard."
	exit 1
	;;
toggle)
	if try_unload_module; then
		echo "Module removed"
		exit 0
	fi
	# fallback to unbind toggle (if currently bound, try unbind; else attempt bind)
	serio_dev="$(find_serio_dev)"
	if [ -z "$serio_dev" ]; then
		echo "serio device not found; run script with disable/enable or use NixOS blacklist."
		exit 2
	fi
	# if device present under /sys/bus/serio/devices, check parents
	if [ -e "/sys/bus/serio/devices/${serio_dev}" ]; then
		# unbind
		do_unbind && {
			echo "Toggled -> disabled"
			exit 0
		} || {
			echo "unbind failed"
			exit 1
		}
	else
		do_bind && {
			echo "Toggled -> enabled"
			exit 0
		} || {
			echo "bind failed"
			exit 1
		}
	fi
	;;
*)
	echo "Usage: $0 [disable|enable|toggle]"
	exit 2
	;;
esac
