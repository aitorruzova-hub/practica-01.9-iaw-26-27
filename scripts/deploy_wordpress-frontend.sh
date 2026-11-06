#!/bin/bash
set -ex

# Importamos los archivos .env
source .env

# Eliminamos descargas previas de wpcli
rm -f /tmp/wp-cli.*

# Descargamos wpcli
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /tmp

# Asignamos permisos de ejecucion a wpcli
chmod +x /tmp/wp-cli.phar

# Movemos wpcli a /usr/local/bin para que sea accesible globalmente
mv /tmp/wp-cli.phar /usr/local/bin/wp

# Eliminamos instalaciones previas de wordpress
rm -rf /var/www/html/*

# Descargamos el codigo fuente
wp core download \
  --path=/var/www/html \
  --allow-root

# Creamos el archivo de configuracion de WordPress
wp config create \
  --dbname=$WORDPRESS_DB_NAME \
  --dbuser=$WORDPRESS_DB_USER \
  --dbpass=$WORDPRESS_DB_PASSWORD \
  --dbhost=$WORDPRESS_DB_HOST \
  --path=/var/www/html \
  --allow-root

# Instalamos WordPress
wp core install \
  --url=$LETSENCRYPT_DOMAIN \
  --title="IAW" \
  --admin_user=$WORDPRESS_ADMIN_USER \
  --admin_password=$WORDPRESS_ADMIN_PASSWORD \
  --admin_email=$WORDPRESS_ADMIN_EMAIL \
  --path=/var/www/html \
  --allow-root  

# Instalamos el plugin WPS Hide Login
wp plugin install wps-hide-login --activate --path=/var/www/html --allow-root

# Actualizamos la URL de inicio de sesión de WordPress
wp option update whl_page "$WORDPRESS_LOGIN_URL" --path=/var/www/html --allow-root

# Asignamos los permisos correctos a los archivos de WordPress
chown -R www-data:www-data /var/www/html