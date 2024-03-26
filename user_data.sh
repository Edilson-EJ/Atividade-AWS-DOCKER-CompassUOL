#!/bin/bash

# Atualizar pacotes
sudo apt-get update

# Instalar Docker
sudo apt-get install -y docker.io

# Iniciar serviço do Docker
sudo systemctl start docker

# Habilitar o Docker para iniciar na inicialização
sudo systemctl enable docker