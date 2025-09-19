Delete the pod and check the marker survives.

`kubectl -n datarec delete pod dataapp-0 --wait=false`{{exec}}
`kubectl -n datarec wait --for=condition=Ready pod dataapp-0 --timeout=240s`{{exec}}
`kubectl -n datarec exec dataapp-0 -- sh -c 'cat /data/marker.txt'`{{exec}}
