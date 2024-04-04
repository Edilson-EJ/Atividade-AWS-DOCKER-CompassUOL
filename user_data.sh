#!/bin/bash

# Atualizar pacotes
sudo yum update -y

# Instalar Docker
sudo yum install -y docker

# Iniciar serviço Docker
sudo service docker start

# Adicionar usuário ao grupo docker
sudo usermod -a -G docker ec2-user
