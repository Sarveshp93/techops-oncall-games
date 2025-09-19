Grant **read-only** verbs on core resources cluster-wide using a ClusterRole and ClusterRoleBinding targeting `system:serviceaccount:oncall:oncall`.
Example to apply (least-privilege):

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata: {name: oncall-readonly}
rules:
- apiGroups: [""]
  resources: ["pods","services","endpoints","configmaps","namespaces"]
  verbs: ["get","list","watch"]
- apiGroups: ["apps"]
  resources: ["deployments","statefulsets","daemonsets","replicasets"]
  verbs: ["get","list","watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata: {name: oncall-readonly}
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: oncall-readonly
subjects:
- kind: ServiceAccount
  name: oncall
  namespace: oncall