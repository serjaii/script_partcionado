#!/usr/bin/bash
#Script particionado disco con sgdisk (GPT)
#Autores: Sergio Jiménez, Aleksandr Kosenko, Roberto Martín

#------------Variables colores----------------------------------------

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"
RESET="\e[0m"

#--------------------------------------------------------------------

#Comprobamos que eres root
function soy_root(){
echo "Comprobando que eres root..."
sleep 1
clear
if [[ ! $UID -eq 0 ]]; then
 echo -e "${YELLOW}Este script debe ejecutarse como root, vuelve a entrar como usuario root${RESET}"
exit
fi
}

#Verificamos paquetes instalados
function ck_paquetes(){
if apt policy gdisk 2> /dev/null | grep -q ninguno; then
  sudo apt install gdisk
fi
}

#Seleccionamos disco
function select_disk(){
while true; do
read -p "Indique el disco a particionar (Ej. sda): " disco

#Verificamos si el disco existe
if ! lsblk | grep -q $disco; then 
   echo -e "El disco dev/$disco no existe"
else
  break
fi
done
}

#Definimos el número de particiones
function num_particiones(){
while true; do
read -p "Introduzca las particiones a realizar: " num_part

#Comprobamos el numero de particiones
if [[ $num_part -gt 128 || $num_part -lt 1 || $num_part =~ [0-9]{3}]]; then
  echo "Número de particiones no válido"
else 
  break
fi
done
}

#Elegimos el tamaño de las particiones
function part_size(){
while true; do
read -p "Indique tamaño de la partción en megas (Ej. 512M): " size

#Confirmamos que este bien escrito el tamaño
if [[ ! "$size" =~ ^[0-9]{1,5}M$ ]]; then
  echo "El tamaño no es válido"
else
  break
fi
done
}

#Realizamos el particionado
function ejecucion(){
exitos=0
errores=0

for particion in $(seq 1 $num_part); do 
if ! sudo sgdisk --new=0:0:+$size /dev/$disco > /dev/null; then
  ((errores++))
else
  ((exitos++))
fi
done

if [ $errores -eq 0 ]; then 
  echo -e "${GREEN}Todas las particones se han realizado con éxito${RESET}"
else
  echo -e "${YELLOW}Solo se han realizado con éxtio $exitos particiones${RESET}"
fi
}


soy_root
ck_paquetes
select_disk
num_particiones
part_size
ejecucion
