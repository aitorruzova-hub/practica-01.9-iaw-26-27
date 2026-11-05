#!/bin/bash
set -ex

#Actualizar repositorios
apt update

#Instalamos el sistema gestor de bases de datos MySQL
sudo apt install mysql-server -y