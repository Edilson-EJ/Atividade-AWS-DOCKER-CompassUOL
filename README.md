
# Atividade-AWS-DOCKER-CompassUOL

# Deploy de Aplicação Wordpress na AWS

Este projeto consiste na implementação de um ambiente de hospedagem para uma aplicação Wordpress na AWS utilizando tecnologias como Docker, RDS MySQL, EFS e Load Balancer.

Etapas do Projeto:

1: Instalação e Configuração do Docker ou Containerd no Host EC2:

- Utilize o script user_data.sh para automatizar a instalação do Docker ou Containerd na instância EC2.
Deploy da Aplicação Wordpress:

2: Configure um Dockerfile ou Docker Compose para a aplicação Wordpress.

- Crie um banco de dados RDS MySQL para a aplicação Wordpress.

- Configure a conexão da aplicação com o banco de dados MySQL.

- Configuração do Serviço EFS AWS para Estáticos do Container de Aplicação Wordpress:

3: Crie um sistema de arquivos do EFS e monte-o no host EC2.

- Configure o Docker para montar os diretórios do Wordpress nos diretórios do EFS.

4: Configuração do Serviço de Load Balancer AWS para a Aplicação Wordpress:

- Crie um Load Balancer Clássico na AWS e configure-o para encaminhar o tráfego para as instâncias EC2 onde a aplicação está sendo executada.

# Pontos de Atenção:

- Evite o uso de IP público para a saída dos serviços do Wordpress.

- Sugere-se que o tráfego de internet saia pelo Load Balancer Clássico para centralizar o gerenciamento e a segurança do tráfego.

- Utilize o EFS para armazenar os arquivos estáticos do Wordpress, garantindo escalabilidade e persistência.

- Certifique-se de que a aplicação Wordpress esteja funcionando corretamente, incluindo a tela de login, e esteja acessível através da porta 80 ou 8080.

- Utilize um repositório Git para versionamento do código da aplicação Wordpress.

