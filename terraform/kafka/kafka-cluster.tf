resource "kubernetes_manifest" "kafka_my_cluster" {
  manifest = {
    "apiVersion" = "kafka.strimzi.io/v1beta2"
    "kind"       = "Kafka"
    "metadata" = {
      "name"      = "my-cluster"
      "namespace" = "kafka"
    }
    "spec" = {
      "entityOperator" = {
        "topicOperator" = {}
        "userOperator"  = {}
      }
      "kafka" = {
        "config" = {
          "default.replication.factor"               = 1
          "inter.broker.protocol.version"            = "3.3"
          "min.insync.replicas"                      = 1
          "offsets.topic.replication.factor"         = 1
          "transaction.state.log.min.isr"            = 1
          "transaction.state.log.replication.factor" = 1
        }
        "listeners" = [
          {
            "name" = "plain"
            "port" = 9092
            "tls"  = false
            "type" = "internal"
          },
          {
            "name" = "tls"
            "port" = 9093
            "tls"  = true
            "type" = "internal"
          },
          {
            "name" = "external"
            "port" = 9094
            "tls"  = false
            "type" = "nodeport"
          },
        ]
        "replicas" = 1
        "storage" = {
          "type" = "jbod"
          "volumes" = [
            {
              "deleteClaim" = false
              "id"          = 0
              "size"        = "100Gi"
              "type"        = "persistent-claim"
            },
          ]
        }
        "version" = "3.3.2"
      }
      "zookeeper" = {
        "replicas" = 1
        "storage" = {
          "deleteClaim" = false
          "size"        = "100Gi"
          "type"        = "persistent-claim"
        }
      }
    }
  }
}
