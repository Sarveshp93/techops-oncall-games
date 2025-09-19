#!/usr/bin/env bash
set -euo pipefail
LOG_FILE="/opt/init.log"
touch "$LOG_FILE"
echo "[wait] watching $LOG_FILE for completion..."

# Tail in background so the user sees progress
( tail -n +1 -f "$LOG_FILE" & echo $! > /opt/.tailpid ) &>/dev/null || true

# Wait for marker
for i in $(seq 1 600); do
  if [ -f /opt/INIT_DONE ]; then
    break
  fi
  sleep 1
done

# Stop tail
if [ -f /opt/.tailpid ]; then
  kill "$(cat /opt/.tailpid)" >/dev/null 2>&1 || true
  rm -f /opt/.tailpid
fi

echo "✅ Setup complete."
