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
    fun_logDebug "ATH9004" "Parcours du répertoire ${envData}/input"
    for file in $(ls ${envData}/input) ; do
        gsFileExt="${file##*.}"
        fun_logDebug "ATH9001" "Fichier présent dans input: ${file}"
        if [ "${gsFileExt}" == "csv" ] ; then
            fun_logInfo "ATH0003" "Traitement de ${file}"
            mv ${envData}/input/${file} "${envData}/done/"
            if [ $? -ne 0 ] ; then
                fun_logError "ATH1001" "Erreur lors du déplacement de ${file} vers done"
                mv ${envData}/input/${file} "${envData}/error/"
                if [ $? -ne 0 ] ; then
                    fun_logError "ATH1002" "Erreur lors du déplacement de ${file} vers error"
                fi
            fi
        else
            fun_logError "ATH1003" "Extension non pris en charge (.${gsFileExt})"
            mv ${envData}/input/${file} "${envData}/error/"
            if [ $? -ne 0 ] ; then
                fun_logError "ATH1002" "Erreur lors du déplacement de ${file} vers error"
            fi
        fi
    done
    fun_logDebug "ATH9002" "Fin de la boucle. Nouveau lancement dans 5 secondes."
    sleep 5
done
