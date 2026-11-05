#!/bin/bash
set -ex

#Actualizar repositorios
apt update

#Instalamos el sistema gestor de bases de datos MySQL
sudo apt install mysql-server -y

# Configuramos MySQL para que se pueda acceder desde cualquier host
sudo sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

#  Reiniciamos el servicio de MySQL para que los cambios surtan efecto
sudo systemctl restart mysql