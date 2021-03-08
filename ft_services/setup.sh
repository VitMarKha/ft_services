#!/bin/sh

minikube stop
minikube delete
VBoxManage hostonlyif remove vboxnet0
minikube start --vm-driver=virtualbox

#Установка minikube и metallb
eval $(minikube docker-env)
minikube addons enable metallb
minikube addons list

#Установка nginx
docker build -t nginx_image srcs/nginx
kubectl apply -f ./srcs/configmap.yaml
kubectl apply -f ./srcs/nginx/nginx.yaml

#Установка mysql
docker build -t mysql_image srcs/mysql
kubectl apply -f ./srcs/mysql/mysql.yaml

#Установка phpmyadmin
docker build -t phpmyadmin_image srcs/phpmyadmin
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml

#Установка wordpress
docker build -t wordpress_image srcs/wordpress
kubectl apply -f ./srcs/wordpress/wordpress.yaml

#Установка ftps
docker build -t ftps_image srcs/ftps
kubectl apply -f ./srcs/ftps/ftps.yaml

#Установка grafana
docker build -t grafana_image srcs/grafana
kubectl apply -f ./srcs/grafana/grafana.yaml

#Установка influxdb
docker build -t influxdb_image srcs/influxdb
kubectl apply -f ./srcs/influxdb/influxdb.yaml

#Вызов dashboard
minikube dashboard