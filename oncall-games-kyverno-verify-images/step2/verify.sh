#!/usr/bin/env bash
set -euo pipefail
kubectl get clusterpolicy verify-image-prod >/dev/null 2>&1 || { echo "policy missing"; exit 1; }
MD=$(kubectl get clusterpolicy verify-image-prod -o jsonpath='{.spec.rules[0].verifyImages[0].mutateDigest}')
[ "$MD" = "true" ] || { echo "mutateDigest not true"; exit 1; }
echo "Step 2 OK: policy applied"
