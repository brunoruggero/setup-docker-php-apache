# Setup Docker Para Projetos PHP

#### Introdução

O presente projeto tem como objetivo demonstrar como criar um ambiente de desenvolvimento para aplicativos PHP usando Docker, Docker Compose, PHP, Apache e MySQL. A abordagem do Docker torna mais fácil e eficiente a configuração do ambiente, garantindo a consistência entre máquinas e facilitando o desenvolvimento colaborativo. 

#### Visão Geral do Projeto

O projeto consiste na criação de um ambiente de desenvolvimento local para aplicativos PHP. O Docker é uma ferramenta de conteinerização que permite empacotar o aplicativo, suas dependências e configurações em um único contêiner, garantindo a portabilidade e facilidade de implantação. O Docker Compose é usado para orquestrar vários contêineres e definir a infraestrutura do ambiente.

#### Componentes do Ambiente

1. **Dockerfile:** Um arquivo de configuração que define as especificações do contêiner. Nele, são listadas as dependências necessárias, comandos para instalação do PHP e Apache, e configurações adicionais.
2. **Docker Compose:** Um arquivo YAML que define a estrutura do ambiente e a relação entre os serviços. Neste projeto, definiremos um serviço para o contêiner PHP e outro para o contêiner do MySQL.
3. **PHP:** A linguagem de programação usada para desenvolver aplicativos web. No contêiner, o PHP será instalado com as extensões e bibliotecas necessárias.
4. **Apache:** O servidor web responsável por processar as solicitações HTTP dos aplicativos e devolver as respostas adequadas.
5. **MySQL:** Um sistema de gerenciamento de banco de dados relacional que armazenará os dados do aplicativo.

#### Pré-requisitos

Antes de começar, você vai precisar ter instalado em sua máquina as seguintes ferramentas:

[Docker-composer](https://docs.docker.com/compose/)

[WSL2](https://learn.microsoft.com/pt-br/windows/wsl/install)

#### Branchs do projeto

1. Versão com **PHP 7.4** (docker-with-php-7.4)
2. Versão com **PHP 8.1** (docker-with-php-8)
3. Versão com **PHP 8.2** (docker-with-php-8.2)