#!/usr/bin/env bash
set -euo pipefail
fail(){ echo "[X] $1"; exit 1; }
ok(){ echo "[✓] $1"; }

# seed
MSG="STATEFUL-PERSISTENCE-OK"
kubectl -n datarec exec dataapp-0 -- sh -c "echo $MSG > /data/marker.txt && sync" >/dev/null

# delete pod and wait
kubectl -n datarec delete pod dataapp-0 --ignore-not-found --wait=false >/dev/null
kubectl -n datarec wait --for=condition=Ready pod dataapp-0 --timeout=240s >/dev/null

OUT=$(kubectl -n datarec exec dataapp-0 -- sh -c "cat /data/marker.txt" 2>/dev/null || true)
[[ "$OUT" == "$MSG" ]] || fail "marker missing after pod recreation"

# scale to zero then up
kubectl -n datarec scale statefulset dataapp --replicas=0 >/dev/null
sleep 2
kubectl -n datarec scale statefulset dataapp --replicas=1 >/dev/null
kubectl -n datarec rollout status statefulset/dataapp --timeout=300s >/dev/null
OUT2=$(kubectl -n datarec exec dataapp-0 -- sh -c "cat /data/marker.txt" 2>/dev/null || true)
[[ "$OUT2" == "$MSG" ]] || fail "marker missing after scale cycle"

ok "StatefulSet PVC persisted data across delete/recreate and scale"
