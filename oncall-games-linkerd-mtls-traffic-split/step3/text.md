Apply TrafficSplit and show at least one v2 response over multiple curls.

`kubectl apply -f /opt/assets/trafficsplit.yaml`{{exec}}
`kubectl -n demo exec pod/$(kubectl -n demo get po -l run=curler -o name) -- sh -c 'for i in $(seq 1 20); do curl -s http://hello.demo:80; done'`{{exec}}
