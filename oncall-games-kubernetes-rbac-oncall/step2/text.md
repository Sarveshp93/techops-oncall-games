Grant **read-only** verbs cluster-wide (least-privilege).

Test again:
`kubectl --kubeconfig=/root/.kube/oncall.conf get pods -A`{{exec}}
