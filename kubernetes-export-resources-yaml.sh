#!/bin/bash

echo "Type the kubernetes namespace to export all configurations: "
read namespace

for n in $(kubectl get -o=name pv,pvc,configmap,serviceaccount,secret,ingress,service,deployment,statefulset,hpa,job,cronjob -n $namespace)
do
    echo "Exporting ... " $n
    echo $n
    mkdir -p $(dirname $n)
    kubectl get -o=yaml --export $n > $n.yaml
done
