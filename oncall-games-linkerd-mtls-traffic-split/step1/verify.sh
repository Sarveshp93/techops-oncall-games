#!/usr/bin/env bash
set -euo pipefail
linkerd check >/dev/null 2>&1 || { echo "linkerd check failed"; exit 1; }
echo "Step 1 OK: linkerd installed"
