#!/usr/bin/env bash
set -euo pipefail
# Start init in background, log to /opt/init.log
( bash /opt/init.sh >> /opt/init.log 2>&1 & echo $! > /opt/INIT_PID ) || true
# Show live progress until INIT_DONE is touched
bash /opt/wait-init.sh
