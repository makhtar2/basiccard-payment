# Presentation du projet

Le fichier `presentation.tex` contient une presentation LaTeX Beamer complete du projet BasicCard en FCFA.

## Contenu

La presentation couvre :

- le contexte du projet ;
- les objectifs ;
- l'architecture carte/terminal/simulateur ;
- les fonctionnalites ;
- le protocole APDU ;
- la securite du PIN ;
- le ticket de paiement ;
- le scenario de demonstration ;
- les limites et ameliorations possibles.

## Generation du PDF

Installer d'abord une distribution LaTeX :

- MiKTeX : https://miktex.org/
- TeX Live : https://www.tug.org/texlive/

Ensuite, depuis la racine du projet, lancer :

```bat
generer-presentation.bat
```

Le PDF sera genere ici :

```text
docs\presentation.pdf
```

## Compilation manuelle

Si vous preferez compiler manuellement :

```bat
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=docs docs\presentation.tex
pdflatex -interaction=nonstopmode -halt-on-error -output-directory=docs docs\presentation.tex
```
