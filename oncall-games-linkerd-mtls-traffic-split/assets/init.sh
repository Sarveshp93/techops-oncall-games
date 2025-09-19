#!/usr/bin/env bash
set -euo pipefail
source /opt/k8s.sh
log "Init Linkerd scenario"
wait_apiserver
if ! command -v linkerd >/dev/null 2>&1; then
  curl -sL https://run.linkerd.io/install | sh >>/opt/init.log 2>&1 || true
  export PATH=$PATH:/root/.linkerd2/bin
  echo 'export PATH=$PATH:/root/.linkerd2/bin' >> /root/.bashrc
fi
linkerd install --crds | kubectl apply -f - >>/opt/init.log 2>&1 || true
linkerd install | kubectl apply -f - >>/opt/init.log 2>&1 || true
kubectl -n linkerd rollout status deploy --timeout=300s --all || true
kubectl get crd trafficsplits.split.smi-spec.io >/dev/null 2>&1 || \
  kubectl apply -f https://github.com/servicemeshinterface/smi-spec/releases/download/v0.6.1/crds.yaml >>/opt/init.log 2>&1
ensure_ns demo
kubectl apply -f /opt/assets/hello-v1.yaml
kubectl apply -f /opt/assets/hello-v2.yaml
kubectl -n demo get deploy -o yaml | linkerd inject - | kubectl apply -f - >>/opt/init.log 2>&1 || true
kubectl -n demo run curler --image=quay.io/curl/curl:8.8.0 --restart=Never --command -- sleep 3650d >/dev/null 2>&1 || true
kubectl -n demo rollout status deploy --timeout=240s --all || true
wait_ready demo "run=curler" 240s
log "Linkerd ready"
touch /opt/INIT_DONE
log "INIT_DONE"
