Apply the generate policy and create a new namespace; a default-deny NetworkPolicy should appear automatically:

`kubectl apply -f /opt/assets/policy-generate-np.yaml`{{exec}}
`kubectl create ns sandbox`{{exec}}
`kubectl -n sandbox get networkpolicy`{{exec}}