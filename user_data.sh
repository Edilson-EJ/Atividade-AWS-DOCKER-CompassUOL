#!/bin/bash

# Instalar Docker
sudo yum update -y
sudo yum install docker -y
sudo usermod -a -G docker ec2-user

# Ativar docker
sudo systemctl enable docker.service
sudo systemctl start docker.service

# Iniciar contêiner WordPress
sudo docker run -d \
  -e WORDPRESS_DB_HOST=database-aws-docker.cb46cmyuqm96.us-east-1.rds.amazonaws.com \
  -e WORDPRESS_DB_USER=root \
  -e WORDPRESS_DB_PASSWORD=Pa$$w0rd \
  -e WORDPRESS_DB_NAME=database-aws-docker \
  -p 80:80 \
  wordpress:latest

