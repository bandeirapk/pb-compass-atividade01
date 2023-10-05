# Atividade 01 - Trilha de DevSecOps

> Atividade de Linux e AWS da trilha de DevSecOps do Programa de bolsas da Compasso UOL.

## Descrição da Atividade

> Requisitos da AWS:

- Gerar uma chave pública para acesso ao ambiente;
- Criar 1 instância EC2 com o sistema operacional Amazon Linux 2 (Família t3.small, 16 GB SSD);
- Gerar 1 elastic IP e anexar à instância EC2;
- Liberar as portas de comunicação para acesso público: (22/TCP, 111/TCP e UDP, 2049/TCP/UDP, 80/TCP, 443/TCP).

> Requisitos do Linux:

- Configurar o NFS entregue;
- Criar um diretório dentro do filesystem do NFS com seu nome;
- Subir um apache no servidor o apache deve estar online e rodando; - Criar um script que valide se o serviço esta online e envie o resultado da validação para o seu diretório no nfs;
- O script deve conter - Data HORA + nome do serviço + Status + mensagem personalizada de ONLINE ou offline; - O script deve gerar 2 arquivos de saída: 1 para o serviço online e 1 para o serviço OFFLINE;
- Preparar a execução automatizada do script a cada 5 minutos.

## Execução da Atividade

> Requisitos da AWS:

- [x] Gerar a uma chave pública:
  - Acesse o console da AWS;
  - Dentro do console, vá até o serviço de EC2;
  - No painel de controle do EC2, no menu à esquerda, clique em "Key Pairs" sob a seção "Network & Security";
  - Na página "Key Pairs", clique no botão "Create Key Pair"
  - Na janela pop-up "Create Key Pair", insira um nome para a sua chave na caixa de texto "Key pair name". Certifique-se de que o nome é descritivo e fácil de lembrar;
  - Em "Key pair type", escolha "RSA" ou "ED25519";
  - Clique em "Create Key Pair";
  - Após criar a chave, a AWS gerará o par de chaves e disponibilizará a chave pública automaticamente;
  - A chave privada será baixada automaticamente para o seu computador com a extensão ".pem". Certifique-se de que você armazene esta chave em um local seguro, pois você precisará dela para autenticar-se nas instâncias EC2.
- [x] Criar instância:
  - Dentro do painel geral do EC2, vá na parta de instâncias;
  - Dentro do painel de instâncias, selecione "Launch Instance", para começar o processo de criar instância;
  - Caso seja preciso, adicione tags na sua instância;
  - Em seguida selecione a AMI e a arquitetura para executar a instância;
  - Próximo passo é selecionar o tipo da instância;
  - Logo após selecionar o tipo da instância, selecione o par de chaves criado anteriormente;
  - Configure a rede da instância selecionando VPC e o Security Group;
  - Selecione a quantidade e o tipo de armazenamento;
  - Por último, revise a configuração da instância e execute a instância.
- [x] Gerar Elastic IP e Anexar a uma instância EC2:
  - No painel esquerdo, vá em "Elastic IP" na parte de "Network e Security";
  - Vá em "Allocate elastic IP Address";
  - O próximo passo é selecionar o IP reservado, vá em "Actions" e vá na opção "Associate Elastic IP address" e selecione a instância que deseja fazer a associação.
- [x] Liberar as portas de comunicação:
  - No painel esquerdo de navegação, vá em "Security Groups" em "Network & Security";
  - Vá ao grupo de segurança que está associado a sua instância;
  - Selecione o grupo de segurança e vá em "Inbound Rules";
  - Clique em "Edit Inbound Rules" e adicione as portas que deseja liberar, Como a porta 80 e 443.

> Requisitos do Linux:

```bash
# Para acessar a instância use o seguinte comando:
  ssh -i nomeDaChave.pem ec2-user@ipDaInstancia
```

- [x] Configuração do NFS:

  - Instalação do NFS:

    - Para instalar o NFS, execute o seguinte comando:

      ```bash
      sudo yum install nfs-utils
      ```

  - Configuração do NFS:

    - Criar um diretório compartilhado, execute o seguinte comando:

      ```bash
      sudo mkdir /srv/share/
      ```

    - No diretório criado, dê permissão para o grupo nfsnobody. Para isso, execute o seguinte comando:

      ```bash
      sudo chown -R nfsnobody:nfsnobody /srv/share/
      ```

    - Para configurar o NFS, execute o seguinte comando:

      ```bash
      sudo vim /etc/exports
      ```

    - Dentro do arquivo, adicione a seguinte linha:

      ```bash
      /srv/share [IpSubNet](rw,sync,root_squash,no_all_squash)
      ```

    - Após adicionar a linha, salve o arquivo e execute o seguinte comando:

      ```bash
      sudo exportfs -rva
      ```

    - Para iniciar o serviço do NFS, execute o seguinte comando:

      ```bash
      sudo systemctl start nfs-server.service
      ```

    - Para habilitar o serviço do NFS junto com o sistema, execute o seguinte comando:

      ```bash
      sudo systemctl enable nfs-server.service
      ```

    - Para verificar o status do serviço do NFS, execute o seguinte comando:

      ```bash
      sudo systemctl status nfs-server.service
      ```

  - Criar um diretório dentro do filesystem do NFS:

    - Para criar um diretório dentro do filesystem do NFS, execute o seguinte comando:

      ```bash
      sudo mkdir /srv/share/seuNome
      ```

    - Liberar permissão para o diretório criado, execute o seguinte comando:

      ```bash
      sudo chmod 777 /srv/share/seuNome
      ```

    - Entrar no diretório criado, execute o seguinte comando:

      ```bash
      cd /srv/share/seuNome
      ```

- [x] Subir o serviço do Apache no servidor

  > O apache deve está online e rodando.

  - Atualizar os repositórios, execute o seguinte comando:

    ```bash
    sudo yum update
    ```

  - Para instalar o Apache, execute o seguinte comando:

    ```bash
    sudo yum install httpd
    ```

  - Para iniciar o serviço do Apache, execute o seguinte comando:

    ```bash
    sudo systemctl start httpd
    ```

  - Para habilitar o serviço do Apache junto com o sistema, execute o seguinte comando:

    ```bash
    sudo systemctl enable httpd
    ```

  - Para verificar o status do serviço do Apache, execute o seguinte comando:

    ```bash
    sudo systemctl status httpd
    ```

- [x] Script para validar se o serviço do apache está online e envie para o diretório do NFS.

  - O script está dentro desse reposótiório, com o nome de "apacheVerify.sh";
  - Faça os passos citados antes, e depois baixe o script e execute na máquina.

- [x] Preparar a execução automatizada do script a cada 5 minutos>

  - Para automatizar a execução do script, execute o seguinte comando:

    ```bash
    sudo crontab -e
    ```

    > O cron é um serviço que executa comandos agendados. Para agendar um comando, basta adicionar uma linha no arquivo de configuração do cron. Para isso, execute o comando acima.

    - Após executar o comando, adicione a seguinte linha no arquivo:

      ```bash
      */5 * * * * /srv/share/seuNome/apacheVerify.sh
      ```
