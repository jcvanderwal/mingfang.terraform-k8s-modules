resource "k8s_rbac_authorization_k8s_io_v1_cluster_role_binding" "auth-delegator" {
  metadata {
    name = "${var.namespace}:system:auth-delegator"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }

  subjects {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = var.namespace
  }
}