#!/usr/bin/env bash
set -euo pipefail
source /opt/k8s.sh
log "Init: NetworkPolicy triage"
wait_apiserver
log "Creating namespaces and deployments"
ensure_ns team-a
ensure_ns team-b
kubectl apply -f /opt/assets/app.yaml
kubectl apply -f /opt/assets/np-default-deny.yaml
wait_ready_pods team-a "app=client" 240s || true
wait_ready_pods team-b "app=echoserver" 240s || true
log "Seeding complete. Scenario ready."
touch /opt/INIT_DONE
log "INIT_DONE"
