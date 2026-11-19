@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0Restore-MFC.ps1" %*
pause
