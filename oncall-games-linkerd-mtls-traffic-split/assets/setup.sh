#!/usr/bin/env bash
set -euo pipefail
# Install Linkerd CLI if missing
if ! command -v linkerd >/dev/null 2>&1; then
  curl -sL https://run.linkerd.io/install | sh
  export PATH=$PATH:/root/.linkerd2/bin
  echo 'export PATH=$PATH:/root/.linkerd2/bin' >> /root/.bashrc
fi
# Pre-check & install control plane
linkerd check --pre
linkerd install --crds | kubectl apply -f -
linkerd install | kubectl apply -f -
kubectl -n linkerd rollout status deploy --timeout=180s --all
linkerd check
# App namespace & workloads
kubectl create ns demo >/dev/null 2>&1 || true
kubectl apply -f /opt/assets/hello-v1.yaml
kubectl apply -f /opt/assets/hello-v2.yaml
# Mesh everything in demo
kubectl -n demo get deploy -o yaml | linkerd inject - | kubectl apply -f -
# Simple curl client
kubectl -n demo run curler --image=quay.io/curl/curl:8.8.0 --restart=Never --command -- sleep 3650d >/dev/null 2>&1 || true
kubectl -n demo wait --for=condition=Ready pod -l app=hello --timeout=180s
kubectl -n demo wait --for=condition=Ready pod -l run=curler --timeout=120s