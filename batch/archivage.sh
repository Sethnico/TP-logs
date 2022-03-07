#!/usr/bin/sh
if [ -f ~/tprt/param/tprt.env ] ; then
    . ~/tprt/param/tprt.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

logFile="jnlArchivage.log"
archDir=$(date +"%Y%m%d-%H%M%S")
jnlArchivage="${tprtPath}/log/${archDir}/${logFile}"
typeset -i nbArchivedFiles=0

function fun_writeLog {
    msg=$1
    eventDateTime=$(date +"%Y%m%d %T.%3N")
    echo "${eventDateTime} - ${msg}" >> ${jnlArchivage}
}

if [ ! -d "${tprtPath}/log/${archDir}" ] ; then
    mkdir "${tprtPath}/log/${archDir}"
fi

fun_writeLog "*******************************************"
fun_writeLog " Démarrage de l'archivage : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

fun_writeLog "Archivage de ${tprtPath}/log..."
for file in $(find ${tprtPath}/log -maxdepth 1 -type f -name "*.log" ) ; do
    fun_writeLog "    Deplacement de ${file} dans ${tprtPath}/log/${archDir}/"
    mv ${file} "${tprtPath}/log/${archDir}/"
    if [[ $? -eq 0 ]] ; then
        nbArchivedFiles=$((nbArchivedFiles + 1))
    fi
done

fun_writeLog "Nombre de fichier archivé : ${nbArchivedFiles}"
fun_writeLog "*******************************************"
fun_writeLog " Fin de l'archivage : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

exit 0
