# Terraform config for Kafka

These Terraform config files will set up Kafka on your Kubernetes cluster. To do this, the [Strimzi helm chart](https://github.com/strimzi/strimzi-kafka-operator/tree/main/helm-charts) will be used.

## Requirements

- Helm
- Kubectl
- Terraform

If you are running Minikube, make sure your kubectl command is configured correctly ([installing kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux) normally should work).

## Installation

```
terraform init
```
```
terraform apply
```

Deployment will take up to 5 minutes. You can look at the progress with:

```
kubectl get po -n kafka --watch
```

Your end result should be:

```
NAME                                         READY   STATUS 
my-cluster-entity-operator-795fb55fc-j5k64   3/3     Running
my-cluster-kafka-0                           1/1     Running
my-cluster-zookeeper-0                       1/1     Running
strimzi-cluster-operator-77cf4d89cb-cwwgd    1/1     Running
```

You can also observe the services:

```
kubectl get svc -n kafka
```

The end result should look like this:

```
NAME                                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                            
my-cluster-kafka-0                    NodePort    10.96.101.238    <none>        9094:31974/TCP                     
my-cluster-kafka-bootstrap            ClusterIP   10.111.186.126   <none>        9091/TCP,9092/TCP,9093/TCP         
my-cluster-kafka-brokers              ClusterIP   None             <none>        9090/TCP,9091/TCP,9092/TCP,9093/TCP
my-cluster-kafka-external-bootstrap   NodePort    10.104.103.135   <none>        9094:31912/TCP                     
my-cluster-zookeeper-client           ClusterIP   10.107.3.32      <none>        2181/TCP                           
my-cluster-zookeeper-nodes            ClusterIP   None             <none>        2181/TCP,2888/TCP,3888/TCP         
```

## Running producers and consumers

Run the producer with:

```
kubectl run kafka-producer -n kafka -ti --image=quay.io/strimzi/kafka:0.32.0-kafka-3.3.1 --rm=true --restart=Never -- bin/kafka-console-producer.sh --bootstrap-server my-cluster-kafka-external-bootstrap:9094 --topic my-topic
```

Run the consumer with:

```
kubectl run kafka-consumer -n kafka -ti --image=quay.io/strimzi/kafka:0.32.0-kafka-3.3.1 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server my-cluster-kafka-external-bootstrap:9094 --topic my-topic --from-beginning
```

## Running the sample Python producer

This project also comes with a Python producer. To use it, first run the consumer:

```
kubectl run kafka-consumer -n kafka -ti --image=quay.io/strimzi/kafka:0.32.0-kafka-3.3.1 --rm=true --restart=Never -- bin/kafka-console-consumer.sh --bootstrap-server my-cluster-kafka-external-bootstrap:9094--topic my-topic --from-beginning
```

Now, open a terminal instacne in the python-producer folder and run:

```
terraform init
```

```
terraform apply
```

This will pull an image from Docker Hub that contains a simple python producer set to run run when the container is started. The Dockerfile and Python code for this image can be found in the `image` folder. This image will be used to deploy a pod into your existing Kubernetes cluster. You can see this pod running with:

```
kubectl get po -n kafka
```

When the pod starts, you should see messages appearing in the consumer window you previously opened.
