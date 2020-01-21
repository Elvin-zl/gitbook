#!/bin/sh

set -e


## istio 安装

## 1. 前提条件 

## 1.1 kubernetes 已安装,版本为1.11;

## 1.2 helm , 版本 : 2.14.3  安装教程 : http://blog.chinaunix.net/uid-31410005-id-5828798.html

## 2 准备

echo "开始下载 istio 1.1.9安装包..."

curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.1.9 sh -

echo "下载 istio 1.1.9安装包完成!"

echo "目录切换进istio安装包"

cd istio-1.1.9

echo "将istioctl 客户端加入环境变量"

export PATH=$PWD/bin:$PATH

## echo "添加Istio发行版存储库 , 使用Istio发行版Helm图表仓库"

## helm repo add istio.io https://storage.googleapis.com/istio-release/releases/1.1.9/charts/

## 3 安装 

echo "为istio-system组件创建一个名称空间"

kubectl create namespace istio-system

echo "使用安装所有Istio 自定义资源定义 （CRD）kubectl apply，然后等待几秒钟以在Kubernetes API服务器中提交CRD"

helm template install/kubernetes/helm/istio-init --name istio-init --namespace istio-system | kubectl apply -f -

echo "CRDs 初始化中 , please wait for several seconds ..."

sleep 10

echo "默认配置文件用于生产部署"

helm template install/kubernetes/helm/istio --name istio --namespace istio-system | kubectl apply -f -

## 4 验证安装

echo "services & pods  initing , please wait for several seconds ..."

sleep 20

echo "查看 istio service"

kubectl get svc -n istio-system

echo "查看 istio pod"

kubectl get pods -n istio-system

