Apply mutate policy and create a compliant deployment:

`kubectl apply -f /opt/assets/policy-mutate-securitycontext.yaml`{{exec}}
`kubectl apply -f /opt/assets/good-deploy.yaml`{{exec}}

Check mutation:

`kubectl -n app get pod -l app=good -o json | jq '.items[0].spec.containers[0].securityContext'`{{exec}}
