resource "kubernetes_manifest" "pod_pykafka" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Pod"
    "metadata" = {
      "name"      = "pykafka"
      "namespace" = "kafka"
    }
    "spec" = {
      "containers" = [
        {
          "image" = "ccdockerrgu/pyproducer:1.0"
          "name"  = "pyproducer"
        },
      ]
    }
  }
}
