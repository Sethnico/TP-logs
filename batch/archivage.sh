#!/usr/bin/sh
if [ -f /app/param/app.env ] ; then
    . /app/param/app.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

logFile="jnlArchivage.log"
archDir=$(date +"%Y%m%d-%H%M%S")
jnlArchivage="${logPath}/${archDir}/${logFile}"
typeset -i nbArchivedFiles=0
typeset -i nbArchivedFilesUnit=0

function fun_writeLog {
    msg=$1
    eventDateTime=$(date +"%Y%m%d %T.%3N")
    echo "${eventDateTime} - ${msg}" >> ${jnlArchivage}
}

if [ ! -d "${logPath}/${archDir}" ] ; then
    mkdir "${logPath}/${archDir}"
fi

fun_writeLog "*******************************************"
fun_writeLog " Starting  archivage script : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

fun_writeLog "Archivage de ${logPath}..."
for file in $(find ${logPath} -maxdepth 1 -type f -name "*.log" ) ; do
    fun_writeLog "    Deplacement de ${file} dans ${logPath}/${archDir}/"
    mv ${file} "${logPath}/${archDir}/"
    if [[ $? -eq 0 ]] ; then
        nbArchivedFiles=$((nbArchivedFiles + 1))
        nbArchivedFilesUnit=$((nbArchivedFilesUnit + 1))
    fi
done
fun_writeLog "    Fin d'archivage de ${logPath}. ${nbArchivedFiles} fichier archivés."

fun_writeLog "Number of files archived : ${nbArchivedFiles}"
fun_writeLog "*******************************************"
fun_writeLog " End of archivage script : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

exit 0
