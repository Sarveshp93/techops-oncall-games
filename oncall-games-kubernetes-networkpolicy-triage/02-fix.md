Create a minimal allow policy in `team-b` … then retest:

`kubectl apply -f /opt/assets/np-solution.yaml`{{exec}}
`kubectl -n team-a exec deploy/client -- sh -c "curl -sS http://echoserver.team-b.svc.cluster.local:8080 | head -n1"`{{exec}}
