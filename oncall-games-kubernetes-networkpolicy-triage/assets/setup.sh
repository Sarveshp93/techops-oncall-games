#!/usr/bin/env bash
set -euo pipefail
kubectl create ns team-a >/dev/null 2>&1 || true
kubectl create ns team-b >/dev/null 2>&1 || true
kubectl apply -f /opt/assets/app.yaml
kubectl apply -f /opt/assets/np-default-deny.yaml
kubectl -n team-a wait --for=condition=Ready pod -l app=client --timeout=180s
kubectl -n team-b wait --for=condition=Ready pod -l app=echoserver --timeout=180s
