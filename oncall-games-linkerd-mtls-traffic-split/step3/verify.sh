#!/usr/bin/env bash
set -euo pipefail
V2=0
for i in $(seq 1 30); do
  OUT=$(kubectl -n demo exec pod/$(kubectl -n demo get po -l run=curler -o name) -- sh -c 'curl -s http://hello.demo:80' || true)
  [[ "$OUT" == *"v2"* ]] && V2=$((V2+1))
done
[ "$V2" -ge 1 ] || { echo "no v2 responses observed"; exit 1; }
echo "Step 3 OK: traffic split active"
