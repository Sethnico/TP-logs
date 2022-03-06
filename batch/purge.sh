#!/usr/bin/sh
if [ -f /app/param/app.env ] ; then
    . /app/param/app.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

logFile="jnlPurge.log"
jnlPurge="${logPath}/${logFile}"
typeset -i nbPurgeFiles=0

function fun_writeLog {
    msg=$1
    eventDateTime=$(date +"%Y%m%d %T.%3N")
    echo "${eventDateTime} - ${msg}" >> ${jnlPurge}
}

if [ ! -d "${logPath}/${archDir}" ] ; then
    mkdir "${logPath}/${archDir}"
fi

fun_writeLog "*******************************************"
fun_writeLog " Starting purge script : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

fun_writeLog "Purge des dossiers dans ${logPath} de plus de ${nbJourPurge} minutes..."
for dirname in $(find ${logPath} -maxdepth 1 -type d -mmin +${nbJourPurge}) ; do
    fun_writeLog "    Suppression de ${dirname}."
    rm -rf ${dirname}
    if [[ $? -eq 0 ]] ; then
        nbPurgeFiles=$((nbPurgeFiles + 1))
    fi
done
fun_writeLog "    Fin de la purge ${logPath}."

fun_writeLog "Number of directory purged : ${nbPurgeFiles}"
fun_writeLog "*******************************************"
fun_writeLog " End of purge script : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

exit 0
