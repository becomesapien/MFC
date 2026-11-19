#!/bin/bash
# Megumax's FFXIV Config (MFC) installer for macOS.
#  - Works with Square Enix's Mac client and with XIV on Mac.
#  - Backs up FFXIV.cfg and every character folder it touches BEFORE changing anything.
#  - Copies "Manual Installation/CharacterData" into the character folders you choose.
#  - System settings (FFXIV.cfg): by default only MFC's UI size is applied.
#  - Undo any time with Restore-MFC-Mac.command.
#
# Run it: double-click. If macOS blocks it the first time ("Apple could not verify..."):
#   macOS 15+: click Done, then System Settings > Privacy & Security > Open Anyway, and double-click again.
#   macOS 14 and older: right-click > Open > Open.
#   Any macOS: open Terminal, type "bash " (with a space), drag this file into the window, press Return.
# Options: --path "<folder that contains FFXIV.cfg>"   --all   --system ask|keep|uionly|replace   --yes
[ -n "${BASH_VERSION:-}" ] || exec /bin/bash "$0" "$@"
set -u
TAB=$(printf '\t')
NL='
'
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd -P)"
PAYLOAD="$SCRIPT_DIR/Manual Installation"
CHARDATA="$PAYLOAD/CharacterData"
UIKEYS="UiBaseScale UiHighScale UiSystemEnlarge UiAssetType"
INDEX_DIR="$HOME/Library/Application Support/MFC"
BACKUP=""

pause() { if [ -t 0 ] && [ -t 1 ]; then echo; printf 'Press Return to close this window...'; read -r _ || true; fi; }
trap pause EXIT
die()  { echo; echo "ERROR: $*"; echo "Nothing was changed."; exit 1; }
fail() { echo; echo "ERROR: $*"; echo "Some files WERE changed. Quit the game, then double-click Restore-MFC-Mac.command"
         echo "and choose the backup '$(basename "$BACKUP")' to undo everything."; exit 1; }
mtime() { perl -e '@s = stat($ARGV[0]); print(($s[9] || 0), "\n")' "$1" 2>/dev/null || /usr/bin/stat -f %m "$1" 2>/dev/null || echo 0; }
fmtdate() { perl -e '@t = localtime($ARGV[0]); printf("%04d-%02d-%02d %02d:%02d\n", $t[5]+1900, $t[4]+1, $t[3], $t[2], $t[1])' "$1" 2>/dev/null || echo "$1"; }
num() { case "$1" in ''|*[!0-9]*) echo 0 ;; *) echo "$1" ;; esac; }
game_running() { pgrep -if 'ffxiv_dx11|ffxivboot|ffxivlauncher|XIV on Mac|FINAL FANTASY XIV' 2>/dev/null | grep -vx "$$" | grep -q .; }

# ---- options (parsed before anything else, relative paths resolved against where you ran it) ----
GAME=""; ALL=0; SYSMODE="ask"; YES=0
while [ $# -gt 0 ]; do
  case "$1" in
    --path)   [ $# -ge 2 ] || die "--path needs a folder."; GAME="$2"; shift 2 ;;
    --system) [ $# -ge 2 ] || die "--system needs ask, keep, uionly or replace."; SYSMODE="$2"; shift 2 ;;
    --all) ALL=1; shift ;;
    --yes) YES=1; shift ;;
    *) die "Unknown option: $1" ;;
  esac
done
case "$SYSMODE" in ask|keep|uionly|replace) ;; *) die "--system must be ask, keep, uionly or replace." ;; esac
if [ -n "$GAME" ]; then GAME="$(cd "$GAME" 2>/dev/null && pwd -P)" || die "--path folder not found."; fi

echo
echo "=== Megumax's FFXIV Config (MFC) installer for Mac ==="
echo
[ -f "$CHARDATA/HOTBAR.DAT" ] || die "Can't find '$CHARDATA'. Run this from the unzipped MFC folder."
game_running && die "FINAL FANTASY XIV, its launcher or XIV on Mac is still running. Quit it completely (Cmd+Q). If you just quit, wait 10 seconds and try again."

# ---- find the game settings folder ----
newest_char() {   # newest file time inside any FFXIV_CHR* folder of $1
  local best=0 c f t
  for c in "$1"/FFXIV_CHR*; do [ -d "$c" ] || continue
    for f in "$c"/*; do [ -f "$f" ] || continue; t=$(num "$(mtime "$f")"); [ "$t" -gt "$best" ] && best=$t; done
  done
  echo "$best"
}
if [ -z "$GAME" ]; then
  if ! ls "$HOME/Documents" >/dev/null 2>&1; then
    echo "Note: Terminal can't read your Documents folder. If the game folder isn't found, allow it in"
    echo "System Settings > Privacy & Security > Files and Folders > Terminal > Documents Folder, then run this again."
  fi
  CANDS=""
  add_cand() {
    local d="$1" real
    case "$d" in *"/MFC Backup "*) return ;; esac
    [ -f "$d/FFXIV.cfg" ] || return
    real="$(cd "$d" 2>/dev/null && pwd -P)" || return
    case "$NL$CANDS" in *"$NL$real$NL"*) return ;; esac
    CANDS="$CANDS$real$NL"
  }
  SE_BOTTLE="$HOME/Library/Application Support/FINAL FANTASY XIV ONLINE/Bottles/published_Final_Fantasy/drive_c/users/crossover/My Documents/My Games/FINAL FANTASY XIV - A Realm Reborn"
  add_cand "$SE_BOTTLE"
  add_cand "$HOME/Documents/My Games/FINAL FANTASY XIV - A Realm Reborn"
  add_cand "$HOME/Library/Application Support/XIV on Mac/ffxivConfig"
  # search only the game's own folders (never all of Library/Documents: that triggers macOS privacy prompts)
  for root in "$HOME/Library/Application Support/FINAL FANTASY XIV ONLINE" \
              "$HOME/Library/Application Support/XIV on Mac" \
              "$HOME/Documents/My Games"; do
    [ -d "$root" ] || continue
    FOUND="$(find -L "$root" -maxdepth 12 -name FFXIV.cfg -type f 2>/dev/null)"
    while IFS= read -r cfg; do
      [ -n "$cfg" ] || continue
      d="$(dirname "$cfg")"
      ls -d "$d"/FFXIV_CHR* >/dev/null 2>&1 && add_cand "$d"
    done <<EOF
$FOUND
EOF
  done
  [ -n "$CANDS" ] || die "Couldn't find your FFXIV settings folder. Start the game once and log in to a character, or run with --path \"<folder that contains FFXIV.cfg>\"."
  N=$(printf '%s' "$CANDS" | awk 'NF' | wc -l | tr -d ' ')
  if [ "$N" -eq 1 ]; then
    GAME="$(printf '%s' "$CANDS" | awk 'NF')"
  else
    echo "Found more than one FFXIV settings folder (the one your game uses is usually the most recently played):"
    i=1
    while IFS= read -r d; do
      [ -n "$d" ] || continue
      t=$(newest_char "$d")
      echo "  [$i] $d"; echo "      last played: $( [ "$t" -gt 0 ] && fmtdate "$t" || echo unknown)"
      i=$((i+1))
    done <<EOF
$CANDS
EOF
    printf "Which one does your game use? (number) "; read -r pick
    case "$pick" in ''|*[!0-9]*) die "Invalid choice." ;; esac
    GAME="$(printf '%s' "$CANDS" | awk 'NF' | sed -n "${pick}p")"
    [ -n "$GAME" ] || die "Invalid choice."
  fi
fi
[ -f "$GAME/FFXIV.cfg" ] || die "'$GAME' has no FFXIV.cfg."
echo "Game settings folder: $GAME"

# ---- characters, most recently played first (newest file the game saved inside each folder) ----
LIST=""
for c in "$GAME"/FFXIV_CHR*; do
  [ -d "$c" ] || continue
  newest=0
  for f in "$c"/*; do [ -f "$f" ] || continue; t=$(num "$(mtime "$f")"); [ "$t" -gt "$newest" ] && newest=$t; done
  [ "$newest" -eq 0 ] && newest=$(num "$(mtime "$c")")
  LIST="$LIST$newest$TAB$(basename "$c")$NL"
done
LIST="$(printf '%s' "$LIST" | awk 'NF' | sort -rn)"
[ -n "$LIST" ] || die "No character folders (FFXIV_CHR...) found in '$GAME'. Log in to each character once first."
NCH=$(printf '%s\n' "$LIST" | wc -l | tr -d ' ')

SELECTED=""
if [ "$ALL" -eq 1 ]; then
  SELECTED="$(printf '%s\n' "$LIST" | cut -f2)"
else
  echo
  echo "Character folders, most recently played first."
  echo "(Tip: the game names these by character ID. Log in to the character you want last, so it is [1].)"
  i=1
  while IFS="$TAB" read -r t name; do
    echo "  [$i] $name   (last played $(fmtdate "$t"))"; i=$((i+1))
  done <<EOF
$LIST
EOF
  echo "  [A] All of them"
  echo
  printf "Install to which character(s)? Enter numbers separated by commas, or A: "; read -r ans
  ans="$(printf '%s' "$ans" | tr -d ' ')"
  case "$ans" in
    [aA]) SELECTED="$(printf '%s\n' "$LIST" | cut -f2)" ;;
    *)
      for n in $(printf '%s' "$ans" | tr ',' ' '); do
        case "$n" in ''|*[!0-9]*) echo "  (ignoring '$n': use numbers like 1 or 1,3)"; continue ;; esac
        if [ "$n" -lt 1 ] || [ "$n" -gt "$NCH" ]; then echo "  (ignoring '$n': no such character)"; continue; fi
        name="$(printf '%s\n' "$LIST" | sed -n "${n}p" | cut -f2)"
        printf '%s\n' "$SELECTED" | grep -qxF "$name" || SELECTED="$SELECTED$name$NL"
      done ;;
  esac
  SELECTED="$(printf '%s' "$SELECTED" | awk 'NF')"
fi
[ -n "$SELECTED" ] || die "Nothing selected."

if [ "$SYSMODE" = "ask" ]; then
  echo
  echo "System settings (FFXIV.cfg) are shared by every character on this Mac."
  echo "  [1] Apply only MFC's UI size, so the HUD fits as designed  (recommended)"
  echo "  [2] Keep this Mac's FFXIV.cfg exactly as it is"
  echo "  [3] Replace it with MFC's full system settings (made on a Windows PC: graphics/window settings may not suit a Mac)"
  printf "Choose 1, 2 or 3 [1]: "; read -r c
  case "$c" in 2) SYSMODE="keep" ;; 3) SYSMODE="replace" ;; *) SYSMODE="uionly" ;; esac
fi
if [ "$SYSMODE" = "uionly" ] && ! command -v perl >/dev/null 2>&1; then
  echo "Note: perl isn't available, so FFXIV.cfg will be kept as it is (set the UI size in System Configuration instead)."
  SYSMODE="keep"
fi

# ---- confirm ----
NSEL=$(printf '%s\n' "$SELECTED" | wc -l | tr -d ' ')
echo
echo "About to install MFC into $NSEL character folder(s) in:"
echo "  $GAME"
printf '%s\n' "$SELECTED" | sed 's/^/    /'
echo "Their hotbars, keybinds, macros, HUD, chat tabs and character settings will be replaced (a backup is made first)."
echo "FFXIV.cfg: $SYSMODE"
if [ "$YES" -ne 1 ]; then
  printf "Continue? [y/N] "; read -r ok
  case "$ok" in y|Y|yes|YES) ;; *) die "Cancelled." ;; esac
fi

# ---- pre-flight: everything we will write must be writable ----
while IFS= read -r name; do
  [ -w "$GAME/$name" ] || die "Can't write to '$GAME/$name'."
  for f in "$CHARDATA"/*; do
    t="$GAME/$name/$(basename "$f")"
    [ ! -e "$t" ] || [ -w "$t" ] || die "'$t' is read-only. Make it writable (Finder > Get Info > Sharing & Permissions) and run this again."
  done
done <<EOF
$SELECTED
EOF
if [ "$SYSMODE" != "keep" ]; then [ -w "$GAME/FFXIV.cfg" ] || die "FFXIV.cfg is read-only. Make it writable or choose option [2]."; fi

# ---- backup first (unique folder, GAME_PATH.txt written last = backup complete) ----
STAMP="$(date '+%Y-%m-%d %H%M%S')"
base="$(dirname "$GAME")/MFC Backup $STAMP"
BACKUP="$base"; k=1
while ! mkdir "$BACKUP" 2>/dev/null; do
  [ -e "$BACKUP" ] || die "Couldn't create the backup folder '$BACKUP'."
  k=$((k+1)); BACKUP="$base ($k)"
done
abort_backup() { rm -rf "$BACKUP"; die "$1"; }
cp -p "$GAME/FFXIV.cfg" "$BACKUP/" || abort_backup "Backup of FFXIV.cfg failed."
while IFS= read -r name; do
  cp -Rp "$GAME/$name" "$BACKUP/$name" || abort_backup "Backup of $name failed."
done <<EOF
$SELECTED
EOF
printf 'Backup made by the MFC installer on %s\nRestore with Restore-MFC-Mac.command (or copy these back with the game closed).\n' "$STAMP" > "$BACKUP/README.txt"
printf '%s\n' "$GAME" > "$BACKUP/GAME_PATH.txt" || abort_backup "Couldn't finish the backup."
mkdir -p "$INDEX_DIR" 2>/dev/null && printf '%s\n' "$BACKUP" >> "$INDEX_DIR/backups.txt"
echo
echo "Backup saved to: $BACKUP"

# ---- install ----
NF=$(ls "$CHARDATA" | wc -l | tr -d ' ')
while IFS= read -r name; do
  for f in "$CHARDATA"/*; do
    cp "$f" "$GAME/$name/" || fail "Copying $(basename "$f") into $name failed."
  done
  echo "Installed to $name ($NF files)"
done <<EOF
$SELECTED
EOF

CFG="$GAME/FFXIV.cfg"
case "$SYSMODE" in
  replace)
    cat "$PAYLOAD/FFXIV.cfg" > "$CFG" || fail "Couldn't replace FFXIV.cfg."
    echo "Replaced FFXIV.cfg with MFC's system settings" ;;
  uionly)
    tmp="$(mktemp "${TMPDIR:-/tmp}/mfc-cfg.XXXXXX")" || fail "Couldn't create a temporary file."
    # byte-exact: only the UI-size values change; line endings and every other byte stay as they were
    if MFC_KEYS="$UIKEYS" perl -e '
        my ($src, $dst, $tmp) = @ARGV; my %want = map { $_ => 1 } split / /, $ENV{MFC_KEYS}; my %val;
        open(my $s, "<", $src) or die "src"; binmode $s;
        while (<$s>) { $val{$1} = $2 if /^(\w+)\t([^\r\n]*)/ && $want{$1} }
        close $s;
        open(my $d, "<", $dst) or die "dst"; binmode $d; local $/; my $c = <$d>; close $d;
        my $n = ($c =~ s/^(\w+)\t[^\r\n]*/exists $val{$1} ? "$1\t$val{$1}" : $&/mge);
        my $hit = () = $c =~ /^(?:UiBaseScale|UiHighScale|UiSystemEnlarge|UiAssetType)\t/mg;
        warn "MFC-WARN: only $hit of " . scalar(keys %val) . " UI settings were present in your FFXIV.cfg\n" if $hit < keys %val;
        open(my $o, ">", $tmp) or die "tmp"; binmode $o; print $o $c; close $o or die "tmp";
      ' "$PAYLOAD/FFXIV.cfg" "$CFG" "$tmp" && cat "$tmp" > "$CFG"; then
      rm -f "$tmp"; echo "Applied MFC's UI size to FFXIV.cfg (everything else kept)"
    else
      rm -f "$tmp"; fail "Couldn't update FFXIV.cfg (the character files were installed)."
    fi ;;
  *) echo "FFXIV.cfg left unchanged" ;;
esac

echo
echo "Done! Start the game. If the HUD looks off on your screen, open HUD Layout and drag things into place."
echo "Undo any time: quit the game and double-click Restore-MFC-Mac.command"
