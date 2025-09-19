#!/usr/bin/env bash
set -euo pipefail
# create SA and a kubeconfig using a token
NAMESPACE=oncall
SA=oncall
kubectl create ns $NAMESPACE >/dev/null 2>&1 || true
kubectl -n $NAMESPACE create sa $SA >/dev/null 2>&1 || true
# kubeconfig with token (works on k8s >=1.24)
TOKEN=$(kubectl -n $NAMESPACE create token $SA 2>/dev/null || true)
SERVER=$(kubectl config view -o jsonpath='{.clusters[0].cluster.server}')
KCFG=/root/.kube/oncall.conf
cat >"$KCFG" <<EOF
apiVersion: v1
kind: Config
clusters:
- cluster:
    server: ${SERVER}
    insecure-skip-tls-verify: true
  name: in-cluster
contexts:
- context:
    cluster: in-cluster
    user: oncall
  name: oncall
current-context: oncall
users:
- name: oncall
  user:
    token: ${TOKEN}
EOF
# create some sample workloads to view
kubectl create ns foo >/dev/null 2>&1 || true
kubectl -n foo create deploy nginx --image=nginx:1.25 --replicas=1 >/dev/null 2>&1 || true