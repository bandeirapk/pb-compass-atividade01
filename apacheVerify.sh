#!/bin/bash

# Diretório no NFS onde os resultados serão armazenados
nfs_dir="/srv/share/antonioBandeira"
service="Apache"

# Definir timezone
sudo timedatectl set-timezone America/Fortaleza

# Verificar o status do serviço Apache
status_apache=$(sudo systemctl is-active httpd)

# Obter a data e hora atual
date_hour=$(date +"%Y-%m-%d %H:%M:%S")

# Mensagem personalizada com base no status
if [ "$status_apache" = "active" ]; then
    mensagem="Online"
else
    mensagem="Offline"
fi

archive_online="${nfs_dir}/${date_hour}_${service}_active.txt"
archive_offline="${nfs_dir}/${date_hour}_${service}_inactive.txt"

# Escrever os resultados nos arquivos correspondentes
if [ "$mensagem" = "Online" ]; then
    echo "$date_hour $service Está online e rodando normalmente." >> "$archive_online"
else
    echo "$date_hour $service Está offline." >> "$archive_offline"
fi
