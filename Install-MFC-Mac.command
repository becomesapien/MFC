#!/bin/bash
# Megumax's FFXIV Config (MFC) installer for macOS.
#  - Works with Square Enix's Mac client and with XIV on Mac.
#  - Backs up FFXIV.cfg and every character folder it touches BEFORE changing anything.
#  - Copies "Manual Installation/CharacterData" into the character folders you choose.
#  - System settings (FFXIV.cfg): by default only MFC's UI size is applied.
#  - Undo any time with Restore-MFC-Mac.command.
# Double-click this file (first time: right-click > Open), or run:  bash Install-MFC-Mac.command
# Options: --path "<folder with FFXIV.cfg>"   --all   --system ask|keep|uionly|replace
set -u
cd "$(dirname "$0")" || exit 1
HERE="$(pwd)"
PAYLOAD="$HERE/Manual Installation"
CHARDATA="$PAYLOAD/CharacterData"
UIKEYS="UiBaseScale UiHighScale UiSystemEnlarge UiAssetType"

GAME=""; ALL=0; SYSMODE="ask"
while [ $# -gt 0 ]; do
  case "$1" in
    --path) GAME="${2:-}"; shift 2 ;;
    --all) ALL=1; shift ;;
    --system) SYSMODE="${2:-ask}"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

die() { echo; echo "ERROR: $*"; echo "Nothing was changed."; echo; exit 1; }
mtime() { stat -f %m "$1" 2>/dev/null || stat -c %Y "$1" 2>/dev/null || echo 0; }
fmtdate() { date -r "$1" '+%Y-%m-%d %H:%M' 2>/dev/null || date -d "@$1" '+%Y-%m-%d %H:%M' 2>/dev/null || echo "$1"; }

echo
echo "=== Megumax's FFXIV Config (MFC) installer for Mac ==="
echo
[ -f "$CHARDATA/HOTBAR.DAT" ] || die "Can't find '$CHARDATA'. Run this from the unzipped MFC folder."
if pgrep -if "ffxiv_dx11|ffxivboot|ffxivlauncher|XIV on Mac|FINAL FANTASY XIV" >/dev/null 2>&1; then
  die "FINAL FANTASY XIV, its launcher or XIV on Mac is running. Quit it completely (Cmd+Q), then run this again."
fi

# ---- find the game settings folder ----
if [ -z "$GAME" ]; then
  CANDS=""
  for d in "$HOME/Documents/My Games/FINAL FANTASY XIV - A Realm Reborn" \
           "$HOME/Library/Application Support/XIV on Mac/ffxivConfig"; do
    [ -f "$d/FFXIV.cfg" ] && CANDS="$CANDS$d
"
  done
  if [ -z "$CANDS" ]; then
    echo "Searching for your FFXIV settings folder..."
    for root in "$HOME/Library/Application Support" "$HOME/Documents"; do
      [ -d "$root" ] || continue
      while IFS= read -r cfg; do
        d="$(dirname "$cfg")"
        ls -d "$d"/FFXIV_CHR* >/dev/null 2>&1 && CANDS="$CANDS$d
"
      done < <(find "$root" -maxdepth 9 -name FFXIV.cfg -type f 2>/dev/null)
    done
  fi
  CANDS="$(printf '%s' "$CANDS" | awk 'NF && !seen[$0]++')"
  [ -n "$CANDS" ] || die "Couldn't find your FFXIV settings folder. Start the game once and log in to a character, or run with --path \"<folder that contains FFXIV.cfg>\"."
  N=$(printf '%s\n' "$CANDS" | wc -l | tr -d ' ')
  if [ "$N" -eq 1 ]; then
    GAME="$CANDS"
  else
    echo "Found more than one FFXIV settings folder:"
    i=1; printf '%s\n' "$CANDS" | while IFS= read -r d; do echo "  [$i] $d"; i=$((i+1)); done
    printf "Which one does your game use? (number) "; read -r pick
    case "$pick" in ''|*[!0-9]*) die "Invalid choice." ;; esac
    GAME="$(printf '%s\n' "$CANDS" | sed -n "${pick}p")"
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
  for f in "$c"/*; do [ -f "$f" ] || continue; t=$(mtime "$f"); [ "$t" -gt "$newest" ] && newest=$t; done
  [ "$newest" -eq 0 ] && newest=$(mtime "$c")
  LIST="$LIST$newest	$(basename "$c")
"
done
LIST="$(printf '%s' "$LIST" | awk 'NF' | sort -rn)"
[ -n "$LIST" ] || die "No character folders (FFXIV_CHR...) found. Log in to each character once first."
NCH=$(printf '%s\n' "$LIST" | wc -l | tr -d ' ')

SELECTED=""
if [ "$ALL" -eq 1 ]; then
  SELECTED="$(printf '%s\n' "$LIST" | cut -f2)"
else
  echo
  echo "Character folders, most recently played first."
  echo "(Tip: the game names these by character ID. Log in to the character you want last, so it is [1].)"
  i=1
  while IFS="	" read -r t name; do
    echo "  [$i] $name   (last played $(fmtdate "$t"))"; i=$((i+1))
  done <<EOF
$LIST
EOF
  echo "  [A] All of them"
  echo
  printf "Install to which character(s)? Enter numbers separated by commas, or A: "; read -r ans
  case "$ans" in
    [aA]|" "[aA]|[aA]" ") SELECTED="$(printf '%s\n' "$LIST" | cut -f2)" ;;
    *)
      for n in $(printf '%s' "$ans" | tr ', ' '\n\n'); do
        case "$n" in ''|*[!0-9]*) continue ;; esac
        [ "$n" -ge 1 ] && [ "$n" -le "$NCH" ] || continue
        name="$(printf '%s\n' "$LIST" | sed -n "${n}p" | cut -f2)"
        printf '%s\n' "$SELECTED" | grep -qx "$name" || SELECTED="$SELECTED$name
"
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

# ---- backup first ----
STAMP="$(date '+%Y-%m-%d %H%M%S')"
BACKUP="$(dirname "$GAME")/MFC Backup $STAMP"
mkdir -p "$BACKUP" || die "Couldn't create the backup folder '$BACKUP'."
printf '%s\n' "$GAME" > "$BACKUP/GAME_PATH.txt"
cp -p "$GAME/FFXIV.cfg" "$BACKUP/" || die "Backup of FFXIV.cfg failed."
while IFS= read -r name; do
  cp -Rp "$GAME/$name" "$BACKUP/$name" || die "Backup of $name failed."
done <<EOF
$SELECTED
EOF
printf 'Backup made by the MFC installer on %s\nRestore with Restore-MFC-Mac.command (or copy these back with the game closed).\n' "$STAMP" > "$BACKUP/README.txt"
echo
echo "Backup saved to: $BACKUP"

# ---- install ----
while IFS= read -r name; do
  cp "$CHARDATA"/* "$GAME/$name/" || die "Copying files into $name failed (your backup is in '$BACKUP')."
  echo "Installed to $name ($(ls "$CHARDATA" | wc -l | tr -d ' ') files)"
done <<EOF
$SELECTED
EOF

CFG="$GAME/FFXIV.cfg"
case "$SYSMODE" in
  replace) cp "$PAYLOAD/FFXIV.cfg" "$CFG" && echo "Replaced FFXIV.cfg with MFC's system settings" ;;
  uionly)
    tmp="$CFG.mfc-tmp"
    if command -v perl >/dev/null 2>&1; then
      # byte-exact: only the UI-size values change, line endings and every other byte stay as they were
      MFC_KEYS="$UIKEYS" perl -e '
        my ($src, $dst, $tmp) = @ARGV; my %want = map { $_ => 1 } split / /, $ENV{MFC_KEYS}; my %val;
        open(my $s, "<", $src) or die; binmode $s;
        while (<$s>) { $val{$1} = $2 if /^(\w+)\t([^\r\n]*)/ && $want{$1} }
        close $s;
        open(my $d, "<", $dst) or die; binmode $d; local $/; my $c = <$d>; close $d;
        $c =~ s/^(\w+)\t[^\r\n]*/exists $val{$1} ? "$1\t$val{$1}" : $&/mge;
        open(my $o, ">", $tmp) or die; binmode $o; print $o $c; close $o or die;
      ' "$PAYLOAD/FFXIV.cfg" "$CFG" "$tmp" && mv "$tmp" "$CFG"
    else
      awk -F'\t' -v keys="$UIKEYS" '
        NR==FNR { k=$1; v=$2; sub(/\r$/,"",v); if (index(" " keys " ", " " k " ")) src[k]=v; next }
        { k=$1; cr=($0 ~ /\r$/) ? "\r" : ""; if (k in src) print k "\t" src[k] cr; else print }
      ' "$PAYLOAD/FFXIV.cfg" "$CFG" > "$tmp" && mv "$tmp" "$CFG"
    fi && echo "Applied MFC's UI size to FFXIV.cfg (everything else kept)" ;;
  *) echo "FFXIV.cfg left unchanged" ;;
esac

echo
echo "Done! Start the game. If the HUD looks off on your screen, press CTRL+NUMPAD0 (or open HUD Layout from the menu) and drag things into place."
echo "Undo any time: quit the game and double-click Restore-MFC-Mac.command"
echo
