Try a signed image (should be admitted and pinned to digest).

`kubectl apply -f /opt/pod-signed.yaml`{{exec}}
`kubectl -n prod-apps get pod signed -o jsonpath='{.spec.containers[0].image}'`{{exec}}
