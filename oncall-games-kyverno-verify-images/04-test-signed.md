`kubectl apply -f /opt/assets/pod-signed.yaml`{{exec}}
`kubectl -n prod-apps get pod signed -o jsonpath='{.spec.containers[0].image}'`{{exec}}
