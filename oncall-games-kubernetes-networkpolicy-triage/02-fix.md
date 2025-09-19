Create a minimal allow policy in `team-b` to permit ingress **only** from pods labeled `app=client` in namespace `team-a` to port `8080`.
Apply your policy then retest:

`kubectl -n team-a exec deploy/client -- sh -c "curl -sS http://echoserver.team-b.svc.cluster.local:8080 | head -n1"`{{exec}}