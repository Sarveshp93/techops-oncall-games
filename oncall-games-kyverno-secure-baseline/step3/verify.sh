#!/usr/bin/env bash
set -euo pipefail
kubectl -n app rollout status deploy/good --timeout=240s >/dev/null 2>&1 || true
SEC=$(kubectl -n app get pod -l app=good -o jsonpath='{.items[0].spec.securityContext.runAsNonRoot}')
[ "$SEC" = "true" ] || { echo "mutation missing runAsNonRoot"; exit 1; }
echo "Step 3 OK: mutation added securityContext"
