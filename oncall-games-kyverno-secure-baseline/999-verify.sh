#!/usr/bin/env bash
set -euo pipefail
fail(){ echo "[X] $1"; exit 1; }
ok(){ echo "[✓] $1"; }

# 1) disallowed registry blocked
if kubectl apply -f /opt/assets/bad-deploy.yaml >/tmp/kyverno-bad-apply.txt 2>&1; then
  fail "bad deploy unexpectedly allowed"
fi
ok "disallowed registry denied"

# 2) allowed image admitted & mutated
kubectl apply -f /opt/assets/good-deploy.yaml >/dev/null
kubectl -n app rollout status deploy/good --timeout=180s >/dev/null
# ensure runAsNonRoot appears on pod spec
SECCTX=$(kubectl -n app get pod -l app=good -o jsonpath='{.items[0].spec.securityContext.runAsNonRoot}')
[[ "$SECCTX" == "true" ]] || fail "mutation did not add runAsNonRoot"
ok "mutation added securityContext"

# 3) generate policy creates default-deny on new ns
kubectl get ns sandbox >/dev/null 2>&1 || kubectl create ns sandbox >/dev/null
kubectl apply -f /opt/assets/policy-generate-np.yaml >/dev/null
sleep 2
kubectl -n sandbox get networkpolicy default-deny >/dev/null || fail "generated NetworkPolicy missing in sandbox"
ok "generate policy produced default-deny networkpolicy"
