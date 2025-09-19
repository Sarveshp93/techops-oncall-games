#!/usr/bin/env bash
set -euo pipefail
source /opt/k8s.sh
log "Init RBAC scenario"
wait_apiserver
ensure_ns oncall
kubectl -n oncall create sa oncall >/dev/null 2>&1 || true
TOKEN=$(kubectl -n oncall create token oncall 2>/dev/null || true)
SERVER=$(kubectl config view -o jsonpath='{.clusters[0].cluster.server}')
mkdir -p /root/.kube
cat >/root/.kube/oncall.conf <<EOF
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
kubectl apply -f /opt/sample-workload.yaml >/dev/null 2>&1 || true
log "RBAC scenario ready"
touch /opt/INIT_DONE
log "INIT_DONE"
