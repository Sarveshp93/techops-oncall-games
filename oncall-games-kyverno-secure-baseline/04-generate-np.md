`kubectl apply -f /opt/assets/policy-generate-np.yaml`{{exec}}
`kubectl create ns sandbox`{{exec}}
`kubectl -n sandbox get networkpolicy`{{exec}}
