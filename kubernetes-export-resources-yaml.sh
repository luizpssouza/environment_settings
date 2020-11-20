#!/bin/bash


for n in $(kubectl get -o=name pvc,configmap,serviceaccount,secret,ingress,service,deployment,statefulset,hpa,job,cronjob)
do
    echo $n
    mkdir -p $(dirname $n)
    kubectl get -o=yaml --export $n > $n.yaml
done
