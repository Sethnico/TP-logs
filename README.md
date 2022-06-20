# TP-Logs - Gestion des logs - IUT de Colmar

Repo GitHUB pour le TP sur la gestion des logs


## Description
- Athena : Applcation Bash déplacant des fichiers selon l'extention
- Hades : A compléter...


## Prérequis
Télécharger les applications depuis GitHUB :
```bash
git clone https://github.com/Sethnico/TP-logs.git .
```

### Athena :
Insérer le contenu suivant dans votre crontab :
```bash
crontab -e
*/5 * * * * /app/athena/batch/stop.sh ; sleep 5 ; /app/athena/batch/purge.sh ; sleep 5 ; /app/athena/batch/start.sh
```

### Hades :
Copier / coller successivement les commandes suivantes :
```bash
sudo mv hades/hades.logrotate /etc/logrotate.d/
sudo chown root. /etc/logrotate.d/hades.logrotate
sudo chmod 644 /etc/logrotate.d/hades.logrotate
sudo mv hades/hades.service /usr/lib/systemd/system/
sudo chown root. /usr/lib/systemd/system/hades.service
ln -s /usr/lib/systemd/system/hades.service /etc/systemd/system/hades.service
sudo systemctl daemon-reload
sudo systemctl enable hades.service
sudo systemctl start hades
```

## Messages

 - Athena
### INFO
```
ATH0001     Default
ATH0002     Scrute rep
ATH0003     Fichier en traitement
ATH0004     Démarrage d'archivage
ATH0005     Déplacement de log en archivage
ATH0006     Fin d'archivage
ATH0007     Démarrage de purge
ATH0008     Suppression de log
ATH0009     Fin de purge
ATH0010     Application déjà lancée
ATH0011     Arret de la boucle
```

### ERROR
```
ATH1001     Erreur de déplacement vers done
ATH1002     Erreur de déplacement vers error
ATH1003     Type de fichier non pris en charge
ATH1004     Erreur lors du lancement de l'application
```

### DEBUG
```
ATH9001     Fichier trouvé dans input
ATH9002     Fin de boucle
ATH9003     Lancement de l'application
```

## Further Documentation
Link to sujt de TP https://someting.bla.com/

## Contribute
- Issue Tracker: https://git.renard.intra/java/myApp/issues
- Source Code: https://git.renard.intra/java/myApp/
