#!/usr/bin/env bash
set -euo pipefail
fail() { echo "[X] $1"; exit 1; }
ok() { echo "[✓] $1"; }

# 1) Positive path succeeds
kubectl -n team-a exec deploy/client -- sh -c "curl -sS --max-time 5 http://echoserver.team-b.svc.cluster.local:8080" >/dev/null \
  || fail "client -> echoserver:8080 should succeed"

# 2) Reverse still blocked
if kubectl -n team-b exec deploy/echoserver -- sh -c "apk add --no-cache curl >/dev/null 2>&1 || true; curl -sS --max-time 3 http://client.team-a.svc.cluster.local:8080" >/dev/null; then
  fail "echoserver should NOT reach client"
fi

# 3) Ports are constrained
if kubectl -n team-a exec deploy/client -- sh -c "curl -sS --max-time 3 http://echoserver.team-b.svc.cluster.local:9090" >/dev/null; then
  fail "Access to non-8080 port should be blocked"
fi

ok "NetworkPolicy behaves as intended"
