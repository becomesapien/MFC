#!/bin/bash
# Restores a backup made by Install-MFC-Mac.command ("MFC Backup ..." folders next to your FFXIV settings folder).
# The current state is saved first as "MFC Backup <time> (pre-restore)", so a restore can itself be undone.
# Double-click this file (first time: right-click > Open), or run:  bash Restore-MFC-Mac.command [--backup "<folder>"]
set -u
MFCFILES="ADDON.DAT COMMON.DAT CONTROL0.DAT CONTROL1.DAT HOTBAR.DAT KEYBIND.DAT LOGFLTR.DAT MACRO.DAT"
die() { echo; echo "ERROR: $*"; echo "Nothing was changed."; echo; exit 1; }

BACKUP=""
while [ $# -gt 0 ]; do
  case "$1" in --backup) BACKUP="${2:-}"; shift 2 ;; *) echo "Unknown option: $1"; exit 1 ;; esac
done

if pgrep -if "ffxiv_dx11|ffxivboot|ffxivlauncher|XIV on Mac|FINAL FANTASY XIV" >/dev/null 2>&1; then
  die "FINAL FANTASY XIV, its launcher or XIV on Mac is running. Quit it completely (Cmd+Q) first."
fi

if [ -z "$BACKUP" ]; then
  LIST=""
  for root in "$HOME/Documents/My Games" "$HOME/Library/Application Support/XIV on Mac"; do
    for b in "$root"/MFC\ Backup\ *; do [ -f "$b/GAME_PATH.txt" ] && LIST="$LIST$b
"; done
  done
  LIST="$(printf '%s' "$LIST" | awk 'NF' | sort -r)"
  [ -n "$LIST" ] || die "No \"MFC Backup ...\" folders found. Run with --backup \"<backup folder>\"."
  i=1
  while IFS= read -r b; do echo "  [$i] $(basename "$b")   (for: $(cat "$b/GAME_PATH.txt"))"; i=$((i+1)); done <<EOF
$LIST
EOF
  printf "Restore which backup? (number) "; read -r pick
  case "$pick" in ''|*[!0-9]*) die "Invalid choice." ;; esac
  BACKUP="$(printf '%s\n' "$LIST" | sed -n "${pick}p")"
  [ -n "$BACKUP" ] || die "Invalid choice."
fi
[ -f "$BACKUP/GAME_PATH.txt" ] && [ -f "$BACKUP/FFXIV.cfg" ] || die "'$BACKUP' doesn't look like an MFC backup."
GAME="$(head -n 1 "$BACKUP/GAME_PATH.txt")"
[ -d "$GAME" ] || die "The game settings folder '$GAME' no longer exists."

# save the current state first
PRE="$(dirname "$GAME")/MFC Backup $(date '+%Y-%m-%d %H%M%S') (pre-restore)"
mkdir -p "$PRE" || die "Couldn't create '$PRE'."
printf '%s\n' "$GAME" > "$PRE/GAME_PATH.txt"
cp -p "$GAME/FFXIV.cfg" "$PRE/" || die "Couldn't save the current FFXIV.cfg."
for d in "$BACKUP"/FFXIV_CHR*; do
  [ -d "$d" ] || continue
  name="$(basename "$d")"
  [ -d "$GAME/$name" ] && { cp -Rp "$GAME/$name" "$PRE/$name" || die "Couldn't save the current $name."; }
done
echo "Current state saved to: $PRE"

cp -p "$BACKUP/FFXIV.cfg" "$GAME/FFXIV.cfg"
for d in "$BACKUP"/FFXIV_CHR*; do
  [ -d "$d" ] || continue
  name="$(basename "$d")"
  mkdir -p "$GAME/$name"
  for f in "$d"/*; do [ -f "$f" ] && cp -p "$f" "$GAME/$name/"; done
  # files the installer added that did not exist before (only MFC's own file names, never anything else)
  for m in $MFCFILES; do
    [ ! -e "$d/$m" ] && [ -e "$GAME/$name/$m" ] && rm -f "$GAME/$name/$m"
  done
  echo "Restored $name"
done
echo "Restored FFXIV.cfg and the character folders from: $BACKUP"
echo
