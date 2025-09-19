Try listing Pods with the on-call kubeconfig (should fail):

`kubectl --kubeconfig=/root/.kube/oncall.conf get pods -A`{{exec}}