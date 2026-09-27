#!/bin/sh

# Read the Taildrop directory path from the file
TAILDROP_DIR=$(cat /mnt/us/extensions/tailscale/bin/taildrop_dir | tr -d $'\n')

eips_log() {
    echo "$1" >> "$LOG"
    eips 0 22 "$(printf '%-50s' "$1")" 2>/dev/null
}

# Receive files via Taildrop
eips_log "Receiving Taildrop files into $TAILDROP_DIR..."
/mnt/us/extensions/tailscale/bin/tailscale file get "$TAILDROP_DIR"

if [ $? -eq 0 ]; then
    eips_log "Taildrop files received successfully. Check the Taildrop folder at $TAILDROP_DIR."
else
    eips_log "Failed to receive Taildrop files. Please check the connection."
    exit 1
fi

