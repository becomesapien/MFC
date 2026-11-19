<#
  Megumax's FFXIV Config (MFC) installer.

  - Backs up FFXIV.cfg and every character folder it touches BEFORE changing anything.
  - Copies the files in "Manual Installation\CharacterData" into the character folders you choose.
  - System settings (FFXIV.cfg): by default only MFC's UI size is applied, so your graphics,
    sound, language and window settings stay yours. You can also keep it untouched or replace it fully.
  - Restore a backup at any time with Restore-MFC.ps1.

  Double-click Install-MFC.bat, or run:  powershell -ExecutionPolicy Bypass -File .\Install-MFC.ps1
#>
[CmdletBinding()]
param(
    [string]$GameConfigPath,          # override for testing / unusual Documents locations
    [switch]$AllCharacters,           # non-interactive: install to every character
    [ValidateSet('Ask', 'Keep', 'UiOnly', 'Replace')]
    [string]$SystemConfig = 'Ask'
)
$ErrorActionPreference = 'Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$payload = Join-Path $here 'Manual Installation'
$charData = Join-Path $payload 'CharacterData'
$gameProcesses = 'ffxiv_dx11', 'ffxivboot', 'ffxivboot64', 'ffxivlauncher', 'ffxivlauncher64', 'XIVLauncher'
$uiKeys = 'UiBaseScale', 'UiHighScale', 'UiSystemEnlarge', 'UiAssetType'

function Find-GameConfig {
    $docs = [Environment]::GetFolderPath('MyDocuments')
    $candidates = @(
        (Join-Path $docs 'My Games\FINAL FANTASY XIV - A Realm Reborn'),
        (Join-Path $env:USERPROFILE 'Documents\My Games\FINAL FANTASY XIV - A Realm Reborn'),
        (Join-Path $env:USERPROFILE 'OneDrive\Documents\My Games\FINAL FANTASY XIV - A Realm Reborn')
    )
    foreach ($c in $candidates) { if (Test-Path (Join-Path $c 'FFXIV.cfg')) { return $c } }
    return $null
}

function Merge-UiSettings([string]$target, [string]$source) {
    $src = @{}
    foreach ($line in Get-Content -LiteralPath $source) {
        $k, $v = $line -split "`t", 2
        if ($uiKeys -contains $k) { $src[$k] = $v }
    }
    $lines = Get-Content -LiteralPath $target
    $out = foreach ($line in $lines) {
        $k = ($line -split "`t", 2)[0]
        if ($src.ContainsKey($k)) { "$k`t$($src[$k])" } else { $line }
    }
    [IO.File]::WriteAllLines($target, [string[]]$out)
}

Write-Host "`n=== Megumax's FFXIV Config (MFC) installer ===`n"
if (-not (Test-Path (Join-Path $charData 'HOTBAR.DAT'))) { throw "Can't find '$charData'. Run this from the unzipped MFC folder." }
if (Get-Process -Name $gameProcesses -ErrorAction SilentlyContinue) {
    throw 'FINAL FANTASY XIV (or its launcher) is running. Close it completely, then run the installer again.'
}
if (-not $GameConfigPath) { $GameConfigPath = Find-GameConfig }
if (-not $GameConfigPath -or -not (Test-Path $GameConfigPath)) {
    throw "Couldn't find 'Documents\My Games\FINAL FANTASY XIV - A Realm Reborn'. Start the game once and log in to a character, or pass -GameConfigPath."
}
Write-Host "Game settings folder: $GameConfigPath"

# "last played" = newest file the game saved inside each character folder (more reliable than the folder date)
$chars = @(Get-ChildItem -Path $GameConfigPath -Directory -Filter 'FFXIV_CHR*' | ForEach-Object {
        $newest = Get-ChildItem -Path $_.FullName -File -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
        $when = if ($newest) { $newest.LastWriteTime } else { $_.LastWriteTime }
        $_ | Add-Member -NotePropertyName LastPlayed -NotePropertyValue $when -PassThru
    } | Sort-Object LastPlayed -Descending)
if ($chars.Count -eq 0) { throw 'No character folders (FFXIV_CHR...) found. Log in to each character once first, then run the installer.' }

if ($AllCharacters) {
    $selected = $chars
} else {
    Write-Host "`nCharacter folders, most recently played first."
    Write-Host "(Tip: the game names these by character ID. Log in to the character you want last, so it is [1].)"
    for ($i = 0; $i -lt $chars.Count; $i++) {
        Write-Host ("  [{0}] {1}   (last played {2:yyyy-MM-dd HH:mm})" -f ($i + 1), $chars[$i].Name, $chars[$i].LastPlayed)
    }
    Write-Host '  [A] All of them'
    $ans = Read-Host "`nInstall to which character(s)? Enter numbers separated by commas, or A"
    if ($ans -match '^\s*[aA]\s*$') { $selected = $chars }
    else {
        $idx = $ans -split '[,\s]+' | Where-Object { $_ -match '^\d+$' } | ForEach-Object { [int]$_ - 1 }
        $selected = @($idx | Where-Object { $_ -ge 0 -and $_ -lt $chars.Count } | Sort-Object -Unique | ForEach-Object { $chars[$_] })
    }
    if ($selected.Count -eq 0) { throw 'Nothing selected, nothing changed.' }
}

$mode = $SystemConfig
if ($mode -eq 'Ask') {
    Write-Host "`nSystem settings (FFXIV.cfg) are shared by every character on this PC."
    Write-Host '  [1] Apply only MFC''s UI size, so the HUD fits as designed  (recommended)'
    Write-Host '  [2] Keep this PC''s FFXIV.cfg exactly as it is'
    Write-Host '  [3] Replace it with MFC''s full system settings (graphics, sound, 2560x1600 borderless window...)'
    $c = Read-Host 'Choose 1, 2 or 3 [1]'
    $mode = switch ($c) { '2' { 'Keep' } '3' { 'Replace' } default { 'UiOnly' } }
}

# ---- backup first ----
$stamp = Get-Date -Format 'yyyy-MM-dd HHmmss'
$backup = Join-Path (Split-Path $GameConfigPath -Parent) "MFC Backup $stamp"
New-Item -ItemType Directory -Path $backup -Force | Out-Null
Copy-Item (Join-Path $GameConfigPath 'FFXIV.cfg') $backup -Force
foreach ($c in $selected) { Copy-Item $c.FullName (Join-Path $backup $c.Name) -Recurse -Force }
"Backup made by the MFC installer on $stamp from: $GameConfigPath`r`nRestore with Restore-MFC.ps1 (or copy these folders/files back with the game closed)." |
    Set-Content -Path (Join-Path $backup 'README.txt') -Encoding UTF8
Write-Host "`nBackup saved to: $backup"

# ---- install ----
$files = Get-ChildItem -Path $charData -File
foreach ($c in $selected) {
    foreach ($f in $files) { Copy-Item $f.FullName (Join-Path $c.FullName $f.Name) -Force }
    Write-Host ("Installed to {0} ({1} files)" -f $c.Name, $files.Count)
}
$cfg = Join-Path $GameConfigPath 'FFXIV.cfg'
switch ($mode) {
    'Replace' { Copy-Item (Join-Path $payload 'FFXIV.cfg') $cfg -Force; Write-Host 'Replaced FFXIV.cfg with MFC''s system settings' }
    'UiOnly'  { Merge-UiSettings $cfg (Join-Path $payload 'FFXIV.cfg'); Write-Host 'Applied MFC''s UI size to FFXIV.cfg (everything else kept)' }
    default   { Write-Host 'FFXIV.cfg left unchanged' }
}

Write-Host "`nDone! Start the game. If the HUD looks off on your screen size, press CTRL+NUMPAD0 to open HUD Layout and drag things into place."
Write-Host "Undo any time: close the game and run Restore-MFC.bat`n"
