Scale to zero (PVC remains), then scale back:

`kubectl -n datarec scale statefulset dataapp --replicas=0`{{exec}}
`kubectl -n datarec scale statefulset dataapp --replicas=1`{{exec}}
`kubectl -n datarec rollout status statefulset/dataapp --timeout=240s`{{exec}}

Verify the marker once more:

`kubectl -n datarec exec dataapp-0 -- sh -c 'cat /data/marker.txt'`{{exec}}
