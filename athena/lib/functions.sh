#!/bin/bash

function fun_writeLog {
    fsLevel="$1"
    msgID=$2
    msg=$3
    eventDateTime=$(date +"%Y%m%d %T.%3N")
    echo "${eventDateTime} - [${fsLevel}] - [${msgID}] - ${msg}" >> ${gsFicLog}
}

function fun_logDebug {
    if [ "$envLogLevel" == "DEBUG" ] ; then
        fun_writeLog "DEBUG" "$1" "$2"
    fi
}

function fun_logInfo {
    fun_writeLog "INFO" "$1" "$2"
}

function fun_logError {
    fun_writeLog "ERROR" "$1" "$2"
}
