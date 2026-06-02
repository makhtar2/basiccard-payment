# Projet BasicCard FCFA - version compilation manuelle ZC

Ce dossier est une copie propre du projet pour travailler directement avec l'environnement BasicCard/ZC, sans utiliser les scripts `.bat`.

## Contenu du dossier

- `card/MaCarte.bas` : code source de la carte.
- `card/MaCarte.zcc` : fichier projet carte a ouvrir dans ZC.
- `terminal/MonTerminal.bas` : code source du terminal.
- `terminal/MonTerminal.zct` : fichier projet terminal a ouvrir dans ZC.
- `docs/protocole.md` : protocole APDU.
- `docs/explication-projet.md` : explication du projet.
- `docs/presentation.pdf` : presentation du projet.

## Objectif

Le projet simule un paiement par carte a puce au Senegal avec des montants en FCFA.

Fonctionnalites :

- verification du PIN ;
- consultation du solde ;
- paiement en FCFA ;
- rechargement en FCFA ;
- blocage apres 3 mauvais PIN ;
- ticket de paiement apres une transaction acceptee.

## Donnees de test

- PIN : `1234`
- Solde initial : `10000 FCFA`
- Exemple de paiement : `500 FCFA`

## Compilation manuelle avec ZC / BasicCard

### 1. Compiler la carte

1. Ouvrir BasicCard Development Environment.
2. Ouvrir le fichier :

   ```text
   card\MaCarte.zcc
   ```

3. Compiler le projet carte.
4. Generer l'image carte `MaCarte.img`.

Selon la configuration de ZC, l'image peut etre generee dans le dossier `card` ou dans le dossier choisi par l'IDE.

### 2. Compiler le terminal

1. Ouvrir le fichier :

   ```text
   terminal\MonTerminal.zct
   ```

2. Verifier que le terminal utilise le port virtuel :

   ```text
   ComPort=201
   ```

3. Compiler le terminal.
4. Generer l'image terminal `MonTerminal.img` ou l'executable terminal selon le mode choisi.

### 3. Lancer la simulation

Dans le simulateur BasicCard :

1. Charger l'image de la carte `MaCarte.img`.
2. Charger/lancer le terminal `MonTerminal.img` ou le terminal compile.
3. Entrer le PIN `1234`.
4. Tester le menu :
   - `1` : consulter le solde ;
   - `2` : payer ;
   - `3` : recharger ;
   - `0` : quitter.

## Commande equivalente, sans script

Si vous voulez lancer manuellement depuis une invite de commande, apres compilation des images :

```bat
ZCMSim.exe -P201 -CMaCarte MonTerminal.img
```

Cette commande doit etre lancee depuis le dossier qui contient `MaCarte.img` et `MonTerminal.img`.

## Remarque

Ce dossier ne contient volontairement pas :

- `compiler.bat` ;
- `lancer.bat` ;
- `generer-presentation.bat` ;
- le dossier `bin`.

Le but est de garder une version propre pour l'IDE ZC.
