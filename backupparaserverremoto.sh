#!/bin/bash

# Define o arquivo a ser feito o backup
file_to_backup="/caminho/para/o/arquivo"

# Define o endereço IP ou hostname do servidor de destino
backup_server="endereco_ip_ou_hostname"

# Define o diretório de destino no servidor de destino
backup_destination="/caminho/para/o/diretorio/de/backup"

# Define o nome do arquivo de backup
backup_file="nome_do_arquivo_de_backup.tar.gz"

# Cria o backup
tar -czf - $file_to_backup | ssh $backup_server "cat > $backup_destination/$backup_file"

# Confirmação
echo "O backup do arquivo $file_to_backup foi criado com sucesso no servidor $backup_server:$backup_destination/$backup_file"

#Este script usa o comando tar para criar um arquivo comprimido .tar.gz do arquivo especificado e, em seguida
#usa o comando ssh para se conectar ao servidor de destino e enviar o arquivo para lá.
#Certifique-se de definir o endereço IP ou hostname correto do servidor de destino,
#o diretório de destino no servidor de destino e o nome do arquivo de backup correto.
#Também é importante ter uma chave ssh para fazer login sem senha no servidor de backup.
