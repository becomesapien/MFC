"""Render MFC's README diagrams (docs/images). Needs Python + Pillow and the Windows fonts Georgia/Segoe UI/Consolas. usage: python tools/make_images.py docs/images"""
import os, sys
from PIL import Image, ImageDraw, ImageFont

OUT = sys.argv[1]; os.makedirs(OUT, exist_ok=True)
F = r'C:\Windows\Fonts'
def font(name, size): return ImageFont.truetype(os.path.join(F, name), size)
TITLE, BODY, BOLD, SEMI, MONO = 'georgiab.ttf', 'segoeui.ttf', 'segoeuib.ttf', 'segoeuisl.ttf', 'consolab.ttf'

BG = (24, 24, 27); PANEL = (34, 34, 38); GOLD = (196, 166, 102); GOLD_D = (120, 100, 60)
TXT = (232, 228, 220); MUTED = (160, 156, 150)
PLAIN = (110, 200, 120); SHIFT = (110, 160, 235); CTRL = (190, 130, 230)
TANK = (90, 140, 230); HEAL = (90, 190, 110); DPS = (215, 85, 85)
S = 2   # supersampling

def canvas(w, h, title):
    im = Image.new('RGB', (w * S, h * S), BG); d = ImageDraw.Draw(im)
    d.rounded_rectangle([6 * S, 6 * S, (w - 6) * S, (h - 6) * S], 14 * S, outline=GOLD, width=2 * S)
    d.rounded_rectangle([10 * S, 10 * S, (w - 10) * S, (h - 10) * S], 11 * S, outline=GOLD_D, width=1 * S)
    d.text((26 * S, 18 * S), title, font=font(TITLE, 30 * S), fill=GOLD)
    d.line([(24 * S, 62 * S), ((w - 24) * S, 62 * S)], fill=GOLD_D, width=1 * S)
    return im, d

def T(d, xy, text, f, fill=TXT, anchor='la'):
    d.text((xy[0] * S, xy[1] * S), text, font=f, fill=fill, anchor=anchor)

def box(d, x, y, w, h, fill=PANEL, outline=GOLD_D, r=10, width=1):
    d.rounded_rectangle([x * S, y * S, (x + w) * S, (y + h) * S], r * S, fill=fill, outline=outline, width=width * S)

def save(im, name, w, h):
    im.resize((w, h), Image.LANCZOS).save(os.path.join(OUT, name), optimize=True)

KEYS = [['1', '2', '3', '4'], ['Q', 'E', 'R', 'X'], ['F', 'C', 'V', 'T']]
ROWS = [('plain key', '', PLAIN), ('SHIFT + key', 'SHIFT ', SHIFT), ('CTRL + key', 'CTRL ', CTRL)]

# ------------------------------------------------------------------ Main Hotbar
def main_hotbar():
    W, H = 1100, 780
    im, d = canvas(W, H, 'Main Hotbar')
    T(d, (26, 74), 'Three 4x3 blocks. Each row is the same key with a different modifier.', font(BODY, 18 * S), MUTED)
    tile, gap, bgap = 58, 8, 40
    x0, y0 = 200, 130
    for r, (label, mod, col) in enumerate(ROWS):
        y = y0 + r * (tile + gap)
        T(d, (x0 - 22, y + tile / 2), label, font(BOLD, 20 * S), col, 'rm')
    for b, keys in enumerate(KEYS):
        bx = x0 + b * (4 * tile + 3 * gap + bgap)
        for r, (label, mod, col) in enumerate(ROWS):
            for c, k in enumerate(keys):
                x, y = bx + c * (tile + gap), y0 + r * (tile + gap)
                box(d, x, y, tile, tile, fill=(46, 46, 52), outline=col, r=9, width=2)
                T(d, (x + 6, y + 4), (mod.strip() + ' ' if mod else '') + k if mod else k, font(BOLD, 11 * S), col)
                T(d, (x + tile / 2, y + tile / 2 + 6), k, font(TITLE, 26 * S), TXT, 'mm')
    # callout for temporary actions
    cy = y0 - 18
    T(d, (x0, cy - 12), 'Mount, vehicle and NPC-duty actions appear on this top row: just press 1-4, no modifier', font(BOLD, 15 * S), PLAIN)
    # keyboard
    ky, kw, kh, kg = 400, 46, 46, 6
    hot = set('1234QERXFCVT') | {'Shift', 'Ctrl'}
    rows = [(0, list('`1234567890-=')), (0.5, ['Tab'] + list('QWERTYUIOP[]')), (0.75, ['Caps'] + list("ASDFGHJKL;'")),
            (1.25, ['Shift'] + list('ZXCVBNM,./')), (0, ['Ctrl', 'Win', 'Alt', 'Space', 'Alt', 'Ctrl'])]
    kx0 = 150
    box(d, kx0 - 24, ky - 20, 800, 5 * (kh + kg) + 36, fill=(30, 30, 34), outline=GOLD_D, r=14)
    for i, (indent, keys) in enumerate(rows):
        x = kx0 + indent * kw; y = ky + i * (kh + kg)
        for k in keys:
            w = kw * (1.6 if k in ('Tab', 'Caps') else 2.2 if k == 'Shift' else 1.5 if k in ('Ctrl', 'Win', 'Alt') else 6 if k == 'Space' else 1)
            on = k in hot
            col = (PLAIN if k in set('1234QERXFCVT') else SHIFT if k == 'Shift' else CTRL) if on else None
            box(d, x, y, w - kg, kh, fill=(60, 58, 52) if on else (44, 44, 48), outline=col or (70, 70, 74), r=6, width=2 if on else 1)
            T(d, (x + (w - kg) / 2, y + kh / 2), k, font(BOLD if on else BODY, (13 if len(k) > 1 else 16) * S), TXT if on else MUTED, 'mm')
            x += w
    T(d, (W / 2, 690), 'MFC shows the plain row on top (FFC showed CTRL on top). Every key still does the same thing.', font(BODY, 16 * S), MUTED, 'mm')
    T(d, (W / 2, 716), 'This lets the game put temporary actions on plain 1-4 instead of CTRL + 1-4.', font(BODY, 16 * S), MUTED, 'mm')
    T(d, (W - 24, H - 26), "MFC diagram, after Fr4nsson's FFC infographic", font(BODY, 12 * S), (110, 106, 100), 'ra')
    save(im, 'main-hotbar.png', W, H)

# ------------------------------------------------------------------ General Idea
def general_idea():
    W, H = 1100, 710
    im, d = canvas(W, H, 'General Idea')
    T(d, (26, 74), 'The same kind of action sits on the same key on every job. Examples from the real MFC bars:', font(BODY, 18 * S), MUTED)
    cw, ch, gx = 66, 112, 5
    x0, y0 = 140, 160
    groups = [(0, 3, 'Main rotation', TXT), (3, 1, 'Crowd ctrl', TXT), (4, 1, 'AoE', TXT), (5, 1, 'Heals', TXT),
              (6, 1, 'Ranged', TXT), (7, 1, 'Utility', TXT), (8, 1, 'Movement', TXT), (9, 2, 'Buffs / boosts', TXT),
              (11, 1, 'Defense', TXT)]
    allkeys = sum(KEYS, [])
    def cx(i): return x0 + i * (cw + gx) + (i // 4) * 14
    for start, n, name, col in groups:
        xa, xb = cx(start), cx(start + n - 1) + cw
        d.line([(xa * S, (y0 - 30) * S), (xb * S, (y0 - 30) * S)], fill=GOLD, width=2 * S)
        T(d, ((xa + xb) / 2, y0 - 36), name, font(BOLD, 12 * S), GOLD, 'md')
    for i, k in enumerate(allkeys):
        T(d, (cx(i) + cw / 2, y0 - 14), k, font(TITLE, 18 * S), TXT, 'mm')
    cells = {   # (row, key) -> list of (role colour, text)
        (0, '4'): [(None, 'Low Blow\nLeg Sweep\nLeg Graze\nRepose'), (DPS, 'casters:\nrotation')],
        (0, 'Q'): [(None, 'AoE')], (1, 'Q'): [(None, 'stronger\nAoE')],
        (0, 'E'): [(TANK, 'Provoke'), (HEAL, 'Cure'), (DPS, 'Second\nWind')], (1, 'E'): [(HEAL, 'stronger\nheal')],
        (0, 'R'): [(None, 'Ranged\nattack'), (HEAL, 'Regen')],
        (0, 'X'): [(TANK, 'Shirk'), (DPS, 'Feint /\nAddle'), (HEAL, 'Rescue')], (1, 'X'): [(None, 'Sprint')], (2, 'X'): [(None, "Arm's\nLength /\nSurecast")],
        (0, 'F'): [(None, 'Gap\ncloser'), (HEAL, 'instant\nheal')],
        (0, 'V'): [(TANK, 'damage\nboost'), (DPS, 'Bloodbath /\nSwiftcast'), (HEAL, 'Swiftcast')],
        (1, 'V'): [(TANK, 'Reprisal'), (DPS, 'boost /\nLucid'), (HEAL, 'Lucid')],
        (0, 'T'): [(TANK, 'Immunity'), (HEAL, 'Raise'), (DPS, 'True\nNorth')], (1, 'T'): [(TANK, 'Stance')],
    }
    for r, (label, mod, col) in enumerate(ROWS):
        y = y0 + r * (ch + gx)
        T(d, (x0 - 16, y + ch / 2), label, font(BOLD, 17 * S), col, 'rm')
        for i, k in enumerate(allkeys):
            x = cx(i)
            box(d, x, y, cw, ch, fill=(44, 44, 50), outline=col, r=8, width=2)
            if i < 3 and r == 0: T(d, (x + cw / 2, y + ch / 2), 'combo\n1 > 2 > 3' if i == 0 else '', font(BODY, 12 * S), MUTED, 'mm')
            items = cells.get((r, k), [])
            ty = y + 8
            for rc, text in items:
                lines = text.split('\n')
                for ln in lines:
                    T(d, (x + cw / 2, ty), ln, font(BOLD if rc else SEMI, 11 * S), rc or TXT, 'ma'); ty += 14
                ty += 3
    # row meaning
    ly = y0 + 3 * (ch + gx) + 18
    T(d, (x0, ly), 'plain = the basic / first-learned version', font(BODY, 16 * S), PLAIN)
    T(d, (x0, ly + 26), 'SHIFT = the next stronger version or next step', font(BODY, 16 * S), SHIFT)
    T(d, (x0, ly + 52), 'CTRL = the one after that', font(BODY, 16 * S), CTRL)
    lx = 620
    for i, (c, n) in enumerate([(TANK, 'tank'), (HEAL, 'healer'), (DPS, 'DPS'), (TXT, 'every job')]):
        box(d, lx, ly + i * 24 + 3, 14, 14, fill=c, outline=c, r=3)
        T(d, (lx + 22, ly + i * 24), n, font(BODY, 15 * S), TXT)
    T(d, (W - 24, H - 26), "MFC diagram, after Fr4nsson's FFC infographic", font(BODY, 12 * S), (110, 106, 100), 'ra')
    save(im, 'general-idea.png', W, H)

# ------------------------------------------------------------------ Manual installation
def installation():
    W, H = 1100, 640
    im, d = canvas(W, H, 'Manual Installation')
    T(d, (26, 76), 'Easiest: run Install-MFC.bat (Windows) or Install-MFC-Mac.command (Mac / Steam Deck / Linux).', font(BOLD, 17 * S), PLAIN)
    T(d, (26, 102), 'They make a backup first and do everything below for you. By hand, with the game closed:', font(BODY, 17 * S), MUTED)
    # left: package
    box(d, 40, 150, 400, 400, fill=PANEL)
    T(d, (60, 166), 'MFC (the folder you unzipped)', font(BOLD, 17 * S), GOLD)
    T(d, (70, 200), 'Manual Installation', font(BOLD, 16 * S))
    T(d, (90, 228), 'CharacterData', font(BOLD, 16 * S), PLAIN)
    files = ['ADDON.DAT', 'COMMON.DAT', 'CONTROL0.DAT', 'CONTROL1.DAT', 'HOTBAR.DAT', 'KEYBIND.DAT', 'LOGFLTR.DAT', 'MACRO.DAT']
    for i, f in enumerate(files): T(d, (116, 256 + i * 26), f, font(MONO, 14 * S), TXT)
    T(d, (90, 476), 'FFXIV.cfg   (optional)', font(BOLD, 16 * S), SHIFT)
    # right: game folder
    box(d, 620, 150, 440, 400, fill=PANEL)
    T(d, (640, 166), 'Your FFXIV settings folder', font(BOLD, 17 * S), GOLD)
    T(d, (640, 194), 'Documents\\My Games\\', font(BODY, 14 * S), MUTED)
    T(d, (640, 214), 'FINAL FANTASY XIV - A Realm Reborn', font(BODY, 14 * S), MUTED)
    for i in range(3): T(d, (660, 256 + i * 40), f'FFXIV_CHR00...  (character {i + 1})', font(MONO, 14 * S), PLAIN)
    T(d, (660, 372), 'one folder per character', font(BODY, 13 * S), MUTED)
    T(d, (660, 476), 'FFXIV.cfg', font(MONO, 15 * S), SHIFT)
    # arrows
    def arrow(x1, y1, x2, y2, col):
        d.line([(x1 * S, y1 * S), (x2 * S, y2 * S)], fill=col, width=3 * S)
        d.polygon([(x2 * S, y2 * S), ((x2 - 12) * S, (y2 - 7) * S), ((x2 - 12) * S, (y2 + 7) * S)], fill=col)
    for i in range(3): arrow(300, 352, 650, 264 + i * 40, PLAIN)
    arrow(300, 484, 650, 484, SHIFT)
    T(d, (475, 392), 'copy the 8 files INSIDE CharacterData', font(BOLD, 13 * S), PLAIN, 'mm')
    T(d, (475, 410), 'into every character folder you want MFC on', font(BOLD, 13 * S), PLAIN, 'mm')
    T(d, (475, 508), 'either copy over yours, or just copy the 4 UI lines', font(BOLD, 13 * S), SHIFT, 'mm')
    T(d, (475, 526), 'UiBaseScale, UiHighScale, UiSystemEnlarge, UiAssetType', font(BODY, 12 * S), SHIFT, 'mm')
    T(d, (W / 2, 584), 'Mac / Steam Deck / Linux: the settings folder is elsewhere. See the README; the installers find it for you.', font(BODY, 15 * S), MUTED, 'mm')
    T(d, (W - 24, H - 26), "MFC diagram, after Fr4nsson's FFC infographic", font(BODY, 12 * S), (110, 106, 100), 'ra')
    save(im, 'installation.png', W, H)

main_hotbar(); general_idea(); installation()
print('written', sorted(os.listdir(OUT)))
