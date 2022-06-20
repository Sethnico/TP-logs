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

fsArchDir=$(date +"%Y%m%d-%H%M%S")
gsFicLog="${envAppPath}/log/${fsArchDir}/jnlPurge.log"
typeset -i nbArchivedFiles=0
typeset -i nbPurgeFiles=0

if [ ! -d "${envAppPath}/log/${fsArchDir}" ] ; then
    mkdir "${envAppPath}/log/${fsArchDir}"
fi

fun_logInfo "TPRT0001" "Démarrage de l'archivage : $(date +"%Y/%m/%d %T")"

fun_logInfo "TPRT0001" "Archivage de ${envAppPath}/log..."
for file in $(find ${envAppPath}/log -maxdepth 1 -type f -name "*.log" -o -name "*.err") ; do
    fun_logInfo "TPRT0001" "    Deplacement de ${file} dans ${envAppPath}/log/${fsArchDir}/"
    mv ${file} "${envAppPath}/log/${fsArchDir}/"
    if [[ $? -eq 0 ]] ; then
        nbArchivedFiles=$((nbArchivedFiles + 1))
    fi
done

fun_logInfo "TPRT0001" "Nombre de fichier archivé : ${nbArchivedFiles}"
fun_logInfo "TPRT0001" "Fin de l'archivage : $(date +"%Y/%m/%d %T")"

fun_logInfo "TPRT0001" "Démarrage de la purge : $(date +"%Y/%m/%d %T")"

fun_logInfo "TPRT0001" "Purge des dossiers dans ${envAppPath}/log de plus de ${envNbJourPurge} minutes..."
for dirname in $(find ${envAppPath}/log -maxdepth 1 -type d -mmin +${envNbJourPurge}) ; do
    fun_logInfo "TPRT0001" "    Suppression de ${dirname}."
    rm -rf ${dirname}
    if [[ $? -eq 0 ]] ; then
        nbPurgeFiles=$((nbPurgeFiles + 1))
    fi
done

fun_logInfo "TPRT0001" "Nombre de dossier purgé : ${nbPurgeFiles}"
fun_logInfo "TPRT0001" "Fin de la purge : $(date +"%Y/%m/%d %T")"

exit 0
