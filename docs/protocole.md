# Protocole carte/terminal en FCFA

Les commandes utilisent la classe `80` et des instructions differentes selon l'operation. Tous les montants sont exprimes directement en francs CFA.

## Codes retour

| Code | Signification |
| --- | --- |
| `9000` | Operation reussie |
| `6B01` | Solde insuffisant |
| `6B02` | Montant invalide |
| `6B03` | PIN incorrect |

## Commandes

### Consultation du solde

- CLA : `80`
- INS : `10`
- Parametres : `PinSaisi As Long`
- Sortie : `Solde As Long`

La carte renvoie le solde uniquement si le PIN est correct.

### Debit

- CLA : `80`
- INS : `20`
- Parametres : `PinSaisi As Long`, `Montant As Long`
- Sortie : `NouveauSolde As Long`

La carte refuse l'operation si le PIN est incorrect, si le montant est negatif ou nul, ou si le solde en FCFA est insuffisant.

### Credit

- CLA : `80`
- INS : `30`
- Parametres : `PinSaisi As Long`, `Montant As Long`
- Sortie : `NouveauSolde As Long`

La carte ajoute le montant en FCFA au solde si le PIN est correct et si le montant est strictement positif.

## Variables persistantes

La carte stocke deux valeurs en EEPROM :

- `SoldeCompte` : solde en FCFA, initialise a `10000`.
- `PinCode` : code PIN, initialise a `1234`.
