#!/usr/bin/env bash
set -euo pipefail
IMG=$(kubectl -n prod-apps get pod signed -o jsonpath='{.spec.containers[0].image}' 2>/dev/null || true)
[[ "$IMG" == *"@sha256:"* ]] || { echo "image not pinned to digest"; exit 1; }
echo "Step 4 OK: signed admitted and pinned"
