@echo off
setlocal

set "BC_PATH=C:\Program Files (x86)\BasicCardV7"

echo --- COMPILATION DU PROJET BASICCARD ---

if not exist "%BC_PATH%\ZCMBasic.exe" (
    echo Erreur : BasicCardV7 est introuvable dans "%BC_PATH%".
    echo Modifiez BC_PATH dans compiler.bat si BasicCard est installe ailleurs.
    pause
    exit /b 1
)

if not exist bin (
    mkdir bin
)

echo.
echo Compilation de la carte...
"%BC_PATH%\ZCMBasic.exe" src\card\MaCarte.bas -CF"%BC_PATH%\Enh\ZC312_C.zcf" -I"%BC_PATH%\Inc" -OIbin\MaCarte.img -X
if errorlevel 1 (
    echo Erreur lors de la compilation de la carte.
    pause
    exit /b 1
)

echo.
echo Compilation du terminal...
if exist bin\QtCore4.dll attrib -h bin\QtCore4.dll
if exist bin\libgcc_s_dw2-1.dll attrib -h bin\libgcc_s_dw2-1.dll
if exist bin\libstdc++-6.dll attrib -h bin\libstdc++-6.dll
if exist bin\QtCore4.dll del /f /q bin\QtCore4.dll
if exist bin\libgcc_s_dw2-1.dll del /f /q bin\libgcc_s_dw2-1.dll
if exist bin\libstdc++-6.dll del /f /q bin\libstdc++-6.dll
"%BC_PATH%\ZCMBasic.exe" src\terminal\MonTerminal.bas -CT -I"%BC_PATH%\Inc" -I"%BC_PATH%\Lib" -Ebin\MonTerminal.exe -X
if errorlevel 1 (
    echo Erreur lors de la compilation du terminal.
    pause
    exit /b 1
)

echo.
echo Compilation de l'image terminal pour le simulateur...
"%BC_PATH%\ZCMBasic.exe" src\terminal\MonTerminal.bas -CT -I"%BC_PATH%\Inc" -I"%BC_PATH%\Lib" -OIbin\MonTerminal.img -X
if errorlevel 1 (
    echo Erreur lors de la compilation de l'image terminal.
    pause
    exit /b 1
)

echo.
echo Compilation terminee avec succes.
echo Fichiers generes :
echo   bin\MaCarte.img
echo   bin\MonTerminal.exe
echo   bin\MonTerminal.img
pause
