Run a test from the client pod (should **fail**):

`kubectl -n team-a exec deploy/client -- sh -c "curl -sS --max-time 2 http://echoserver.team-b.svc.cluster.local:8080"`{{exec}}