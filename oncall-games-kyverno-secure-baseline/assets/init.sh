#!/usr/bin/env bash
set -euo pipefail
source /opt/k8s.sh
log "Init: Kyverno secure baseline"
wait_apiserver
ensure_ns kyverno
kubectl apply -f https://raw.githubusercontent.com/kyverno/kyverno/release-1.12/config/release/install.yaml >>/opt/init.log 2>&1
kubectl -n kyverno rollout status deploy --timeout=300s --all || true
ensure_ns app
log "Kyverno baseline ready."
touch /opt/INIT_DONE
log "INIT_DONE"
