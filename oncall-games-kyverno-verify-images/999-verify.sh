#!/usr/bin/env bash
set -euo pipefail
fail(){ echo "[X] $1"; exit 1; }
ok(){ echo "[✓] $1"; }
kubectl get clusterpolicy verify-image-prod >/dev/null || fail "verify-image-prod policy missing"
if kubectl apply -f /opt/assets/pod-unsigned.yaml >/tmp/unsigned-apply.txt 2>&1; then
  fail "unsigned image unexpectedly admitted in prod"
fi
ok "unsigned image denied in prod"
kubectl apply -f /opt/assets/pod-signed.yaml >/dev/null
sleep 2
IMG=$(kubectl -n prod-apps get pod signed -o jsonpath='{.spec.containers[0].image}')
[[ "$IMG" == *"@sha256:"* ]] || fail "signed pod image not pinned to digest"
ok "signed image admitted and pinned: $IMG"
