@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install-MFC.ps1" %*
pause
