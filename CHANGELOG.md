# Changelog

MFC (Megumax's FFXIV Config) is a continuation of [Fr4nsson's FFXIV Config (FFC)](https://github.com/Fr4nsson/FFC) 2.5, updated for Dawntrail. All the hard work of the original layout, HUD and custom menu is Fr4nsson's; MFC just brings it up to date. PvE controller layouts for combat jobs and crafters were originally made by Squintina (credited in FFC 2.5, gatherers excluded). MFC is unofficial: it is not an official FFC release and is not endorsed by Fr4nsson or affiliated with Square Enix.

## CHANGELOG MFC 1.0

Tested against game data current as of November 2026 (Dawntrail 7.x). You can check your version in macro `#99` (`ALT + M`), it says *Version: MFC 1.0, based on Fr4nsson's FFC 2.5*.

• Jobs (NON-PVP):
  - Every older combat job and its base class updated for Dawntrail (19 jobs), keyboard **and** controller, about 357 slot changes in total.
  - Removed abilities taken off the hotbars (for example Dragon Sight, Sharpcast, Anatman, Meditation, the old AST card system, Arcanist Bane/Egi Assault, Spineshatter Dive, Shoha II).
  - New 7.x buttons placed following FFC's rules: the same kind of spell sits on the same key on every job, plain = basic, SHIFT = stronger, CTRL = next step, Q = AoE, E = heal / Second Wind / Provoke for tanks, 4 = rotation or crowd control, and so on.
  - Trait upgrades (Bootshine → Leaping Opo and friends) are **not** placed separately, the base button upgrades itself.
  - Low-level spells stay, as in FFC: one layout for the whole game, level sync included.
  - WHM Glare IV (CTRL+2) and Divine Caress (CTRL+V) placed as their own buttons. Game data can't tell whether these are separate buttons or automatic replacements, so if one shows up as a duplicate, just drag it off.
  - MCH Dismantle parked on hotbar 7 (the "spells here so the game doesn't auto-place them" bar).
  - Full per-job list in [docs/layouts](docs/layouts/README.md).

• New jobs:
  - Viper (melee), Pictomancer (caster) and Beastmaster (limited job, melee, PvE only) added with full keyboard + controller layouts following FFC's conventions.
  - Job-change macros added: `#11` Viper, `#12` Pictomancer, `#36` Beastmaster (FFC's reserved slot).

• PvP:
  - Every job rebuilt for the current PvP kits (PvP Role Action included), keyboard and controller, about 630 slot changes.
  - Keyboard follows FFC 2.4's PvP pattern: 1 = one-button combo or basic attack, Q / SHIFT+Q = AoE, E = Recuperate, CTRL+E = Elixir (also on SHIFT+E, unless the job has a PvP heal there), X = Limit Break, SHIFT+X = Sprint, F = dash, C = Purify, T = Guard.
  - FFC never had PvP controller layouts, MFC's are derived from FFC's PvE controller conventions.

• Crafters & Gatherers:
  - Crafters (all 8 share one layout): Focused Synthesis / Focused Touch removed. Refined Touch (CTRL+R), Immaculate Mend (SHIFT+R), Quick Innovation (CTRL+C) and Trained Perfection (CTRL+V) added. Heart and Soul and Careful Observation added to controller.
  - Miner / Botanist: Priming Touch added. Bountiful Yield II / Bountiful Harvest II are trait upgrades of Bountiful Yield / Bountiful Harvest, so they are not placed separately.
  - Fisher: Spareful Hand, Big-game Fishing, Ambitious Lure and Modest Lure added (Rest/Quit on controller).

• Custom menu:
  - The DPS tab is split into **Melee** (MNK, DRG, NIN, SAM, RPR, VPR, plus Beastmaster set off with a gap, like Blue Mage in Tank/Healer) and **Ranged** (BRD, MCH, DNC, BLM, SMN, RDM, PCT).
  - Melee database = Fisher hotbar 7 (non-PvP) / Dancer hotbar 7 (PvP). Ranged database = Carpenter hotbar 7 (non-PvP) / Pictomancer hotbar 7 (PvP).
  - Macro `#96` renamed "Dps" → "Melee", new macro `#21` "Ranged" (red sword "2" icon). The Expand row gained the Ranged button.

• Hotbars / Keybinds (row swap):
  - On the three main 4x3 blocks, the plain-key row and the CTRL row were swapped in **both** the keybinds and every class/job's hotbars. Every key still fires the same ability as before.
  - Why: temporary NPC / vehicle / duty actions always drop into hotbar 1 from slot 1 onward, so they now land on plain `1`–`4` instead of `CTRL + 1`–`4`.
  - What you'll notice: in-game each block now shows **plain on top, SHIFT in the middle, CTRL at the bottom** (FFC's pictures show CTRL on top). In *System Configuration → Keybind*, Hotbar 1–3 slots 1–4 show the plain keys. That's expected.
  - Keybind bars (hotbars 8 & 9) are visible by default. The mount keys SHIFT+H / CTRL+H show FFC's "Replace with Mount" placeholder, ALT+H = Ridepillion. See [CUSTOMIZING.md](CUSTOMIZING.md).

• HUD / Gauges:
  - Viper, Pictomancer and Beastmaster gauges, plus Ninja's new Kazematoi gauge and Black Mage's new Astral gauge, set to Simple style and anchored bottom-middle like all FFC gauges, in all 4 HUD presets (CTRL+NUMPAD1–4).
  - Beastmaster's Inner Compass shows after pressing a HUD preset key once.
  - The HUD (ADDON.DAT) is laid out for 2560x1600. FFC's separate 1080p / 1440p / 4K HUD files are **not** provided, fix small offsets with HUD Layout (CTRL+NUMPAD0).

• Macros:
  - Red Mage, Scholar and Summoner job-change macros put the wrong PvP Limit Break on L (removed / PvE action), fixed.
  - Controller Sprint macro (`#99`) called a removed PvP action, fixed.

• Installer:
  - New `Install-MFC.bat`: backs up `FFXIV.cfg` and every character folder it touches **before** changing anything (into an `MFC Backup <date time>` folder next to the game's settings folder), lets you choose which characters to install to, and asks what to do with `FFXIV.cfg`: [1] apply only MFC's UI size and UI resolution settings (default), [2] keep yours as it is, [3] replace it with MFC's full system settings.
  - New `Restore-MFC.bat`: puts any MFC backup back, and saves your current state first as `MFC Backup <date time> (pre-restore)` so a restore can be undone too.
  - Both refuse to run while the game or launcher is open. Restore was tested on a test game folder and comes back byte-identical.
  - New `Install-MFC-Mac.command` / `Restore-MFC-Mac.command` for macOS: same behaviour as the Windows ones, for both Square Enix's Mac client and XIV on Mac (finds the settings folder by itself). Tested against copies of both folder layouts; the UI-size merge is byte-exact.
  - Steam Deck / Linux: manual installation only.

• Megumax's personal settings (good to know):
  - Legacy movement is on (keyboard and gamepad), legacy flying controls on keyboard only, legacy autorun while flying in both.
  - Chat log tabs and filters are Megumax's (two tabs renamed "S-Hunt" and "Chat").
  - `FFXIV.cfg` (only applied in full if you pick [3]): English client, 2560x1600 borderless window, UI size settings.

• Removed personal data:
  - Personal emotes, mounts and minions removed (mount keys show the "Replace with Mount" placeholder).
  - Gearset buttons removed from the cross hotbars (gearset numbers differ on every character).
  - The free-to-use hotbars 4–6 ship empty, like in FFC.
  - Account-wide macros removed; active linkshell cleared.
  - Machine-specific and identifying `FFXIV.cfg` lines removed (world, device IDs, last login, MSQ progress, screenshot path, window position).

• Not covered (yet):
  - Blue Mage spells were not updated (they depend on the spells you have loaded); only the row swap was applied.
  - Not tested in-game on every job, please report anything that looks off.

## Based on FFC 2.5

Everything before MFC 1.0 is Fr4nsson's work. For FFC 2.3, 2.4 and 2.5 (hotbar order change, PvP rework, controller layouts by Squintina, installer, macro tab changes and more) see Fr4nsson's own changelogs on the [FFC GitHub](https://github.com/Fr4nsson/FFC) and the [Nexus Mods page](https://www.nexusmods.com/finalfantasy14/mods/1054).
