#!/usr/bin/bash
#Script particionado disco con sgdisk
#Autores: Sergio Jiménez, Aleksandr Kosenko, Roberto Martín

#Comprobamos que eres root
function soy_root(){
#for i in $(seq 0 10 100)
#do
sleep 1
echo "Comprobando que eres root..."
#echo $i | dialog --gauge "Comprobando que eres root..." 0 0 0
#done
clear
if [[ ! $UID -eq 0 ]]; then
 #dialog --msgbox "Este script debe ejecutarse como root, vuelve a entrar como usuario root" 0 0 
 echo "Este script debe ejecutarse como root, vuelve a entrar como usuario root"
#clear
exit
fi
}

#Verificamos paquetes instalados
function ck_paquetes(){
if apt policy gdisk 2> /dev/null | grep -q ninguno; then
  sudo apt install gdisk
fi

if apt policy dialog 2> /dev/null | grep -q ninguno; then
  sudo apt install dialog
fi
}

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

function num_particiones(){
while true; do
read -p "Introduzca las particiones a realizar: " num_part

#Comprobamos el numero de particiones
if [[ $num_part -gt 128 || $num_part -lt 1 ]]; then
  echo "Número de particiones no válido"
else 
  break
fi
done
}

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

function ejecucion(){
for particion in $(seq 1 $num_part); do 
if ! sudo sgdisk --new=0:0:+$size /dev/$disco > /dev/null; then
  echo -e "Error al crear la partición $partcion"
  exit
fi
done
echo "Particiones realizadas"
exit
}

soy_root
ck_paquetes
select_disk
num_particiones
part_size
ejecucion
