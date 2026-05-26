#include zc75.mcf

' Etape 2: Déclaration d'une variable persistante en mémoire sécurisée
' On initialise la carte avec un solde de 10000 (soit 100,00)
Eeprom SoldeCompte As Long = 10000

' Commande de paiement
Command &H80 &H02 Paiement(Montant As Long, Out SoldeRestant As Long)
    ' Vérification du solde
    If Montant > SoldeCompte Then
        ' Code d'erreur arbitraire pour indiquer un solde insuffisant
        SW1SW2 = &H6100
        SoldeRestant = SoldeCompte
        Exit
    End If
    
    ' Soustraction si le solde est suffisant
    SoldeCompte = SoldeCompte - Montant
    SoldeRestant = SoldeCompte
    
    ' Code de succès standard
    SW1SW2 = &H9000
End Command
