# Explication du projet

## Idee generale

Ce projet simule un systeme de paiement par carte a puce pour le Senegal. La carte stocke un solde en francs CFA et le terminal permet de consulter ce solde, de payer un achat ou de recharger la carte.

Le projet utilise BasicCard :

- une partie carte, qui represente le programme embarque dans la carte ;
- une partie terminal, qui represente la caisse ou le lecteur de paiement ;
- un simulateur, qui permet de tester sans vraie carte physique.

## Monnaie utilisee

Tous les montants sont en FCFA.

Il n'y a pas de centimes dans le projet. Quand l'utilisateur saisit `500`, cela signifie `500 FCFA`. Quand il saisit `2500`, cela signifie `2 500 FCFA`.

## Fichiers importants

### `src/card/MaCarte.bas`

Ce fichier contient le programme de la carte. La carte garde deux informations principales en EEPROM :

- `SoldeCompte` : le solde disponible, initialise a `10000 FCFA` ;
- `PinCode` : le code PIN, initialise a `1234`.

La carte expose trois commandes :

- `GetBalance` : consulter le solde ;
- `Debit` : retirer un montant lors d'un paiement ;
- `Credit` : ajouter un montant lors d'un rechargement.

La carte gere aussi la securite du PIN. Apres trois mauvais codes PIN, elle passe en etat bloque et refuse les operations suivantes.

### `src/terminal/MonTerminal.bas`

Ce fichier contient le programme du terminal. Il affiche un menu a l'utilisateur :

- consulter le solde ;
- effectuer un paiement en FCFA ;
- recharger la carte en FCFA ;
- quitter.

Le terminal demande d'abord le PIN, puis envoie les commandes a la carte. Il affiche ensuite le resultat de l'operation.

Apres un paiement accepte, le terminal affiche un ticket avec le pays, la monnaie, le montant paye, le statut et le nouveau solde.

### `compiler.bat`

Ce script compile le projet. Il genere :

- `bin\MaCarte.img` : image de la carte ;
- `bin\MonTerminal.exe` : executable terminal ;
- `bin\MonTerminal.img` : image terminal utilisee par le simulateur.

### `lancer.bat`

Ce script lance la simulation. Il demarre `ZCMSim` avec la carte et le terminal.

## Scenario de test

1. Lancer `compiler.bat`.
2. Lancer `lancer.bat`.
3. Entrer le PIN `1234`.
4. Choisir `1` pour consulter le solde.
5. Choisir `2` pour payer, par exemple `500 FCFA`.
6. Choisir `3` pour recharger, par exemple `1000 FCFA`.
7. Choisir `0` pour quitter.

Pour tester la securite, relancer la simulation et saisir trois mauvais PIN. La carte affichera une erreur de blocage.

## Codes retour

La carte renvoie des codes pour indiquer le resultat :

- `9000` : operation reussie ;
- `6B01` : solde insuffisant ;
- `6B02` : montant invalide ;
- `6B03` : PIN incorrect.
- `6B04` : carte bloquee apres 3 mauvais PIN.

## Limites du projet

Ce projet est une simulation pedagogique. Il montre le principe d'une carte de paiement, mais il ne gere pas encore :

- le chiffrement des transactions ;
- un historique des paiements ;
- l'identite du commercant ;
- une vraie connexion bancaire.

Ces ameliorations peuvent etre ajoutees dans une version suivante.
