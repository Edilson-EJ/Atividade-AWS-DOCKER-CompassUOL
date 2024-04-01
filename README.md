
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

# Criar VPC

1: Acesse o serviço VPC:

- No Console de Gerenciamento da AWS, vá para o serviço "VPC" clicando em "Services" e pesquisando por "VPC", ou simplesmente clicando em "VPC" se ele estiver presente nos serviços recentes.

2: Inicie a criação da VPC:

- No painel de navegação à esquerda, selecione "Your VPCs" e clique em "Create VPC".

3: Preencha os detalhes básicos:

- Dê um nome para a sua VPC (aws-docker).

- Especifique um bloco de endereço  para a sua VPC.

        - Bloco 10.0.0.0/24

- Certifique-se de escolher um que não entre em conflito com outras redes que você possa estar usando.

Depois de preencher os detalhes, clique em "Create VPC" para criar a VPC.

# Criar Sub-rede

1: Navegue até o serviço VPC:

- No Console de Gerenciamento da AWS, vá para o serviço "VPC" clicando em "Services" e pesquisando por "VPC", ou simplesmente clicando em "VPC" se ele estiver presente nos serviços recentes.

2: Selecione "Subnets" no painel de navegação à esquerda:

- Isso irá levá-lo para a página onde você pode gerenciar suas sub-redes.

3: Clique em "Create subnet" (Criar sub-rede):

- Isso iniciará o assistente de criação de sub-rede.

4: Preencha os detalhes da sub-rede:

- Escolha a VPC na qual você deseja criar a sub-rede (aws-docker).

- Escolha uma região para a sub-rede (a região deve corresponder à região da sua VPC).

- Dê um nome para a sua sub-rede.

        - Região: (Leste dos EUA(norte da viriginia))

        - Nome Sub-Rede: atividade-aws-docker

- Escolha o bloco de endereços CIDR para a sub-rede. Certifique-se de que este bloco esteja contido no bloco de endereços CIDR da sua VPC e não entre em conflito com outras sub-redes.

        - Bloco: (10.0.0.0/24)
        - Bloco CIDR IPv4 da sub-rede: (10.0.0.0/28)

- Selecione a zona de disponibilidade para a sub-rede.

        - Leste dos EUA(norte da viriginia)

5: Clique em "Create subnet" (Criar sub-rede):

6: Depois de preencher os detalhes, clique em "Create subnet" para criar a sub-rede.

# Grupo de segurança

1: Navegue até o serviço EC2:

- No Console de Gerenciamento da AWS, vá para o serviço "EC2" clicando em "Services" e pesquisando por "EC2", ou clicando diretamente no serviço se ele estiver presente nos serviços recentes.

2: Acesse a seção "Security Groups":

No painel de navegação à esquerda, clique em "Security Groups" sob a seção "Network & Security".

3: Crie um novo grupo de segurança:

- Na página "Security Groups", clique em "Create security group".

4: Preencha os detalhes do grupo de segurança:

- Forneça um nome e uma descrição para o grupo de segurança.

        - nome: security-group-aws-docker
        - Descrição: atividade aws-docker

5: Escolha a VPC na qual você deseja criar o grupo de segurança.

        - aws-docker

6:  Adicione as regras de entrada:

- Clique na guia "Inbound rules" ou "Rules" (dependendo da interface do console).

- Clique em "Add rule" para adicionar uma nova regra.

- Adicione as seguintes regras de entrada:

        - Tipo: SSH, Protocolo: TCP, Porta: 22, Origem: 0.0.0.0/0

        - Tipo: HTTP, Protocolo: TCP, Porta: 80, Origem: 0.0.0.0/0

        - Tipo: HTTPS, Protocolo: TCP, Porta: 443, Origem: 0.0.0.0/0

        - Tipo: NFS, Protocolo: TCP, Porta: 2049, Origem: 0.0.0.0/0

        - Tipo: NFS, Protocolo: UDP, Porta: 2049, Origem: 0.0.0.0/0

        - Tipo: RPC, Protocolo: TCP, Porta: 111, Origem: 0.0.0.0/0

        - Tipo: RPC, Protocolo: UDP, Porta: 111, Origem: 0.0.0.0/0

7: Salve as alterações:

- Certifique-se de revisar as regras e clique em "Create security group" ou "Save" para criar o grupo de segurança com as regras especificadas.


# Processo de criação da INSTÂNCIA EC2 para a atividade.

Passo 1: Navegue até o serviço EC2

- No Console de Gerenciamento da AWS, vá para o serviço "EC2" clicando em "Services" e pesquisando por "EC2", ou clicando diretamente no serviço se ele estiver presente nos serviços recentes.

Passo 2: Adiciona tags 

        - Chave: AWS-DOCKER valor: PB-UNICESUMAR RECURSO: Instância, Volumes

        - Chave: Name valor: PB-UNICESUMAR RECURSO: Instância, Volumes

        - Chave: CostCenter valor: C092000024 RECURSO: Instância, Volumes

        - Chave: Project valor: PB-UNICESUMAR RECURSO: Instância, Volumes

Passo 3: AMI 

        - Amazon Linux 2023 AMI

Passo 4: Tipo de Instância

        - t3.small

Passo 5: Par de chaves

        - KeySSH01

Passo 4: VPC

        - aws-docker 

Passo 5: Sub-rede:

        - atividade-aws-docker 

Passo 6: Grupo de segurança 

        - security-group-aws-docker

Passo 7: Armazenamento

        - 16 GB

Passo 8: Dados do usuário

- peque o arquivo de script que está na pasta do projeto.

- nome: user_data.sh

- conteudo: 

        #!/bin/bash

        # Atualizar pacotes
        sudo apt-get update

        # Instalar Docker
        sudo apt-get install -y docker.io

        # Iniciar serviço do Docker
        sudo systemctl start docker

        # Habilitar o Docker para iniciar na inicialização
        sudo systemctl enable docker

Passo 9: Número de instância:

        - 2

Passo 10: Criar Instância.

# Associando IPs elásticos as Instância

1. Criar um Endereço IP Elástico: 

- No menu de serviços, vá para "EC2" clicando em "Serviços" e depois em "EC2" ou pesquisando por "EC2".

- No painel de navegação esquerdo, clique em "Elastic IPs" sob "Network & Security".

- Clique no botão "Allocate new address" na parte superior da página.

- Escolha "Amazon's pool of IPv4 addresses" e clique em "Allocate".

2. Associar o Endereço IP Elástico a uma Instância EC2:

- No painel de navegação esquerdo, clique em "Instances" sob "Instances" para ver suas instâncias EC2.

- Selecione a instância EC2 à qual você deseja associar o endereço IP elástico.

- No menu "Actions" (Ações), vá até "Networking" e selecione "Manage IP addresses".

- Clique em "Associate new address".

- No campo "Instance", selecione a instância EC2 à qual deseja associar o endereço IP elástico.

- No campo "Private IP address", selecione o IP privado da instância (ou deixe em branco para usar o IP primário da instância).

- Clique em "Associate".

            - 44.196.14.149 ID da instância  i-0c7d2b41401fccfa8
            - 55.88.183.232 ID da instância  i-07dce8fa625ea956f


# ssh: connect to host 55.88.183.232 port 22: Connection timed out

1: No Console de Gerenciamento da AWS, vá para o serviço "VPC".

2: No painel de navegação à esquerda, clique em "Tabelas de roteamento".

3: Selecione a tabela de roteamento associada à sua sub-rede.

                - VPC aws-docker

4: Clique no botão "Editar rotas".

5: Adicione uma nova rota com destino 0.0.0.0/0 e selecione o Internet Gateway como alvo. Certifique-se de salvar as alterações após adicionar a rota.

                - 0.0.0.0/0

6: Reinicie as instancias

# Acessa a Instancia

Passo 1: Acesse o PowerShell como administrador.

Passo 2: Execute o comando SSH completo para se conectar à instância EC2.

        - cd C:\Users\edils\Desktop\chaves-aws

        - ssh -i "keySSH01.pem" ec2-user@44.196.14.149

        - ssh -i "keySSH01.pem" ec2-user@54.88.183.232



# Crie um banco de dados MySQL no RDS:

Passo 1: Vá para o Console de Gerenciamento da AWS.

Passo 2: Selecione o serviço "RDS".

Passo 3: Clique em "Criar banco de dados".

Passo 4: Escolher um método de criação de banco de dados.

        - Criação Padrão

Passo 4: Opções do mecanismo.

        - MySQL

Passo 5: Opções do mecanismo.

        5.1 Nome do usuário principal

                - admin

        5.2 Select the encryption key

                - Padrão
        
Passo 6: Conectividade

        - Não se conectar a um recurso de computação do EC2

        6.1 Grupo de segurança de VPC (firewall)

                - security-group-aws-docker

        6.2 Zona de disponibilidade

                - us-east-1a


# Sua solicitação para criar a instância de banco de dados aws-docker-database não foi bem-sucedida.

Descrição: The DB subnet group doesn't meet Availability Zone (AZ) coverage requirement. Current AZ coverage: us-east-1a. Add subnets to cover at least 2 AZs.

1: Acesse o RDS:

- Vá para o serviço "RDS" no Console de Gerenciamento da AWS.

2: Navegue para "Subnet Groups" (Grupos de Sub-redes):

- No painel de navegação à esquerda, clique em "Subnet Groups" sob a seção "Network & Security" (Rede e Segurança).

- Clique em criar 

        2.1 Detalhes do grupo de sub-redes

        nome: sub-rede-db-aws-docker


3: Selecione o Grupo de Sub-redes:

- Selecione o grupo de sub-redes associado à instância do banco de dados aws-docker-database.

        - VPC: aws-docker

4: Adicione Sub-redes em Outras AZs:

- Adicione sub-redes em diferentes AZs para cobrir pelo menos duas AZs na região us-east-1 (Norte da Virgínia).

        - us-east-1a

        - us-east-1b

        - us-east-1c

- Certifique-se de que as sub-redes adicionadas estejam em AZs diferentes e estejam corretamente configuradas para permitir a conectividade com o RDS.

5: Salve as Alterações:

- Depois de adicionar as sub-redes necessárias, salve as alterações no grupo de sub-redes.

# Sua solicitação para criar um grupo de banco de dados sub-rede-db-aws-docker falhou.

Descrição: modifica o grupo de segurança para permitir a porta do MySql.

Passo 1: Editar Regra.

        - Selecione MySql - porta 3306

Passo 2: Salve as Alterações

# Sub-redes - para adiciona 3 zonas de disponibilidades.

                - sub-rede-us-east-1a

                - sub-rede-us-east-1b

                - sub-rede-us-east-1c



# Identificador da instância de banco de dados - RDS

                - database-aws-docker

# Script Atualizador

        #!/bin/bash

        # Instalar Docker
        sudo yum update -y
        sudo amazon-linux-extras install docker -y
        sudo service docker start
        sudo usermod -a -G docker ec2-user

        # Iniciar contêiner WordPress
        sudo docker run -d \
        -e WORDPRESS_DB_HOST=database-aws-docker.cb46cmyuqm96.us-east-1.rds.amazonaws.com \
        -e WORDPRESS_DB_USER=root \
        -e WORDPRESS_DB_PASSWORD=Pa$$w0rd \
        -e WORDPRESS_DB_NAME=database-aws-docker \
        -p 80:80 \
        wordpress:latest


# Substituir o arquivo do script 

1: instância 

2: Certifique-se de que o script user_data.sh esteja no diretório desejado na instância.

3: Vá para o console da AWS e encontre a instância que você deseja configurar.

4: Selecione a instância e clique em "Actions" (Ações) -> "Instance settings" (Configurações da instância) -> "Edit user data" (Editar dados de usuário).

5: Na janela de edição, cole o conteúdo do seu script user_data.sh.

6: Clique em "Save" (Salvar) para aplicar as alterações.

7: Reinicie a instância para que o novo script seja executado.


