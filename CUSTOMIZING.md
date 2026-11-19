[index]: #make-it-yours "Back to top"

# Make it yours

MFC works out of the box, but a few things are personal and are left for you to fill in: your mounts, your emotes, which jobs show up in the custom menu, and how the HUD sits on your screen. Almost everything below is done inside the game; only the undo step uses `Restore-MFC.bat`.

## Index

1. [Before you start](#before-you-start-)
2. [Your mounts (SHIFT+H / CTRL+H)](#your-mounts-shifth--ctrlh-)
3. [Free hotbars 4–6 (emotes and anything else)](#free-hotbars-46-emotes-and-anything-else-)
4. [Keybind bar (8) and database bar (9)](#keybind-bar-8-and-database-bar-9-)
5. [Custom menu](#custom-menu-)
   1. [Which job holds which row](#which-job-holds-which-row-)
   2. [Editing a row](#editing-a-row-)
   3. [Adding a new job to the menu](#adding-a-new-job-to-the-menu-)
   4. [Gearset names for the job-change buttons](#gearset-names-for-the-job-change-buttons-)
6. [HUD for your resolution](#hud-for-your-resolution-)
7. [Job gauges: Simple or Standard](#job-gauges-simple-or-standard-)
8. [Using the per-job layout pages](#using-the-per-job-layout-pages-)
9. [Keyboard vs controller](#keyboard-vs-controller-)
10. [Megumax's personal settings you may want to change](#megumaxs-personal-settings-you-may-want-to-change-)
11. [Undo everything (Restore-MFC.bat)](#undo-everything-restore-mfcbat-)

## Before you start <sup>[⮝][index]</sup>

The idea behind the layout is Fr4nsson's, so his pictures are still the best overview (images from [FFC](https://github.com/Fr4nsson/FFC), credit Fr4nsson):

![General Idea](https://raw.githubusercontent.com/Fr4nsson/FFC/main/images/general-idea.png)

![Main Hotbar](https://raw.githubusercontent.com/Fr4nsson/FFC/main/images/main-hotbar.png)

**One difference:** MFC swapped the plain row and the CTRL row on the three main 4x3 blocks. Every key still does the same thing as in FFC, but in-game each block now shows **plain on top, SHIFT in the middle, CTRL at the bottom**, while the picture above shows CTRL on top. The reason: temporary NPC, vehicle and duty actions always drop into hotbar 1 starting at slot 1, and now they land on plain `1`–`4` instead of `CTRL + 1`–`4`.

## Your mounts (SHIFT+H / CTRL+H) <sup>[⮝][index]</sup>

Your mount keys live on the keybind bar (hotbar 8), which is visible by default. The first two slots show FFC's **"Replace with Mount"** placeholder.

```
SHIFT + H           = Single Seat Mount   (hotbar 8, slot 1)
CTRL  + H           = Multiple Seat Mount (hotbar 8, slot 2)
ALT   + H           = Ridepillion         (already set up, leave it)
```

1. If you can't see the keybind bar, press `8`.
2. Open your Mount Guide and drag your favourite single-seat mount onto the first "Replace with Mount" slot.
3. Drag a multi-seat mount onto the second "Replace with Mount" slot.
4. Press `8` again if you want the keybind bar hidden. The keys keep working while it's hidden.
5. Done. :tada:

Hotbar 8 is shared between all jobs, so you only have to do this once per character.

## Free hotbars 4–6 (emotes and anything else) <sup>[⮝][index]</sup>

Hotbars 4, 5 and 6 are yours. They ship empty (just like in FFC) and have no keybinds, so they're perfect for things you click with the mouse: emotes, minions, fashion accessories, items, your own macros and so on.

They're set to shared, so whatever you place there shows up on every job. If they're hidden, turn them on under *Character Configuration → Hotbar Settings* and drag them where you like in HUD Layout (`CTRL + NUMPAD 0`).

## Keybind bar (8) and database bar (9) <sup>[⮝][index]</sup>

```
8                   = Toggle Keybind bars (hotbars 8 and 9: mounts, ridepillion, target markers, the 8/9 toggles, ...)
9                   = Toggle Database bar (hotbar 7: the custom menu's "database")
```

Both are macros on hotbar 9. `9` runs FFC's **"Toggle Database 9"** macro. Hiding a bar only hides it, the keys on it keep working.

On jobs with nothing in their database, the database bar holds FFC's **"Why spells here?"** macro, so you can always tell whether it's showing. On some jobs it also holds spells parked there so the game doesn't auto-place them on your main bars (Machinist's Dismantle, for example). Leave those where they are.

## Custom menu <sup>[⮝][index]</sup>

The custom menu works exactly like in FFC: jobs are used as a **database**. Each row of the menu is read from hotbar 7 of one particular job. You don't need those jobs unlocked to *use* the menu, only to *edit* it. The logic behind the menu is under `ALT + M → Individual Tab`.

### Which job holds which row <sup>[⮝][index]</sup>

MFC split FFC's "Dps" row into **Melee** and **Ranged**. Everything else is as in FFC.

#### Non-PvP Areas

| Job           | Information | Changed in MFC? |
| ------------- | ----------- | --------------- |
| Botanist      | Expand      |                 |
| Miner         | Collapse    |                 |
| Fisher        | Melee       | was "Dps"       |
| Carpenter     | Ranged      | new             |
| Culinarian    | Tanks       |                 |
| Alchemist     | Healers     |                 |
| Weaver        | Professions |                 |
| Leatherworker | Items       |                 |
| Goldsmith     | Hunt        |                 |
| Armorer       | Misc2       |                 |
| Blacksmith    | Misc1       |                 |

#### PvP Areas *(Wolves' Den Pier)*

| Job           | Information | Changed in MFC? |
| ------------- | ----------- | --------------- |
| Bard          | Expand      |                 |
| Machinist     | Collapse    |                 |
| Dancer        | Melee       | was "Dps"       |
| Pictomancer   | Ranged      | new             |
| Red Mage      | Tank        |                 |
| Black Mage    | Healer      |                 |

Where to unlock the original FFC jobs (quest, quest giver, location) is listed in Fr4nsson's [FFC README](https://github.com/Fr4nsson/FFC#custom-menu-).

What's in the rows now:

- **Melee:** Monk, Dragoon, Ninja, Samurai, Reaper, Viper, then a gap, then Beastmaster (like Blue Mage in the Tank/Healer rows).
- **Ranged:** Bard, Machinist, Dancer, Black Mage, Summoner, Red Mage, Pictomancer.
- **Expand** row: gained the Ranged button (macro `#21` "Ranged", red sword "2" icon). Macro `#96` is now called "Melee".

### Editing a row <sup>[⮝][index]</sup>

1. Switch to the job that holds the row you want to change (see the tables above). For example `Fisher` for Melee or `Carpenter` for Ranged.
2. Press `9`. The database bar appears in the top center of the screen.
3. Drag gearsets (`SHIFT + G`), macros (`ALT + M`), items, mounts or whatever you like onto it, or drag things off it.
4. Press `9` again to hide the database bar.
5. Done. :tada:

For the PvP menu, teleport to **Wolves' Den Pier** and do the same steps with the PvP job instead (for example `Dancer` for Melee, `Pictomancer` for Ranged).

### Adding a new job to the menu <sup>[⮝][index]</sup>

Same as FFC's FAQ, just with the new rows. Say a new melee job comes out:

1. Switch to `Fisher` (holds the Melee row in non-PvP areas).
2. Press `9`.
3. Press `SHIFT + G` and drag the new job's gearset onto a free slot of the database bar.
4. Press `9` again.

For a new caster or ranged job use `Carpenter`, for tanks `Culinarian`, for healers `Alchemist`. In PvP areas, use `Dancer` (Melee), `Pictomancer` (Ranged), `Red Mage` (Tank) or `Black Mage` (Healer).

If you drop a job's gearset on a job that **isn't** listed as a database, it won't save and will "revert" every time you switch. Always switch to the database job first.

### Gearset names for the job-change buttons <sup>[⮝][index]</sup>

The job-change buttons switch gear **by gearset name**, so you need a gearset named exactly after the job in English: `Viper`, `Pictomancer`, `Beastmaster`, `Gunbreaker` and so on. If a button does nothing, open your gearsets (`SHIFT + G`) and rename that job's gearset to its plain job name.

MFC's new job-change macros are `#11` Viper, `#12` Pictomancer and `#36` Beastmaster.

Playing in another language? Your gearset names need to match the names the macros use through auto-translate. Fr4nsson explains this in the FFC FAQ (for example, French players need all-lowercase gearset names).

In PvP areas the buttons only work if you're currently a PvP-capable job. Crafters, gatherers, Blue Mage and Beastmaster don't have PvP hotbars. Switch to a PvP job with `SHIFT + G` first.

## HUD for your resolution <sup>[⮝][index]</sup>

MFC's HUD is laid out for **2560x1600**. Positions are stored as screen percentages, so 16:9 screens should be close, but FFC's separate 1080p / 1440p / 4K HUD files are **not** included. Small offsets are easy to fix:

```
CTRL + NUMPAD 0     = Toggle HUD Layout (drag things into place)
Arrow Keys          = Move the selected HUD element one pixel at a time
CTRL + NUMPAD 1     = HUD Preset 1
CTRL + NUMPAD 2     = HUD Preset 2
CTRL + NUMPAD 3     = HUD Preset 3
CTRL + NUMPAD 4     = HUD Preset 4
```

In FFC, preset 1 is the default, 2 is larger, 3 is like 1 with gauges and HP reversed, and 4 is like 2 with gauges and HP reversed. Each preset is saved separately, so fix the one you actually play with.

UI size matters too. If you chose **[1] apply only MFC's UI size** in the installer (the default), the game's UI size is set to the one MFC was laid out with on a 2560x1600 screen, and the rest of your system settings stay yours. If your screen is much smaller or larger and the HUD looks too big or too small, change the UI size in *System Configuration*.

## Job gauges: Simple or Standard <sup>[⮝][index]</sup>

MFC set the new gauges to **Simple** style, anchored bottom-middle like all of FFC's gauges, in all 4 HUD presets:

- Viper, Pictomancer and Beastmaster
- Ninja's new Kazematoi gauge
- Black Mage's new Astral gauge

If you prefer the Standard look, switch it in the game's job gauge settings in Character Configuration. The Standard gauge has a different size, so check its position afterwards in HUD Layout (`CTRL + NUMPAD 0`).

Playing Beastmaster? The Inner Compass shows up after you press a HUD preset key (`CTRL + NUMPAD 1`–`4`) once.

## Using the per-job layout pages <sup>[⮝][index]</sup>

[docs/layouts](docs/layouts/README.md) has one page per job, generated straight from the shipped hotbars and keybinds. Each page shows:

- **Keyboard (PvE)** and **Keyboard (PvP)** as a grid: columns are the keys `1 2 3 4 Q E R X F C V T`, rows are plain / SHIFT / CTRL, in the same order you see in-game.
- **Controller (PvE)** and **Controller (PvP)** per cross hotbar, with slots named LT d-pad 1–4, LT buttons 1–4, RT d-pad 1–4, RT buttons 1–4, in the same order the game lists them under *Character Configuration → Hotbar Settings → Cross Hotbar*.

Handy for learning a new job, or for checking where a button went if you think something is missing. Crafters all share one layout, and Blue Mage isn't listed (its spells weren't updated because they depend on the spells you have loaded; only the row swap was applied).

## Keyboard vs controller <sup>[⮝][index]</sup>

**Keyboard:** the general keybinds are Fr4nsson's (see the [Keybinds section of the FFC README](https://github.com/Fr4nsson/FFC#keybinds-)), with a few changes from Megumax. Because of the row swap, *System Configuration → Keybind* shows Hotbar 1–3 slots 1–4 as the plain keys (`1`–`4`, `Q E R X`, `F C V T`). That's expected, don't "fix" it, or your keys will fire the wrong row.

**Controller:** every combat job, crafter and gatherer has cross hotbar layouts, for PvE and PvP. The PvE controller layouts for combat jobs and crafters started from Squintina's (credited in FFC 2.5; gatherers excluded). FFC never had PvP controller layouts, MFC derived them from FFC's PvE controller conventions. For general controller tips (autorun, sheathe, sprint, virtual mouse) see the [Controller section of the FFC README](https://github.com/Fr4nsson/FFC#controller--comprehensive-controller-guide-).

**Console:** install on PC first, then use the game's *Back Up Client Settings* / *Back Up Character Settings* upload (on PC) and download (on console), exactly as described in the [FFC README](https://github.com/Fr4nsson/FFC#installation-console-).

**Mac:** use `Install-MFC-Mac.command` / `Restore-MFC-Mac.command` (see the README, Installation (Mac)). **Steam Deck / Linux:** manual installation only (copy the files from `Manual Installation` yourself, with the game closed).

## Megumax's personal settings you may want to change <sup>[⮝][index]</sup>

A few things are Megumax's own taste rather than FFC's:

- **Legacy movement** is on, for keyboard and controller, and legacy flying controls on keyboard. Prefer Standard? Change *Character Configuration → Control Settings → Character → Movement Type*. Change it in both keyboard and gamepad mode (the setting is stored separately for each).
- **Chat log tabs and filters** (tab names like "S-Hunt" and "Chat") are Megumax's. Rename or refilter them in the chat log's settings.
- **System settings** (`FFXIV.cfg`) are only fully applied if you chose **[3] Replace** in the installer: English client, 2560x1600 borderless window and MFC's UI size. If that doesn't suit your PC, change it in *System Configuration*, or restore your backup (below) and install again with [1] or [2].

## Undo everything (Restore-MFC.bat) <sup>[⮝][index]</sup>

The installer made a backup **before** changing anything, in an `MFC Backup <date time>` folder next to your game's settings folder.

1. Make sure the game **and the launcher** are closed.
2. Double-click `Restore-MFC.bat`.
3. Pick the backup you want from the list (newest first). Pick the backup from the day you installed, **not** one ending in `(pre-restore)`. If you ran the installer more than once, restore each of those backups, oldest last, so your original `FFXIV.cfg` ends up back. Restoring also throws away anything you changed in game on those characters since installing (mounts placed, hotbar edits).
4. Done. :tada: Your `FFXIV.cfg` and the character folders from that backup are put back.

Before restoring, the current state is saved as `MFC Backup <date time> (pre-restore)`, so you can even undo the undo by restoring that one. MFC's own files that didn't exist before installing are removed from those character folders, nothing else is touched.

Found something that looks wrong on a job? MFC hasn't been tested in-game on every job yet, so please report it.
