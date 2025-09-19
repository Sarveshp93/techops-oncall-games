#!/usr/bin/env bash
set -euo pipefail

LOG_FILE="${LOG_FILE:-/opt/init.log}"

log() { printf '[%s] %s\n' "$(date +%H:%M:%S)" "$*" | tee -a "$LOG_FILE"; }
try() { "$@" || { log "WARN: command failed: $*"; return 1; }; }

wait_apiserver() {
  for i in $(seq 1 120); do
    if kubectl get ns kube-system >/dev/null 2>&1; then
      log "Kubernetes API is reachable."
      return 0
    fi
    sleep 2
  done
  log "Timeout waiting for API server"; return 1
}

wait_ready_pods() { # ns label timeout
  local ns="$1" lbl="$2" to="${3:-300s}"
  try kubectl -n "$ns" wait --for=condition=Ready pod -l "$lbl" --timeout="$to"
}

rollout_wait_all() { # ns kind-label
  local ns="$1" selector="${2:-}"
  if [ -n "$selector" ]; then
    try kubectl -n "$ns" rollout status deploy -l "$selector" --timeout=300s
  else
    try kubectl -n "$ns" rollout status deploy --all --timeout=300s
  fi
}

ensure_ns() {
  local ns="$1"
  kubectl get ns "$ns" >/dev/null 2>&1 || kubectl create ns "$ns"
}
