#!/usr/bin/env bash
set -euo pipefail
# Pass condition: command exits non-zero (forbidden)
if kubectl --kubeconfig=/root/.kube/oncall.conf get pods -A >/dev/null 2>&1; then
  echo "Expected failure, but it succeeded"; exit 1
fi
echo "Step 1 OK: listing pods failed as expected"
