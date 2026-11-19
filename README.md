[index]: #index "Back to top"
[ffc]: https://github.com/Fr4nsson/FFC "Fr4nsson's FFXIV Config on GitHub"
[ffc-nexus]: https://www.nexusmods.com/finalfantasy14/mods/1054 "Fr4nsson's FFXIV Config on Nexus Mods"
[ffc-discord]: https://discord.gg/7TJG9H8Xyf "Fr4nsson's Discord"
[squintina]: https://www.youtube.com/@Squintina "Squintina on YouTube"
[terms-of-service]: https://support.na.square-enix.com/rule.php?id=5382&la=1 "Terms of service"
[comprehensive-controller-guide]: https://docs.google.com/document/d/1q_i5_X01hecbCOZOIN_71zceuSjWSuaN-OJdU6ZPV6s "Comprehensive Controller Guide"

[general-idea]: https://raw.githubusercontent.com/Fr4nsson/FFC/main/images/general-idea.png "General Idea (image by Fr4nsson)"
[main-hotbar]: https://raw.githubusercontent.com/Fr4nsson/FFC/main/images/main-hotbar.png "Main Hotbar (image by Fr4nsson)"
[install-picture]: https://raw.githubusercontent.com/Fr4nsson/FFC/main/images/installation.png "Installation (image by Fr4nsson)"
[install-console-char-screen]: https://raw.githubusercontent.com/Fr4nsson/FFC/main/images/installation_console_character_screen.png "Character Screen (image by Fr4nsson)"
[custom-menu-gif]: https://raw.githubusercontent.com/Fr4nsson/FFC/main/images/custom-menu.gif "Custom Menu (image by Fr4nsson)"

# Megumax's FFXIV Config (MFC)
A continuation of [Fr4nsson's FFXIV Config (FFC)][ffc], updated for Dawntrail.

A complete config for FFXIV with a clean, informative HUD layout. Every combat job (including Viper, Pictomancer and Beastmaster), crafter and gatherer has its actions already placed on hotbars, for keyboard and controller, in PvE and (for combat jobs) PvP. Blue Mage is the exception, and Beastmaster has no PvP.

Like FFC, MFC is only the game's own settings files: no mod, no plugin, nothing runs while you play. The files started as FFC's and Megumax's in-game settings, and MFC's Dawntrail changes were applied to those files before release. FFC's position is that a config like this does not go against the [Terms of Service][terms-of-service]; see the [FAQ](#frequently-asked-questions-faq-).

## Credits and permission

**MFC would not exist without Fr4nsson.** It is inspired by and built directly on top of [Fr4nsson's FFXIV Config (FFC) 2.5][ffc] ([Nexus Mods][ffc-nexus] | [Discord][ffc-discord]). The HUD, the keybind philosophy, the custom menu, the macros and most of the layouts are his work. FFC was last updated in April 2023, before Dawntrail. MFC tries to carry on what he built so it keeps working on today's game.

- **Fr4nsson**: original config, HUD, keybinds, custom menu, macros and the rules every layout here follows.
- **[Squintina][squintina]**: the original PvE controller layouts for combat jobs and crafters (gatherers excluded), credited in FFC 2.5.
- **Megumax**: the Dawntrail update, new jobs, PvP rebuild, hotbar row swap and installer described below.

**Permission status:** Fr4nsson's terms ask that modified versions of FFC aren't uploaded elsewhere without his permission. He has since stepped away from the game, and the FFC community has been sharing its own updated builds in his absence. MFC is shared in the same spirit, **without his explicit permission**. If Fr4nsson asks for it to be taken down, it will be (see the [note at the end](#a-note-to-fr4nsson)).

MFC is an unofficial continuation. It is not an official FFC release and is not endorsed by Fr4nsson or affiliated with Square Enix.

All images on this page are Fr4nsson's, linked from his FFC repository.

## Index

1. [Credits and permission](#credits-and-permission)
2. [About](#about)
3. [What's new compared to FFC 2.5](#whats-new-compared-to-ffc-25-)
4. [How Megumax's setup differs from Fr4nsson's](#how-megumaxs-setup-differs-from-fr4nssons-)
5. [Main Hotbar](#main-hotbar-)
6. [General Idea](#general-idea-)
7. [Backup](#backup-)
8. [Installation (PC)](#installation-pc-)
   1. [With the installer](#with-the-installer-recommended-)
   2. [Undo / restore](#undo--restore-)
   3. [Manual Installation](#manual-installation-pc-)
9. [Installation (Mac)](#installation-mac-)
10. [Installation (Steam Deck / Linux)](#installation-steam-deck--linux-)
    1. [Steam Deck](#steam-deck-)
    2. [Linux (desktop)](#linux-desktop-)
    3. [Undo / restore](#undo--restore-steam-deck-and-linux-)
11. [Installation (Console)](#installation-console-)
12. [What each file does](#what-each-file-does-)
13. [Custom Menu](#custom-menu-)
    1. [non-pvp](#non-pvp-areas-)
    2. [pvp](#pvp-areas-wolves-den-pier-)
14. [Hotbar layouts per job](docs/layouts/README.md)
15. [Make it yours](#make-it-yours-)
16. [Known limitations](#known-limitations-)
17. [Frequently Asked Questions (FAQ)](#frequently-asked-questions-faq-)
18. [Keybinds](#keybinds-)
19. [Controller](#controller--comprehensive-controller-guide-)

## About

Fr4nsson spent a very long time on FFC: a HUD that is easy to read, and keybinds that put the same kind of action on the same key on every job, so switching jobs feels natural. His idea was simple. He did the trial and error so you can just play the game.

Then Dawntrail arrived. Abilities were removed, new ones were added, three new jobs came out, and PvP changed again. A config that no longer matches the game slowly falls apart. MFC is my attempt to keep FFC alive: the same philosophy and the same rules, updated for the current game (checked against game data current as of November 2026, Dawntrail 7.x).

If you enjoy setting up your own HUD and keybinds, this probably isn't for you (though see [Make it yours](#make-it-yours-)). If you would rather log in and play, welcome.

Current version: **MFC 1.0**, based on Fr4nsson's FFC 2.5. Check macro `#99` in game (`ALT + M` -> Individual tab).

## What's new compared to FFC 2.5 <sup>[⮝][index]</sup>

#### Jobs (PvE)
- **Every older combat job except Blue Mage updated for Dawntrail**: 19 jobs and their base classes, keyboard **and** controller (about 357 slot changes).
  - Removed abilities are taken off (for example Dragon Sight, Sharpcast, Anatman, Meditation, the old Astrologian card system, Arcanist Bane/Egi Assault, Spineshatter Dive, Shoha II).
  - New 7.x buttons are placed following FFC's rules: the same concept on the same key on every job. Plain = basic, SHIFT = stronger, CTRL = next. Q = AoE. E = heal / Second Wind / Provoke for tanks. 4 = rotation or crowd control, and so on.
  - Trait upgrades (Bootshine -> Leaping Opo and similar) are **not** placed separately, because the base button upgrades itself.
  - Low-level spells stay, following FFC's rule of one layout for the whole game, level sync included.
  - White Mage: Glare IV (`CTRL + 2`) and Divine Caress (`CTRL + V`) have their own buttons. The game data can't tell whether they are separate buttons or automatic replacements. If one shows up as a duplicate, just drag it off.
  - Machinist: Dismantle is parked on hotbar 7, the "spells here so the game doesn't auto-place them" bar.
- **New jobs: Viper** (melee), **Pictomancer** (caster) and **Beastmaster** (limited job, melee, PvE only). Each has full keyboard and controller layouts following FFC's conventions, plus job-change macros `#11` Viper, `#12` Pictomancer and `#36` Beastmaster (the slot FFC had reserved).
- **Crafters and gatherers updated for 7.x.**
  - Crafters (all 8 share one layout): Focused Synthesis and Focused Touch removed. Added Refined Touch (`CTRL + R`), Immaculate Mend (`SHIFT + R`), Quick Innovation (`CTRL + C`) and Trained Perfection (`CTRL + V`). Heart and Soul and Careful Observation added to the controller layout.
  - Miner / Botanist: Priming Touch added. Bountiful Yield II / Bountiful Harvest II are trait upgrades of Bountiful Yield / Bountiful Harvest, so they are not placed separately.
  - Fisher: added Spareful Hand, Big-game Fishing, Ambitious Lure and Modest Lure. Rest/Quit added on controller.

#### PvP
- **PvP rebuilt for every job** (keyboard and controller, about 630 slot changes) for the current PvP kits, including the PvP Role Action. It uses FFC 2.4's PvP key pattern: `1` = one-button combo or basic attack, `Q` / `SHIFT + Q` = AoE, `E` = Recuperate, `CTRL + E` = Elixir (also on `SHIFT + E`, unless the job has a PvP heal there), `X` = Limit Break, `SHIFT + X` = Sprint, `F` = dash, `C` = Purify, `T` = Guard.
- FFC never had PvP controller layouts. MFC's are derived from FFC's PvE controller conventions.

#### Hotbars and HUD
- **Plain row and CTRL row swapped** on the three main 4x3 blocks, in both the keybinds and every class/job's hotbars. Every key still fires the same ability as in FFC. The difference is that temporary NPC/vehicle/duty actions, which the game always drops into hotbar 1 from slot 1 onward, now land on plain `1`-`4` instead of `CTRL + 1`-`4`. See [Main Hotbar](#main-hotbar-) for what this looks like.
- **Keybind bars (hotbars 8 and 9) are visible by default.** In FFC you had to press `8` to show them. Press `8` to hide them. The mount keys `SHIFT + H` / `CTRL + H` show FFC's "Replace with Mount" placeholder until you drag your own mounts on. `ALT + H` = Ridepillion.
- **New job gauges** (Viper, Pictomancer, Beastmaster, Ninja's new Kazematoi gauge and Black Mage's new Astral gauge) are set to Simple style and anchored bottom-middle like every FFC gauge, in all 4 HUD presets (`CTRL + NUMPAD 1`-`4`). Beastmaster's Inner Compass appears after you press a HUD preset key once.

#### Custom menu and macros
- **The DPS tab is split into Melee and Ranged.** See [Custom Menu](#custom-menu-). Macro `#96` was renamed from "Dps" to "Melee", and there is a new macro `#21` "Ranged" (red sword "2" icon). The Expand row gained a Ranged button.
- **Macro fixes**: the Red Mage, Scholar and Summoner job-change macros put the wrong PvP Limit Break on `L` (a removed or PvE action), which is now fixed. The controller Sprint macro called a removed PvP action, which is also fixed.

#### Installer
- **Install-MFC.bat** backs up first, lets you choose characters and asks what to do with your system settings. **Restore-MFC.bat** puts any MFC backup back. See [Installation (PC)](#installation-pc-).

## How Megumax's setup differs from Fr4nsson's <sup>[⮝][index]</sup>

MFC ships my own character and system settings, so a few things are set up for how I play. These are easy to change in game.

#### Movement
- **Legacy movement** (Character Configuration -> Control Settings -> Character -> Movement: Legacy), in both keyboard and gamepad mode.
- **Legacy flying controls** in keyboard mode (gamepad uses Standard flying), with legacy autorun while flying.

To switch back to Standard: `ESC` -> Character Configuration -> Control Settings -> Character -> Movement Type. Change it in both keyboard and gamepad mode (the setting is stored separately for each).

#### Chat
- My own chat log tabs and filters. Two of the tabs are renamed **S-Hunt** and **Chat**. Rename or refilter them by right-clicking a chat tab.

#### System settings (FFXIV.cfg)
FFXIV.cfg is shared by every character on the PC. These settings are only fully applied if you choose option `[3]` in the installer:
- English client (Language).
- 2560x1600, borderless window.
- UI size: the HUD was laid out at 2560x1600 with these UI scale settings. The installer's default option `[1]` copies **only** MFC's UI size and UI resolution settings (the four lines `UiBaseScale`, `UiHighScale`, `UiSystemEnlarge`, `UiAssetType`) and keeps everything else of yours.

The HUD (ADDON.DAT) was laid out on a 2560x1600 screen. The game stores positions as screen percentages, so other screens (16:9 included) should be close. FFC's separate 1080p/1440p/4K HUD files are **not** included. Fix small offsets in HUD Layout (`CTRL + NUMPAD 0`).

#### Keybinds
Compared to the keybind list in FFC's README, these are the differences in MFC's files:

| Key                       | FFC (documented)                   | MFC                                                                                  |
| ------------------------- | ---------------------------------- | ------------------------------------------------------------------------------------ |
| `1`-`4`, `Q E R X`, `F C V T` | bottom row of each block on screen | top row of each block on screen (row swap, same abilities)                       |
| `8`                       | keybind bars start hidden          | keybind bars start visible (`8` hides them)                                         |
| `B`                       | not listed                         | opens all bags (same as `I`)                                                         |
| `CTRL + B`                | not listed                         | second key for the open-and-sort inventory slot (same as `SHIFT + B`)                |
| `SHIFT + HOME`            | not listed                         | second key for the Return (Eternity Ring) slot (same as `CTRL + HOME`)               |
| `NUMPAD .`                | not listed                         | extra Cancel key                                                                     |
| `CTRL + NUMPAD 1`-`4`     | presets only in the 1080p and 2160p files | all four HUD presets in the single ADDON.DAT                                  |

The most useful ones are listed in [Keybinds](#keybinds-). Everything else can be seen in game under System Configuration -> Keybind.

#### Removed from the public files
My personal emotes, mounts and minions, gearset buttons (gearset numbers differ on every character), the free-to-use hotbars 4-6 (empty, like FFC), account-wide macros, my active linkshell, and machine-specific lines from FFXIV.cfg (world, device IDs, last login, MSQ progress, screenshot folder, window position).

## Main Hotbar <sup>[⮝][index]</sup>
![main-hotbar][main-hotbar]

*Image: Fr4nsson (FFC).* **In MFC the rows are in a different order on screen.** Fr4nsson's image shows each 4x3 block with the CTRL row on top. In MFC each block shows **plain on top, SHIFT in the middle, CTRL at the bottom**. The keys still do exactly the same thing. Only the row positions moved, so that temporary actions (mounts, vehicles, NPC duties) land on plain `1`-`4`.

This also means *System Configuration -> Keybind -> Hotbar* shows Hotbar 1-3 slots 1-4 bound to the plain keys. That is expected.

## General Idea <sup>[⮝][index]</sup>
![general-idea][general-idea]

*Image: Fr4nsson (FFC).* The same ideas apply in MFC, and the new Dawntrail buttons follow them.

## Backup <sup>[⮝][index]</sup>
The installer makes a backup for you automatically (see below). For a backup of your own:

1. Make sure the game is not running!
2. Navigate to your FFXIV config folder, usually<br>
   <code>Documents\My Games\FINAL FANTASY XIV - A Realm Reborn</code>
3. Copy the following and put them somewhere safe<br>
   <code>FFXIV.cfg</code><br>
   <code>FFXIV_CHR...</code> folders
4. Done.

## Installation (PC) <sup>[⮝][index]</sup>

#### With the installer (recommended) <sup>[⮝][index]</sup>
Works the same for the **Square Enix standalone version and the Steam version**: on Windows both keep their settings in `Documents\My Games\FINAL FANTASY XIV - A Realm Reborn` (also when Documents is in OneDrive), and that's where the installer looks.

1. Log in to the character you want MFC on (so it shows first in the list), then **close the game completely**, launcher included. The installer stops if FFXIV or its launcher is running.
2. Download MFC (on the GitHub page: **Code -> Download ZIP**), right-click the zip -> **Extract All**, and open the extracted folder. Don't run the installer from inside the zip.
3. Double-click **`Install-MFC.bat`**.
   * If Windows SmartScreen says "Windows protected your PC", click **More info -> Run anyway**. The `.bat` only starts `Install-MFC.ps1`, a plain-text PowerShell script you can open and read first.
4. **Choose your characters.** The game names character folders by an ID, not by character name. The installer lists them **most recently played first**, with the last-played time.
   * **Every character you pick gets MFC's hotbars, keybinds, macros, HUD, chat tabs and character settings in place of its own.** Your current ones are saved in the backup (step 6) and can be put back with `Restore-MFC.bat`. Only pick `A` if you want MFC on every character on this PC.
   * The character you logged in to last (step 1) should be `[1]`.
   * Type numbers separated by commas (for example `1` or `1,3`), or `A` for all of them.
5. **Choose what happens to your system settings (FFXIV.cfg)**, which are shared by every character on the PC:
   * `[1]` **Apply only MFC's UI size and UI resolution settings** (the four lines `UiBaseScale`, `UiHighScale`, `UiSystemEnlarge`, `UiAssetType`). Graphics, sound, language and window settings stay yours. **This is the default**, so just press Enter.<br>
     This sets the game's UI size to the one MFC was laid out with on a 2560x1600 screen. If your screen is much smaller or larger and the HUD looks too big or too small, change the UI size in System Configuration (or restore and run the installer again with `[2]`).
   * `[2]` Keep your FFXIV.cfg exactly as it is.
   * `[3]` Replace it with MFC's full system settings (graphics, sound, English client, 2560x1600 borderless window...).
6. **The installer makes a backup before changing anything.** Your FFXIV.cfg and every character folder you picked are copied to<br>
   <code>Documents\My Games\MFC Backup &lt;date time&gt;</code><br>
   The installer prints the exact location.
7. It then copies the files from `Manual Installation\CharacterData` into each chosen character folder, and handles FFXIV.cfg the way you chose.
8. Start the game. If the HUD looks slightly off on your screen, press `CTRL + NUMPAD 0` to open HUD Layout and drag things into place.
9. Done. :tada:

New character later? Log in to it once, close the game, and run the installer again for that character.

#### Undo / restore <sup>[⮝][index]</sup>
1. Close the game.
2. Double-click **`Restore-MFC.bat`**.
3. Pick a backup from the list (newest first). Pick the backup from the day you installed, **not** one ending in `(pre-restore)`. If you ran the installer more than once, restore each of those backups, oldest last, so your original FFXIV.cfg ends up back. Restoring also throws away anything you changed in game on those characters since installing (mounts placed, hotbar edits).
4. It first saves your **current** state as `MFC Backup <date time> (pre-restore)`, so a restore can itself be undone. Then it puts the backed-up FFXIV.cfg and character files back. It also removes MFC files the installer added to a folder where they did not exist before, and nothing else.

#### Manual Installation (PC) <sup>[⮝][index]</sup>
If you prefer doing it by hand. (Mac, Steam Deck and Linux can use the shell installer instead, see [Installation (Mac)](#installation-mac-) and [Installation (Steam Deck / Linux)](#installation-steam-deck--linux-).)

1. Make sure the game is not running!
2. [Backup](#backup-) your current config. Installing overwrites almost everything in your character settings.
3. Download MFC and unzip it.
4. Navigate to your FFXIV config folder, usually<br>
   <code>Documents\My Games\FINAL FANTASY XIV - A Realm Reborn</code><br>
   On Mac, Steam Deck or Linux the folder is somewhere else (inside your game/Wine/Proton prefix). Look for the folder that contains <code>FFXIV.cfg</code> and the <code>FFXIV_CHR...</code> folders.
5. Open the <code>Manual Installation</code> folder.
6. FFXIV.cfg (optional). Either copy MFC's <code>FFXIV.cfg</code> over yours (full system settings, including 2560x1600 borderless and the English client), or keep yours and copy just these four lines from MFC's FFXIV.cfg into yours with a text editor (game closed): <code>UiBaseScale</code>, <code>UiHighScale</code>, <code>UiSystemEnlarge</code>, <code>UiAssetType</code>. This is exactly what the installer's default option <code>[1]</code> does.
7. Copy the files **inside** <code>CharacterData</code> into each <code>FFXIV_CHR...</code> folder you want MFC on, and replace when prompted. MFC has a single <code>ADDON.DAT</code>, so there is no resolution file to rename like in FFC.
8. Done. :tada:

![Installation][install-picture]

*Image: Fr4nsson (FFC). It shows FFC's zip, but the steps are the same, minus the ADDON renaming.*

## Installation (Mac) <sup>[⮝][index]</sup>
Works with **Square Enix's Mac client (standalone or Steam)** and with **XIV on Mac**. The installer looks in all the usual places:
* Square Enix client: inside its app data, `~/Library/Application Support/FINAL FANTASY XIV ONLINE/Bottles/published_Final_Fantasy/drive_c/users/crossover/My Documents/My Games/FINAL FANTASY XIV - A Realm Reborn`, or `~/Documents/My Games/FINAL FANTASY XIV - A Realm Reborn`
* XIV on Mac: `~/Library/Application Support/XIV on Mac/ffxivConfig`
* Steam: the FFXIV folders inside **every Steam library** Steam knows about (including libraries on other drives, read from Steam's own `libraryfolders.vdf`). Where the Steam edition of the Mac client keeps its settings isn't documented anywhere we could find, so the installer searches for them there; if it can't find yours, run it from Terminal with `--path "<the folder that contains FFXIV.cfg>"` (and please report the location so it can be added).

It only searches the game's own folders (so macOS won't pop up privacy prompts for your contacts or photos), and if it finds more than one settings folder it shows when each was last played and asks which one to use. It does the same things as the Windows installer: backup first, pick characters, and by default only MFC's UI size goes into your system settings. Before changing anything it shows exactly which characters it will overwrite and asks you to confirm.

1. Log in to the character you want MFC on (so it shows first in the list), then **quit the game completely** (`Cmd + Q`), including XIV on Mac. The installer stops if the game is running.
2. Download MFC (**Code -> Download ZIP**) and double-click the zip to unzip it.
3. Double-click **`Install-MFC-Mac.command`**. It opens in Terminal.
   * **The first time, macOS will block it** ("Apple could not verify..."), because it is a script downloaded from the internet. Either:
     * open **System Settings -> Privacy & Security**, scroll down, click **Open Anyway** next to `Install-MFC-Mac.command`, and confirm; or
     * skip the prompt entirely: open **Terminal** and run `bash ~/Downloads/MFC-main/Install-MFC-Mac.command` (change the path if you unzipped it somewhere else; you can also type `bash ` and drag the file into the Terminal window).
   * On macOS 14 and older, right-click the file -> **Open** -> **Open** also works.
4. **Choose your characters** by number (`1`, `1,3`) or `A` for all. Every character you pick gets MFC's hotbars, keybinds, macros, HUD, chat tabs and character settings in place of its own (saved in the backup).
5. **System settings**: press Enter for `[1]` (only MFC's UI size, everything else stays yours). `[3]` replaces the whole FFXIV.cfg, but it was made on a Windows PC, so graphics/window settings may not suit a Mac.
6. **Confirm**: it lists the character folders it will overwrite. Type `y` to go ahead (anything else cancels, nothing changed).
7. Done. :tada: The backup is saved as `MFC Backup <date time>` next to your settings folder. If macOS asks whether Terminal may access your Documents folder, click **Allow** (that's where the game keeps its settings).

If something can't be written (for example a read-only file), the installer stops **before** changing anything and tells you which file. If it ever stops halfway, it says so and tells you which backup to restore.

**Undo:** quit the game and double-click **`Restore-MFC-Mac.command`** (same first-time permission step), pick a backup by number (the oldest one is your setup from before MFC), and confirm with `y`. It saves your current state as `(pre-restore)` first, so a restore can be undone too.

*The Mac scripts were tested against copies of these folder layouts (Square Enix client, XIV on Mac, a Steam library on another drive), not yet on every macOS version. If anything goes wrong, your backup folder has everything; please report it.*

## Installation (Steam Deck / Linux) <sup>[⮝][index]</sup>
The Mac installer, `Install-MFC-Mac.command`, is a plain bash script, and it works on Steam Deck and Linux too. Don't let the "Mac" in the name confuse you. It does exactly the same as the other installers: **backup first**, you pick the characters, by default only MFC's UI size goes into your system settings, and it **asks you to confirm** before changing anything.

It finds your FFXIV settings by itself in:
* **Steam (Proton)**: FFXIV is Steam app `39210`, so its settings live in `steamapps/compatdata/39210/pfx/drive_c/users/steamuser/Documents/My Games/FINAL FANTASY XIV - A Realm Reborn`. The installer checks this in **every Steam library**, including an **SD card** or second drive. It reads the list of libraries from Steam's own `libraryfolders.vdf`, and it also works with **Flatpak Steam**.
* **XIVLauncher**: `~/.xlcore/ffxivConfig`

Before you start: log in to every character you want MFC on at least once, because the game only creates a character's settings folder after its first login. Log in to the one you care about **last**, so it's at the top of the list.

#### Steam Deck <sup>[⮝][index]</sup>
1. **Quit FFXIV completely** in Gaming Mode (Steam button -> the game -> **Exit game**). The installer stops if the game is still running.
2. Switch to the desktop: press the **Steam button -> Power -> Switch to Desktop**.
3. Open a web browser, go to this GitHub page, and click **Code -> Download ZIP**. If you don't have a browser, install Firefox from the **Discover** app first.
4. Open **Dolphin** (the folder icon on the taskbar), go to **Downloads**, right-click `MFC-main.zip` and choose **Extract -> Extract archive here**.
5. Open **Konsole** (the terminal) from the application menu (bottom-left icon -> System -> Konsole) and type:
   ```bash
   cd ~/Downloads/MFC-main
   bash Install-MFC-Mac.command
   ```
   (If you extracted it somewhere else, change the `cd` line. You can also type `cd ` and drag the folder from Dolphin into Konsole.)
6. Answer the questions. Type the number and press **Enter**:
   * If it found more than one FFXIV settings folder, it shows when each was last played. Pick the one your game uses (normally the most recent).
   * **Characters**: `1` (or `1,3`, or `A` for all). The game names character folders by ID, which is why logging in to your main character last puts it at `[1]`.
   * **System settings**: just press **Enter** for `[1]` (only the UI size). `[3]` copies the full Windows system settings and is **not recommended** on a Steam Deck.
   * **Confirm**: it lists exactly which character folders it will overwrite. Type `y` to go ahead. Anything else cancels, and nothing is changed.
7. When it says **Done!**, close Konsole and double-click **Return to Gaming Mode** on the desktop.
8. Start FFXIV. :tada: If the HUD looks off on the Steam Deck screen, open **HUD Layout** in game and drag things into place.

#### Linux (desktop) <sup>[⮝][index]</sup>
1. Close FFXIV and its launcher completely.
2. Download MFC (**Code -> Download ZIP**) and extract it.
3. Open a terminal in the extracted folder and run:
   ```bash
   bash Install-MFC-Mac.command
   ```
4. Answer the same questions as in the Steam Deck steps above (folder if asked, characters, system settings `[1]`, confirm with `y`).

**Using Lutris, Bottles, Heroic or another Wine setup?** The installer doesn't search those automatically. Find the folder that contains `FFXIV.cfg` and the `FFXIV_CHR...` folders (inside your Wine prefix, under `drive_c/users/<name>/Documents/My Games/FINAL FANTASY XIV - A Realm Reborn`), then point the installer at it:
```bash
bash Install-MFC-Mac.command --path "/full/path/to/FINAL FANTASY XIV - A Realm Reborn"
```

#### Undo / restore (Steam Deck and Linux) <sup>[⮝][index]</sup>
1. Close the game.
2. In a terminal in the MFC folder run:
   ```bash
   bash Restore-MFC-Mac.command
   ```
3. Pick a backup by number. The oldest one is your setup from before MFC was first installed. Then confirm with `y`. Your current state is saved first as `MFC Backup <date time> (pre-restore)`, so a restore can be undone too.

Backups are saved as `MFC Backup <date time>` folders **next to** your settings folder. On Steam that's inside `.../compatdata/39210/.../Documents/My Games/`. The installer also keeps a list of them in `~/.local/share/MFC/backups.txt` (on Mac: `~/Library/Application Support/MFC/backups.txt`), so Restore always finds them.

**Good to know**
* The installer needs `bash` and `perl`, which SteamOS and almost every Linux distribution already have. If `perl` is missing, it keeps your FFXIV.cfg exactly as it is and installs everything else.
* Want an extra copy of your settings on Square Enix's servers? Use the game's own **Back Up Character Settings** on the character select screen (see [Console](#installation-console-) for how that works).
* *Tested against copies of these folder layouts: Steam (Proton) in the main library, on an SD-card library, Flatpak Steam, and XIVLauncher. Not yet tested on a real Steam Deck. If something goes wrong, your backup has everything; please report it.*

## Installation (Console) <sup>[⮝][index]</sup>
Same method as FFC. You need at least the starter edition on PC (yes, even if you already own the game on console). Install on PC, then move the settings through the game's server backup.

#### What to do on PC
1. Buy at least the starter edition on PC, for the same account you use on console.
2. Install the game.
3. Fully log in to the character(s) you want the config on.
4. Fully exit the game.
5. Install MFC, see [Installation (PC)](#installation-pc-).
6. Log back in on one of those characters and check that the config installed correctly.
7. Log out to the character screen (do not exit the game).
8. On the character screen, click the cog wheel in the top right corner -> <code>Back Up CLIENT Settings</code>.
   * Choose <code>Proceed</code>, <code>Upload</code>, <code>Ok</code>.
   * You will get a message saying _Client Settings data saved to the server_.
9. On the character screen, click the cog wheel next to the character -> <code>Back Up CHARACTER Settings</code>.
   * Choose <code>Proceed</code>, <code>Upload</code>, <code>Ok</code>.
   * You will get a message saying _Character Settings for X successfully uploaded to the server_.
10. Repeat <code>step 9</code> for each character you want the config on.
11. PC done. Go to your console and follow the steps below.

![Character Screen][install-console-char-screen]

*Image: Fr4nsson (FFC).*

#### What to do on console
1. On the character screen, click the cog wheel in the top right corner -> <code>Back Up CLIENT Settings</code>.
   * Choose <code>Proceed</code>, <code>Download</code>, <code>Ok</code>.
   * Note: on console you choose **download**, not upload.
2. On the character screen, click the cog wheel next to the character -> <code>Back Up CHARACTER Settings</code>.
   * Choose <code>Proceed</code>, <code>Download</code>, <code>Ok</code>.
3. Repeat <code>step 2</code> for each character you want the config on.
4. Restart the game.
5. Log in on one of those characters and check that the config installed correctly.
6. Done. :tada:

## What each file does <sup>[⮝][index]</sup>
<pre>
MFC
|
|- Install-MFC.bat / Install-MFC.ps1 : Installer (backup first, choose characters, FFXIV.cfg choice).
|- Restore-MFC.bat / Restore-MFC.ps1 : Puts an "MFC Backup ..." back (saves the current state first).
|- docs/layouts/                     : Every job's hotbars as readable tables, keyboard and controller, PvE and PvP.
|- Manual Installation
   |
   |- FFXIV.cfg                      : Settings in System Configuration (shared by all characters).
   |- CharacterData
      |
      |- ADDON.DAT                   : UI settings such as HUD and window layouts (laid out at 2560x1600).
      |- COMMON.DAT                  : Settings in Character Configuration.
      |- CONTROL0.DAT                : Keyboard/mouse mode settings.
      |- CONTROL1.DAT                : Gamepad mode settings.
      |- HOTBAR.DAT                  : Hotbar content (actions placed on hotbars).
      |- KEYBIND.DAT                 : Keybinds.
      |- LOGFLTR.DAT                 : Chat log filter settings.
      |- MACRO.DAT                   : Macros (Individual tab).
</pre>

## Custom Menu <sup>[⮝][index]</sup>
![][custom-menu-gif]

*Image: Fr4nsson (FFC). MFC's DPS tab is now split into Melee and Ranged.*

The menu works the same as in FFC. Jobs act as a **database**: items, macros or gearsets are put on a hidden hotbar (hotbar 7) you normally don't use. You don't need to unlock these jobs to **use** the menu, only to **edit** it.

The logic behind the menu is in <code>ALT + M -> Individual tab</code>.

To change what is in the menu, switch to the job that holds that information and press <code>9</code>. The database hotbar appears in the top center of the screen. Drag macros, items, gearsets, mounts or anything else onto it, then press <code>9</code> again to hide it.

**New in MFC:** the old DPS tab is split in two.
- **Melee**: Monk, Dragoon, Ninja, Samurai, Reaper, Viper, then Beastmaster set off with a gap (like Blue Mage in the Tank/Healer tabs).
- **Ranged**: Bard, Machinist, Dancer, Black Mage, Summoner, Red Mage, Pictomancer.

#### Non-PvP Areas <sup>[⮝][index]</sup>

| Job           | Information | Quest                    | Quest Giver | Location                              |
| ------------- | ----------- | ------------------------ | ----------- | ------------------------------------- |
| Botanist      | Expand      | Way of the Botanist      | Leonceault  | Old Gridania (x6.4, y8.3)             |
| Miner         | Collapse    | Way of the Miner         | Linette     | Ul'dah - Steps of Thal (x11,y14)      |
| Fisher        | **Melee** (was Dps) | Way of the Fisher | N'nmulika | Limsa Lominsa Lower Decks (x7,y14)  |
| Carpenter     | **Ranged** (new) | Carpenter unlock quest | Carpenters' Guild | Old Gridania (check in game) |
| Culinarian    | Tanks       | Way of the Culinarian    | Charlys     | Limsa Lominsa Upper Decks (x9,y7)     |
| Alchemist     | Healers     | Way of the Alchemist     | Deitrich    | Ul'dah - Steps of Thal (x9, y13)      |
| Weaver        | Professions | Way of the Weaver        | Maronne     | Ul'dah - Steps of Thal (x13.9, y13.2) |
| Leatherworker | Items       | Way of the Leatherworker | Randall     | Old Gridania (x12.5, y8.2)            |
| Goldsmith     | Hunt        | Way of the Goldsmith     | Jemime      | Ul'dah - Steps of Thal (x10, y13)     |
| Armorer       | Misc2       | Way of the Armorer       | G'wahnako   | Limsa Lominsa Upper Decks (x10,y15)   |
| Blacksmith    | Misc1       | Way of the Blacksmith    | Randwulf    | Limsa Lominsa Upper Decks (x10,y15)   |

#### PvP Areas *(Wolves' Den Pier)* <sup>[⮝][index]</sup>

| Job           | Information | Quest                    | Quest Giver     | Location                               |
| ------------- | ----------- | ------------------------ | --------------- | -------------------------------------- |
| Bard          | Expand      | Way of the Archer        | Athelyna        | New Gridania (x15,y12)                 |
| Machinist     | Collapse    | Savior of Skysteel       | Stephanivien    | Ishgard - Foundation (x8.1,y10.1)      |
| Dancer        | **Melee** (was Dps) | Shall We Dance   | Eager Lominsan  | Limsa Lominsa Lower Decks (x9.8,y12.0) |
| Pictomancer   | **Ranged** (new) | Pictomancer job quest (Dawntrail required) | see the Lodestone job guide | see the Lodestone job guide |
| Red Mage      | Tank        | Taking the Red           | Distraught Lass | Ul'dah - Steps of Thal (x14.1,y11.7)   |
| Black Mage    | Healer      | Way of the Thaumaturge   | Yayake          | Ul'dah - Steps of Nald (x7.3,y12.4)    |

*The Carpenter and Pictomancer rows are new in MFC and their quest details have not been verified yet. All other rows are from Fr4nsson's FFC README.*

## Hotbar layouts <sup>[⮝][index]</sup>
Every job's hotbars, generated from the shipped files, are in **[docs/layouts](docs/layouts/README.md)**: tank, healer, melee, ranged, crafters and gatherers, keyboard and controller, PvE and PvP. Remember the [row order](#main-hotbar-): plain on top, SHIFT in the middle, CTRL at the bottom.

## Make it yours <sup>[⮝][index]</sup>
MFC is a starting point, not a cage. Want Standard movement, your own chat tabs, different keys, your mounts on `SHIFT + H` / `CTRL + H`, or the keybind bars hidden? See **[CUSTOMIZING.md](CUSTOMIZING.md)**.

## Known limitations <sup>[⮝][index]</sup>
- **Not tested in game on every job.** If something is wrong (a duplicate button, a missing action, a macro that does nothing), please report it.
- **Blue Mage spells were not updated.** They depend on which spells you have loaded. Only the row swap was applied.
- **One HUD file only**, laid out at 2560x1600. No separate 1080p/1440p/4K versions like FFC had. Small offsets can be fixed in HUD Layout (`CTRL + NUMPAD 0`).
- **Installers: Windows (`.bat`) and Mac / Steam Deck / Linux (`.command`, run with bash).** Both handle the standalone and Steam versions. The shell installer was tested against copies of the Square Enix client, XIV on Mac, Steam-library and Proton folder layouts, not on every macOS version or a real Steam Deck.
- **Console**: install on PC first, then use the game's Back Up Client/Character Settings, see [Installation (Console)](#installation-console-).
- **Job-change buttons switch gear by gearset name.** You need a gearset named exactly the English job name (for example `Viper`, `Pictomancer`, `Beastmaster`). Non-English clients: see the [FAQ](#frequently-asked-questions-faq-).
- **White Mage**: Glare IV and Divine Caress may show up as duplicates of the buttons they upgrade from. Drag them off if so.

## Frequently Asked Questions (FAQ) <sup>[⮝][index]</sup>

<details><p></p>
<summary>What version am I using?</summary>
Open the macro menu <code>ALT + M</code>, Individual tab, and check <code>Macro #99</code> in the bottom right. MFC shows <code>Version: MFC 1.0</code> (based on Fr4nsson's FFC 2.5).
<br><br></details>

<details><p></p>
<summary>Is this against TOS? Can I get banned for using this?</summary>
No. Like FFC, this is not a mod, only the game's own settings files. Nothing runs while you play. The files started as FFC's and Megumax's in-game settings; MFC's Dawntrail changes were applied to those files before release. The installer backs up your settings, copies MFC's files into the character folders you pick and, if you choose <code>[1]</code>, changes only the four UI size lines in your FFXIV.cfg.
<br><br></details>

<details><p></p>
<summary>Does this work on console (PS4, PS5, Xbox)?</summary>

Yes, through the PC and the game's server backup. See [Installation (Console)](#installation-console-).
<br><br></details>

<details><p></p>
<summary>Windows says "Windows protected your PC" when I run Install-MFC.bat</summary>
That is SmartScreen, which shows for any downloaded script it doesn't recognise. Click <b>More info -> Run anyway</b>. If you want to check what it does first, open <code>Install-MFC.ps1</code> in Notepad. It is plain text.
<br><br></details>

<details><p></p>
<summary>Which character is which in the installer list?</summary>
The game names character folders by an ID, not by name. The list is sorted by most recently played. Log in to the character you want last, close the game, and run the installer. That character will be <code>[1]</code>.
<br><br></details>

<details><p></p>
<summary>My hotbars look upside down compared to Fr4nsson's pictures</summary>
That is intended. MFC swapped the plain row and the CTRL row so that temporary actions (mounts, vehicles, NPC duties) land on plain <code>1</code>-<code>4</code>. Every key still fires the same ability. In game each block shows plain on top, SHIFT in the middle, CTRL at the bottom. The keybind settings show Hotbar 1-3 slots 1-4 bound to plain keys, which is also expected.
<br><br></details>

<details><p></p>
<summary>What are the extra bars with keys on them? How do I hide them?</summary>
Those are FFC's keybind bars (hotbars 8 and 9). In MFC they are visible by default. Press <code>8</code> to toggle them. Drag your own mounts onto the <code>SHIFT + H</code> / <code>CTRL + H</code> slots to replace the "Replace with Mount" placeholders.
<br><br></details>

<details><p></p>
<summary>I added a job to the menu but it doesn't save, every time I switch it reverts back</summary>
You have to put it on the database bar of the job that holds that tab:

1. Switch to the database job, for example <code>Fisher</code> for Melee, <code>Carpenter</code> for Ranged, <code>Alchemist</code> for Healers or <code>Culinarian</code> for Tanks.
2. Press <code>9</code>. A new hotbar appears in the top center of the screen.
3. Press <code>SHIFT + G</code> to bring up your gearsets and drag the gearset onto that hotbar.
4. Press <code>9</code> again to hide it.

In PvP areas, go to <code>Wolves' Den Pier</code> and do the same with <code>Dancer</code> (Melee), <code>Pictomancer</code> (Ranged), <code>Red Mage</code> (Tank) or <code>Black Mage</code> (Healer).

For more, see [Custom Menu](#custom-menu-).
<br><br></details>

<details><p></p>
<summary>In the expandable menu, when I click a job-change icon nothing happens</summary>
The gearset name is wrong. Make sure each job has a gearset with the default English name, for example <code>Gunbreaker</code>, <code>Viper</code>, <code>Pictomancer</code> or <code>Beastmaster</code>.
<br><br>
<b>Non-English clients:</b> your gearset names must match the names used by the auto-translation in the job macros. Open the macro menu <code>ALT + M</code>, click a job-change macro and check the name. As Fr4nsson noted, French players need gearset names in all lowercase letters for this to work.
<br><br>
In PvP areas, this happens if your current job has no PvP hotbars (crafters, gatherers, Blue Mage and Beastmaster). Switch to a PvP job with <code>SHIFT + G</code> first.
<br><br></details>

<details><p></p>
<summary>A White Mage button shows up twice</summary>
Glare IV (<code>CTRL + 2</code>) and Divine Caress (<code>CTRL + V</code>) have their own buttons because the game data can't tell whether they replace another button automatically. If one is a duplicate, just drag it off the hotbar.
<br><br></details>

<details><p></p>
<summary>I don't see Beastmaster's Inner Compass gauge</summary>
Press any HUD preset key once (<code>CTRL + NUMPAD 1</code>-<code>4</code>) and it shows up.
<br><br></details>

<details><p></p>
<summary>How do I undo the install?</summary>
Close the game and double-click <code>Restore-MFC.bat</code>. See [Undo / restore](#undo--restore-).
<br><br></details>

## Keybinds <sup>[⮝][index]</sup>
Mostly Fr4nsson's FFC keybinds. Differences are listed in [How Megumax's setup differs](#keybinds).

#### Main hotbars (hotbars 1-3)
```
Block 1: 1  2  3  4      (top row on screen)
         SHIFT + 1-4     (middle row)
         CTRL  + 1-4     (bottom row)
Block 2: Q  E  R  X  / SHIFT + Q E R X / CTRL + Q E R X
Block 3: F  C  V  T  / SHIFT + F C V T / CTRL + F C V T
```
#### Inventory <sup>[⮝][index]</sup>
```
I or B              = Open all bags
SHIFT + B or CTRL + B = Open character screen, armoury chest and all bags and sort them
SHIFT + I           = Open Chocobo Saddlebag
CTRL  + I           = Armoury Chest
ALT   + I           = Fashion Accessories
```
#### Mount <sup>[⮝][index]</sup>
```
ALT   + H           = Ridepillion
SHIFT + H           = Single Seat Mount   (drag your mount onto the placeholder)
CTRL  + H           = Multiple Seat Mount (drag your mount onto the placeholder)
```
#### Stance & Weapon <sup>[⮝][index]</sup>
```
Z                   = Sheathe/Unsheathe Weapon
SHIFT + Z           = Change stance (try it holding a weapon, sitting or standing with weapon sheathed)
```
#### Marking Targets / Combat Related (mostly used when playing as Tank) <sup>[⮝][index]</sup>
```
ALT   + 1           = Mark primary target to attack
ALT   + 2           = Mark secondary target to attack
ALT   + X           = Mark target to ignore
ALT   + F           = Set Focus Target
ALT   + R           = Ready Check
ALT   + C           = Countdown
CTRL  + M           = Waymark Menu
SHIFT + M           = Signs Menu
```
#### Chat <sup>[⮝][index]</sup>
```
ALT   + S           = Switch chat mode to Say
ALT   + Y           = Switch chat mode to Yell
CTRL  + Y           = Temporarily switch chat mode to Shout
ALT   + P           = Switch chat mode to Party
ALT   + A           = Switch chat mode to Alliance / Raid
ALT   + G           = Switch chat mode to Free Company / Guild
SHIFT + ENTER       = Chat fullscreen
```
#### General <sup>[⮝][index]</sup>
```
8                   = Toggle Keybind bars (visible by default in MFC)
9                   = Toggle Database bar
L                   = Limit Break
NUMPAD 0            = Confirm (spam through dialog or GC turn-ins)
NUMPAD .            = Cancel
NUMPAD 1-5          = Toggle spell effects/names
INSERT              = Toggle spell effects/names, preset 1 (all)
DELETE              = Toggle spell effects/names, preset 3 (limited)
HOME                = Return
CTRL/SHIFT + HOME   = Return (Eternity Ring)
END                 = Teleport Menu
Print Screen        = Screenshot
ALT + M             = Macro Menu
ALT + NUMPAD PLUS   = Continuously increase volume until stopped by pressing NUMPAD -
NUMPAD -            = Stop volume increase (Macro cancel)
NUMPAD +            = Toggle Master Volume On/Off
NUMPAD *            = Helm Visor
NUMPAD /            = RP Walk
SHIFT + G           = Gear sets
CTRL  + G           = Portraits
G                   = Free Company / Guild Menu
H                   = Housing Menu
J                   = Journal / Quest Log
K                   = Key items
M                   = Map
O                   = Friend list
SHIFT + O           = Party Members
CTRL  + O           = Party Finder
CTRL  + L           = Cross-world Linkshells
U                   = Duty Finder
ALT   + U           = V&C Dungeon Finder
P                   = Actions & Traits
SHIFT + P           = PvP Profile
CTRL  + K           = System Configuration
```
The mouse binds and the Currency / Challenge Log keys are unchanged from FFC's list (FFC: `Mouse5` = Confirm, `Mouse4` = Cancel, `Mouse3` = Auto-run, `,` = Currency, `.` = Challenge Log).

#### Hud <sup>[⮝][index]</sup>
```
Scroll Lock         = Toggle visibility for ALL hud elements (nice for screenshots)
SHIFT + Scroll Lock = Toggle visibility of some hud elements (Clean Hud)
Arrow Keys          = Move the selected hud element by one pixel in the hud editor
CTRL + NUMPAD 0     = Toggle Hud Editor (also ALT + Scroll Lock)

CTRL + NUMPAD 1     = Hud Preset 1, config default
CTRL + NUMPAD 2     = Hud Preset 2, larger
CTRL + NUMPAD 3     = Hud Preset 3, like Hud Preset 1, gauges and hp reversed
CTRL + NUMPAD 4     = Hud Preset 4, like Hud Preset 2, gauges and hp reversed
```

## Controller | [Comprehensive Controller Guide][comprehensive-controller-guide] <sup>[⮝][index]</sup>
PvE controller layouts for combat jobs and crafters were originally made by [Squintina][squintina] for FFC 2.5 (gatherers excluded). MFC updated them for Dawntrail, added Viper, Pictomancer and Beastmaster, and added PvP controller layouts (FFC had none) based on the same conventions. Per-job tables: [docs/layouts](docs/layouts/README.md).

Fr4nsson's general controller tips:
```
Autorun
Left Analog Stick (move it) then press L1

Sheathe/Unsheathe Weapon
L1 + R1 or L3

Sprint
R3 or double tap L2 then Dpad Up

Virtual Mouse
L1 + R3

Zoom In/Out
L1 + Right Analog Stick (move it)
```

---
## A note to Fr4nsson

FFC made this game so much nicer to play, and MFC only exists to keep it working for the people who still use it. All the credit for the design, the layouts and the custom menu is yours. If you'd rather this weren't public, or want anything changed or credited differently, just open an issue or reach out, and it will be taken down or changed right away, no questions asked.

---
*MFC is an unofficial fan continuation of Fr4nsson's FFXIV Config. It is not an official FFC release and is not endorsed by Fr4nsson or affiliated with Square Enix. FINAL FANTASY XIV is a registered trademark of Square Enix Holdings Co., Ltd.*
