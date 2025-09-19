Verify reverse direction still blocked and only `8080` works.

`kubectl -n team-b exec deploy/echoserver -- sh -c "apk add --no-cache curl >/dev/null 2>&1 || true; curl -sS --max-time 2 http://client.team-a.svc.cluster.local:8080 || echo BLOCKED"`{{exec}}
