# TP-Logs - Gestion des logs - IUT de Colmar

Repo GitHUB pour le TP sur la gestion des logs


## Features
- Athena : Applcation Bash déplacant des fichiers selon l'extention
- Hades : A compléter...


## Prerequisites
git clone [repo] .

### Athena :
crontab >

### Hades :
systemctl enable


## Usage

- Athena :
```bash
~$ /app/athena/batch/start.sh
```

- Hades :
```bash
~$ sudo systemctl start hades
```


## Messages

 - Athena
### INFO
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

### ERROR
ATH1001     Erreur de déplacement vers done
ATH1002     Erreur de déplacement vers error
ATH1003     Type de fichier non pris en charge
ATH1004     Erreur lors du lancement de l'application

### DEBUG
ATH9001     Fichier trouvé dans input
ATH9002     Fin de boucle
ATH9003     Lancement de l'application


## Further Documentation
Link to sujt de TP https://someting.bla.com/

## Contribute
- Issue Tracker: https://git.renard.intra/java/myApp/issues
- Source Code: https://git.renard.intra/java/myApp/
