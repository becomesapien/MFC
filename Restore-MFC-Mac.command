#!/bin/bash
# Restores a backup made by Install-MFC-Mac.command.
# The current state is saved first as "MFC Backup <time> (pre-restore)", so a restore can itself be undone.
#
# Run it: double-click. If macOS blocks it the first time ("Apple could not verify..."):
#   macOS 15+: click Done, then System Settings > Privacy & Security > Open Anyway, and double-click again.
#   macOS 14 and older: right-click > Open > Open.
#   Any macOS: open Terminal, type "bash " (with a space), drag this file into the window, press Return.
# Options: --backup "<MFC Backup folder>"
[ -n "${BASH_VERSION:-}" ] || exec /bin/bash "$0" "$@"
set -u
NL='
'
MFCFILES="ADDON.DAT COMMON.DAT CONTROL0.DAT CONTROL1.DAT HOTBAR.DAT KEYBIND.DAT LOGFLTR.DAT MACRO.DAT"
INDEX="$HOME/Library/Application Support/MFC/backups.txt"

pause() { if [ -t 0 ] && [ -t 1 ]; then echo; printf 'Press Return to close this window...'; read -r _ || true; fi; }
trap pause EXIT
die() { echo; echo "ERROR: $*"; echo "Nothing was changed."; exit 1; }
game_running() { pgrep -if 'ffxiv_dx11|ffxivboot|ffxivlauncher|XIV on Mac|FINAL FANTASY XIV' 2>/dev/null | grep -vx "$$" | grep -q .; }
is_backup() { [ -f "$1/GAME_PATH.txt" ] && [ -f "$1/FFXIV.cfg" ] && ls -d "$1"/FFXIV_CHR* >/dev/null 2>&1; }

BACKUP=""
while [ $# -gt 0 ]; do
  case "$1" in
    --backup) [ $# -ge 2 ] || die "--backup needs a folder."; BACKUP="$2"; shift 2 ;;
    *) die "Unknown option: $1" ;;
  esac
done
if [ -n "$BACKUP" ]; then BACKUP="$(cd "$BACKUP" 2>/dev/null && pwd -P)" || die "--backup folder not found."; fi

game_running && die "FINAL FANTASY XIV, its launcher or XIV on Mac is still running. Quit it completely (Cmd+Q). If you just quit, wait 10 seconds and try again."

if [ -z "$BACKUP" ]; then
  LIST=""
  add() { case "$NL$LIST" in *"$NL$1$NL"*) ;; *) is_backup "$1" && LIST="$LIST$1$NL" ;; esac; }
  # backups recorded by the installer, plus the usual places
  if [ -f "$INDEX" ]; then while IFS= read -r b; do [ -n "$b" ] && add "$b"; done < "$INDEX"; fi
  for root in "$HOME/Documents/My Games" \
              "$HOME/Library/Application Support/XIV on Mac" \
              "$HOME/Library/Application Support/FINAL FANTASY XIV ONLINE/Bottles/published_Final_Fantasy/drive_c/users/crossover/My Documents/My Games"; do
    for b in "$root"/MFC\ Backup\ *; do [ -d "$b" ] && add "$(cd "$b" && pwd -P)"; done
  done
  # newest first: sort on the folder name (it starts with the date and time)
  LIST="$(printf '%s' "$LIST" | awk 'NF' | awk -F/ '{print $NF "\t" $0}' | sort -r | cut -f2-)"
  [ -n "$LIST" ] || die "No \"MFC Backup ...\" folders found. Run with --backup \"<backup folder>\"."
  i=1
  while IFS= read -r b; do echo "  [$i] $(basename "$b")"; echo "      for: $(head -n 1 "$b/GAME_PATH.txt")"; i=$((i+1)); done <<EOF
$LIST
EOF
  printf "Restore which backup? (number) "; read -r pick
  case "$pick" in ''|*[!0-9]*) die "Invalid choice." ;; esac
  BACKUP="$(printf '%s\n' "$LIST" | sed -n "${pick}p")"
  [ -n "$BACKUP" ] || die "Invalid choice."
fi
is_backup "$BACKUP" || die "'$BACKUP' doesn't look like a complete MFC backup."
GAME="$(head -n 1 "$BACKUP/GAME_PATH.txt")"
[ -d "$GAME" ] || die "The game settings folder '$GAME' no longer exists."
echo "Restoring: $BACKUP"
echo "Into:      $GAME"

# save the current state first (unique folder)
base="$(dirname "$GAME")/MFC Backup $(date '+%Y-%m-%d %H%M%S') (pre-restore)"
PRE="$base"; k=1
while ! mkdir "$PRE" 2>/dev/null; do
  [ -e "$PRE" ] || die "Couldn't create '$PRE'."
  k=$((k+1)); PRE="$base ($k)"
done
cp -p "$GAME/FFXIV.cfg" "$PRE/" || { rm -rf "$PRE"; die "Couldn't save the current FFXIV.cfg."; }
for d in "$BACKUP"/FFXIV_CHR*; do
  [ -d "$d" ] || continue
  name="$(basename "$d")"
  if [ -d "$GAME/$name" ]; then cp -Rp "$GAME/$name" "$PRE/$name" || { rm -rf "$PRE"; die "Couldn't save the current $name."; }; fi
done
printf '%s\n' "$GAME" > "$PRE/GAME_PATH.txt"
mkdir -p "$(dirname "$INDEX")" 2>/dev/null && printf '%s\n' "$PRE" >> "$INDEX"
echo "Current state saved to: $PRE"

ERR=0
cat "$BACKUP/FFXIV.cfg" > "$GAME/FFXIV.cfg" || { echo "FAILED: FFXIV.cfg"; ERR=1; }
for d in "$BACKUP"/FFXIV_CHR*; do
  [ -d "$d" ] || continue
  name="$(basename "$d")"
  mkdir -p "$GAME/$name" || { echo "FAILED: $name"; ERR=1; continue; }
  for f in "$d"/*; do
    [ -f "$f" ] || continue
    cp -p "$f" "$GAME/$name/" || { echo "FAILED: $name/$(basename "$f")"; ERR=1; }
  done
  # files the installer added that did not exist before (only MFC's own file names, never anything else)
  for m in $MFCFILES; do
    if [ ! -e "$d/$m" ] && [ -e "$GAME/$name/$m" ]; then rm -f "$GAME/$name/$m" || { echo "FAILED: removing $name/$m"; ERR=1; }; fi
  done
  echo "Restored $name"
done
if [ "$ERR" -ne 0 ]; then
  echo; echo "Some files could not be restored (see FAILED lines above). Nothing is lost: your state from just before this restore is in '$PRE'."
  exit 1
fi
echo "Restored FFXIV.cfg and the character folders from: $BACKUP"
