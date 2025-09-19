#!/usr/bin/env bash
set -euo pipefail
echo "🚀 Running scenario setup for: $(basename "$(pwd)")"
# Ensure kubectl is responsive before running setup
for i in $(seq 1 60); do
  if kubectl version --client >/dev/null 2>&1 && kubectl get ns >/dev/null 2>&1; then
    break
  fi
  sleep 2
done
if [ -x /opt/setup.sh ]; then
  bash /opt/setup.sh || true
fi
if [ -x /opt/verify.sh ]; then
  chmod +x /opt/verify.sh || true
fi
echo "✅ Setup finished (or best-effort)."
