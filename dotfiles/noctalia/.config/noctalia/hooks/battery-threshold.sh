#!/usr/bin/env bash

set -euo pipefail

threshold="${NOCTALIA_BATTERY_THRESHOLD:-20}"
percent="${NOCTALIA_BATTERY_PERCENT:-}"
battery_state="${NOCTALIA_BATTERY_STATE:-unknown}"

[[ "$threshold" =~ ^[0-9]+$ ]] || exit 0
[[ "$percent" =~ ^[0-9]+$ ]] || exit 0
(( threshold >= 0 && threshold <= 100 )) || exit 0

state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/noctalia"
notified_file="$state_dir/battery-low-notified"

mkdir -p "$state_dir"

# Re-arm the warning after charging starts or the battery rises above the limit.
if [[ "$battery_state" != "discharging" ]] || (( percent > threshold )); then
  rm -f "$notified_file"
  exit 0
fi

# Warn only once during each low-battery discharge cycle.
if [[ ! -e "$notified_file" ]]; then
  notify-send \
    --app-name="Battery" \
    --urgency=critical \
    --expire-time=30000 \
    "Battery low" \
    "Battery is at ${percent}%. Connect the charger."
  touch "$notified_file"
fi
