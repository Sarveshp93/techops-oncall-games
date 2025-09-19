#!/usr/bin/env bash
set -euo pipefail
source /opt/k8s.sh
log "Init Kyverno baseline"
wait_apiserver
ensure_ns kyverno
ensure_ns app
kubectl create -f https://github.com/kyverno/kyverno/releases/download/v1.15.1/install.yaml >>/opt/init.log 2>&1
kubectl -n kyverno rollout status deploy --timeout=300s --all || true
ensure_ns app
touch /opt/INIT_DONE
log "INIT_DONE"
