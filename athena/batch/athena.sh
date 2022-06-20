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

gsFicLog="${envAppPath}/log/athena.log"

function fun_exit {
    fun_logInfo "ATH0001" "Arrêt de la boucle : $(date +"%Y/%m/%d %T")"
    exit 0
}

trap fun_exit 15

fun_logInfo "ATH0001" "Démarrage de la boucle : $(date +"%Y/%m/%d %T")"

while true ; do
    fun_logDebug "ATH0001" "Parcours du répertoire ${envData}/input"
    for files in $(ls ${envData}/input) ; do
        fun_logDebug "ATH0003" "Fichier: ${files}"
    done
    fun_logInfo "ATH0003" "Fin de la boucle. Nouveau lanecment dans 5 secondes."
    sleep 5
done
