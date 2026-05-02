@echo off
chcp 65001 >nul
echo ==========================================
echo  Blocage de ai.exe pour Microsoft Office
echo  (Outlook, Word, Excel, PowerPoint...)
echo ==========================================
echo.

:: Vérification droits administrateur
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ERREUR : Ce script doit être exécuté en tant qu'administrateur.
    echo Cliquez droit sur le fichier .bat → "Exécuter en tant qu'administrateur"
    pause
    exit /b 1
)

echo [1/2] Création de la clé IFEO pour bloquer ai.exe...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ai.exe" /v "Debugger" /t REG_SZ /d "systray.exe" /f >nul 2>&1
if %errorlevel% equ 0 (
    echo       ✓ ai.exe bloqué avec succès
) else (
    echo       ✗ Échec du blocage (erreur registre)
)

echo.
echo [2/2] Vérification...
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ai.exe" >nul 2>&1
if %errorlevel% equ 0 (
    echo       ✓ Clé IFEO confirmée dans le registre
) else (
    echo       ✗ Clé non trouvée
)

echo.
echo ==========================================
echo  REDÉMARRAGE REQUIS
echo ==========================================
echo Fermez et rouvrez Word/Outlook pour appliquer.
echo.
echo Pour annuler ce blocage, exécutez :
echo   reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ai.exe" /f
echo.
pause
