#Script particionado disco con sgdisk
#Autores: Sergio Jiménez, Aleksandr Kosenko, Roberto Martín

#Comprobamos que eres root
for i in $(seq 0 10 100)
do
sleep 0.1
echo $i | dialog --gauge "Comprobando que eres root..." 0 0 0
done
clear
if [[ ! $UID -eq 0 ]]; then
dialog --msgbox "Este script debe ejecutarse como root, vuelve a entrar como us>
" 0 0 
exit
clear
fi

while true; do  
read -p "Indique el disco a particionar: " disco  

#Verificamos si el disco existe  
if ! lsblk | grep -q $disco; then  
    echo -e "El disco dev/$disco no existe"  
else  
    break  
fi  
done  

while true; do  
read -p "Introduzca las particiones a realizar: " num_part  

#Comprobamos el numero de particiones  
if [[ $num_part -gt 128 || $num_part -lt 1]]; then  
    echo "Número de particiones no válido"  
else  
    break  
fi  
done  

while true; do  
read -p "Indique tamaño de la partición en megas (E). 512M): " size  

#Confirmamos que este bien escrito el tamaño  
if [[ ! "$size" =~ ^[0-9]{1,5}M$ ]]; then  
   echo "El tamaño no es válido"  
else  
    break  
fi  
done  

for partition in $(seq 1 $num_part); do sudo sgdisk --new-0:0:+$size /dev/$disco > /dev/null; done
