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

gsFicLog="${envAppPath}/log/start.log"

fun_logInfo "ATH0001" "Démarrage de l'application : $(date +"%Y/%m/%d %T")"

nbProc=$(ps -ef | grep ${envAppPath}/batch/${envAppName}.sh | grep -v grep | wc -l)
if [[ ${nbProc} -eq 0 ]] ; then
    fun_logInfo "ATH0001" "Pas de process en cours. Lancement..."
    nohup ${envAppPath}/batch/${envAppName}.sh 1>> ${gsFicLog}.err 2>> ${gsFicLog}.err &
    if [[ $? -ne 0 ]] ; then
        fun_logError "ATH1004" "Erreur lors du lancement de l'application"
    else
        fun_logDebug "ATH9003" "Application lancée"
    fi
else
    fun_logInfo "ATH0010" "Boucle déjà lancée. On ne la relance pas."
    ps -ef | grep ${envAppName}.sh | grep -v grep >> ${gsFicLog}.err
fi
