#!/usr/bin/env bash
set -euo pipefail
# Install Kyverno
kubectl create ns kyverno >/dev/null 2>&1 || true
kubectl apply -f https://raw.githubusercontent.com/kyverno/kyverno/release-1.12/config/release/install.yaml
kubectl -n kyverno rollout status deploy kyverno --timeout=240s
kubectl -n kyverno rollout status deploy kyverno-background-controller --timeout=240s
kubectl -n kyverno rollout status deploy kyverno-cleanup-controller --timeout=240s

# Create a prod namespace labeled for policy selection
kubectl create ns prod-apps >/dev/null 2>&1 || true
kubectl label ns prod-apps env=prod --overwrite
