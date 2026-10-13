# ZanZarah Translation Kit

A toolkit to translate **ZanZarah: The Hidden Portal** into any language, plus ready-to-use translations and installers.

> 🇧🇷 **[Leia em português](README-PT.md)**. Jogadores brasileiros: baixe o instalador na pasta [`installers/`](installers/) e execute. Pronto!

---

## 💡 How it works

All of the game's text lives in two files inside the game's `Data` folder: `_fb0x02.fbs` (UI, items, spells, menus) and `_fb0x06.fbs` (character dialogue). The kit turns them into a single, easy-to-edit **`texts.json`** file and then compiles that file back into the game format.

That means **a whole translation is just one `texts.json` file**. Each language in this repository is stored that way, and anyone can create a new language by translating that one file.

## 📁 Repository layout

```
zanzarah-translation-kit/
├── kit/                     # The translation toolkit
│   ├── EXTRACT.bat          # original .fbs → texts.json
│   ├── COMPILE.bat          # texts.json → translated .fbs
│   ├── tools/
│   │   └── zzio_dbsqlite.exe    # .fbs ↔ SQLite converter (based on zzio)
│   ├── scripts/             # Python helpers used by the .bat files
│   ├── base/                # Intermediate database (generated)
│   └── installer/
│       └── ZanZarah-PTBR.iss    # Inno Setup script for building an installer
├── installers/              # Ready-to-run installers, one per language
│   └── ZanZarah-PT-BR-Setup.exe
└── languages/               # One folder per language, each with its texts.json
    ├── pt-BR/
    │   └── texts.json
    ├── it/  de/  fr/  es/  nl/  sv/
    │   └── texts.json
```

## 🌍 Available languages

| Language | Code | Status | Author |
|---|---|---|---|
| Português (Brasil) | `pt-BR` | ✅ Complete | Hugo Leonardo ([@Krunsher](https://github.com/Krunsher)) |
| Italiano | `it` | ✅ Complete | Hugo Leonardo ([@Krunsher](https://github.com/Krunsher)) |
| Deutsch | `de` | ✅ Complete | Hugo Leonardo ([@Krunsher](https://github.com/Krunsher)) |
| Français | `fr` | ✅ Complete | Hugo Leonardo ([@Krunsher](https://github.com/Krunsher)) |
| Español | `es` | ✅ Complete | Hugo Leonardo ([@Krunsher](https://github.com/Krunsher)) |
| Nederlands | `nl` | ✅ Complete | Hugo Leonardo ([@Krunsher](https://github.com/Krunsher)) |
| Svenska | `sv` | ✅ Complete | Hugo Leonardo ([@Krunsher](https://github.com/Krunsher)) |

---

## 🎮 Installing a translation

### Option 1: installer (easiest)

Download your language's installer from [`installers/`](installers/) and run it. It finds the Steam install automatically (or lets you pick the game folder) and backs up the original files as `.bak`. Uninstall it from Windows' "Apps" settings to restore English.

### Option 2: compile it yourself

Use this if there is no installer for your language yet, or if you prefer doing it by hand. You need Windows and [Python 3](https://www.python.org/) (tick "Add Python to PATH" during setup).

1. Copy the **original** `_fb0x02.fbs` and `_fb0x06.fbs` from the game's `Data` folder (e.g. `C:\Program Files (x86)\Steam\steamapps\common\ZanZarah\Data`) into `kit/`.
2. Run `kit/EXTRACT.bat`. This prepares the kit's database.
3. Copy `texts.json` from `languages/<your-language>/` into `kit/`, replacing the one that was just created.
4. Run `kit/COMPILE.bat`. The translated `_fb0x02.fbs` and `_fb0x06.fbs` are written to `kit/`.
5. Back up the originals in the game's `Data` folder and copy the two new files there.

---

## 🛠️ Translating into a new language

1. Follow steps 1 and 2 above. `EXTRACT.bat` creates `kit/texts.json` with the game's original English text.
   *Tip: you can start from another language's `texts.json` in `languages/` if you find it easier.*
2. Translate `kit/texts.json` in a text editor such as VS Code or Notepad++. It has two sections: `"_fb0x02"` (UI and items, 943 strings) and `"_fb0x06"` (dialogue, 1140 strings). Translate only the text values, and:
   - never change the IDs (e.g. `"802A94A1"`);
   - keep formatting tags exactly as they are: `{4*Name}`, `{5*Title}`, `~~`.
3. Run `COMPILE.bat`, copy the two `.fbs` files into the game's `Data` folder and check your translation in-game.

> ⚠️ `EXTRACT.bat` rebuilds `kit/texts.json` from scratch. Once you start translating, keep a copy of your file and only run `COMPILE.bat`, or you will lose your work.

### Building an installer

Installers are built with [Inno Setup 6](https://jrsoftware.org/isinfo.php). Run `COMPILE.bat` first, then open `kit/installer/ZanZarah-PTBR.iss`, adjust the name and language for your translation and click **Build > Compile**. The installer is written to `installers/`.

---

## 🤝 Contributing a new language

Anyone can add a language through a Pull Request. You only need to send your `texts.json`:

1. **Fork** this repository (the *Fork* button at the top right).
2. In your fork, create `languages/<code>/texts.json` using the language code, e.g. `pl`, `ru`, `ja`, `pt-PT`.
3. Open a **Pull Request** to this repository describing your translation.

Once it is reviewed and merged, your language will be listed in the table above. Please only touch your own language folder.

---

## 🙏 Credits

- **Translation kit and translations (Brazilian Portuguese, Italian, German, French, Spanish, Dutch and Swedish):** Hugo Leonardo ([@Krunsher](https://github.com/Krunsher))
- **[zzio](https://github.com/Helco/zzio)** by [Helco](https://github.com/Helco): an open-source reimplementation of the ZanZarah engine and a set of tools for the game's file formats. The `zzio_dbsqlite.exe` converter in this kit is built on zzio. This project would not exist without it. Thank you!
- **ZanZarah: The Hidden Portal** © Funatics Development / THQ Nordic. This is a non-commercial fan project, not affiliated with or endorsed by the rights holders. You need a legitimate copy of the game to use these translations.
