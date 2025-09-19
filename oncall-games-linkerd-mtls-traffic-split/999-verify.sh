#!/usr/bin/env bash
set -euo pipefail
fail(){ echo "[X] $1"; exit 1; }
ok(){ echo "[✓] $1"; }
SIDECARS=$(kubectl -n demo get po -l app=hello -o jsonpath='{range .items[*]}{.spec.containers[*].name}{"\n"}{end}' | grep -c linkerd-proxy || true)
[[ "$SIDECARS" -ge 2 ]] || fail "expected linkerd-proxy sidecars on hello pods"
V1=0; V2=0
for i in $(seq 1 30); do
  OUT=$(kubectl -n demo exec pod/$(kubectl -n demo get po -l run=curler -o name) -- sh -c 'curl -s http://hello.demo:80' || true)
  [[ "$OUT" == *"v2"* ]] && V2=$((V2+1)) || V1=$((V1+1))
done
[[ "$V2" -ge 1 ]] || fail "no v2 responses observed"
ok "Linkerd canary and sidecars verified ($V1 v1 / $V2 v2)"
