::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFDRaSRzQaDuGIrof/eX+4f6UnmITUfoQaJvS172UJfJd713hFQ==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
title OnexOptimizer - Optimisation complete v1.1
color 0A
setlocal enabledelayedexpansion

:menu
cls
echo ===================================================
echo             OnexOptimizer v1.1 - Menu Principal
echo ===================================================
echo.
echo [1] Optimisation complete du PC
echo [2] Nettoyer les fichiers temporaires
echo [3] Reparer le disque
echo [4] Windows Settings
echo [5] Quitter
echo.
set /p choix="Choisissez une option (1-5) : "

if "%choix%"=="1" goto optim_complete
if "%choix%"=="2" goto nettoyage_temp
if "%choix%"=="3" goto reparer_disque
if "%choix%"=="4" goto windows_settings
if "%choix%"=="5" goto quitter

:optim_complete
cls
echo Optimisation complete en cours...
rem Fermer les processus inutiles
for /f "tokens=1,2 delims= " %%a in ('tasklist ^| findstr "exe"') do (
    if not "%%a"=="explorer.exe" (
        taskkill /f /im %%a >nul 2>&1
    )
)
echo Fermeture des processus inutiles effectuee !

rem Desactivation des animations visuelles de Windows
reg add "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul

rem Desactiver les effets visuels
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewAlphaSelect /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f >nul

echo Desactivation des animations et effets visuels effectuee !

rem Desactiver les applications en arriere-plan
echo Desactivation des applications en arriere-plan...
powershell -Command "Get-AppxPackage | Disable-AppxPackage"

rem Desactiver les services inutiles
echo Desactivation des services inutiles...
sc config wuauserv start= disabled >nul 2>&1  rem Windows Update
sc config SysMain start= disabled >nul 2>&1  rem Superfetch
sc config DiagTrack start= disabled >nul 2>&1  rem Service de suivi de diagnostic

echo Optimisation complete du PC terminee avec succes !
pause
goto menu

:nettoyage_temp
cls
echo Nettoyage des fichiers temporaires en cours...
del /s /q %temp%\*.* >nul 2>&1
rd /s /q %temp% >nul 2>&1
md %temp% >nul 2>&1
echo Fichiers temporaires supprimes avec succes !
pause
goto menu

:reparer_disque
cls
echo Verification et reparation du disque en cours...
echo Cela peut prendre du temps...
chkdsk /f C:
echo Verification terminee !
pause
goto menu

:windows_settings
cls
echo Optimisation des parametres Windows en cours...
rem Optimiser les performances du systeme pour les jeux
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" /v CsEnabled /t REG_DWORD /d 0 /f >nul
powercfg -h off >nul 2>&1

rem Activer le mode de performance maximale
powercfg /s SCHEME_MAX >nul 2>&1

rem Desactiver le mode jeu enregistre de Windows (GameDVR)
reg add "HKEY_CURRENT_USER\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v GameDVR_FSEBehavior /t REG_DWORD /d 2 /f >nul
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v GameDVR_HonorUserFSEBehaviorMode /t REG_DWORD /d 1 /f >nul

rem Desactiver les services inutiles pour Windows
sc config wuauserv start= disabled >nul 2>&1  rem Windows Update
sc config SysMain start= disabled >nul 2>&1  rem Superfetch
sc config DiagTrack start= disabled >nul 2>&1  rem Service de suivi de diagnostic

echo Parametres Windows optimises avec succes !
pause
goto menu

:quitter
cls
echo Merci d'avoir utilise OnexOptimizer v1.1 !
timeout /t 2 >nul
exit

:verification
cls
echo Verification des parametres Windows en cours...
rem Verifier si les animations sont desactivees
for /f "tokens=2*" %%A in ('reg query "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /v MinAnimate') do (
    if "%%B"=="0" (
        echo Animations desactivees : OK
    ) else (
        echo Animations activees : Corrige...
        reg add "HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul
    )
)

rem Verifier si le mode de performance maximale est actif
for /f "tokens=*" %%A in ('powercfg /query SCHEME_CURRENT') do (
    echo %%A | findstr /i "SCHEME_MAX" >nul
    if !errorlevel! == 0 (
        echo Mode performance maximale : OK
    ) else (
        echo Mode performance maximale non actif : Activation...
        powercfg /s SCHEME_MAX >nul
    )
)

echo Verification terminee.
pause
goto menu
