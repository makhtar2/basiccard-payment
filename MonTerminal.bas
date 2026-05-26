#include cardutil.bas

' Etape 3: Déclaration de la commande de la carte
Declare Command &H80 &H02 Paiement(Montant As Long, Out SoldeRestant As Long)

Program
    Dim Montant As Long
    Dim SoldeRestant As Long
    
    ' Fixer ComPort = 0 pour forcer l'usage du simulateur logiciel
    ComPort = 0
    
    Print "--- TERMINAL DE PAIEMENT ---"
    
    ' Demander à l'utilisateur de saisir le prix
    Input "Entrez le montant de l'achat (ex: 2000 pour 20.00) : ", Montant
    
    Print "Veuillez insérer la carte..."
    ' Attente de la carte virtuelle
    Call WaitForCard()
    
    Print "Traitement en cours..."
    
    ' Envoyer la requête à la carte et récupérer le solde restant
    Call Paiement(Montant, SoldeRestant)
    
    ' Affichage du ticket de paiement (réussite ou échec)
    If SW1SW2 = &H9000 Then
        Print "---> Paiement ACCEPTE !"
        Print "---> Solde restant : " + Str$(SoldeRestant)
    ElseIf SW1SW2 = &H6100 Then
        Print "---> Paiement REFUSE : Solde insuffisant !"
        Print "---> Solde actuel : " + Str$(SoldeRestant)
    Else
        Print "---> Erreur de transaction : " + Hex$(SW1SW2)
    End If
    
    Print "Merci de votre visite."
End Program
