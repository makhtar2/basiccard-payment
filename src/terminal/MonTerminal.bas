Option Explicit

#include CARDUTIL.DEF

' *******************************************************************
' MonTerminal.bas - Terminal de paiement BasicCard en FCFA
' *******************************************************************

Rem Codes retour personnalises envoyes par la carte.
Const swInsufficientFunds = &H6B01
Const swInvalidAmount = &H6B02
Const swInvalidPIN = &H6B03
Const swCardBlocked = &H6B04

Rem Commandes APDU disponibles sur la carte.
Rem Le terminal doit declarer les memes signatures que la carte.
Declare Command &H80 &H10 GetBalance(Code As Long, SoldeCarte As Long)
Declare Command &H80 &H20 Debit(Code As Long, MontantCarte As Long, NouveauSolde As Long)
Declare Command &H80 &H30 Credit(Code As Long, MontantCarte As Long, NouveauSolde As Long)

Rem Affiche le solde dans la monnaie utilisee au Senegal.
Sub AfficherSolde(Solde As Long)
    Print "Solde disponible : " + Str$(Solde) + " FCFA"
End Sub

Rem Traduit les codes techniques de la carte en messages comprehensibles.
Sub AfficherErreur()
    If SW1SW2 = swInvalidPIN Then
        Print "Erreur : PIN incorrect."
    ElseIf SW1SW2 = swCardBlocked Then
        Print "Erreur : carte bloquee apres 3 mauvais PIN."
    ElseIf SW1SW2 = swInsufficientFunds Then
        Print "Erreur : solde insuffisant."
    ElseIf SW1SW2 = swInvalidAmount Then
        Print "Erreur : montant invalide."
    Else
        Print "Erreur carte : " + Hex$(SW1SW2)
    End If
End Sub

Rem Affiche un ticket simple apres un paiement accepte.
Sub AfficherTicket(Montant As Long, Solde As Long)
    Print ""
    Print "---------- TICKET DE PAIEMENT ----------"
    Print "Pays      : Senegal"
    Print "Monnaie   : FCFA"
    Print "Montant   : " + Str$(Montant) + " FCFA"
    Print "Statut    : Paiement accepte"
    Print "Nouveau solde : " + Str$(Solde) + " FCFA"
    Print "----------------------------------------"
End Sub

Private CodePIN&
Private ChoixMenu&
Private MontantSaisi&
Private SoldeCarte&
Private Continuer&
Private PinValide&
Private Saisie$
Private Len@

' Le simulateur BasicCard utilise le lecteur virtuel 201.
ComPort = 201
Continuer& = 1
PinValide& = 0

Print "--- TERMINAL DE PAIEMENT FCFA - SENEGAL ---"
Print "Insertion de la carte..."
Call WaitForCard()

Rem ResetCard initialise la carte avant l'envoi des commandes APDU.
ResetCard

While PinValide& = 0
    Print "Entrez le code PIN : " ;
    Line Input Saisie$
    Rem Val! convertit le texte tape par l'utilisateur en nombre.
    CodePIN& = Val!(Saisie$, Len@)
    Call GetBalance(CodePIN&, SoldeCarte&)

    If SW1SW2 = &H9000 Then
        PinValide& = 1
    Else
        Call AfficherErreur()
        If SW1SW2 = swCardBlocked Then
            Exit
        End If
    End If
Wend

Print "PIN accepte."
Call AfficherSolde(SoldeCarte&)

While Continuer& = 1
    Print ""
    Print "1 - Consulter le solde"
    Print "2 - Effectuer un paiement en FCFA"
    Print "3 - Recharger la carte en FCFA"
    Print "0 - Quitter"
    Print "Votre choix : " ;
    Line Input Saisie$
    ChoixMenu& = Val!(Saisie$, Len@)

    If ChoixMenu& = 1 Then
        Call GetBalance(CodePIN&, SoldeCarte&)
        If SW1SW2 = &H9000 Then
            Call AfficherSolde(SoldeCarte&)
        Else
            Call AfficherErreur()
        End If
    ElseIf ChoixMenu& = 2 Then
        Print "Montant a payer en FCFA : " ;
        Line Input Saisie$
        MontantSaisi& = Val!(Saisie$, Len@)
        Call Debit(CodePIN&, MontantSaisi&, SoldeCarte&)
        If SW1SW2 = &H9000 Then
            Call AfficherTicket(MontantSaisi&, SoldeCarte&)
        Else
            Call AfficherErreur()
            Call AfficherSolde(SoldeCarte&)
        End If
    ElseIf ChoixMenu& = 3 Then
        Print "Montant a recharger en FCFA : " ;
        Line Input Saisie$
        MontantSaisi& = Val!(Saisie$, Len@)
        Call Credit(CodePIN&, MontantSaisi&, SoldeCarte&)
        If SW1SW2 = &H9000 Then
            Print "Carte rechargee."
            Call AfficherSolde(SoldeCarte&)
        Else
            Call AfficherErreur()
        End If
    ElseIf ChoixMenu& = 0 Then
        Continuer& = 0
    Else
        Print "Choix invalide."
    End If
Wend

Print "Merci de votre visite."
