#!/bin/bash
#Copia de seguridad mensual en dispositivo secundario.
#Añadimos la siguiente linea al archivo /etc/crontab
#Ejecutara uan copia de seguridad en el cada mes el dia 1 a las 13h en el minuto 01
# 01 13  1 * *   root sh /home/adrian/copia_seguridad.sh
# Directoriode origen
origen="/home/adrian/tars/"
#Destino
destino="adrian@10.2.0.209:/home/adrian/copias"
#Declaramos las variables que usaremos posteriormente
PASS="password"
# Obtenemos el mes y el año en una variable para usarla en el nombre del .tar
ma=`date +%b%Y`
# Ejecutamos la compresion
tar -czvf /home/adrian/tars/backup-$ma.tar /home/adrian/Documentos/
# Se inicia el espect que realizará la sinconización y logeo.
expect -c "spawn rsync --progress -avze ssh $origen $destino
expect \"*?assword:*\"
send -- \"$PASS\r\"
expect \"*?seepdup*\"
expect eof" 2>/dev/null
