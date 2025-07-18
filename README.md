## Ambiente de desenvolvimento Magento2

### Resumo
Esse repositório tem o propósito de facilitar a construção de um ambiente de desenvolvimento **Magento2**.

### Passo a passo

#### 1° Passo

Você precisa clonar o repositório junto com o sub-módulos, para isso utilize o seguinte comando:

<code>git clone {URL do repositório} --recurse-submodules</code>

#### 2° Passo

A seguintes instruções irão te auxiliar a construir o ambiente inteiro utilizando Docker como principal ferramenta, portanto, instale-o [aqui](https://docs.docker.com/engine/install/).

#### 3° Passo

Todos os arquivos que terminam com `.sample` são arquivos de configurações customizáveis que você pode alterar de acordo com o a sua necessidade, mas não há obrigatoriedade de alterações. Para que os arquivos de configuração passem a ser válidos, você deve realizar uma cópia dos arquivos e remover o `.sample`, ex:

`nginx-magento-site.sample` > `nginx-magento-site`

#### 4° Passo

Agora você pode executar o seguinte comando do Docker:

<code>docker compose up -d</code>

Isso pode levar alguns minutos pois o repositório do **Magento2** é um pouco pesado.

Após a construção dos container utilize o seguinte comando `docker ps -a` pegue o ID do container do `magento-env-magento` e execute o seguinte comando `docker logs -f {ID do container}` e espere o processo de instalação da aplicação. Ao final você deve ter algo parecido com isso:

````
 * Starting nginx nginx
   ...done.
````

Após isso, pressione `CTRL + C` para sair do terminal.

#### 5° Passo

Após a construção de todos os containers, será necessário você acessar o container principal do **Magento** para executar o comando de instalação, mas antes será necessário você ter em mãos o ID do seu container, para isso você pode utilizar o comando `docker ps -a` ele irá te mostrar todos os containers, basta você buscar o container do **Magento**, algo parecido com **"magento-env-magento"**. Após pegar o ID do seu container, execute o comando para acessar o seu container diretamente:

`docker exec -it {ID do container} /bin/bash`

#### 6° Passo

Após acessar o terminal do seu container, execute o comando abaixo para realizar a configuração do seu **Magento2**, você pode alterar as informações de usuário (`admin-firstname`, `admin-lastname`, `admin-email` e `admin-password`) para a sua necessidade, mas matenha todas as outras configurações padrões.

````
bin/magento setup:install \
    --base-url=http://localhost:8080/ \
    --db-host=magento-database \
    --db-name=magento2 \
    --db-user=root \
    --db-password=1234 \
    --admin-firstname=admin \
    --admin-lastname=admin \
    --admin-email=admin@admin.com \
    --admin-user=admin \
    --admin-password=admin123 \
    --language=pt_BR \
    --currency=BRL \
    --timezone=America/Sao_Paulo \
    --use-rewrites=1 \
    --search-engine=opensearch \
    --opensearch-host=magento-opensearch \
    --opensearch-port=9200 \
    --opensearch-index-prefix=magento2 \
    --opensearch-timeout=15
````

Após o fim da execução do comando você terá como resultado em sua tela o PATH do portal administrativo para acessar, lembre-se de anota-lo, em caso de perda você pode executar o seguinte comando para recupera-lo: `bin/magento info:adminuri`.

Agora com o processo todo finalizado, você pode executar o comando `exit` para sair do terminal do seu container e pode acessar no navegador do seu computador a URL `http://localhost:8080/` e finalmente terá acesso ao **Magento2**.