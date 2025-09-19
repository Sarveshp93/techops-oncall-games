Verify Linkerd sidecars are present on hello pods.

`kubectl -n demo get po -l app=hello -o jsonpath='{.items[*].spec.containers[*].name}'`{{exec}}
