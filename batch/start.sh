#!/usr/bin/sh
if [ -f ~/tprt/param/tprt.env ] ; then
    . ~/tprt/param/tprt.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

logFile="start.log"
jnlAppTraitement="${tprtPath}/log/${logFile}"

function fun_writeLog {
    msg=$1
    eventDateTime=$(date +"%Y%m%d %T.%3N")
    echo "${eventDateTime} - ${msg}" >> ${jnlAppTraitement}
}

fun_writeLog "*******************************************"
fun_writeLog " Démarrage de l'application : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

nbProc=$(ps -ef | grep tprt.sh | grep -v grep | wc -l)
if [[ ${nbProc} -eq 0 ]] ; then
    fun_writeLog "Pas de process en cours. Lancement de la boucle"
    nohup ${tprtPath}/batch/tprt.sh >> ${jnlAppTraitement} 2>&1 &
else
    fun_writeLog "Boucle déjà lancée. On ne la relance pas."
fi
