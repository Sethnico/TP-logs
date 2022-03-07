#!/usr/bin/sh
if [ -f ~/tprt/param/tprt.env ] ; then
    . ~/tprt/param/tprt.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

logFile="jnlPurge.log"
jnlPurge="${tprtPath}/log/${logFile}"
typeset -i nbPurgeFiles=0

function fun_writeLog {
    msg=$1
    eventDateTime=$(date +"%Y%m%d %T.%3N")
    echo "${eventDateTime} - ${msg}" >> ${jnlPurge}
}

if [ ! -d "${tprtPath}/log/${archDir}" ] ; then
    mkdir "${tprtPath}/log/${archDir}"
fi

fun_writeLog "*******************************************"
fun_writeLog " Démarrage de la purge : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

fun_writeLog "Purge des dossiers dans ${tprtPath}/log de plus de ${nbJourPurge} minutes..."
for dirname in $(find ${tprtPath}/log -maxdepth 1 -type d -mmin +${nbJourPurge}) ; do
    fun_writeLog "    Suppression de ${dirname}."
    rm -rf ${dirname}
    if [[ $? -eq 0 ]] ; then
        nbPurgeFiles=$((nbPurgeFiles + 1))
    fi
done

fun_writeLog "Nombre de dossier purgé : ${nbPurgeFiles}"
fun_writeLog "*******************************************"
fun_writeLog " Fin de la purge : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

exit 0
