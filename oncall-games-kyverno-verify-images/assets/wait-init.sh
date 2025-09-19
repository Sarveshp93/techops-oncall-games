#!/usr/bin/env bash
set -euo pipefail
LOG_FILE="/opt/init.log"; touch "$LOG_FILE"
( tail -n +1 -f "$LOG_FILE" & echo $! > /opt/.tailpid ) >/dev/null 2>&1 || true
for i in $(seq 1 900); do [ -f /opt/INIT_DONE ] && break; sleep 1; done
if [ -f /opt/.tailpid ]; then kill "$(cat /opt/.tailpid)" >/dev/null 2>&1 || true; rm -f /opt/.tailpid; fi
echo "✅ Setup complete."
