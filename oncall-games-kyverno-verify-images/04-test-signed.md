Create a Pod with the **signed** image (should be **admitted and mutated to a digest**):

`kubectl apply -f /opt/assets/pod-signed.yaml`{{exec}}

Verify image reference includes a digest:

`kubectl -n prod-apps get pod signed -o jsonpath='{.spec.containers[0].image}'`{{exec}}
