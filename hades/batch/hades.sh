#!/usr/bin/sh
if [ -f /app/hades/param/hades.env ] ; then
    . /app/hades/param/hades.env
else
    echo "Fichier de paramétrage non chargé !"
    exit 8
fi

if [ -f /app/hades/lib/functions.sh ] ; then
    . /app/hades/lib/functions.sh
else
    echo "Librairies non chargées !"
    exit 8
fi

gsFicLog="${envAppPath}/log/hades.log"

function fun_exit {
    fun_logInfo "HAD0001" "Arrêt de la boucle : $(date +"%Y/%m/%d %T")"
    exit 0
}

function fun_reload {
    fun_logInfo "HAD0001" "Rechargement de l'application $(date +"%Y/%m/%d %T")"
    . /app/hades/param/hades.env
}

trap fun_exit 15

trap fun_reload 1

fun_logInfo "HAD0001" " Démarrage de la boucle : $(date +"%Y/%m/%d %T")"

while true ; do
    fun_logDebug "HAD9002" "Fin de la boucle. Nouveau lancement dans 5 secondes."
    sleep 5
done
