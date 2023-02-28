provider "kubernetes" {
  config_path = var.kube_config
}

resource "kubernetes_namespace" "kafka" {
  metadata {
    name = var.namespace
  }
}
