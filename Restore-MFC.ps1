<#
  Restores a backup made by Install-MFC.ps1. Lists the "MFC Backup ..." folders and puts the chosen one back.
  The current state is saved first as "MFC Backup <time> (pre-restore)", so a restore can itself be undone.
  Double-click Restore-MFC.bat, or run:  powershell -ExecutionPolicy Bypass -File .\Restore-MFC.ps1
#>
[CmdletBinding()]
param([string]$GameConfigPath, [string]$BackupPath)
$ErrorActionPreference = 'Stop'
$gameProcesses = 'ffxiv_dx11', 'ffxivboot', 'ffxivboot64', 'ffxivlauncher', 'ffxivlauncher64', 'XIVLauncher'
$mfcFiles = 'ADDON.DAT', 'COMMON.DAT', 'CONTROL0.DAT', 'CONTROL1.DAT', 'HOTBAR.DAT', 'KEYBIND.DAT', 'LOGFLTR.DAT', 'MACRO.DAT'

if (Get-Process -Name $gameProcesses -ErrorAction SilentlyContinue) {
    throw 'FINAL FANTASY XIV (or its launcher) is running. Close it completely first.'
}
if (-not $GameConfigPath) {
    $docs = [Environment]::GetFolderPath('MyDocuments')
    foreach ($c in @((Join-Path $docs 'My Games\FINAL FANTASY XIV - A Realm Reborn'),
                     (Join-Path $env:USERPROFILE 'Documents\My Games\FINAL FANTASY XIV - A Realm Reborn'),
                     (Join-Path $env:USERPROFILE 'OneDrive\Documents\My Games\FINAL FANTASY XIV - A Realm Reborn'))) {
        if (Test-Path (Join-Path $c 'FFXIV.cfg')) { $GameConfigPath = $c; break }
    }
}
if (-not $GameConfigPath) { throw "Couldn't find the FFXIV settings folder; pass -GameConfigPath." }

if (-not $BackupPath) {
    $backups = @(Get-ChildItem -Path (Split-Path $GameConfigPath -Parent) -Directory -Filter 'MFC Backup *' | Sort-Object Name -Descending)
    if ($backups.Count -eq 0) { throw 'No "MFC Backup ..." folders found.' }
    for ($i = 0; $i -lt $backups.Count; $i++) { Write-Host ("  [{0}] {1}" -f ($i + 1), $backups[$i].Name) }
    $ans = Read-Host 'Restore which backup? (number)'
    if ($ans -notmatch '^\d+$' -or [int]$ans -lt 1 -or [int]$ans -gt $backups.Count) { throw 'Invalid choice, nothing changed.' }
    $BackupPath = $backups[[int]$ans - 1].FullName
}
$chars = @(Get-ChildItem -Path $BackupPath -Directory -Filter 'FFXIV_CHR*')
if (-not (Test-Path (Join-Path $BackupPath 'FFXIV.cfg')) -or $chars.Count -eq 0) { throw "'$BackupPath' doesn't look like an MFC backup." }

# save the current state first
$pre = Join-Path (Split-Path $GameConfigPath -Parent) ("MFC Backup {0} (pre-restore)" -f (Get-Date -Format 'yyyy-MM-dd HHmmss'))
New-Item -ItemType Directory -Path $pre -Force | Out-Null
Copy-Item (Join-Path $GameConfigPath 'FFXIV.cfg') $pre -Force
foreach ($d in $chars) {
    $cur = Join-Path $GameConfigPath $d.Name
    if (Test-Path $cur) { Copy-Item $cur (Join-Path $pre $d.Name) -Recurse -Force }
}
Write-Host "Current state saved to: $pre"

Copy-Item (Join-Path $BackupPath 'FFXIV.cfg') (Join-Path $GameConfigPath 'FFXIV.cfg') -Force
foreach ($d in $chars) {
    $dest = Join-Path $GameConfigPath $d.Name
    New-Item -ItemType Directory -Path $dest -Force | Out-Null
    Get-ChildItem -Path $d.FullName -File | ForEach-Object { Copy-Item $_.FullName (Join-Path $dest $_.Name) -Force }
    # files the installer added that did not exist before (only MFC's own file names, never anything else)
    foreach ($name in $mfcFiles) {
        if (-not (Test-Path (Join-Path $d.FullName $name)) -and (Test-Path (Join-Path $dest $name))) { Remove-Item (Join-Path $dest $name) -Force }
    }
    Write-Host "Restored $($d.Name)"
}
Write-Host "Restored FFXIV.cfg and the character folders from: $BackupPath"
