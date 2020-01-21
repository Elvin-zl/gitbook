#!/bin/sh

set -e


## istio 安装

## 1. 前提条件 

## 1.1 kubernetes 已安装,版本为1.11;

## 1.2 helm , 版本 : 2.14.3  安装教程 : http://blog.chinaunix.net/uid-31410005-id-5828798.html

## 2 准备

echo "开始卸载istio..."

helm template install/kubernetes/helm/istio --name istio --namespace istio-system | kubectl delete -f -

echo "开始删除namespce..."

kubectl delete namespace istio-system
