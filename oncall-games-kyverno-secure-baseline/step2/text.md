Apply registry policy and attempt a disallowed image.

`kubectl apply -f /opt/policy-validate-registries.yaml`{{exec}}
`kubectl apply -f /opt/bad-deploy.yaml`{{exec}}
