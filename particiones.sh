#Script particionado disco con sgdisk
#Autores: Sergio Jiménez, Aleksandr Kosenko, Roberto Martín

read -p "Indique el disco a particionar: " disco
read -p "Introduzca las particiones a realizar: " num_part
read -p "Indique tamaño de la partción en megas (ej. 512M): " size

for particion in $(seq 1 $num_part); do sudo sgdisk --new=0:0:+$size /dev/$disco > /dev/null; done
echo "Particiones realizadas"
