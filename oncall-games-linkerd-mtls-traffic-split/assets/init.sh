#!/usr/bin/env bash
set -euo pipefail
source /opt/k8s.sh
LOG_FILE=/opt/init.log
log "Init: Linkerd scenario"
wait_apiserver
# Install Linkerd CLI and control plane
if ! command -v linkerd >/dev/null 2>&1; then
  log "Installing linkerd CLI"
  curl -sL https://run.linkerd.io/install | sh >>"$LOG_FILE" 2>&1 || true
  export PATH=$PATH:/root/.linkerd2/bin
  echo 'export PATH=$PATH:/root/.linkerd2/bin' >> /root/.bashrc
fi
log "Installing Linkerd control plane"
linkerd install --crds | kubectl apply -f - >>"$LOG_FILE" 2>&1 || true
linkerd install | kubectl apply -f - >>"$LOG_FILE" 2>&1 || true
kubectl -n linkerd rollout status deploy --timeout=300s --all || true
# SMI CRDs
kubectl get crd trafficsplits.split.smi-spec.io >/dev/null 2>&1 || \
  kubectl apply -f https://github.com/servicemeshinterface/smi-spec/releases/download/v0.6.1/crds.yaml >>"$LOG_FILE" 2>&1
ensure_ns demo
kubectl apply -f /opt/assets/hello-v1.yaml
kubectl apply -f /opt/assets/hello-v2.yaml
kubectl -n demo get deploy -o yaml | linkerd inject - | kubectl apply -f - >>"$LOG_FILE" 2>&1 || true
kubectl -n demo run curler --image=quay.io/curl/curl:8.8.0 --restart=Never --command -- sleep 3650d >/dev/null 2>&1 || true
rollout_wait_all demo "app=hello"
wait_ready_pods demo "run=curler" 240s
log "Linkerd scenario ready."
touch /opt/INIT_DONE
log "INIT_DONE"
