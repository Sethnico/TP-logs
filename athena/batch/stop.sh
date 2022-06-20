#!/usr/bin/sh
if [ -f /app/athena/param/athena.env ] ; then
    . /app/athena/param/athena.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

if [ -f /app/athena/lib/functions.sh ] ; then
    . /app/athena/lib/functions.sh
else
    echo "Librairies non chargées !"
    exit 8
fi

gsFicLog="${envAppPath}/log/stop.log"

fun_logInfo "ATH0001" "Arrêt de l'application : $(date +"%Y/%m/%d %T")"

nbProc=$(ps -ef | grep ${envAppName}.sh | grep -v grep | wc -l)
if [[ ${nbProc} -eq 0 ]] ; then
    fun_logInfo "ATH0001" "Pas de process en cours. Application déjà stoppée."
else
    fun_logInfo "ATH0001" "Kill en SIGTERM de la boucle"
    ps -ef | grep ${envAppName}.sh | grep -v grep | awk '{print $2}' | xargs kill -15
fi
