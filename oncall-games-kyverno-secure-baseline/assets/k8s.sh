#!/usr/bin/env bash
set -euo pipefail
LOG_FILE="${LOG_FILE:-/opt/init.log}"
log(){ printf '[%s] %s\n' "$(date +%H:%M:%S)" "$*" | tee -a "$LOG_FILE"; }
try(){ "$@" || { log "WARN: $* failed"; return 1; }; }
wait_apiserver(){
  for i in $(seq 1 200); do
    if kubectl get ns kube-system >/dev/null 2>&1; then log "API reachable"; return 0; fi
    sleep 1
  done; log "API timeout"; return 1
}
wait_ready(){ # ns label timeout
  kubectl -n "$1" wait --for=condition=Ready pod -l "$2" --timeout="${3:-300s}" || true
}
ensure_ns(){ kubectl get ns "$1" >/dev/null 2>&1 || kubectl create ns "$1"; }
