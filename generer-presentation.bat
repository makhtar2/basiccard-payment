@echo off
setlocal

echo --- GENERATION DE LA PRESENTATION PDF ---

where pdflatex > nul 2> nul
if errorlevel 1 (
    echo Erreur : pdflatex est introuvable.
    echo Installez MiKTeX ou TeX Live, puis relancez ce script.
    pause
    exit /b 1
)

if not exist docs (
    echo Erreur : dossier docs introuvable.
    pause
    exit /b 1
)

pdflatex -interaction=nonstopmode -halt-on-error -output-directory=docs docs\presentation.tex
if errorlevel 1 (
    echo Erreur pendant la generation du PDF.
    pause
    exit /b 1
)

pdflatex -interaction=nonstopmode -halt-on-error -output-directory=docs docs\presentation.tex
if errorlevel 1 (
    echo Erreur pendant la deuxieme passe PDF.
    pause
    exit /b 1
)

echo.
echo Presentation generee :
echo   docs\presentation.pdf
pause
