#!/usr/bin/env bash
set -euo pipefail
N=$(kubectl -n demo get po -l app=hello -o jsonpath='{range .items[*]}{.spec.containers[*].name}{"\n"}{end}' | grep -c linkerd-proxy || true)
[ "$N" -ge 2 ] || { echo "no linkerd-proxy containers detected"; exit 1; }
echo "Step 2 OK: mTLS sidecars present"
