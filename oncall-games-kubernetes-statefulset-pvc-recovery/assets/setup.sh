#!/usr/bin/env bash
set -euo pipefail
kubectl apply -f /opt/assets/statefulset.yaml
kubectl -n datarec rollout status statefulset/dataapp --timeout=420s
kubectl -n datarec wait --for=condition=Ready pod dataapp-0 --timeout=180s
