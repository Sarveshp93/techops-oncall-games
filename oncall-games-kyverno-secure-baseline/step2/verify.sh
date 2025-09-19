#!/usr/bin/env bash
set -euo pipefail
if kubectl apply -f /opt/bad-deploy.yaml >/tmp/kyverno-bad.txt 2>&1; then
  echo "bad deploy should be denied"; exit 1;
fi
echo "Step 2 OK: disallowed registry denied"
