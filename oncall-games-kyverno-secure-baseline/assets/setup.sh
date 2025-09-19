#!/usr/bin/env bash
set -euo pipefail
# Install Kyverno using upstream manifests
kubectl create ns kyverno >/dev/null 2>&1 || true
kubectl apply -f https://raw.githubusercontent.com/kyverno/kyverno/release-1.12/config/release/install.yaml
kubectl -n kyverno rollout status deploy kyverno --timeout=180s
kubectl -n kyverno rollout status deploy kyverno-background-controller --timeout=180s
kubectl -n kyverno rollout status deploy kyverno-cleanup-controller --timeout=180s
# Work namespace
kubectl create ns app >/dev/null 2>&1 || true
