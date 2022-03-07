#!/usr/bin/sh
if [ -f ~/tprt/param/tprt.env ] ; then
    . ~/tprt/param/tprt.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

logFile="tprt.log"
jnlAppTraitement="${tprtPath}/log/${logFile}"

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

trap fun_exit 15

fun_writeLog "*******************************************"
fun_writeLog " Démarrage de la boucle : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

while true ; do
    fun_writeLog "[TPRT0000] - Everything is fine..."
    sleep 5
done
