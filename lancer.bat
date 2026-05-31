@echo off
setlocal

set "BC_PATH=C:\Program Files (x86)\BasicCardV7"

echo --- LANCEMENT DE LA SIMULATION BASICCARD ---

if not exist "%BC_PATH%\ZCMSim.exe" (
    echo Erreur : simulateur BasicCard introuvable dans "%BC_PATH%".
    echo Modifiez BC_PATH dans lancer.bat si BasicCard est installe ailleurs.
    pause
    exit /b 1
)

if not exist bin\MaCarte.img (
    echo Erreur : bin\MaCarte.img est introuvable.
    echo Lancez d'abord compiler.bat.
    pause
    exit /b 1
)

if not exist bin\MonTerminal.img (
    echo Erreur : bin\MonTerminal.img est introuvable.
    echo Lancez d'abord compiler.bat.
    pause
    exit /b 1
)

echo Demarrage du simulateur avec la carte et le terminal...
pushd bin
"%BC_PATH%\ZCMSim.exe" -P201 -CMaCarte MonTerminal.img
popd

echo.
echo Simulation terminee.
pause
