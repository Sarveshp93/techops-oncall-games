#!/usr/bin/env bash
set -euo pipefail
kubectl -n sandbox get networkpolicy default-deny >/dev/null 2>&1 || { echo "generated NP missing"; exit 1; }
echo "Step 4 OK: NetworkPolicy generated"
