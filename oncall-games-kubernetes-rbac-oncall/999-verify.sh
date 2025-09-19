#!/usr/bin/env bash
set -euo pipefail
fail(){ echo "[X] $1"; exit 1; }
ok(){ echo "[✓] $1"; }
KCFG=/root/.kube/oncall.conf
kubectl --kubeconfig="$KCFG" get pods -A >/dev/null || fail "oncall cannot list pods -A"
if kubectl --kubeconfig="$KCFG" -n foo delete pod -l app=nginx --ignore-not-found; then
  fail "oncall must NOT be able to delete pods"
fi
ok "RBAC least-privilege enforced"
