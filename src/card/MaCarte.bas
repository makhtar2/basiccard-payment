Option Explicit

Rem *******************************************************************
Rem MaCarte.bas - Carte BasicCard pour paiement en FCFA
Rem *******************************************************************
Rem
Rem Les montants sont stockes en francs CFA entiers :
Rem   10000 = 10 000 FCFA
Rem
Rem Codes retour :
Rem   9000 : succes
Rem   6B01 : solde insuffisant
Rem   6B02 : montant invalide
Rem   6B03 : PIN incorrect

Const swInsufficientFunds = &H6B01
Const swInvalidAmount = &H6B02
Const swInvalidPIN = &H6B03

Rem Donnees persistantes de la carte.
Rem La memoire EEPROM garde ces valeurs meme apres fermeture du simulateur
Rem si le simulateur est lance avec une option d'ecriture EEPROM.
Eeprom SoldeCompte As Long = 10000
Eeprom PinCode As Long = 1234

Rem Commande 80 10 : consultation du solde.
Rem Le terminal envoie le PIN, la carte renvoie le solde actuel.
Command &H80 &H10 GetBalance(PinSaisi As Long, Solde As Long)
    Solde = SoldeCompte

    Rem Refuser la consultation si le code PIN est incorrect.
    If PinSaisi <> PinCode Then
        SW1SW2 = swInvalidPIN
        Exit
    End If
End Command

Rem Commande 80 20 : paiement/debit.
Rem Le montant est retire uniquement si le PIN est correct et si le solde suffit.
Command &H80 &H20 Debit(PinSaisi As Long, Montant As Long, NouveauSolde As Long)
    NouveauSolde = SoldeCompte

    Rem Premiere securite : verifier le porteur de la carte avec le PIN.
    If PinSaisi <> PinCode Then
        SW1SW2 = swInvalidPIN
        Exit
    End If

    Rem On refuse les montants nuls ou negatifs.
    If Montant <= 0 Then
        SW1SW2 = swInvalidAmount
        Exit
    End If

    Rem On refuse le paiement si le client n'a pas assez d'argent.
    If Montant > SoldeCompte Then
        SW1SW2 = swInsufficientFunds
        Exit
    End If

    Rem Transaction acceptee : la carte met a jour son solde.
    SoldeCompte = SoldeCompte - Montant
    NouveauSolde = SoldeCompte
End Command

Rem Commande 80 30 : rechargement/credit.
Rem Cette commande simule un depot d'argent sur la carte.
Command &H80 &H30 Credit(PinSaisi As Long, Montant As Long, NouveauSolde As Long)
    NouveauSolde = SoldeCompte

    Rem Le rechargement est protege par le meme PIN dans ce projet simple.
    If PinSaisi <> PinCode Then
        SW1SW2 = swInvalidPIN
        Exit
    End If

    Rem Un rechargement doit toujours etre strictement positif.
    If Montant <= 0 Then
        SW1SW2 = swInvalidAmount
        Exit
    End If

    Rem Transaction acceptee : on ajoute le montant au solde.
    SoldeCompte = SoldeCompte + Montant
    NouveauSolde = SoldeCompte
End Command
