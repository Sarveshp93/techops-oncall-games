#!/usr/bin/env bash
set -euo pipefail
kubectl -n kyverno get deploy kyverno-admission-controller >/dev/null 2>&1 || { echo "kyverno not installed"; exit 1; }
echo "Step 1 OK: Kyverno installed"
