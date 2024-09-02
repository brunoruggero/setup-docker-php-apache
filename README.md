# Setup Docker Para Projetos PHP

#### 🎲 Rodando a Aplicação (servidor)

Clone Repositório
```sh
git clone https://github.com/brunoruggero/setup-docker-php-apache.git my-project
cd my-project/
```

Alterne para a branch docker-with-php-8.2
```sh
git checkout docker-with-php-8.2
```

Remova o versionamento
```sh
rm -rf .git/
```

Crie o Arquivo .env
```sh
cp .env.example .env
```

Atualize as variáveis de ambiente do arquivo .env
```dosini
DB_ROOT_PASSWORD= INFORME A SENHA PARA O USER ROOT
DB_USER= INFORME O NOME DE USUÁRIO PARA ACESSAR O BANCO DE DADOS
DB_PASSWORD= INFORME A SENHA DO USUÁRIO

PATH_HOST_WWW= INFORME O MESMO NOME DA PASTA ONDE O REPOSITÓRIO FOI CLONADO
```

Em sistemas Windows apontar a URL_DEV no arquivo host. Para isso deve acessar a pasta:

```dosini
 - C:\Windows\System32\drivers\etc
 - Abrir arquivo hosts
 - Adicionar a entrada no arquivo juntamente com o ip.
   -  Exemplo: 192.168.0.0     local.dev.com.br
```

Suba os containers do projeto
```sh
docker-compose up -d --build
```

Após a subir os container, acesse o projeto:
[https://local.dev.com.br](https://local.dev.com.br)