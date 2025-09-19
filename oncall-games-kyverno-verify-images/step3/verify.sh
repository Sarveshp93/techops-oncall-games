#!/usr/bin/env bash
set -euo pipefail
if kubectl apply -f /opt/pod-unsigned.yaml >/tmp/unsigned-apply.txt 2>&1; then
  echo "unsigned image should be denied"; exit 1
fi
echo "Step 3 OK: unsigned denied"
