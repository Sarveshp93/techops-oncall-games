#!/usr/bin/env bash
set -euo pipefail
source /opt/k8s.sh
log "Init: StatefulSet PVC recovery"
wait_apiserver
kubectl apply -f /opt/assets/statefulset.yaml
kubectl -n datarec rollout status statefulset/dataapp --timeout=420s || true
wait_ready_pods datarec "statefulset.kubernetes.io/pod-name=dataapp-0" 240s || true
log "StatefulSet ready."
touch /opt/INIT_DONE
log "INIT_DONE"
