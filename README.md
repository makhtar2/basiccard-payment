# Systeme de paiement BasicCard en FCFA

Ce projet implemente un mini systeme de paiement adapte au Senegal avec une carte a puce programmable BasicCard, un terminal de paiement et des montants en francs CFA.

## Fonctionnalites

- Verification d'un code PIN.
- Consultation du solde de la carte.
- Debit d'un montant en FCFA lors d'un paiement.
- Rechargement d'un montant en FCFA sur la carte.
- Blocage de la carte apres 3 mauvais codes PIN.
- Ticket affiche apres un paiement accepte.
- Gestion des erreurs : PIN incorrect, montant invalide, solde insuffisant.

## Structure

- `src/card/MaCarte.bas` : programme embarque dans la carte.
- `src/card/MaCarte.zcc` : configuration du projet carte BasicCard.
- `src/terminal/MonTerminal.bas` : programme du terminal.
- `compiler.bat` : compile la carte et le terminal.
- `lancer.bat` : lance le simulateur puis le terminal.
- `docs/explication-projet.md` : explication complete du projet.
- `docs/protocole.md` : protocole APDU utilise entre le terminal et la carte.
- `bin/` : fichiers generes par la compilation.

## Prerequis

- Windows.
- BasicCard Development Software installe, par defaut dans :
  `C:\Program Files (x86)\BasicCardV7`

Si BasicCard est installe ailleurs, modifier la variable `BC_PATH` dans `compiler.bat` et `lancer.bat`.

## Compilation

Double-cliquer sur :

```bat
compiler.bat
```

La compilation doit produire :

- `bin\MaCarte.img`
- `bin\MonTerminal.exe`
- `bin\MonTerminal.img`

## Execution

Double-cliquer sur :

```bat
lancer.bat
```

Le script lance le simulateur BasicCard avec l'image de la carte et l'image du terminal.

## Donnees de test

- PIN par defaut : `1234`
- Solde initial : `10000 FCFA`.
- Les montants saisis dans le terminal sont directement en FCFA.
- Apres 3 mauvais PIN, la carte se bloque pendant la simulation.

Exemples :

- `500` = 500 FCFA
- `2500` = 2 500 FCFA
- `10000` = 10 000 FCFA

## Objectifs pedagogiques

1. Comprendre la separation entre carte et terminal.
2. Definir un protocole de commandes simple.
3. Stocker des donnees persistantes dans l'EEPROM de la carte.
4. Tester des transactions dans le simulateur BasicCard.
