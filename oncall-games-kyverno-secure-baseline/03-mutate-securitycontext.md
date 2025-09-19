`kubectl apply -f /opt/assets/policy-mutate-securitycontext.yaml`{{exec}}
`kubectl apply -f /opt/assets/good-deploy.yaml`{{exec}}
`kubectl -n app get pod -l app=good -o jsonpath='{.items[0].spec.containers[0].securityContext}'`{{exec}}
