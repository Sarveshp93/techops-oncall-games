`kubectl -n demo get po -o custom-columns=NAME:.metadata.name,CONTAINERS:.spec.containers[*].name`{{exec}}

You should see `linkerd-proxy`.
