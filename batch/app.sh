#!/usr/bin/sh
if [ -f /app/param/app.env ] ; then
    . /app/param/app.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

logFile="app.log"
jnlAppTraitement="${logPath}/${logFile}"

function fun_writeLog {
    msg=$1
    eventDateTime=$(date +"%Y%m%d %T.%3N")
    echo "${eventDateTime} - ${msg}" >> ${jnlAppTraitement}
}

function fun_exit {
    fun_writeLog "*******************************************"
    fun_writeLog " Stopping app scripts : $(date +"%Y/%m/%d %T")"
    fun_writeLog "*******************************************"
    exit 0
}

trap fun_exit 15

fun_writeLog "*******************************************"
fun_writeLog " Starting app script : $(date +"%Y/%m/%d %T")"
fun_writeLog "*******************************************"

while true ; do
    fun_writeLog "Everything is fine..."
    sleep 5
done
