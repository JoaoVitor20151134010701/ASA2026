cat > README.txt << 'EOF'
================================================================================
                    PROJETO DOCKER + NGINX PERSONALIZADO
================================================================================

ALUNO:  JOAO VITOR DOS SANTOS NASCIMENTO
DISCIPLINA: ASA
DATA: 26/04/2026

================================================================================
1. SOBRE O PROJETO
================================================================================

Container Nginx com pagina HTML personalizada e configuracao customizada,
demonstrando uso de ARG e ENV no Docker.

================================================================================
2. ARQUITETURA DO PROJETO
================================================================================

projeto-docker/
|
|-- Dockerfile              (Imagem com ARG e ENV)
|-- docker-compose.yaml     (Orquestracao)
|-- README.txt              (Documentacao)
|-- html/
|   |-- index.html          (Pagina personalizada)
|-- nginx-config/
    |-- default.conf        (Configuracao Nginx)

FLUXO DE FUNCIONAMENTO:

   Dockerfile --> Build --> Imagem --> Container (meu-nginx) --> localhost:8080

   ARG (NGINX_VERSION=1.25) --> Usado no BUILD, nao aparece no container
   ENV (NGINX_PORT=80)      --> Usado no RUNTIME, aparece no container

================================================================================
3. TECNOLOGIAS UTILIZADAS
================================================================================

- Docker 24+      : Containerizacao
- Nginx 1.25      : Servidor Web
- Docker Compose  : Orquestracao
- WSL Ubuntu      : Ambiente Linux
- HTML5 + CSS3    : Pagina web

================================================================================
4. COMO BAIXAR E EXECUTAR
================================================================================

PRE-REQUISITOS:
- Docker instalado
- Docker Compose instalado

PASSOS:

1. Clone o repositorio:
   git clone <url-do-repositorio>
   cd projeto-docker

2. Construir e iniciar o container:
   docker compose up -d

3. Acessar no navegador:
   http://localhost:8080

4. Verificar status:
   docker compose ps

5. Parar o container:
   docker compose down

================================================================================
5. COMANDOS UTEIS
================================================================================

+---------------------------+------------------------------------------+
| COMANDO                   | DESCRICAO                                |
+---------------------------+------------------------------------------+
| docker compose up -d      | Iniciar container em background          |
| docker compose ps         | Ver status do container                  |
| docker compose logs       | Ver logs                                 |
| docker compose down       | Parar e remover container                |
| docker exec meu-nginx env | Ver variaveis de ambiente no container   |
| curl localhost:8080       | Testar pagina                            |
| curl localhost:8080/health| Testar health check                      |
+---------------------------+------------------------------------------+

================================================================================
6. ARG vs ENV (DIFERENCA PRINCIPAL)
================================================================================

+------------------+--------------------------+--------------------------+
| CARACTERISTICA   | ARG                      | ENV                      |
+------------------+--------------------------+--------------------------+
| Quando existe    | So durante o BUILD       | BUILD + RUNTIME          |
| Persiste no      | Nao                      | Sim                      |
| container?       |                          |                          |
| Uso no projeto   | NGINX_VERSION=1.25       | NGINX_PORT=80            |
| Sobrescrito por  | args: no compose         | environment: no compose  |
+------------------+--------------------------+--------------------------+

EXEMPLO NO DOCKERFILE:

   ARG NGINX_VERSION=latest    (definido na build)
   FROM nginx:${NGINX_VERSION}
   ENV NGINX_PORT=80           (disponivel no container rodando)

================================================================================
7. DOCKERFILE (CONTEUDO COMPLETO)
================================================================================

ARG NGINX_VERSION=latest
FROM nginx:${NGINX_VERSION}

ENV NGINX_PORT=80

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx-config/default.conf /etc/nginx/conf.d/
COPY html/ /usr/share/nginx/html/

EXPOSE ${NGINX_PORT}
CMD ["nginx", "-g", "daemon off;"]

================================================================================
8. DOCKER-COMPOSE.YAML (CONTEUDO COMPLETO)
================================================================================

services:
  nginx:
    build:
      context: .
      args:
        NGINX_VERSION: "1.25"
    container_name: meu-nginx
    ports:
      - "8080:80"
    environment:
      - NGINX_PORT=80
    volumes:
      - ./html:/usr/share/nginx/html
    restart: unless-stopped

================================================================================
9. ARQUIVO DE CONFIGURACAO NGINX (default.conf)
================================================================================

server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html;
    }

    location /health {
        return 200 'OK';
        add_header Content-Type text/plain;
    }
}

================================================================================
10. BOAS PRATICAS DE GITFLOW UTILIZADAS
================================================================================

ESTRUTURA DE BRANCHES:

   main          (producao - versao final)
   |-- develop   (integracao)
       |-- feature/dockerfile   (desenvolvimento do Dockerfile)
       |-- feature/compose      (desenvolvimento do compose)
       |-- feature/html         (desenvolvimento do HTML)

CONVENCAO DE COMMITS:

   feat: adiciona Dockerfile com ARG e ENV
   feat: cria docker-compose.yaml
   feat: adiciona pagina HTML personalizada
   feat: cria configuracao Nginx customizada
   docs: adiciona README com documentacao

FLUXO DE TRABALHO:

   1. Criar branch feature/* a partir do develop
   2. Desenvolver e commitar
   3. Merge para develop
   4. Merge develop para main (versao final)

================================================================================
11. CRITERIOS DE ACEITACAO
================================================================================

+----------------------------------------------------+--------+
| CRITERIO                                           | STATUS |
+----------------------------------------------------+--------+
| Dockerfile utiliza ARG                             |   OK   |
| Dockerfile utiliza ENV                             |   OK   |
| Container sobe com docker compose up               |   OK   |
| Pagina customizada acessivel no navegador          |   OK   |
| Configuracao Nginx personalizada                   |   OK   |
| README documentado                                 |   OK   |
+----------------------------------------------------+--------+

================================================================================
12. RESUMO FINAL
================================================================================

PROJETO: Container Docker com Nginx personalizado
ARG: NGINX_VERSION (build)
ENV: NGINX_PORT (runtime)
PORTA: 8080 (host) -> 80 (container)
VOLUME: ./html sincronizado com /usr/share/nginx/html
CONTAINER: meu-nginx
ACESSO: http://localhost:8080

================================================================================
ALUNO: JOAO VITOR DOS SANTOS NASCIMENTO
DISCIPLINA: ASA
DATA: 26/04/2026
================================================================================
EOF