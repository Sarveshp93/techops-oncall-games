Try to create a Pod in the prod namespace with an **unsigned** image (should be **denied**):

`kubectl apply -f /opt/assets/pod-unsigned.yaml`{{exec}}
