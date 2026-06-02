# Système de Paiement par Carte à Puce (Simulation BasicCard)

Ce projet est une simulation d'un écosystème de paiement électronique composé d'une **Carte à Puce virtuelle** et d'un **Terminal de Paiement**. Il a été réalisé à l'aide de la technologie **ZeitControl BasicCard**.

## 📌 Aperçu du Projet
L'objectif est de démontrer la communication sécurisée entre un objet portable (la carte) et un lecteur (le terminal) via un protocole de commandes/réponses.

### Composants
1.  **MaCarte.bas** : Le logiciel embarqué dans la puce. Il gère le stockage sécurisé du solde en mémoire EEPROM et valide les transactions.
2.  **MonTerminal.bas** : L'interface utilisateur. Il simule un lecteur de carte qui demande un montant, initie la communication et affiche le résultat (ticket de caisse).

## 🛠️ Fonctionnalités
- **Solde Persistant** : La carte mémorise son solde même après "déconnexion" grâce à la variable `Eeprom`.
- **Validation de Transaction** : Vérification automatique du solde avant chaque retrait.
- **Retour d'Information** : Le terminal affiche le solde restant après chaque opération (réussie ou échouée).
- **Codes de Statut (SW1SW2)** : Utilisation des standards de cartes à puce pour signaler le succès (`9000`) ou les erreurs (ex: `6100` pour solde insuffisant).

## 🚀 Guide de Simulation

### Prérequis
- Windows avec le package **BasicCard Development Software** installé.

### Étapes pour lancer le test
1.  **Compiler la Carte** : Ouvrez `MaCarte.bas` dans l'IDE BasicCard et appuyez sur **F9**. Cela génère le fichier `MaCarte.img`.
2.  **Compiler le Terminal** : Ouvrez `MonTerminal.bas` et appuyez sur **F9**.
3.  **Lancer la simulation** :
    - Exécutez le programme du terminal.
    - Saisissez un montant dans la console (ex: `2000`).
    - Le simulateur "insère" automatiquement la carte virtuelle.
    - Observez le résultat de la transaction et le solde mis à jour.

## 📝 Structure du Code
- `#include zc75.mcf` : Définit l'architecture de la puce cible.
- `Command &H80 &H02` : Définit une instruction personnalisée pour le paiement.
- `Call WaitForCard()` : Met le terminal en attente d'une insertion physique ou virtuelle.

---
*Projet réalisé dans le cadre d'un exercice d'apprentissage des systèmes embarqués et de la programmation de cartes à puce.*
# basiccard-payment
