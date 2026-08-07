#!/usr/bin/env bash

set -euo pipefail

picker_pid=""

cleanup() {
  if [[ -n "$picker_pid" ]]; then
    kill "$picker_pid" 2>/dev/null || true
  fi
}

trap cleanup EXIT INT TERM

# Freeze the desktop while selecting so content cannot move before capture.
hyprpicker -r -z >/dev/null 2>&1 &
picker_pid=$!
sleep 0.1

selection="$(slurp 2>/dev/null)" || exit 0
[[ -n "$selection" ]] || exit 0

text="$(
  grim -g "$selection" - |
    tesseract stdin stdout \
      --oem 1 \
      --psm 6 \
      -l eng \
      --dpi 300 \
      -c preserve_interword_spaces=1 \
      2>/dev/null
)" || {
  notify-send --urgency=critical "Text capture failed" "Could not read the selected region."
  exit 1
}

if [[ -z "$text" ]]; then
  notify-send "No text found" "Try selecting a tighter or clearer region."
  exit 0
fi

printf '%s' "$text" | wl-copy
notify-send "Text copied" "The selected text is now in the clipboard."
