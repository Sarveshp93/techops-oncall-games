Apply the verify policy and check it’s active:

`kubectl apply -f /opt/assets/policy-verify-image.yaml`{{exec}}
`kubectl get clusterpolicy verify-image-prod -o jsonpath='{.spec.rules[0].verifyImages[0].mutateDigest}'`{{exec}}
