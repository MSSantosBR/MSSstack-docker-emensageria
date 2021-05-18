# O que é MSSstack-docker-emensageria?

Geração de um stack de desenvolvimento/testes utilizando dockers configurados especificamente para o app eMensageria.

[https://github.com/marcelomdevasconcellos/emensageria](https://github.com/marcelomdevasconcellos/emensageria)

```console
$ docker-compose down
$ docker-compose rm -f
$ docker-compose up -d
$ docker ps
```
Acesso: http://localhost:8000
Usuário: admin (após passo 1.4)
Senha: admin (após passo 1.4)

# TL;DR

# 1 - Sobre

## 1.1 - Dockers gerados
- eMensageriaApp = python:3.8.5, Django:2.2.2, etc... (Debian 10:buster)
- eMensageriaDB =  postgres:13 (Debian 10:buster)

## 1.2 - Downloads

### 1.2.1 - Download eMensageria
```console
$ git clone https://github.com/marcelomdevasconcellos/emensageria.git ~/emensageria/app
```

### 1.2.2 - Download MSS Stack Docker eMensageria
```console
$ git clone https://github.com/MSSantosBR/MSSstack-docker-emensageria.git ~/emensageria/docker
```
- Atualização provisória de scripts do eMensageria
```console
$ cp ~/emensageria/docker/emensageria-config/* ~/emensageria/app/config/
$ rm ~/emensageria/app/config/set_super_user.py
$ cp ~/emensageria/docker/emensageria-config/set_super_user.py ~/emensageria/app/esocial/management/commands/
$ cp ~/emensageria/docker/emensageria-config/wsgi.py ~/emensageria/app/
```

## 1.3 - Configurações

### 1.3.1 - Configurações do eMensageria
- Copiar o arquivo app/docker/emensageria.env para app/config/.env e editar o .env ajustando as informações necessárias relativas ao aplicativo.
```console
$ cp ~/emensageria/docker/emensageria.env ~/emensageria/app/config/.env
$ nano ~/emensageria/app/config/.env
```

### 1.3.2 - Configurações do MSSstack-docker-emensageria
- Copiar o arquivo docker/docker.env para docker/.env e editar o .env colocando os paths corretos.
```console
$ cp ~/emensageria/docker/docker.env ~/emensageria/docker/.env
$ nano ~/emensageria/docker/.env
```
## 1.4 - Execução
- Executar o script emensageria.init para criar e inicializar os dockers.
```console
$ sh ~/emensageria/docker/emensageria.init
```

- Gerar os arquivos da pasta static (Necessário executar apenas a primeira vez que executar o passo 1.2.1)
```console
$ docker exec eMensageriaApp python /app/manage.py collectstatic
```

Obs: Ao reinicializar os dockers é necessário executar a preparação da base e a criação do superusuario

- Preparar a base dados do eMensageria
```console
$ docker exec eMensageriaApp python /app/manage.py migrate
```

- Criar o superusuario admin com senha admin
```console
$ docker exec eMensageriaApp python manage.py set_super_user --username admin --email admin@admin.localhost --password admin
```

## 1.5 - Diversos
- Execução do shell do container do banco de dados (eMensageriaDB)
```console
$ docker exec -it eMensageriaDB bash
```
- Execução do shell do container do aplicativo (eMensageriaApp)
```console
$ docker exec -it eMensageriaApp bash
```

- A execução do script emensageria.end finalizar os dockers e após é necessário repetir o passo 1.4.
- ATENÇÃO! A execução deste comando provoca a perda do banco de dados. Realize os devidos backups antes de proseeguir.
```console
$ sh ~/emensageria/docker/emensageria.end
```
