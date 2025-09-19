#!/usr/bin/env bash
set -euo pipefail
source /opt/k8s.sh
log "Init StatefulSet recovery"
wait_apiserver
kubectl apply -f /opt/statefulset.yaml
kubectl -n datarec rollout status statefulset/dataapp --timeout=420s || true
wait_ready datarec "statefulset.kubernetes.io/pod-name=dataapp-0" 240s
touch /opt/INIT_DONE
log "INIT_DONE"
