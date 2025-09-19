#!/usr/bin/env bash
set -euo pipefail
if ! command -v linkerd >/dev/null 2>&1; then
  curl -sL https://run.linkerd.io/install | sh
  export PATH=$PATH:/root/.linkerd2/bin
  echo 'export PATH=$PATH:/root/.linkerd2/bin' >> /root/.bashrc
fi
linkerd check --pre || true
linkerd install --crds | kubectl apply -f -
linkerd install | kubectl apply -f -
kubectl -n linkerd rollout status deploy --timeout=240s --all || true
linkerd check || true
# SMI CRDs for TrafficSplit
kubectl get crd trafficsplits.split.smi-spec.io >/dev/null 2>&1 || \
  kubectl apply -f https://github.com/servicemeshinterface/smi-spec/releases/download/v0.6.1/crds.yaml
kubectl create ns demo >/dev/null 2>&1 || true
kubectl apply -f /opt/assets/hello-v1.yaml
kubectl apply -f /opt/assets/hello-v2.yaml
kubectl -n demo get deploy -o yaml | linkerd inject - | kubectl apply -f -
kubectl -n demo run curler --image=quay.io/curl/curl:8.8.0 --restart=Never --command -- sleep 3650d >/dev/null 2>&1 || true
kubectl -n demo wait --for=condition=Ready pod -l app=hello --timeout=240s || true
kubectl -n demo wait --for=condition=Ready pod -l run=curler --timeout=180s || true
