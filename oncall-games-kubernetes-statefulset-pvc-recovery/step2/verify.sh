#!/usr/bin/env bash
set -euo pipefail
OUT=$(kubectl -n datarec exec dataapp-0 -- sh -c 'cat /data/marker.txt' 2>/dev/null || true)
[[ "$OUT" == "STATEFUL-PERSISTENCE-OK" ]] || { echo "marker missing after recreate"; exit 1; }
echo "Step 2 OK: data persisted after pod delete"
