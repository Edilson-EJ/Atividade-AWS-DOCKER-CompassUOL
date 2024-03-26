
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




