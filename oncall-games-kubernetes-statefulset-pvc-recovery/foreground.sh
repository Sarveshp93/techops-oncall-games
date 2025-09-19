#!/usr/bin/env bash
set -euo pipefail
echo "🚀 Running scenario setup..."
for i in $(seq 1 60); do
  if kubectl get ns >/dev/null 2>&1; then break; fi
  sleep 2
done
if [ -x /opt/setup.sh ]; then
  bash /opt/setup.sh || true
fi
echo "✅ Setup complete."
