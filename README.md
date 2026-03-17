# MyNotchApp

A macOS notch companion that monitors your Claude Code sessions with animated pixel art mascots.

[![Download](https://img.shields.io/badge/download-MyNotchApp_v1.0.0-0075FF?style=flat-square&logo=apple&logoColor=white)](https://github.com/prolifiq1/MyNotchApp/releases/download/v1.0.0/MyNotchApp-1.0.dmg)
[![macOS](https://img.shields.io/badge/macOS-15%2B-lightgrey?style=flat-square&logo=apple&logoColor=white)](https://github.com/prolifiq1/MyNotchApp/releases)
[![License](https://img.shields.io/badge/license-MIT-0075FF?style=flat-square)](LICENSE)

---

## What is MyNotchApp?

MyNotchApp lives in your MacBook's notch and keeps you updated on what Claude Code is doing. It shows:

- **Animated pixel art mascots** — choose from 6 characters that react to session state
- **Session status** — see when Claude is processing, waiting for input, or idle
- **Shimmer progress** — a glassy traveling highlight shows active work
- **Menu bar integration** — quick status view and settings from the menu bar
- **Theme colours** — 6 presets to personalise the notch UI

## Install

1. [Download MyNotchApp-1.0.dmg](https://github.com/prolifiq1/MyNotchApp/releases/download/v1.0.0/MyNotchApp-1.0.dmg)
2. Open the DMG and drag **MyNotchApp** to Applications
3. Launch MyNotchApp — it appears in your notch
4. Right-click → Open on first launch to bypass Gatekeeper

## Requirements

- macOS 15.0 or later
- Apple Silicon Mac with a notch display
- Claude Code CLI installed

## Built With

- SwiftUI + AppKit
- Canvas API for pixel art rendering
- NSPanel for the notch overlay

## Build from Source

```bash
git clone https://github.com/prolifiq1/MyNotchApp.git
cd MyNotchApp
open MyNotchApp.xcodeproj
```

Or via command line:

```bash
swift build
swift run MyNotchApp
```

## License

MIT
