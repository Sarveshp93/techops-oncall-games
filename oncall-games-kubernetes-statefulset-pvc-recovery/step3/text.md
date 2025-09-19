Scale to 0 then back to 1 and confirm the marker still exists.

`kubectl -n datarec scale statefulset dataapp --replicas=0`{{exec}}
`kubectl -n datarec scale statefulset dataapp --replicas=1`{{exec}}
`kubectl -n datarec rollout status statefulset/dataapp --timeout=420s`{{exec}}
`kubectl -n datarec exec dataapp-0 -- sh -c 'cat /data/marker.txt'`{{exec}}
