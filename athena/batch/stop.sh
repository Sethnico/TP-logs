#!/usr/bin/sh
if [ -f /app/athena/param/athena.env ] ; then
    . /app/athena/param/athena.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

logFile="stop.log"
jnlAppTraitement="${appPath}/log/${logFile}"

function fun_writeLog {
    msg=$1
    eventDateTime=$(date +"%Y%m%d %T.%3N")
    echo "${eventDateTime} - ${msg}" >> ${jnlAppTraitement}
}

fun_writeLog "*******************************************"
fun_writeLog " Arrêt de l'application : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

nbProc=$(ps -ef | grep ${appName}.sh | grep -v grep | wc -l)
if [[ ${nbProc} -eq 0 ]] ; then
    fun_writeLog "Pas de process en cours. Application déjà stoppée."
else
    fun_writeLog "Kill en SIGTERM de la boucle"
    ps -ef | grep ${appName}.sh | grep -v grep | awk '{print $2}' | xargs kill -15
fi
