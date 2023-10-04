#!/bin/bash

# Diretório no NFS onde os resultados serão armazenados
# echo "Digite o nome do diretório: "; read NFS_DIR_USER

NFS_DIR="/srv/share/antonioBandeira"

# Nome do serviço
SERVICO="Apache"

# Verificar o status do serviço Apache
status_apache=$(sudo systemctl is-active httpd)

# Obter a data e hora atual
data_hora=$(date +"%Y-%m-%d %H:%M:%S")

# Mensagem personalizada com base no status
if [ "$status_apache" = "active" ]; then
    mensagem="Online"
else
    mensagem="Offline"
fi

# Nome dos arquivos de saída
arquivo_online="${data_hora}_online.txt"
arquivo_offline="${data_hora}_offline.txt"

# Escrever os resultados nos arquivos correspondentes
if [ "$mensagem" = "Online" ]; then
    echo "$data_hora $SERVICO $mensagem" > "$arquivo_online"
    echo "$data_hora $SERVICO está online e funcionando sem problemas!"
else
    echo "$data_hora $SERVICO $mensagem" > "$arquivo_offline"
    echo "$data_hora $SERVICO está offline"
fi
