#!/usr/bin/env bash
set -euo pipefail
KCFG=/root/.kube/oncall.conf
kubectl --kubeconfig="$KCFG" get pods -A >/dev/null || { echo "Expected list to succeed"; exit 1; }
if kubectl --kubeconfig="$KCFG" -n foo delete pod -l app=nginx --ignore-not-found >/dev/null 2>&1; then
  echo "Delete should be forbidden"; exit 1
fi
echo "Step 2 OK: read-only access verified"
