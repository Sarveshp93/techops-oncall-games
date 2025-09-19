Delete the Pod to simulate a node drain or crash and wait for it to be recreated:

`kubectl -n datarec delete pod dataapp-0 --wait=false`{{exec}}
`kubectl -n datarec wait --for=condition=Ready pod dataapp-0 --timeout=180s`{{exec}}

Read the marker again:

`kubectl -n datarec exec dataapp-0 -- sh -c 'cat /data/marker.txt'`{{exec}}
