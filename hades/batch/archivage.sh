#!/usr/bin/sh
if [ -f /app/hades/param/hades.env ] ; then
    . /app/hades/param/hades.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

logFile="jnlArchivage.log"
archDir=$(date +"%Y%m%d-%H%M%S")
jnlArchivage="${appPath}/log/${archDir}/${logFile}"
typeset -i nbArchivedFiles=0

function fun_writeLog {
    msg=$1
    eventDateTime=$(date +"%Y%m%d %T.%3N")
    echo "${eventDateTime} - ${msg}" >> ${jnlArchivage}
}

if [ ! -d "${appPath}/log/${archDir}" ] ; then
    mkdir "${appPath}/log/${archDir}"
fi

fun_writeLog "*******************************************"
fun_writeLog " Démarrage de l'archivage : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

fun_writeLog "Archivage de ${appPath}/log..."
for file in $(find ${appPath}/log -maxdepth 1 -type f -name "*.log" ) ; do
    fun_writeLog "    Deplacement de ${file} dans ${appPath}/log/${archDir}/"
    mv ${file} "${appPath}/log/${archDir}/"
    if [[ $? -eq 0 ]] ; then
        nbArchivedFiles=$((nbArchivedFiles + 1))
    fi
done

fun_writeLog "Nombre de fichier archivé : ${nbArchivedFiles}"
fun_writeLog "*******************************************"
fun_writeLog " Fin de l'archivage : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

exit 0
