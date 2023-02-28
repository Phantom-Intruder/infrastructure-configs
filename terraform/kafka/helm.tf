provider "helm" {
  kubernetes {
    config_path = var.kube_config
  }
}

resource "helm_release" "strimzi" {
  chart      = "strimzi-kafka-operator"
  name       = "strimzi-kafka-operator"
  namespace  = var.namespace
  repository = "https://strimzi.io/charts/"
}
