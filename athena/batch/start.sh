#!/usr/bin/sh
if [ -f /app/athena/param/athena.env ] ; then
    . /app/athena/param/athena.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

logFile="start.log"
jnlAppTraitement="${appPath}/log/${logFile}"

function fun_writeLog {
    msg=$1
    eventDateTime=$(date +"%Y%m%d %T.%3N")
    echo "${eventDateTime} - ${msg}" >> ${jnlAppTraitement}
}

fun_writeLog "*******************************************"
fun_writeLog " Démarrage de l'application : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

nbProc=$(ps -ef | grep ${appName}.sh | grep -v grep | wc -l)
if [[ ${nbProc} -eq 0 ]] ; then
    fun_writeLog "Pas de process en cours. Lancement de la boucle"
    nohup ${appPath}/batch/${appName}.sh >> ${jnlAppTraitement} 2>&1 &
    if [[ $? -ne 0 ]] ; then
        fun_writeLog "Erreur lors du lancement de l'application"
    fi
else
    fun_writeLog "Boucle déjà lancée. On ne la relance pas."
    ps -ef | grep ${appName}.sh | grep -v grep
fi
