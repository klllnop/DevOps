#!/bin/bash

# Verifique se o script foi executado como root
if [ "$(id -u)" != "0" ]; then
   echo "Este script deve ser executado como root" 1>&2
   exit 1
fi

# Verifique se o Apache está instalado
if ! [ -x "$(command -v apache2)" ]; then
   echo "O Apache não está instalado. Por favor, instale-o antes de continuar." 1>&2
   exit 1
fi

# Obtenha o nome do novo virtual host e o caminho para o diretório de instalação do WordPress
echo "Digite o nome do novo virtual host (sem o '.com'):"
read -r vhost_name
echo "Digite o caminho completo para o diretório de instalação do WordPress (por exemplo, '/var/www/html/example.com'):"
read -r wordpress_dir

# Crie o arquivo de configuração do virtual host
vhost_config_file="/etc/apache2/sites-available/$vhost_name.conf"
touch "$vhost_config_file"

# Adicione o conteúdo do arquivo de configuração do virtual host
echo "<VirtualHost *:80>" >> "$vhost_config_file"
echo "    ServerName $vhost_name.com" >> "$vhost_config_file"
echo "    ServerAdmin webmaster@$vhost_name.com" >> "$vhost_config_file"
echo "    DocumentRoot $wordpress_dir" >> "$vhost_config_file"
echo "    ErrorLog ${vhost_name}-error.log" >> "$vhost_config_file"
echo "    CustomLog ${vhost_name}-access.log common" >> "$vhost_config_file"
echo "</VirtualHost>" >> "$vhost_config_file"

# Ative o novo virtual host
a2ensite "$vhost_name.conf"

# Reinicie o Apache para aplicar as alterações
systemctl restart apache2

echo "O novo virtual host foi criado com sucesso!"
