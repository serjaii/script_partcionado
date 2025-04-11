# Particionador GPT con sgdisk

Para distribuciones basadas en Debian/Ubuntu

Este script permite crear particiones en discos utilizando el esquema de particionado GPT (GUID Partition Table) mediante la herramienta `sgdisk`. El usuario puede seleccionar el disco a modificar, especificar el número de particiones y definir el tamaño de cada una.

## Características

- Selección del disco a particionar.
- Elección del número de particiones.
- Definición del tamaño de cada partición.
- Uso de `sgdisk` para un particionado confiable y compatible con GPT.
- Automatización simple y efectiva para tareas de particionado.

## Requisitos

- Sistema operativo basado en Linux.
- Permisos de superusuario (`sudo`).
- Herramienta `sgdisk` instalada (incluida en el paquete `gdisk`).

## Desarrollado por:

- Sergio Jiménez
- Aleksandr Kosenko
- Roberto Martín
