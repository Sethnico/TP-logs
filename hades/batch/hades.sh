#!/usr/bin/sh
if [ -f /app/hades/param/hades.env ] ; then
    . /app/hades/param/hades.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

logFile="hades.log"
jnlAppTraitement="${appPath}/log/${logFile}"

function fun_writeLog {
    msg=$1
    eventDateTime=$(date +"%Y%m%d %T.%3N")
    echo "${eventDateTime} - ${msg}" >> ${jnlAppTraitement}
}

function fun_exit {
    fun_writeLog "*******************************************"
    fun_writeLog " Arrêt de la boucle : $(date +"%Y/%m/%d %T")"
    fun_writeLog "*******************************************"
    exit 0
}

function fun_reload {
    fun_writeLog "*******************************************"
    fun_writeLog " Rechargement de l'application $(date +"%Y/%m/%d %T")"
    fun_writeLog "*******************************************"
    . /app/hades/param/hades.env
}

trap fun_exit 15

trap fun_reload 1

fun_writeLog "*******************************************"
fun_writeLog " Démarrage de la boucle : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"
fun_writeLog "Lancement de ${appName}"

while true ; do
    fun_writeLog "[INFO] - [TPRT0000] - Everything is fine..."
    sleep 1
done
